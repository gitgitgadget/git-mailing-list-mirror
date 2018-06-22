Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54C9B1F516
	for <e@80x24.org>; Fri, 22 Jun 2018 22:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754728AbeFVWoG (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 18:44:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:52576 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754265AbeFVWnw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 18:43:52 -0400
Received: (qmail 4945 invoked by uid 109); 22 Jun 2018 22:43:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Jun 2018 22:43:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23572 invoked by uid 111); 22 Jun 2018 22:44:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 22 Jun 2018 18:44:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jun 2018 18:43:50 -0400
Date:   Fri, 22 Jun 2018 18:43:50 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 3/4] branch: deprecate "-l" option
Message-ID: <20180622224349.GA7463@sigill.intra.peff.net>
References: <20180622092327.GA8361@sigill.intra.peff.net>
 <20180622092414.GC13573@sigill.intra.peff.net>
 <20180622223428.GA23440@flurp.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180622223428.GA23440@flurp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 22, 2018 at 06:34:28PM -0400, Eric Sunshine wrote:

> I wonder if it would be better and cleaner to limit the visibility of
> this change to cmd_branch(), rather than spreading it across a global
> variable, a callback function, and cmd_branch(). Perhaps, like this:

I'd prefer that, too, but...

> @@ -615,7 +616,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		OPT_BIT('c', "copy", &copy, N_("copy a branch and its reflog"), 1),
>  		OPT_BIT('C', NULL, &copy, N_("copy a branch, even if target exists"), 2),
>  		OPT_BOOL(0, "list", &list, N_("list branch names")),
> -		OPT_BOOL('l', "create-reflog", &reflog, N_("create the branch's reflog")),
> +		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
> +		OPT_HIDDEN_BOOL('l', NULL, &deprecated_reflog_option,
> +				N_("deprecated synonym for --create-reflog")),

Now that "-l" processing is delayed, it interacts in a funny way with
--create-reflog. For instance:

  git branch -l --no-create-reflog

currently cancels itself out, but after your patch would enable reflogs.

This is a pretty niche corner case, but I think it's important not to
change any behavior during the deprecation period. You'd have to do
something more like:

  reflog = -1;

  ... parse options ...

  if (deprecated_reflog_option && !list)
    warning(...);
  if (reflog < 0 && deprecated_reflog_option)
    reflog = 1;

I think that probably works in all cases, but I actually think the
existing callback/global is less invasive.

-Peff
