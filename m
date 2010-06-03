From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 2/2] ls-files: allow relative pathspec
Date: Thu, 3 Jun 2010 15:39:18 +0200
Message-ID: <20100603133918.GB31565@localhost>
References: <7v4ohlatwn.fsf@alter.siamese.dyndns.org>
 <20100603133631.GA31565@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 15:40:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKAek-0005Hx-Bc
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 15:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754547Ab0FCNkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 09:40:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58581 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025Ab0FCNkO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 09:40:14 -0400
Received: by fxm8 with SMTP id 8so97250fxm.19
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 06:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=fTS0ZuhEokZ/FGc6XTSbvhtnPO8DhhZRRxM50vWRFa0=;
        b=YobX51uYSvG40mj276gV0tf5p/GO4OmhnbvL9t2+NbuTXTIPdfNa78CAtYESB2AfCO
         S/c3ohOv9Q82Nhf2iXRif+3ZAcErcDfNyFK7UfWMwj7pBU6ZTGhf+5MF3Lpss9a2l73n
         9BhK+f3a2hLyul5hC3wQ6grZUqKwMSJvv6PHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=gv4+vDGDq3mv9o5/QydfLqSv9dJOvMC58I/auenYVNv6Eii9Kp0KlHMplvT7PwdGC0
         N66iKZ4lhiQa8Qwz8ulpqAJHDbG8DBk2QL7Pg8bpYC69HDZhkJMdCG9vw4ESw8mNmfEv
         ksyBuF9FuurXQnI+uKbXwHmblLn6j44ZJfPDI=
Received: by 10.223.54.140 with SMTP id q12mr10157995fag.50.1275572411934;
        Thu, 03 Jun 2010 06:40:11 -0700 (PDT)
Received: from darc.lan (p549A3E4B.dip.t-dialin.net [84.154.62.75])
        by mx.google.com with ESMTPS id 13sm219107fad.7.2010.06.03.06.40.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Jun 2010 06:40:10 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OKAdi-0003Ya-Jy; Thu, 03 Jun 2010 15:39:18 +0200
Content-Disposition: inline
In-Reply-To: <20100603133631.GA31565@localhost>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148316>

git ls-files used to error out if given paths which point outside the current
working directory, such as '../'. We now allow such paths and the output is
analogous to git grep -l.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

There are two changes with respect to the previous version of this
patch.

- write_name() now uses the new write_name_quoted_relative()
- prefix_offset is renamed to prefix_len, which is much more
  intuitive

Clemens

 builtin/ls-files.c |   75 ++++++++++++++++++++++++++++-----------------------
 t/t7010-setup.sh   |   12 +++-----
 2 files changed, 45 insertions(+), 42 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index c0fbcdc..0804047 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -26,8 +26,9 @@ static int show_killed;
 static int show_valid_bit;
 static int line_terminator = '\n';
 
+static const char *prefix;
+static int max_prefix_len;
 static int prefix_len;
-static int prefix_offset;
 static const char **pathspec;
 static int error_unmatch;
 static char *ps_matched;
@@ -43,10 +44,15 @@ static const char *tag_modified = "";
 static const char *tag_skip_worktree = "";
 static const char *tag_resolve_undo = "";
 
+static void write_name(const char* name, size_t len)
+{
+	write_name_quoted_relative(name, len, prefix, prefix_len, stdout,
+			line_terminator);
+}
+
 static void show_dir_entry(const char *tag, struct dir_entry *ent)
 {
-	int len = prefix_len;
-	int offset = prefix_offset;
+	int len = max_prefix_len;
 
 	if (len >= ent->len)
 		die("git ls-files: internal error - directory entry not superset of prefix");
@@ -55,7 +61,7 @@ static void show_dir_entry(const char *tag, struct dir_entry *ent)
 		return;
 
 	fputs(tag, stdout);
-	write_name_quoted(ent->name + offset, stdout, line_terminator);
+	write_name(ent->name, ent->len);
 }
 
 static void show_other_files(struct dir_struct *dir)
@@ -121,8 +127,7 @@ static void show_killed_files(struct dir_struct *dir)
 
 static void show_ce_entry(const char *tag, struct cache_entry *ce)
 {
-	int len = prefix_len;
-	int offset = prefix_offset;
+	int len = max_prefix_len;
 
 	if (len >= ce_namelen(ce))
 		die("git ls-files: internal error - cache entry not superset of prefix");
@@ -156,20 +161,19 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
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
@@ -177,19 +181,19 @@ static int show_one_ru(struct string_list_item *item, void *cbdata)
 		printf("%s%06o %s %d\t", tag_resolve_undo, ui->mode[i],
 		       find_unique_abbrev(ui->sha1[i], abbrev),
 		       i + 1);
-		write_name_quoted(path + offset, stdout, line_terminator);
+		write_name(path, len);
 	}
 	return 0;
 }
 
-static void show_ru_info(const char *prefix)
+static void show_ru_info(void)
 {
 	if (!the_index.resolve_undo)
 		return;
 	for_each_string_list(show_one_ru, the_index.resolve_undo, NULL);
 }
 
-static void show_files(struct dir_struct *dir, const char *prefix)
+static void show_files(struct dir_struct *dir)
 {
 	int i;
 
@@ -243,7 +247,7 @@ static void show_files(struct dir_struct *dir, const char *prefix)
  */
 static void prune_cache(const char *prefix)
 {
-	int pos = cache_name_pos(prefix, prefix_len);
+	int pos = cache_name_pos(prefix, max_prefix_len);
 	unsigned int first, last;
 
 	if (pos < 0)
@@ -256,7 +260,7 @@ static void prune_cache(const char *prefix)
 	while (last > first) {
 		int next = (last + first) >> 1;
 		struct cache_entry *ce = active_cache[next];
-		if (!strncmp(ce->name, prefix, prefix_len)) {
+		if (!strncmp(ce->name, prefix, max_prefix_len)) {
 			first = next+1;
 			continue;
 		}
@@ -265,11 +269,16 @@ static void prune_cache(const char *prefix)
 	active_nr = last;
 }
 
-static const char *verify_pathspec(const char *prefix)
+static const char *pathspec_prefix(const char *prefix)
 {
 	const char **p, *n, *prev;
 	unsigned long max;
 
+	if (!pathspec) {
+		max_prefix_len = prefix ? strlen(prefix) : 0;
+		return prefix;
+	}
+
 	prev = NULL;
 	max = PATH_MAX;
 	for (p = pathspec; (n = *p) != NULL; p++) {
@@ -291,10 +300,7 @@ static const char *verify_pathspec(const char *prefix)
 		}
 	}
 
-	if (prefix_offset > max || memcmp(prev, prefix, prefix_offset))
-		die("git ls-files: cannot generate relative filenames containing '..'");
-
-	prefix_len = max;
+	max_prefix_len = max;
 	return max ? xmemdupz(prev, max) : NULL;
 }
 
@@ -374,7 +380,7 @@ void overlay_tree_on_cache(const char *tree_name, const char *prefix)
 	}
 }
 
-int report_path_error(const char *ps_matched, const char **pathspec, int prefix_offset)
+int report_path_error(const char *ps_matched, const char **pathspec, int prefix_len)
 {
 	/*
 	 * Make sure all pathspec matched; otherwise it is an error.
@@ -404,7 +410,7 @@ int report_path_error(const char *ps_matched, const char **pathspec, int prefix_
 			continue;
 
 		error("pathspec '%s' did not match any file(s) known to git.",
-		      pathspec[num] + prefix_offset);
+		      pathspec[num] + prefix_len);
 		errors++;
 	}
 	return errors;
@@ -456,9 +462,10 @@ static int option_parse_exclude_standard(const struct option *opt,
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
@@ -504,7 +511,7 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 0, "exclude-standard", &dir, NULL,
 			"add the standard git exclusions",
 			PARSE_OPT_NOARG, option_parse_exclude_standard },
-		{ OPTION_SET_INT, 0, "full-name", &prefix_offset, NULL,
+		{ OPTION_SET_INT, 0, "full-name", &prefix_len, NULL,
 			"make the output relative to the project top directory",
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL },
 		OPT_BOOLEAN(0, "error-unmatch", &error_unmatch,
@@ -516,8 +523,9 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 	};
 
 	memset(&dir, 0, sizeof(dir));
+	prefix = cmd_prefix;
 	if (prefix)
-		prefix_offset = strlen(prefix);
+		prefix_len = strlen(prefix);
 	git_config(git_default_config, NULL);
 
 	if (read_cache() < 0)
@@ -555,9 +563,8 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 	if (pathspec)
 		strip_trailing_slash_from_submodules();
 
-	/* Verify that the pathspec matches the prefix */
-	if (pathspec)
-		prefix = verify_pathspec(prefix);
+	/* Find common prefix for all pathspec's */
+	max_prefix = pathspec_prefix(prefix);
 
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
@@ -584,15 +591,15 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
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
-		bad = report_path_error(ps_matched, pathspec, prefix_offset);
+		bad = report_path_error(ps_matched, pathspec, prefix_len);
 		if (bad)
 			fprintf(stderr, "Did you forget to 'git add'?\n");
 
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
1.7.1.2.g2a651
