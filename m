From: Jeff King <peff@peff.net>
Subject: [PATCH 2/6] repack: respect pack.writebitmaps
Date: Tue, 10 Jun 2014 16:09:23 -0400
Message-ID: <20140610200923.GB14974@sigill.intra.peff.net>
References: <20140610200741.GA11248@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 10 22:09:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuSMO-00050i-2r
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 22:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbaFJUJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 16:09:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:41243 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755473AbaFJUJY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 16:09:24 -0400
Received: (qmail 13349 invoked by uid 102); 10 Jun 2014 20:09:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jun 2014 15:09:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jun 2014 16:09:23 -0400
Content-Disposition: inline
In-Reply-To: <20140610200741.GA11248@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251225>

The config option to turn on bitmaps is read all the way
down in the plumbing of pack-objects. This makes it hard for
other options in the porcelain of repack to make decisions
based on the bitmap setting. For example,
repack.packKeptObjects tries to kick in by default only when
bitmaps are turned on. But it can't do so reliably because
it doesn't yet know whether we are using bitmaps.

This patch teaches repack to respect pack.writebitmaps. It
means we pass a redundant command-line flag to pack-objects,
but that's OK; it shouldn't affect the outcome.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/repack.c  |  6 +++++-
 t/t7700-repack.sh | 18 +++++++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 17bc8da..fab9989 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -10,6 +10,7 @@
 
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
+static int write_bitmap = -1;
 static char *packdir, *packtmp;
 
 static const char *const git_repack_usage[] = {
@@ -27,6 +28,10 @@ static int repack_config(const char *var, const char *value, void *cb)
 		pack_kept_objects = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "pack.writebitmaps")) {
+		write_bitmap = git_config_bool(var, value);
+		return 0;
+	}
 	return git_default_config(var, value, cb);
 }
 
@@ -149,7 +154,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	int no_update_server_info = 0;
 	int quiet = 0;
 	int local = 0;
-	int write_bitmap = -1;
 
 	struct option builtin_repack_options[] = {
 		OPT_BIT('a', NULL, &pack_everything,
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index f054434..61e6ed3 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -35,7 +35,7 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 	test -z "$found_duplicate_object"
 '
 
-test_expect_success 'writing bitmaps can duplicate .keep objects' '
+test_expect_success 'writing bitmaps via command-line can duplicate .keep objects' '
 	# build on $objsha1, $packsha1, and .keep state from previous
 	git repack -Adbl &&
 	test_when_finished "found_duplicate_object=" &&
@@ -51,6 +51,22 @@ test_expect_success 'writing bitmaps can duplicate .keep objects' '
 	test "$found_duplicate_object" = 1
 '
 
+test_expect_success 'writing bitmaps via config can duplicate .keep objects' '
+	# build on $objsha1, $packsha1, and .keep state from previous
+	git -c pack.writebitmaps=true repack -Adl &&
+	test_when_finished "found_duplicate_object=" &&
+	for p in .git/objects/pack/*.idx; do
+		idx=$(basename $p)
+		test "pack-$packsha1.idx" = "$idx" && continue
+		if git verify-pack -v $p | egrep "^$objsha1"; then
+			found_duplicate_object=1
+			echo "DUPLICATE OBJECT FOUND"
+			break
+		fi
+	done &&
+	test "$found_duplicate_object" = 1
+'
+
 test_expect_success 'loose objects in alternate ODB are not repacked' '
 	mkdir alt_objects &&
 	echo `pwd`/alt_objects > .git/objects/info/alternates &&
-- 
2.0.0.729.g520999f
