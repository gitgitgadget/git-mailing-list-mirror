From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 7/7] environment: add global variable to disable replacement
Date: Fri, 23 Jan 2009 10:07:46 +0100
Message-ID: <20090123100746.51335fa5.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 10:09:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQI2F-00082C-64
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 10:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269AbZAWJHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 04:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754038AbZAWJHb
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 04:07:31 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:56074 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755041AbZAWJH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 04:07:28 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 37B93818080;
	Fri, 23 Jan 2009 10:07:20 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with SMTP id 371E9818104;
	Fri, 23 Jan 2009 10:07:18 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106866>

This new "read_replace_refs" global variable is set to 1 by
default, so that replace refs are used by default. But
reachability traversal and packing commands ("cmd_fsck",
"cmd_prune", "cmd_pack_objects", "upload_pack",
"cmd_unpack_objects") set it to 0, as they must work with the
original DAG.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-fsck.c           |    1 +
 builtin-pack-objects.c   |    2 ++
 builtin-prune.c          |    1 +
 builtin-unpack-objects.c |    2 ++
 cache.h                  |    1 +
 environment.c            |    1 +
 replace_object.c         |    3 +++
 t/t6050-replace.sh       |   23 +++++++++++++++++++++++
 upload-pack.c            |    2 ++
 9 files changed, 36 insertions(+), 0 deletions(-)

	Note that I tried a little to test this, but I don't know much
	about packing and reachability traversal commands, so I may be
	very wrong on this patch. There may also be many other
	commands where "read_replace_refs" should be set to 0.
	Please check.

diff --git a/builtin-fsck.c b/builtin-fsck.c
index aecc828..67356fb 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -586,6 +586,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	int i, heads;
 
 	errors_found = 0;
+	read_replace_refs = 0;
 
 	argc = parse_options(argc, argv, fsck_opts, fsck_usage, 0);
 	if (write_lost_and_found) {
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index e851534..8e161a3 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -2080,6 +2080,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	int rp_ac_alloc = 64;
 	int rp_ac;
 
+	read_replace_refs = 0;
+
 	rp_av = xcalloc(rp_ac_alloc, sizeof(*rp_av));
 
 	rp_av[0] = "pack-objects";
diff --git a/builtin-prune.c b/builtin-prune.c
index 545e9c1..c0a26fe 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -140,6 +140,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	char *s;
 
 	save_commit_buffer = 0;
+	read_replace_refs = 0;
 	init_revisions(&revs, prefix);
 
 	argc = parse_options(argc, argv, options, prune_usage, 0);
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 47ed610..1a4d51b 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -495,6 +495,8 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 	int i;
 	unsigned char sha1[20];
 
+	read_replace_refs = 0;
+
 	git_config(git_default_config, NULL);
 
 	quiet = !isatty(2);
diff --git a/cache.h b/cache.h
index 1b34381..48fa12a 100644
--- a/cache.h
+++ b/cache.h
@@ -510,6 +510,7 @@ extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern int auto_crlf;
+extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
 
diff --git a/environment.c b/environment.c
index e278bce..d11dde1 100644
--- a/environment.c
+++ b/environment.c
@@ -38,6 +38,7 @@ int pager_use_color = 1;
 const char *editor_program;
 const char *excludes_file;
 int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
+int read_replace_refs = 1;
 enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
diff --git a/replace_object.c b/replace_object.c
index 5b973ba..1227214 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -100,6 +100,9 @@ const unsigned char *lookup_replace_object(const unsigned char *sha1)
 	int pos, depth = MAXREPLACEDEPTH;
 	const unsigned char *cur = sha1;
 
+	if (!read_replace_refs)
+		return sha1;
+
 	prepare_replace_object();
 
 	/* Try to recursively replace the object */
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 334aed6..17f6063 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -82,6 +82,29 @@ test_expect_success 'tag replaced commit' '
      git mktag <tag.sig >.git/refs/tags/mytag 2>message
 '
 
+test_expect_success '"git fsck" works' '
+     git fsck master > fsck_master.out &&
+     grep "dangling commit $R" fsck_master.out &&
+     grep "dangling tag $(cat .git/refs/tags/mytag)" fsck_master.out &&
+     test -z "$(git fsck)"
+'
+
+test_expect_success 'repack, clone and fetch work' '
+     git repack -a -d &&
+     git clone --no-hardlinks . clone_dir &&
+     cd clone_dir &&
+     git show HEAD~5 | grep "A U Thor" &&
+     git show $HASH2 | grep "A U Thor" &&
+     git cat-file commit $R &&
+     git repack -a -d &&
+     test_must_fail git cat-file commit $R &&
+     git fetch ../ "refs/replace/*:refs/replace/*" &&
+     git show HEAD~5 | grep "O Thor" &&
+     git show $HASH2 | grep "O Thor" &&
+     git cat-file commit $R &&
+     cd ..
+'
+
 #
 #
 test_done
diff --git a/upload-pack.c b/upload-pack.c
index e5adbc0..186e338 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -616,6 +616,8 @@ int main(int argc, char **argv)
 	int i;
 	int strict = 0;
 
+	read_replace_refs = 0;
+
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
 
-- 
1.6.1.231.g9c286
