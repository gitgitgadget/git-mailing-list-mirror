From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] ls-files: allow relative pathspec
Date: Sat, 22 May 2010 18:35:25 +0200
Message-ID: <20100522163525.GA12420@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 22 18:35:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFrfm-0004tb-2r
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 18:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685Ab0EVQfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 12:35:33 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:63590 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819Ab0EVQfc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 12:35:32 -0400
Received: by wwb13 with SMTP id 13so102844wwb.19
        for <git@vger.kernel.org>; Sat, 22 May 2010 09:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:mime-version:content-type:content-disposition
         :user-agent;
        bh=DTMQ+Q9fKCE/b1slL5iKQnw2y7gXFNnnn1GsXN9aU/I=;
        b=pdDyoCZNOcKkTflLn6SaPKm45C2QqmiqQ3pizj0+C3X9dy6jxASO5CHT1jmI77S5P1
         xhatU77Mdq4TrlsKGEoSpb+a8vxCLTjTgVmke0F2kMTayRjzzdTRANeDBQB5kFBP+QEO
         sFjvDGT6RlMYLiAJ11Y6k5wMPfhSCD/PGiCSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        b=DpI8eKi0O27MnQK85wGKuom9kAiLbtL5J6mS9vPzj4TN1ZKbQr67gc10CLqO5rwhTi
         X211o75y3OHbZFDFdiGSE2B8YVQsuNTmUUXIonTJ6TMb5E6/cLAEuYfQz/Ih1R96ge0l
         L+rGP2mwLQjOT7n1VnY/tr6iwlYk2A4fLvTiY=
Received: by 10.227.135.195 with SMTP id o3mr2863880wbt.120.1274546130800;
        Sat, 22 May 2010 09:35:30 -0700 (PDT)
Received: from darc.lan (p549A3CF7.dip.t-dialin.net [84.154.60.247])
        by mx.google.com with ESMTPS id h22sm16522667wbh.21.2010.05.22.09.35.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 May 2010 09:35:30 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OFrfZ-0007pW-Tg; Sat, 22 May 2010 18:35:25 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147533>

git ls-files used to error out if given paths which point outside
the current working directory, such as '../'. We now allow such
paths and the output is analogous to git grep -l.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 builtin/ls-files.c |   61 +++++++++++++++++++++++++++++-----------------------
 t/t7010-setup.sh   |   12 +++------
 2 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index c0fbcdc..441da81 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -26,7 +26,8 @@ static int show_killed;
 static int show_valid_bit;
 static int line_terminator = '\n';
 
-static int prefix_len;
+static const char *prefix;
+static int max_prefix_len;
 static int prefix_offset;
 static const char **pathspec;
 static int error_unmatch;
@@ -43,10 +44,19 @@ static const char *tag_modified = "";
 static const char *tag_skip_worktree = "";
 static const char *tag_resolve_undo = "";
 
+static void write_name(const char* name, size_t len)
+{
+	struct strbuf path = STRBUF_INIT;
+	if (prefix_offset > 0)
+		quote_path_relative(name, len, &path, prefix);
+	else
+		strbuf_add(&path, name, len);
+	write_name_quoted(strbuf_detach(&path, NULL), stdout, line_terminator);
+}
+
 static void show_dir_entry(const char *tag, struct dir_entry *ent)
 {
-	int len = prefix_len;
-	int offset = prefix_offset;
+	int len = max_prefix_len;
 
 	if (len >= ent->len)
 		die("git ls-files: internal error - directory entry not superset of prefix");
@@ -55,7 +65,7 @@ static void show_dir_entry(const char *tag, struct dir_entry *ent)
 		return;
 
 	fputs(tag, stdout);
-	write_name_quoted(ent->name + offset, stdout, line_terminator);
+	write_name(ent->name, ent->len);
 }
 
 static void show_other_files(struct dir_struct *dir)
@@ -121,8 +131,7 @@ static void show_killed_files(struct dir_struct *dir)
 
 static void show_ce_entry(const char *tag, struct cache_entry *ce)
 {
-	int len = prefix_len;
-	int offset = prefix_offset;
+	int len = max_prefix_len;
 
 	if (len >= ce_namelen(ce))
 		die("git ls-files: internal error - cache entry not superset of prefix");
@@ -156,20 +165,19 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
 		       find_unique_abbrev(ce->sha1,abbrev),
 		       ce_stage(ce));
 	}
-	write_name_quoted(ce->name + offset, stdout, line_terminator);
+	write_name(ce->name, ce_namelen(ce));
 }
 
 static int show_one_ru(struct string_list_item *item, void *cbdata)
 {
-	int offset = prefix_offset;
 	const char *path = item->string;
 	struct resolve_undo_info *ui = item->util;
 	int i, len;
 
 	len = strlen(path);
-	if (len < prefix_len)
+	if (len < max_prefix_len)
 		return 0; /* outside of the prefix */
-	if (!match_pathspec(pathspec, path, len, prefix_len, ps_matched))
+	if (!match_pathspec(pathspec, path, len, max_prefix_len, ps_matched))
 		return 0; /* uninterested */
 	for (i = 0; i < 3; i++) {
 		if (!ui->mode[i])
@@ -177,19 +185,19 @@ static int show_one_ru(struct string_list_item *item, void *cbdata)
 		printf("%s%06o %s %d\t", tag_resolve_undo, ui->mode[i],
 		       find_unique_abbrev(ui->sha1[i], abbrev),
 		       i + 1);
-		write_name_quoted(path + offset, stdout, line_terminator);
+		write_name(path, len);
 	}
 	return 0;
 }
 
-static void show_ru_info(const char *prefix)
+static void show_ru_info()
 {
 	if (!the_index.resolve_undo)
 		return;
 	for_each_string_list(show_one_ru, the_index.resolve_undo, NULL);
 }
 
-static void show_files(struct dir_struct *dir, const char *prefix)
+static void show_files(struct dir_struct *dir)
 {
 	int i;
 
@@ -243,7 +251,7 @@ static void show_files(struct dir_struct *dir, const char *prefix)
  */
 static void prune_cache(const char *prefix)
 {
-	int pos = cache_name_pos(prefix, prefix_len);
+	int pos = cache_name_pos(prefix, max_prefix_len);
 	unsigned int first, last;
 
 	if (pos < 0)
@@ -256,7 +264,7 @@ static void prune_cache(const char *prefix)
 	while (last > first) {
 		int next = (last + first) >> 1;
 		struct cache_entry *ce = active_cache[next];
-		if (!strncmp(ce->name, prefix, prefix_len)) {
+		if (!strncmp(ce->name, prefix, max_prefix_len)) {
 			first = next+1;
 			continue;
 		}
@@ -265,7 +273,7 @@ static void prune_cache(const char *prefix)
 	active_nr = last;
 }
 
-static const char *verify_pathspec(const char *prefix)
+static const char *verify_pathspec(const char* prefix)
 {
 	const char **p, *n, *prev;
 	unsigned long max;
@@ -291,10 +299,7 @@ static const char *verify_pathspec(const char *prefix)
 		}
 	}
 
-	if (prefix_offset > max || memcmp(prev, prefix, prefix_offset))
-		die("git ls-files: cannot generate relative filenames containing '..'");
-
-	prefix_len = max;
+	max_prefix_len = max;
 	return max ? xmemdupz(prev, max) : NULL;
 }
 
@@ -456,9 +461,10 @@ static int option_parse_exclude_standard(const struct option *opt,
 	return 0;
 }
 
-int cmd_ls_files(int argc, const char **argv, const char *prefix)
+int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 {
 	int require_work_tree = 0, show_tag = 0;
+	const char *max_prefix;
 	struct dir_struct dir;
 	struct option builtin_ls_files_options[] = {
 		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
@@ -516,6 +522,7 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 	};
 
 	memset(&dir, 0, sizeof(dir));
+	prefix = cmd_prefix;
 	if (prefix)
 		prefix_offset = strlen(prefix);
 	git_config(git_default_config, NULL);
@@ -557,7 +564,7 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 
 	/* Verify that the pathspec matches the prefix */
 	if (pathspec)
-		prefix = verify_pathspec(prefix);
+		max_prefix = verify_pathspec(prefix);
 
 	/* Treat unmatching pathspec elements as errors */
 	if (pathspec && error_unmatch) {
@@ -575,8 +582,8 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 	      show_killed | show_modified | show_resolve_undo))
 		show_cached = 1;
 
-	if (prefix)
-		prune_cache(prefix);
+	if (max_prefix)
+		prune_cache(max_prefix);
 	if (with_tree) {
 		/*
 		 * Basic sanity check; show-stages and show-unmerged
@@ -584,11 +591,11 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 		 */
 		if (show_stage || show_unmerged)
 			die("ls-files --with-tree is incompatible with -s or -u");
-		overlay_tree_on_cache(with_tree, prefix);
+		overlay_tree_on_cache(with_tree, max_prefix);
 	}
-	show_files(&dir, prefix);
+	show_files(&dir);
 	if (show_resolve_undo)
-		show_ru_info(prefix);
+		show_ru_info();
 
 	if (ps_matched) {
 		int bad;
diff --git a/t/t7010-setup.sh b/t/t7010-setup.sh
index d8a7c79..0335a9a 100755
--- a/t/t7010-setup.sh
+++ b/t/t7010-setup.sh
@@ -103,14 +103,10 @@ test_expect_success 'git ls-files (relative #3)' '
 	git add a &&
 	(
 		cd a/b &&
-		if git ls-files "../e/f"
-		then
-			echo Gaah, should have failed
-			exit 1
-		else
-			: happy
-		fi
-	)
+		git ls-files "../e/f"
+	)  >current &&
+	echo ../e/f >expect &&
+	test_cmp expect current
 
 '
 
-- 
1.7.0.5.3.ga76e
