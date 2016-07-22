Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0454203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 19:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934AbcGVT2Q (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 15:28:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:48780 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751688AbcGVT2P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 15:28:15 -0400
Received: (qmail 21059 invoked by uid 102); 22 Jul 2016 19:28:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jul 2016 15:28:15 -0400
Received: (qmail 8982 invoked by uid 107); 22 Jul 2016 19:28:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jul 2016 15:28:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jul 2016 15:28:11 -0400
Date:	Fri, 22 Jul 2016 15:28:11 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Richard Soderberg <rsoderberg@gmail.com>, git@vger.kernel.org
Subject: Re: git-prompt.sh incompatible with non-basic global grep.patternType
Message-ID: <20160722192811.GA18079@sigill.intra.peff.net>
References: <CAEvc1UQvXKtQCXvCmt-774A84--bkK-sb94BtFeqDDr0Gsf7qw@mail.gmail.com>
 <20160720134211.GA19359@sigill.intra.peff.net>
 <xmqqwpkgcbp9.fsf@gitster.mtv.corp.google.com>
 <20160720205207.GA578@sigill.intra.peff.net>
 <xmqqr3ala37o.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr3ala37o.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 22, 2016 at 12:21:31PM -0700, Junio C Hamano wrote:

> One thing that I noticed is that there is this strange field
> in grep_opt called .extended_regexp_option; it only is set from the
> boolean configuration grep.extendedregexp and worse yet it takes
> precedence over the command line option or grep.patternType, e.g.
> t7810-grep expects crazy things like these:
> 
>  * "git -c grep.extendedregexp=true -c grep.patterntype=basic grep"
>    wants to be like "git grep -E"
> 
>  * "git -c grep.extendedregexp=false -c grep.patterntype=extended grep"
>    wants to be like "git grep -G"
> 
> This comes from b22520a3 (grep: allow -E and -n to be turned on by
> default via configuration, 2011-03-30) back when we didn't have a
> more generic grep.patternType configuration mechanism in v1.7.5
> days, and it probably need to be deprecated to maintain our sanity.
> I.e. when we see the configuration used, first we warn the user and
> set grep.patternType to extended instead, and then eventually error
> out in a backward-compatibility breaking release of Git we will make
> in some future date, together with things like other compatibility
> breaking topics like ex/deprecate-empty-pathspec-as-match-all.
> 
> But that is a separate topic after this fix goes in anyway.

I am not even sure we need to deprecate it. Once it becomes merely a
historical synonym for "grep.patternType=extended" we can live with it
indefinitely (and I do not think we need a deprecation period to go
there; the existing behavior is simply buggy).

Not that I mind eventually removing it, if you want to go through the
steps.

> -- >8 --
> From: Junio C Hamano <gitster@pobox.com>
> Date: Fri, 22 Jul 2016 11:43:14 -0700
> Subject: [PATCH] grep: further simplify setting the pattern type
> [...]

Thanks. This matches the cursory analysis I had done earlier, and the
patch looks exactly as I had expected.

-Peff
