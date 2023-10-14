Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35547E
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 00:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A389991
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 17:43:50 -0700 (PDT)
Received: (qmail 27706 invoked by uid 109); 14 Oct 2023 00:43:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 14 Oct 2023 00:43:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17764 invoked by uid 111); 14 Oct 2023 00:43:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Oct 2023 20:43:52 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 13 Oct 2023 20:43:48 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 21/20] t5319: make corrupted large-offset test more robust
Message-ID: <20231014004348.GA43880@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009205544.GA3281950@coredump.intra.peff.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 04:55:44PM -0400, Jeff King wrote:

>   [10/20]: midx: bounds-check large offset chunk

Here's one more patch on top that fixes a flaky test. Sorry not to have
caught it before sending out the original series. I did see a flaky CI
run before then, but I tweaked the test with what I thought was the
solution, and then it didn't re-occur until I ran CI again today.

I'm pretty sure this should fix it for good.

(I also saw Taylor posted some further patches; I haven't looked closely
yet, this should be orthogonal to those).

-- >8 --
Subject: [PATCH] t5319: make corrupted large-offset test more robust

The test t5319.88 ("reader bounds-checks large offset table") can fail
intermittently. The failure mode looks like this:

  1. An earlier test sets up "objects64", a directory that can be used
     to produce a midx with a corrupted large-offsets table. To get the
     large offsets, it corrupts the normal ".idx" file to have a fake
     large offset, and then builds a midx from that.

     That midx now has a large offset table, which is what we want. But
     we also have a .idx on disk that has a corrupted entry. We'll call
     the object with the corrupted large-offset "X".

  2. In t5319.88, we further corrupt the midx by reducing the size of
     the large-offset chunk (because our goal is to make sure we do not
     do an out-of-bounds read on it).

  3. We then enumerate all of the objects with "cat-file --batch-check
     --batch-all-objects", expecting to see a complaint when we try to
     show object X. We use --batch-all-objects because our objects64
     repo doesn't actually have any refs (but if we check them all, one
     of them will be the failing one). The default batch-check format
     includes %(objecttype) and %(objectsize), both of which require us
     to access the actual pack data (and thus requires looking at the
     offset).

  4a. Usually, this succeeds. We try to output object X, do a lookup via
      the midx for the type/size lookup, and run into the corrupt
      large-offset table.

  4b. But sometimes we hit a different error. If another object points
      to X as a delta base, then trying to find the type of that object
      requires walking the delta chain to the base entry (since only the
      base has the concrete type; deltas themselves are either OFS_DELTA
      or REF_DELTA).

      Normally this would not require separate offset lookups at all, as
      deltas are usually stored as OFS_DELTA, specifying the relative
      offset to the base. But the corrupt idx created in step 1 is done
      directly with "git pack-objects" and does not pass the
      --delta-base-offset option, meaning we have REF_DELTA entries!
      Those do have to consult an index to find the location of the base
      object, and they use the pack .idx to do this. The same pack .idx
      that we know is corrupted from step 1!

      Git does notice the error, but it does so by seeing the corrupt
      .idx file, not the corrupt midx file, and the error it reports is
      different, causing the test to fail.

The set of objects created in the test is deterministic. But the delta
selection seems not to be (which is not too surprising, as it is
multi-threaded). I have seen the failure in Windows CI but haven't
reproduced it locally (not even with --stress). Re-running a failed
Windows CI job tends to work. But when I download and examine the trash
directory from a failed run, it shows a different set of deltas than I
get locally. But the exact source of non-determinism isn't that
important; our test should be robust against any order.

There are a few options to fix this:

  a. It would be OK for the "objects64" setup to "unbreak" the .idx file
     after generating the midx. But then it would be hard for subsequent
     tests to reuse it, since it is the corrupted idx that forces the
     midx to have a large offset table.

  b. The "objects64" setup could use --delta-base-offset. This would fix
     our problem, but earlier tests have many hard-coded offsets. Using
     OFS_DELTA would change the locations of objects in the pack (this
     might even be OK because I think most of the offsets are within the
     .idx file, but it seems brittle and I'm afraid to touch it).

  c. Our cat-file output is in oid order by default. Since we store
     bases before deltas, if we went in pack order (using the
     "--unordered" flag), we'd always see our corrupt X before any delta
     which depends on it. But using "--unordered" means we skip the midx
     entirely. That makes sense, since it is just enumerating all of
     the packs, using the offsets found in their .idx files directly.
     So it doesn't work for our test.

  d. We could ask directly about object X, rather than enumerating all
     of them. But that requires further hard-coding of the oid (both
     sha1 and sha256) of object X. I'd prefer not to introduce more
     brittleness.

  e. We can use a --batch-check format that looks at the pack data, but
     doesn't have to chase deltas. The problem in this case is
     %(objecttype), which has to walk to the base. But %(objectsize)
     does not; we can get the value directly from the delta itself.
     Another option would be %(deltabase), where we report the REF_DELTA
     name but don't look at its data.

I've gone with option (e) here. It's kind of subtle, but it's simple and
has no side effects.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5319-multi-pack-index.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 2a11dd1af6..d3c9e97feb 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1129,8 +1129,10 @@ test_expect_success 'reader bounds-checks large offset table' '
 		git multi-pack-index --object-dir=../objects64 write &&
 		midx=../objects64/pack/multi-pack-index &&
 		corrupt_chunk_file $midx LOFF clear &&
-		test_must_fail git cat-file \
-			--batch-check --batch-all-objects 2>err &&
+		# using only %(objectsize) is important here; see the commit
+		# message for more details
+		test_must_fail git cat-file --batch-all-objects \
+			--batch-check="%(objectsize)" 2>err &&
 		cat >expect <<-\EOF &&
 		fatal: multi-pack-index large offset out of bounds
 		EOF
-- 
2.42.0.937.g4d9eb42d36

