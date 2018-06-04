Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D5CC1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 04:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbeFDEvZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 00:51:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:32968 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751396AbeFDEvY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 00:51:24 -0400
Received: (qmail 2938 invoked by uid 109); 4 Jun 2018 04:51:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Jun 2018 04:51:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11665 invoked by uid 111); 4 Jun 2018 04:51:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 04 Jun 2018 00:51:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Jun 2018 00:51:22 -0400
Date:   Mon, 4 Jun 2018 00:51:22 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, Johannes.Schindelin@gmx.de,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] sequencer.c: plug mem leak in git_sequencer_config
Message-ID: <20180604045122.GE14451@sigill.intra.peff.net>
References: <20180601200146.114919-1-sbeller@google.com>
 <20180601200146.114919-2-sbeller@google.com>
 <xmqq8t7v6zpd.fsf@gitster-ct.c.googlers.com>
 <xmqqmuwb5i7k.fsf@gitster-ct.c.googlers.com>
 <20180604035637.GA15408@sigill.intra.peff.net>
 <xmqqin6z5g8e.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqin6z5g8e.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 04, 2018 at 01:26:57PM +0900, Junio C Hamano wrote:

> > Doing it "right" in C would probably involve two variables:
> >
> >   const char *some_var = "default";
> >   const char *some_var_storage = NULL;
> >
> >   int git_config_string_smart(const char **ptr, char **storage,
> >                               const char *var, const char *value)
> >   {
> >         ...
> > 	free(*storage);
> > 	*ptr = *storage = xstrdup(value);
> > 	return 0;
> >   }
> >
> >   #define GIT_CONFIG_STRING(name, var, value) \
> >   git_config_string_smart(&(name), &(name##_storage), var, value)
> >
> > Or something like that.
> 
> The attitude the approach takes is that "run once and let exit(3)
> clean after us" programs *should* care.

Even with "let exit clean up", we are still leaking heap every time the
variable is assigned after the first. Again, I don't think it matters
that much in practice, but I think:

  [core]
  editor = foo
  editor = foo
  ...etc...

would leak arbitrary memory during the config parse, that would be
allocated for the remainder of the program. I guess you could say exit()
is handling it, but I think the point is that we are letting exit()
handle memory that was potentially useful until we exit, not leaks. :)

> And at that point, maybe
> 
> 	char *some_var = xstrdup("default");
> 	git_config_string(&some_var, ...);
> 
> that takes "char **" and frees the current storage before assigning
> to it may be simpler than the two-variable approach.

That _is_ much nicer, but you cannot use xstrdup() as the initializer
for a global "static char *some_var", which is what the majority of the
config variables are. It's this "static initializer sometimes, run-time
heap sometimes" duality to the variables that makes handling it such a
pain.

With that strategy, we'd have to have a big initialize_defaults()
function. Which actually might not be _too_ bad since we now have
common-main.c, but:

  - it sucks to keep the default values far away from the declarations

  - it does carry a runtime cost. Not a huge one, but it sucks to pay it
    on every program startup, even if we're not using those variables.

-Peff
