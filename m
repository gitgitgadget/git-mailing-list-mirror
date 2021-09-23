Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A33C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 21:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6014B6103C
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 21:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243378AbhIWVjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 17:39:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:53970 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243380AbhIWVjl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 17:39:41 -0400
Received: (qmail 16053 invoked by uid 109); 23 Sep 2021 21:38:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Sep 2021 21:38:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32611 invoked by uid 111); 23 Sep 2021 21:38:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Sep 2021 17:38:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Sep 2021 17:38:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Andrzej Hunt <andrzej@ahunt.org>
Subject: Re: [PATCH] connect: also update offset for features without values
Message-ID: <YUzzwCwlR9AwSeOD@coredump.intra.peff.net>
References: <pull.1091.git.git.1631970872884.gitgitgadget@gmail.com>
 <xmqq4kabyoo3.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4kabyoo3.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 23, 2021 at 02:20:28PM -0700, Junio C Hamano wrote:

> > +test_expect_success 'bogus symref in v0 capabilities' '
> > +	test_commit foo &&
> > +	oid=$(git rev-parse HEAD) &&
> > +	{
> > +		printf "%s HEAD\0symref object-format=%s\n" "$oid" "$GIT_DEFAULT_HASH" |
> > +			test-tool pkt-line pack-raw-stdin &&
> > +		printf "0000"
> > +	} >input &&
> > +	git ls-remote --upload-pack="cat input ;:" . >actual &&
> > +	printf "%s\tHEAD\n" "$oid" >expect &&
> > +	test_cmp expect actual
> > +'
> > +
> >  test_done
> >
> > base-commit: 186eaaae567db501179c0af0bf89b34cbea02c26
> 
> I've been seeing an occasional and not-reliably-reproducible test
> failure from t5704 in 'seen' these days---since this is the only
> commit that touches t5704, I am suspecting if there is something
> racy about it, but I am coming up empty after staring at it for a
> few minutes.
> 
> Building 87446480 (connect: also update offset for features without
> values, 2021-09-18), which is an application of the patch directly on
> top of v2.33.0, and doing
> 
>     $ cd t
>     $ while sh t5704-*.sh; do :; done
> 
> I can get it fail in a dozen iterations or so when the box is
> loaded, so it does seem timing dependent.

I think the problem is that our fake upload-pack exits immediately, so
ls-remote gets SIGPIPE. In a v0 conversation, ls-remote expects to say
"0000" to indicate that it's not interested in fetching anything (in v2,
it doesn't bother, since fetching would be a separate request that it
just declines to make).

This seems to fix it:

diff --git a/t/t5704-protocol-violations.sh b/t/t5704-protocol-violations.sh
index 34538cebf0..0983c2b507 100755
--- a/t/t5704-protocol-violations.sh
+++ b/t/t5704-protocol-violations.sh
@@ -40,7 +40,7 @@ test_expect_success 'bogus symref in v0 capabilities' '
 			test-tool pkt-line pack-raw-stdin &&
 		printf "0000"
 	} >input &&
-	git ls-remote --upload-pack="cat input ;:" . >actual &&
+	git ls-remote --upload-pack="cat input; read junk;:" . >actual &&
 	printf "%s\tHEAD\n" "$oid" >expect &&
 	test_cmp expect actual
 '

-Peff
