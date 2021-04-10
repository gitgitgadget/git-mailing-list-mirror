Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D70CC433ED
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 01:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1689561108
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 01:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbhDJB1J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 21:27:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:47404 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235201AbhDJB1J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 21:27:09 -0400
Received: (qmail 4734 invoked by uid 109); 10 Apr 2021 01:26:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 10 Apr 2021 01:26:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18664 invoked by uid 111); 10 Apr 2021 01:26:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Apr 2021 21:26:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Apr 2021 21:26:54 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] test-lib: allow test snippets as here-docs
Message-ID: <YHD+3mKoQmzIagjF@coredump.intra.peff.net>
References: <YHDUg6ZR5vu93kGm@coredump.intra.peff.net>
 <YHDVAxxKDzfTlq3h@coredump.intra.peff.net>
 <xmqqtuofkqxu.fsf@gitster.g>
 <xmqqh7kfklcp.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7kfklcp.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 09, 2021 at 05:57:10PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> +	# start with a newline, to match hanging newline from open-quote style
> >> +	eval "$1=\$LF"
> >> +	local test_line
> >> +	while IFS= read -r test_line
> >> +	do
> >> +		eval "$1=\${$1}\${test_line}\${LF}"
> >> +	done
> >
> > I wonder if we can do this without relying on "read -r" (which I
> > distrust, perhaps out of superstition)?  Perhaps by slurping the
> > whole thing with "$(cat)"?
> 
> Meaning, something along this line...
> 
> ----- >8 --------- >8 --------- >8 --------- >8 ----
> #!/bin/sh
> LF='
> '
> ttt () {
> 	eval "$1"='$LF$(cat)'
> }
> ttt script <<\EOT
> 	a
> 	b
> EOT
> echo "<<<$script>>>"
> ----- 8< --------- 8< --------- 8< --------- 8< ----

I wrote it using cat initially. If you want to preserve trailing
whitespace, you have to do something like:

  val=$(printf '\n'
        cat
	printf '.')
  val=${val%.}

I was worried about adding the overhead of the extra subshell and
process for the command substitution, but perhaps that is overblown.
TBH, worrying about whitespace may be overblown, too. Some test snippets
have extra blank lines at the end, but possibly we should just not care.

I imagine "read -r" does not work reliably for binary junk, but keep in
mind that we are talking about text shell script snippets (that are
already in shell strings anyway).

-Peff
