From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] commit: add --skip-intent-to-add to allow commit with i-t-a entries in index
Date: Wed, 11 Jan 2012 16:59:42 +0700
Message-ID: <1326275982-29866-3-git-send-email-pclouds@gmail.com>
References: <1326261707-11484-1-git-send-email-pclouds@gmail.com>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 11:00:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkuyj-0007Kj-P1
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 11:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757371Ab2AKKAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 05:00:11 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:35277 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757182Ab2AKKAI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2012 05:00:08 -0500
Received: by obbup16 with SMTP id up16so621498obb.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 02:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=h5LWbBy8I1aruOke1D08NdSOVxJgy4iys1hKL4tdwRw=;
        b=mHm54GVQ/iZ09ws8cXdJxskfY268vbtMT7CNcWNRDzgGpQr0o4btXkzjp2JPJOb2yy
         9rR/EPGh6uaWnu/eWtvXBc7CgwFClSJ5ICf94SVQq6WFxYEXQ1T+qOxeMP3u/epcmzvP
         PJE5KE7dgxGcHH7pa8r/fyyr/J/r+iSgdyBoM=
Received: by 10.50.87.164 with SMTP id az4mr4136404igb.27.1326276007795;
        Wed, 11 Jan 2012 02:00:07 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id r18sm3595095ibh.4.2012.01.11.02.00.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Jan 2012 02:00:06 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Jan 2012 16:59:59 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326261707-11484-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188352>

---
 builtin/commit.c      |   10 +++++++---
 cache-tree.c          |    8 +++++---
 cache-tree.h          |    1 +
 t/t2203-add-intent.sh |   17 +++++++++++++++++
 4 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index bf42bb3..021206e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -86,6 +86,7 @@ static int all, also, interactive, patch_interactive, only, amend, signoff;
 static int edit_flag = -1; /* unspecified */
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int no_post_rewrite, allow_empty_message;
+static int cache_tree_flags, skip_intent_to_add;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
 static char *sign_commit;
 
@@ -170,6 +171,7 @@ static struct option builtin_commit_options[] = {
 	OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
 	OPT_BOOLEAN(0, "no-post-rewrite", &no_post_rewrite, "bypass post-rewrite hook"),
 	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode", "show untracked files, optional modes: all, normal, no. (Default: all)", PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
+	OPT_BOOL(0, "skip-intent-to-add", &skip_intent_to_add, "allow intent-to-add entries in index"),
 	/* end commit contents options */
 
 	{ OPTION_BOOLEAN, 0, "allow-empty", &allow_empty, NULL,
@@ -400,7 +402,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 		fd = hold_locked_index(&index_lock, 1);
 		add_files_to_cache(also ? prefix : NULL, pathspec, 0);
 		refresh_cache_or_die(refresh_flags);
-		update_main_cache_tree(WRITE_TREE_SILENT);
+		update_main_cache_tree(cache_tree_flags | WRITE_TREE_SILENT);
 		if (write_cache(fd, active_cache, active_nr) ||
 		    close_lock_file(&index_lock))
 			die(_("unable to write new_index file"));
@@ -421,7 +423,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 		fd = hold_locked_index(&index_lock, 1);
 		refresh_cache_or_die(refresh_flags);
 		if (active_cache_changed) {
-			update_main_cache_tree(WRITE_TREE_SILENT);
+			update_main_cache_tree(cache_tree_flags | WRITE_TREE_SILENT);
 			if (write_cache(fd, active_cache, active_nr) ||
 			    commit_locked_index(&index_lock))
 				die(_("unable to write new_index file"));
@@ -870,7 +872,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	 */
 	discard_cache();
 	read_cache_from(index_file);
-	if (update_main_cache_tree(0)) {
+	if (update_main_cache_tree(cache_tree_flags)) {
 		error(_("Error building trees"));
 		return 0;
 	}
@@ -1088,6 +1090,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		cleanup_mode = CLEANUP_ALL;
 	else
 		die(_("Invalid cleanup mode %s"), cleanup_arg);
+	if (skip_intent_to_add)
+		cache_tree_flags = WRITE_TREE_INTENT_TO_ADD_OK;
 
 	handle_untracked_files_arg(s);
 
diff --git a/cache-tree.c b/cache-tree.c
index 16355d6..b8593e0 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -159,7 +159,9 @@ static int verify_cache(struct cache_entry **cache,
 	funny = 0;
 	for (i = 0; i < entries; i++) {
 		struct cache_entry *ce = cache[i];
-		if (ce_stage(ce) || (ce->ce_flags & CE_INTENT_TO_ADD)) {
+		if (ce_stage(ce) ||
+		    ((flags & WRITE_TREE_INTENT_TO_ADD_OK) == 0 &&
+		     (ce->ce_flags & CE_INTENT_TO_ADD))) {
 			if (silent)
 				return -1;
 			if (10 < ++funny) {
@@ -339,8 +341,8 @@ static int update_one(struct cache_tree *it,
 				mode, sha1_to_hex(sha1), entlen+baselen, path);
 		}
 
-		if (ce->ce_flags & CE_REMOVE)
-			continue; /* entry being removed */
+		if (ce->ce_flags & (CE_REMOVE | CE_INTENT_TO_ADD))
+			continue; /* entry being removed or placeholder */
 
 		strbuf_grow(&buffer, entlen + 100);
 		strbuf_addf(&buffer, "%o %.*s%c", mode, entlen, path + baselen, '\0');
diff --git a/cache-tree.h b/cache-tree.h
index d8cb2e9..865733c 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -38,6 +38,7 @@ int update_main_cache_tree(int);
 #define WRITE_TREE_IGNORE_CACHE_TREE 2
 #define WRITE_TREE_DRY_RUN 4
 #define WRITE_TREE_SILENT 8
+#define WRITE_TREE_INTENT_TO_ADD_OK 16
 
 /* error return codes */
 #define WRITE_TREE_UNREADABLE_INDEX (-1)
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 2543529..990c765 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -44,6 +44,23 @@ test_expect_success 'cannot commit with i-t-a entry' '
 	test_must_fail git commit -m initial
 '
 
+test_expect_success 'can commit with i-t-a entry' '
+	git reset --hard &&
+	echo xyzzy >rezrov &&
+	echo frotz >nitfol &&
+	git add rezrov &&
+	git add -N nitfol &&
+	git commit --skip-intent-to-add -m initial &&
+	git ls-tree -r HEAD >actual &&
+	cat >expected <<EOF &&
+100644 blob ce013625030ba8dba906f756967f9e9ca394464a	elif
+100644 blob ce013625030ba8dba906f756967f9e9ca394464a	file
+100644 blob cf7711b63209d0dbc2d030f7fe3513745a9880e4	rezrov
+EOF
+	test_cmp expected actual &&
+	git reset HEAD^
+'
+
 test_expect_success 'can commit with an unrelated i-t-a entry in index' '
 	git reset --hard &&
 	echo xyzzy >rezrov &&
-- 
1.7.3.1.256.g2539c.dirty
