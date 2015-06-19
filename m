From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v6 17/19] fsck: Introduce `git fsck --quick`
Date: Fri, 19 Jun 2015 15:35:27 +0200
Organization: gmx
Message-ID: <5f1c4c16027b00ef80490d67bec5e948481153ec.1434720655.git.johannes.schindelin@gmx.de>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 19 15:36:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5wTG-00024I-U9
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 15:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882AbbFSNfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 09:35:33 -0400
Received: from mout.gmx.net ([212.227.15.18]:59372 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751779AbbFSNfb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 09:35:31 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MYwVv-1ZbeMG1m79-00Ve62; Fri, 19 Jun 2015 15:35:27
 +0200
In-Reply-To: <cover.1434720655.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:Kzb9Am2okKQN40WNZXwbR0osrQaQmZK12CJZrGKf4aduFt8bn38
 bRBXYbd/LunoEotQQJejqSloU+LfUbMDZO/JS/DnEmhAkz9K6Y7BwMeopoHq0v0RlwcEpb2
 etIYtJR6FXMlKN9rF5WHrTvpV0BpxN+JX1NTIPFbYmwW1VQdA7cZ6yxr0q/gcImo45O+z1O
 zM5foTywmWudAFWNO1EXQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272153>

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
index 6de9f3e..75fcb5f 100644
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
@@ -181,6 +182,8 @@ static void check_reachable_object(struct object *obj)
 	if (!(obj->flags & HAS_OBJ)) {
 		if (has_sha1_pack(obj->sha1))
 			return; /* it is in pack - forget about it */
+		if (quick && has_sha1_file(obj->sha1))
+			return;
 		printf("missing %s %s\n", typename(obj->type), sha1_to_hex(obj->sha1));
 		errors_found |= ERROR_REACHABLE;
 		return;
@@ -623,6 +626,7 @@ static struct option fsck_opts[] = {
 	OPT_BOOL(0, "cache", &keep_cache_objects, N_("make index objects head nodes")),
 	OPT_BOOL(0, "reflogs", &include_reflogs, N_("make reflogs head nodes (default)")),
 	OPT_BOOL(0, "full", &check_full, N_("also consider packs and alternate objects")),
+	OPT_BOOL(0, "quick", &quick, N_("check only connectivity")),
 	OPT_BOOL(0, "strict", &check_strict, N_("enable more strict checking")),
 	OPT_BOOL(0, "lost-found", &write_lost_and_found,
 				N_("write dangling objects in .git/lost-found")),
@@ -659,7 +663,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	git_config(fsck_config, NULL);
 
 	fsck_head_link();
-	fsck_object_dir(get_object_directory());
+	if (!quick)
+		fsck_object_dir(get_object_directory());
 
 	prepare_alt_odb();
 	for (alt = alt_odb_list; alt; alt = alt->next) {
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 922c346..2863a8a 100755
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
2.3.1.windows.1.9.g8c01ab4
