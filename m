From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 17/18] fsck: Introduce `git fsck --quick`
Date: Mon, 19 Jan 2015 16:51:58 +0100
Organization: gmx
Message-ID: <5b9bf9ddcac10e3981c9ac7ae5a0af30e25455de.1421682369.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421682369.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 19 17:00:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDEkN-0006Ys-Et
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 17:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbbASQAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2015 11:00:04 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]:35068 "EHLO
	s15462909.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751731AbbASP7k (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2015 10:59:40 -0500
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jan 2015 10:59:22 EST
Received: from s15462909.onlinehome-server.info (localhost.localdomain [127.0.0.1])
	by s15462909.onlinehome-server.info (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id t0JFpxTt026488;
	Mon, 19 Jan 2015 16:51:59 +0100
Received: (from www-data@localhost)
	by s15462909.onlinehome-server.info (8.14.4/8.14.4/Submit) id t0JFpxtW026487;
	Mon, 19 Jan 2015 16:51:59 +0100
X-Authentication-Warning: s15462909.onlinehome-server.info: www-data set sender to johannes.schindelin@gmx.de using -f
X-PHP-Originating-Script: 1000:rcube.php
In-Reply-To: <cover.1421682369.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262633>

This option avoids unpacking each and all objects, and just verifies the
connectivity. In particular with large repositories, this speeds up the
operation, at the expense of missing corrupt blobs and ignoring
unreachable objects, if any.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-fsck.txt |  7 ++++++-
 builtin/fsck.c             |  7 ++++++-
 t/t1450-fsck.sh            | 22 ++++++++++++++++++++++
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 25c431d..b98fb43 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git fsck' [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]
-	 [--[no-]full] [--strict] [--verbose] [--lost-found]
+	 [--[no-]full] [--quick] [--strict] [--verbose] [--lost-found]
 	 [--[no-]dangling] [--[no-]progress] [<object>*]
 
 DESCRIPTION
@@ -60,6 +60,11 @@ index file, all SHA-1 references in `refs` namespace, and all reflogs
 	object pools.  This is now default; you can turn it off
 	with --no-full.
 
+--quick::
+	Check only the connectivity of tags, commits and tree objects. By
+	avoiding to unpack blobs, this speeds up the operation, at the
+	expense of missing corrupt objects.
+
 --strict::
 	Enable more strict checking, namely to catch a file mode
 	recorded with g+w bit set, which was created by older
diff --git a/builtin/fsck.c b/builtin/fsck.c
index d5403c4..c767909 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -23,6 +23,7 @@ static int show_tags;
 static int show_unreachable;
 static int include_reflogs = 1;
 static int check_full = 1;
+static int quick;
 static int check_strict;
 static int keep_cache_objects;
 static struct fsck_options fsck_walk_options = FSCK_OPTIONS_DEFAULT;
@@ -184,6 +185,8 @@ static void check_reachable_object(struct object *obj)
 	if (!(obj->flags & HAS_OBJ)) {
 		if (has_sha1_pack(obj->sha1))
 			return; /* it is in pack - forget about it */
+		if (quick && has_sha1_file(obj->sha1))
+			return;
 		printf("missing %s %s\n", typename(obj->type), sha1_to_hex(obj->sha1));
 		errors_found |= ERROR_REACHABLE;
 		return;
@@ -618,6 +621,7 @@ static struct option fsck_opts[] = {
 	OPT_BOOL(0, "cache", &keep_cache_objects, N_("make index objects head nodes")),
 	OPT_BOOL(0, "reflogs", &include_reflogs, N_("make reflogs head nodes (default)")),
 	OPT_BOOL(0, "full", &check_full, N_("also consider packs and alternate objects")),
+	OPT_BOOL(0, "quick", &quick, N_("check only connectivity")),
 	OPT_BOOL(0, "strict", &check_strict, N_("enable more strict checking")),
 	OPT_BOOL(0, "lost-found", &write_lost_and_found,
 				N_("write dangling objects in .git/lost-found")),
@@ -654,7 +658,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	git_config(fsck_config, NULL);
 
 	fsck_head_link();
-	fsck_object_dir(get_object_directory());
+	if (!quick)
+		fsck_object_dir(get_object_directory());
 
 	prepare_alt_odb();
 	for (alt = alt_odb_list; alt; alt = alt->next) {
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index a79ff9f..1c624a3 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -431,4 +431,26 @@ test_expect_success 'fsck notices ref pointing to missing tag' '
 	test_must_fail git -C missing fsck
 '
 
+test_expect_success 'fsck --quick' '
+	rm -rf quick &&
+	git init quick &&
+	(
+		cd quick &&
+		touch empty &&
+		git add empty &&
+		test_commit empty &&
+		empty=.git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391 &&
+		rm -f $empty &&
+		echo invalid >$empty &&
+		test_must_fail git fsck --strict &&
+		git fsck --strict --quick &&
+		tree=$(git rev-parse HEAD:) &&
+		suffix=${tree#??} &&
+		tree=.git/objects/${tree%$suffix}/$suffix &&
+		rm -f $tree &&
+		echo invalid >$tree &&
+		test_must_fail git fsck --strict --quick
+	)
+'
+
 test_done
-- 
2.0.0.rc3.9669.g840d1f9
