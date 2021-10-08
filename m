Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0F9C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 02:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA4861152
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 02:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbhJHC1r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 22:27:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:35506 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229501AbhJHC1q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 22:27:46 -0400
Received: (qmail 31553 invoked by uid 109); 8 Oct 2021 02:25:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 Oct 2021 02:25:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29765 invoked by uid 111); 8 Oct 2021 02:25:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Oct 2021 22:25:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Oct 2021 22:25:50 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: ab/fsck-unexpected-type (and "cat-file replace handling and
 optimization")
Message-ID: <YV+sLmlWufC5ullA@coredump.intra.peff.net>
References: <xmqqo884tkxd.fsf@gitster.g>
 <87bl43jit5.fsf@evledraar.gmail.com>
 <YVzLRSa9/vUWJPL0@coredump.intra.peff.net>
 <xmqq8rz4pldt.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8rz4pldt.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 07, 2021 at 02:37:02PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I don't mind rebasing on top if that's easier for Junio, but in that
> > case it may make sense to float the test cleanup to the front of the
> > series.
> 
> Yeah, I would rather not to see such a rebase (and I hate the kind
> of churns we seem to be allowing more and more in our codebase that
> causes needless textual conflicts.  We should really slow down and
> make fewer pointless "clean-up" that disrupts real work).

In this case I think neither is churn. I needed to clean up the earlier
part of the test script so that my later tests didn't break, and Ævar
touched the same area to cover more cases in those tests.

> > - test_expect_success 'cat-file -t and -s on corrupt loose object' '
> > - 	git init --bare corrupt-loose.git &&
> > - 	(
> > - 		cd corrupt-loose.git &&
> > ...
> > - 		test_must_fail git fsck 2>err.fsck &&
> > - 		grep "^error: inflate: data stream error (" err.fsck
> > - 	)
> 
> ... what's this lossage of the whole new test?

Whoops, indeed. I was little too anxious in my editor and then read the
combined diff backwards. That test should obviously stay (it is new in
Ævar's series). It still appears in total in the combined diff, but of
course as a "+" on his side.

One other possible thing to do during the resolution is combine the
cleanup of both objects in a single test (since in Ævar's series, both
objects are created together).

I.e., throw away my side from both conflicts, and do this on top:

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 0f52ca9cc8..508a70d877 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -487,6 +487,11 @@ test_expect_success "Size of large broken object is correct when type is large"
 	test_cmp expect actual
 '
 
+test_expect_success 'clean up broken objects' '
+	rm .git/objects/$(test_oid_to_path $bogus_short_sha1) \
+	   .git/objects/$(test_oid_to_path $bogus_long_sha1)
+'
+
 test_expect_success 'cat-file -t and -s on corrupt loose object' '
 	git init --bare corrupt-loose.git &&
 	(

That makes the merge more evil, but the end result is perhaps a little
nicer for people reading it later.

Thanks for reading my proposed resolution so carefully. :)

-Peff
