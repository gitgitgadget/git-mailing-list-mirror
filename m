Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F12B203BD
	for <e@80x24.org>; Thu, 14 Jul 2016 22:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbcGNWUw (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 18:20:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:45062 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750699AbcGNWUu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 18:20:50 -0400
Received: (qmail 19077 invoked by uid 102); 14 Jul 2016 22:20:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 18:20:51 -0400
Received: (qmail 10413 invoked by uid 107); 14 Jul 2016 22:21:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 18:21:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2016 18:20:47 -0400
Date:	Thu, 14 Jul 2016 18:20:47 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 2/2] archive-tar: huge offset and future timestamps
 would not work on 32-bit
Message-ID: <20160714222047.GA21868@sigill.intra.peff.net>
References: <xmqq7fcoot6t.fsf@gitster.mtv.corp.google.com>
 <20160714204357.2628-1-gitster@pobox.com>
 <20160714204357.2628-3-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160714204357.2628-3-gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 01:43:57PM -0700, Junio C Hamano wrote:

> As we are not yet moving everything to size_t but still using ulong
> internally when talking about the size of object, platforms with
> 32-bit long will not be able to produce tar archive with 4GB+ file,
> and cannot grok 077777777777UL as a constant.  Disable the extended
> header feature and do not test it on them.

I tried testing this in a VM with 32-bit Debian. It fixes the build
problems, but t5000 still fails.

I think you need to add the prereq to one more test:

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 699355b..80b2387 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -347,7 +347,7 @@ test_lazy_prereq TAR_HUGE '
 	test_cmp expect actual
 '
 
-test_expect_success 'set up repository with huge blob' '
+test_expect_success LONG_IS_64BIT 'set up repository with huge blob' '
 	obj_d=19 &&
 	obj_f=f9c8273ec45a8938e6999cb59b3ff66739902a &&
 	obj=${obj_d}${obj_f} &&

We shouldn't be accessing the blob in update-index, but I think "git
commit" does so for the diff (and then after seeing the size says
"whoops, that's binary", but even the size check fails on 32-bit
systems).

So another solution would be to use "commit -q" at the end of that test.
I don't think there's much point, though; it's just setting up a state
for other tests that need LONG_IS_64BIT.

As an aside, it is inadvertently testing that our diff code does not
bother to read the whole blob in such a case. Which maybe argues for
using "commit -q", just because that is not a thing we are intending to
test here.

-Peff
