Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B636CC433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 07:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86D726134F
	for <git@archiver.kernel.org>; Thu, 13 May 2021 07:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhEMHYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 03:24:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:53298 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229786AbhEMHYd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 03:24:33 -0400
Received: (qmail 32347 invoked by uid 109); 13 May 2021 07:23:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 May 2021 07:23:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13753 invoked by uid 111); 13 May 2021 07:23:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 May 2021 03:23:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 May 2021 03:23:21 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] t: avoid sed-based chain-linting in some expensive cases
Message-ID: <YJzT6dUBm82L1qZa@coredump.intra.peff.net>
References: <YJzGcZpZ+E9R0gYd@coredump.intra.peff.net>
 <xmqqim3nb01b.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqim3nb01b.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 13, 2021 at 03:49:52PM +0900, Junio C Hamano wrote:

> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index adaa2db601..adaf03543e 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -947,8 +947,11 @@ test_run_ () {
> >  		trace=
> >  		# 117 is magic because it is unlikely to match the exit
> >  		# code of other programs
> > -		if $(printf '%s\n' "$1" | sed -f "$GIT_BUILD_DIR/t/chainlint.sed" | grep -q '?![A-Z][A-Z]*?!') ||
> > -			test "OK-117" != "$(test_eval_ "(exit 117) && $1${LF}${LF}echo OK-\$?" 3>&1)"
> > +		if test "OK-117" != "$(test_eval_ "(exit 117) && $1${LF}${LF}echo OK-\$?" 3>&1)" ||
> > +		   {
> > +			test "${GIT_TEST_CHAIN_LINT_HARDER:-${GIT_TEST_CHAIN_LINT_HARDER_DEFAULT:-1}}" != 0 &&
> > +			$(printf '%s\n' "$1" | sed -f "$GIT_BUILD_DIR/t/chainlint.sed" | grep -q '?![A-Z][A-Z]*?!')
> > +		   }
> 
> We have been doing the more expensive one first, but we now
> optionally skip it while retaining the one that uses the shell.
> OK.

Oh yeah, I meant to call that out. I flipped them mostly because it made
the conditional easier to read (though as you can see, it's already
quite a mouthful).

In practice the short-circuit doesn't help us much, though. Unless a
test is buggy, we end up having to run both tests either way, no matter
the order.

-Peff
