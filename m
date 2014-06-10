From: Jeff King <peff@peff.net>
Subject: [PATCH 6/6] repack: introduce repack.writeBitmaps config option
Date: Tue, 10 Jun 2014 16:20:30 -0400
Message-ID: <20140610202030.GF14974@sigill.intra.peff.net>
References: <20140610200741.GA11248@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 10 22:20:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuSX8-0005tV-Uk
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 22:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755198AbaFJUUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 16:20:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:41266 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754332AbaFJUUc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 16:20:32 -0400
Received: (qmail 14000 invoked by uid 102); 10 Jun 2014 20:20:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jun 2014 15:20:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jun 2014 16:20:30 -0400
Content-Disposition: inline
In-Reply-To: <20140610200741.GA11248@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251230>

We currently have pack.writeBitmaps, which originally
operated at the pack-objects level. This should really have
been a repack.* option from day one. Let's give it the more
sensible name, but keep the old version as a deprecated
synonym.

Signed-off-by: Jeff King <peff@peff.net>
---
We can still do this if we don't take 4/6, but the "this is a synonym"
in the documentation is not quite true, then. We'd probably want to
explain the difference.

 Documentation/config.txt     | 17 ++++++++++-------
 builtin/repack.c             |  3 ++-
 t/perf/p5310-pack-bitmaps.sh |  3 +++
 t/t5310-pack-bitmaps.sh      |  2 +-
 t/t7700-repack.sh            |  2 +-
 5 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index cd2d651..8f0f800 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1901,12 +1901,7 @@ pack.useBitmaps::
 	you are debugging pack bitmaps.
 
 pack.writebitmaps::
-	When true, git will write a bitmap index when packing all
-	objects to disk (e.g., when `git repack -a` is run).  This
-	index can speed up the "counting objects" phase of subsequent
-	packs created for clones and fetches, at the cost of some disk
-	space and extra time spent on the initial repack.  Defaults to
-	false.
+	This is a deprecated synonym for `repack.writeBitmaps`.
 
 pack.writeBitmapHashCache::
 	When true, git will include a "hash cache" section in the bitmap
@@ -2183,7 +2178,15 @@ repack.packKeptObjects::
 	`--pack-kept-objects` was passed. See linkgit:git-repack[1] for
 	details. Defaults to `false` normally, but `true` if a bitmap
 	index is being written (either via `--write-bitmap-index` or
-	`pack.writeBitmaps`).
+	`repack.writeBitmaps`).
+
+repack.writeBitmaps::
+	When true, git will write a bitmap index when packing all
+	objects to disk (e.g., when `git repack -a` is run).  This
+	index can speed up the "counting objects" phase of subsequent
+	packs created for clones and fetches, at the cost of some disk
+	space and extra time spent on the initial repack.  Defaults to
+	false.
 
 rerere.autoupdate::
 	When set to true, `git-rerere` updates the index with the
diff --git a/builtin/repack.c b/builtin/repack.c
index 0e119b7..ff2216a 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -28,7 +28,8 @@ static int repack_config(const char *var, const char *value, void *cb)
 		pack_kept_objects = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp(var, "pack.writebitmaps")) {
+	if (!strcmp(var, "repack.writebitmaps") ||
+	    !strcmp(var, "pack.writebitmaps")) {
 		write_bitmaps = git_config_bool(var, value);
 		return 0;
 	}
diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
index 685d46f..f8ed857 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -8,6 +8,9 @@ test_perf_large_repo
 # note that we do everything through config,
 # since we want to be able to compare bitmap-aware
 # git versus non-bitmap git
+#
+# We intentionally use the deprecated pack.writebitmaps
+# config so that we can test against older versions of git.
 test_expect_success 'setup bitmap config' '
 	git config pack.writebitmaps true &&
 	git config pack.writebitmaphashcache true
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index f4f02ba..0580258 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -18,7 +18,7 @@ test_expect_success 'setup repo with moderate-sized history' '
 	git checkout master &&
 	blob=$(echo tagged-blob | git hash-object -w --stdin) &&
 	git tag tagged-blob $blob &&
-	git config pack.writebitmaps true &&
+	git config repack.writebitmaps true &&
 	git config pack.writebitmaphashcache true
 '
 
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 61e6ed3..82d39ad 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -53,7 +53,7 @@ test_expect_success 'writing bitmaps via command-line can duplicate .keep object
 
 test_expect_success 'writing bitmaps via config can duplicate .keep objects' '
 	# build on $objsha1, $packsha1, and .keep state from previous
-	git -c pack.writebitmaps=true repack -Adl &&
+	git -c repack.writebitmaps=true repack -Adl &&
 	test_when_finished "found_duplicate_object=" &&
 	for p in .git/objects/pack/*.idx; do
 		idx=$(basename $p)
-- 
2.0.0.729.g520999f
