From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v7 17/19] fsck: Introduce `git fsck --connectivity-only`
Date: Mon, 22 Jun 2015 17:27:12 +0200
Organization: gmx
Message-ID: <cb83b55237198db7cde2d4fcf3765e76137af07e.1434986506.git.johannes.schindelin@gmx.de>
References: <cover.1434720655.git.johannes.schindelin@gmx.de>
 <cover.1434986506.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 22 17:27:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z73dI-0007cJ-6n
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 17:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbbFVP11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 11:27:27 -0400
Received: from mout.gmx.net ([212.227.15.18]:58579 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753870AbbFVP1U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 11:27:20 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M7pDs-1Yu58y2o8e-00vOQj; Mon, 22 Jun 2015 17:27:12
 +0200
In-Reply-To: <cover.1434986506.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:qFqjtCYU/GZZURvSn44FbEaW0lQpSbud/0eOQk9eeucX93SZWRH
 v7aD2x9YGhkItkQJT1rVyfS3IqDuRHQ84USPgNSaDlxygKcc6/dd/20Ytg4YfH5uC9M5ORl
 7uMLvHGsYrTzkCtQx6iOo0rPPyYRJ1FDYtlp+JbACwWgf5/qd29AmMlnpNlfXYYef31UebW
 YPel3H1lVdFo9ufWiQcxg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272388>

This option avoids unpacking each and all blob objects, and just
verifies the connectivity. In particular with large repositories, this
speeds up the operation, at the expense of missing corrupt blobs,
ignoring unreachable objects and other fsck issues, if any.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-fsck.txt |  7 ++++++-
 builtin/fsck.c             |  7 ++++++-
 t/t1450-fsck.sh            | 22 ++++++++++++++++++++++
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 25c431d..84ee92e 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git fsck' [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]
 	 [--[no-]full] [--strict] [--verbose] [--lost-found]
-	 [--[no-]dangling] [--[no-]progress] [<object>*]
+	 [--[no-]dangling] [--[no-]progress] [--connectivity-only] [<object>*]
 
 DESCRIPTION
 -----------
@@ -60,6 +60,11 @@ index file, all SHA-1 references in `refs` namespace, and all reflogs
 	object pools.  This is now default; you can turn it off
 	with --no-full.
 
+--connectivity-only::
+	Check only the connectivity of tags, commits and tree objects. By
+	avoiding to unpack blobs, this speeds up the operation, at the
+	expense of missing corrupt objects or other problematic issues.
+
 --strict::
 	Enable more strict checking, namely to catch a file mode
 	recorded with g+w bit set, which was created by older
diff --git a/builtin/fsck.c b/builtin/fsck.c
index adaa802..2d14298 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -23,6 +23,7 @@ static int show_tags;
 static int show_unreachable;
 static int include_reflogs = 1;
 static int check_full = 1;
+static int connectivity_only;
 static int check_strict;
 static int keep_cache_objects;
 static struct fsck_options fsck_walk_options = FSCK_OPTIONS_DEFAULT;
@@ -181,6 +182,8 @@ static void check_reachable_object(struct object *obj)
 	if (!(obj->flags & HAS_OBJ)) {
 		if (has_sha1_pack(obj->sha1))
 			return; /* it is in pack - forget about it */
+		if (connectivity_only && has_sha1_file(obj->sha1))
+			return;
 		printf("missing %s %s\n", typename(obj->type), sha1_to_hex(obj->sha1));
 		errors_found |= ERROR_REACHABLE;
 		return;
@@ -623,6 +626,7 @@ static struct option fsck_opts[] = {
 	OPT_BOOL(0, "cache", &keep_cache_objects, N_("make index objects head nodes")),
 	OPT_BOOL(0, "reflogs", &include_reflogs, N_("make reflogs head nodes (default)")),
 	OPT_BOOL(0, "full", &check_full, N_("also consider packs and alternate objects")),
+	OPT_BOOL(0, "connectivity-only", &connectivity_only, N_("check only connectivity")),
 	OPT_BOOL(0, "strict", &check_strict, N_("enable more strict checking")),
 	OPT_BOOL(0, "lost-found", &write_lost_and_found,
 				N_("write dangling objects in .git/lost-found")),
@@ -659,7 +663,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	git_config(fsck_config, NULL);
 
 	fsck_head_link();
-	fsck_object_dir(get_object_directory());
+	if (!connectivity_only)
+		fsck_object_dir(get_object_directory());
 
 	prepare_alt_odb();
 	for (alt = alt_odb_list; alt; alt = alt->next) {
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 1727129..956673b 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -431,4 +431,26 @@ test_expect_success 'fsck notices ref pointing to missing tag' '
 	test_must_fail git -C missing fsck
 '
 
+test_expect_success 'fsck --connectivity-only' '
+	rm -rf connectivity-only &&
+	git init connectivity-only &&
+	(
+		cd connectivity-only &&
+		touch empty &&
+		git add empty &&
+		test_commit empty &&
+		empty=.git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391 &&
+		rm -f $empty &&
+		echo invalid >$empty &&
+		test_must_fail git fsck --strict &&
+		git fsck --strict --connectivity-only &&
+		tree=$(git rev-parse HEAD:) &&
+		suffix=${tree#??} &&
+		tree=.git/objects/${tree%$suffix}/$suffix &&
+		rm -f $tree &&
+		echo invalid >$tree &&
+		test_must_fail git fsck --strict --connectivity-only
+	)
+'
+
 test_done
-- 
2.3.1.windows.1.9.g8c01ab4
