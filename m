Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E3D21F403
	for <e@80x24.org>; Mon,  4 Jun 2018 05:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751640AbeFDFAg (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 01:00:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:32992 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751061AbeFDFAg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 01:00:36 -0400
Received: (qmail 3266 invoked by uid 109); 4 Jun 2018 05:00:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Jun 2018 05:00:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11732 invoked by uid 111); 4 Jun 2018 05:00:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 04 Jun 2018 01:00:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Jun 2018 01:00:34 -0400
Date:   Mon, 4 Jun 2018 01:00:34 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, Johannes.Schindelin@gmx.de,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] sequencer.c: plug mem leak in git_sequencer_config
Message-ID: <20180604050033.GA17818@sigill.intra.peff.net>
References: <20180601200146.114919-1-sbeller@google.com>
 <20180601200146.114919-2-sbeller@google.com>
 <xmqq8t7v6zpd.fsf@gitster-ct.c.googlers.com>
 <xmqqmuwb5i7k.fsf@gitster-ct.c.googlers.com>
 <20180604035637.GA15408@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180604035637.GA15408@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 03, 2018 at 11:56:37PM -0400, Jeff King wrote:

> So sometimes some_var needs to be freed and sometimes not (and every one
> of those uses is a potential leak, but it's OK because they're all
> program-lifetime globals anyway, and people don't _tend_ to set the same
> option over and over, leaking heap memory). And C being C, we can't
> convert a pointer-to-pointer-to-const into a pointer-to-pointer without
> an explicit cast.
> 
> Doing it "right" in C would probably involve two variables:
> 
>   const char *some_var = "default";
>   const char *some_var_storage = NULL;
> 
>   int git_config_string_smart(const char **ptr, char **storage,
>                               const char *var, const char *value)
>   {
>         ...
> 	free(*storage);
> 	*ptr = *storage = xstrdup(value);
> 	return 0;
>   }
> 
>   #define GIT_CONFIG_STRING(name, var, value) \
>   git_config_string_smart(&(name), &(name##_storage), var, value)
> 
> Or something like that.

Oh, one other option I forgot to mention: we already have an "intern"
hashmap helper. So we could just replace the xstrdup() with strintern()
and magically the memory isn't "leaked".

I think this is a little bit of a hack, though. It catches my:

  [core]
  editor = foo
  editor = foo

case, because we only ever make one copy of the string "foo". But if I
do:

  [core]
  editor = 1
  editor = 2
  ...

then we get unique strings. And while they're not _technically_ leaked,
since the hashmap still knows about them, they might as well be. They're
still wasting space through the duration of the program run.

-Peff
