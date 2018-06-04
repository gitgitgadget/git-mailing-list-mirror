Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8F6F1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 03:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbeFDD4k (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 23:56:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:32920 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751273AbeFDD4j (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 23:56:39 -0400
Received: (qmail 974 invoked by uid 109); 4 Jun 2018 03:56:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Jun 2018 03:56:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11457 invoked by uid 111); 4 Jun 2018 03:56:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 03 Jun 2018 23:56:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 03 Jun 2018 23:56:37 -0400
Date:   Sun, 3 Jun 2018 23:56:37 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, Johannes.Schindelin@gmx.de,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] sequencer.c: plug mem leak in git_sequencer_config
Message-ID: <20180604035637.GA15408@sigill.intra.peff.net>
References: <20180601200146.114919-1-sbeller@google.com>
 <20180601200146.114919-2-sbeller@google.com>
 <xmqq8t7v6zpd.fsf@gitster-ct.c.googlers.com>
 <xmqqmuwb5i7k.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmuwb5i7k.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 04, 2018 at 12:44:15PM +0900, Junio C Hamano wrote:

> >> diff --git a/sequencer.c b/sequencer.c
> >> index b98690ecd41..aba03e9429a 100644
> >> --- a/sequencer.c
> >> +++ b/sequencer.c
> >> @@ -175,6 +175,7 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
> >>  			warning(_("invalid commit message cleanup mode '%s'"),
> >>  				  s);
> >>  
> >> +		free(s);
> >>  		return status;
> >>  	}
> >
> > Shouldn't 's' now lose 'const'?  After all, git_config_string()
> > gives you an allocated memory so...
> 
> Yikes.  Should git_config_string() and git_config_pathname() take
> "char **dst" instead of "const char **" as their out-location
> parameter?  They both assign a pointer to an allocated piece of
> memory for the caller to own or dispose of, but because of
> const-ness of the pointee their first parameter has, a caller like
> this one must declare "const char *s" yet is forced to call free()
> not to leak the value when it is done.

I've looked into it before, but that causes its own wave of headaches.
The source of the problem is that we do:

  const char *some_var = "default";
  ...
  git_config_string(&some_var, ...);

So sometimes some_var needs to be freed and sometimes not (and every one
of those uses is a potential leak, but it's OK because they're all
program-lifetime globals anyway, and people don't _tend_ to set the same
option over and over, leaking heap memory). And C being C, we can't
convert a pointer-to-pointer-to-const into a pointer-to-pointer without
an explicit cast.

Doing it "right" in C would probably involve two variables:

  const char *some_var = "default";
  const char *some_var_storage = NULL;

  int git_config_string_smart(const char **ptr, char **storage,
                              const char *var, const char *value)
  {
        ...
	free(*storage);
	*ptr = *storage = xstrdup(value);
	return 0;
  }

  #define GIT_CONFIG_STRING(name, var, value) \
  git_config_string_smart(&(name), &(name##_storage), var, value)

Or something like that.

We could also get away from an out-parameter and use the return type,
since the single-pointer conversion is OK. But the primary value of
git_config_string() is that it lets you return the error code as a
one-liner.

-Peff
