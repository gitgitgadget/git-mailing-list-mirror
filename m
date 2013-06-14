From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] unpack_entry: do not die when we fail to apply a delta
Date: Fri, 14 Jun 2013 17:53:34 -0400
Message-ID: <20130614215334.GB3821@sigill.intra.peff.net>
References: <20130614214943.GA29138@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Jun 14 23:53:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnbwG-0000px-BE
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 23:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314Ab3FNVxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 17:53:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:59428 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752009Ab3FNVxk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 17:53:40 -0400
Received: (qmail 22800 invoked by uid 102); 14 Jun 2013 21:54:34 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Jun 2013 16:54:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Jun 2013 17:53:34 -0400
Content-Disposition: inline
In-Reply-To: <20130614214943.GA29138@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227922>

When we try to load an object from disk and fail, our
general strategy is to see if we can get it from somewhere
else (e.g., a loose object). That lets users fix corruption
problems by copying known-good versions of objects into the
object database.

We already handle the case where we were not able to read
the delta from disk. However, when we find that the delta we
read does not apply, we simply die.  This case is harder to
trigger, as corruption in the delta data itself would
trigger a crc error from zlib.  However, a corruption that
pointed us at the wrong delta base might cause it.

We can do the same "fail and try to find the object
elsewhere" trick instead of dying. This not only gives us a
chance to recover, but also puts us on code paths that will
alert the user to the problem (with the current message,
they do not even know which sha1 caused the problem).

Note that unlike some other pack corruptions, we do not
recover automatically from this case when doing a repack.
There is nothing apparently wrong with the delta, as it
points to a valid, accessible object, and we realize the
error only when the resulting size does not match up. And in
theory, one could even have a case where the corrupted size
is the same, and the problem would only be noticed by
recomputing the sha1.

We can get around this by recomputing the deltas with
--no-reuse-delta, which our test does (and this is probably
good advice for anyone recovering from pack corruption).

Signed-off-by: Jeff King <peff@peff.net>
---
I don't know if it is worth showing that pack-objects without
"--no-reuse-delta" does not help this case with a test_expect_failure. I
don't have plans to work on it, and I'm not sure that it is a big deal.

 sha1_file.c                           | 11 ++++++++++-
 t/t5303-pack-corruption-resilience.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 5c08701..d458708 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2135,8 +2135,17 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 		data = patch_delta(base, base_size,
 				   delta_data, delta_size,
 				   &size);
+
+		/*
+		 * We could not apply the delta; warn the user, but keep going.
+		 * Our failure will be noticed either in the next iteration of
+		 * the loop, or if this is the final delta, in the caller when
+		 * we return NULL. Those code paths will take care of making
+		 * a more explicit warning and retrying with another copy of
+		 * the object.
+		 */
 		if (!data)
-			die("failed to apply delta");
+			error("failed to apply delta");
 
 		free(delta_data);
 	}
diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index 9cb8172..35926de 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -276,6 +276,33 @@ test_expect_success \
      git cat-file blob $blob_3 > /dev/null'
 
 test_expect_success \
+    'corruption of delta base reference pointing to wrong object' \
+    'create_new_pack --delta-base-offset &&
+     git prune-packed &&
+     printf "\220\033" | do_corrupt_object $blob_3 2 &&
+     git cat-file blob $blob_1 >/dev/null &&
+     git cat-file blob $blob_2 >/dev/null &&
+     test_must_fail git cat-file blob $blob_3 >/dev/null'
+
+test_expect_success \
+    '... but having a loose copy allows for full recovery' \
+    'mv ${pack}.idx tmp &&
+     git hash-object -t blob -w file_3 &&
+     mv tmp ${pack}.idx &&
+     git cat-file blob $blob_1 > /dev/null &&
+     git cat-file blob $blob_2 > /dev/null &&
+     git cat-file blob $blob_3 > /dev/null'
+
+test_expect_success \
+    '... and then a repack "clears" the corruption' \
+    'do_repack --delta-base-offset --no-reuse-delta &&
+     git prune-packed &&
+     git verify-pack ${pack}.pack &&
+     git cat-file blob $blob_1 > /dev/null &&
+     git cat-file blob $blob_2 > /dev/null &&
+     git cat-file blob $blob_3 > /dev/null'
+
+test_expect_success \
     'corrupting header to have too small output buffer fails unpack' \
     'create_new_pack &&
      git prune-packed &&
-- 
1.8.3.rc2.14.g7eee6b3
