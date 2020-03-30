Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3391AC43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 14:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0655C2073B
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 14:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgC3ODL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:03:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:55608 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726312AbgC3ODL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 10:03:11 -0400
Received: (qmail 15152 invoked by uid 109); 30 Mar 2020 14:03:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 30 Mar 2020 14:03:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18691 invoked by uid 111); 30 Mar 2020 14:13:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Mar 2020 10:13:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 30 Mar 2020 10:03:09 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/7] oid_array: use size_t for count and allocation
Message-ID: <20200330140309.GA2456038@coredump.intra.peff.net>
References: <20200330140247.GA476088@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200330140247.GA476088@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The oid_array object uses an "int" to store the number of items and the
allocated size. It's rather unlikely for somebody to have more than 2^31
objects in a repository (the sha1's alone would be 40GB!), but if they
do, we'd overflow our alloc variable.

You can reproduce this case with something like:

  git init repo
  cd repo

  # make a pack with 2^24 objects
  perl -e '
    my $nr = 2**24;

    for (my $i = 0; $i < $nr; $i++) {
	    print "blob\n";
	    print "data 4\n";
	    print pack("N", $i);
    }
  ' | git fast-import

  # now make 256 copies of it; most of these objects will be duplicates,
  # but oid_array doesn't de-dup until all values are read and it can
  # sort the result.
  cd .git/objects/pack/
  pack=$(echo *.pack)
  idx=$(echo *.idx)
  for i in $(seq 0 255); do
    # no need to waste disk space
    ln "$pack" "pack-extra-$i.pack"
    ln "$idx" "pack-extra-$i.idx"
  done

  # and now force an oid_array to store all of it
  git cat-file --batch-all-objects --batch-check

which results in:

  fatal: size_t overflow: 32 * 18446744071562067968

So the good news is that st_mult() sees the problem (the large number is
because our int wraps negative, and then that gets cast to a size_t),
doing the job it was meant to: bailing in crazy situations rather than
causing an undersized buffer.

But we should avoid hitting this case at all, and instead limit
ourselves based on what malloc() is willing to give us. We can easily do
that by switching to size_t.

The cat-file process above made it to ~120GB virtual set size before the
integer overflow (our internal hash storage is 32-bytes now in
preparation for sha256, so we'd expect ~128GB total needed, plus
potentially more to copy from one realloc'd block to another)). After
this patch (and about 130GB of RAM+swap), it does eventually read in the
whole set. No test for obvious reasons.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1-array.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sha1-array.h b/sha1-array.h
index dc1bca9c9a..c5e4b9324f 100644
--- a/sha1-array.h
+++ b/sha1-array.h
@@ -49,8 +49,8 @@
  */
 struct oid_array {
 	struct object_id *oid;
-	int nr;
-	int alloc;
+	size_t nr;
+	size_t alloc;
 	int sorted;
 };
 
-- 
2.26.0.597.g7e08ed78ff

