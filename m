From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH v2] ls-files: allow relative pathspec
Date: Wed, 26 May 2010 23:05:24 +0200
Message-ID: <20100526210523.GA1770@localhost>
References: <20100522163525.GA12420@localhost>
 <7v1vczqmhw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 26 23:05:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHNnU-0006cX-W0
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 23:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491Ab0EZVFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 17:05:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:16589 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696Ab0EZVFp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 17:05:45 -0400
Received: by fg-out-1718.google.com with SMTP id e12so1021041fga.1
        for <git@vger.kernel.org>; Wed, 26 May 2010 14:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=TlP331eLN4Zk0K+RzTLWWFnwdDn03C5e7NQJff1JsNY=;
        b=uweCN7pIT5KojSpMayrZEvq5UjcBF9nOLumM8AbKJH89Npna/JPy1nvF3d7jIFvuie
         kOIejob+ya6viTwE4usdU0AZFnioS9X5HMabm5ogxg6kcIMELwDeg8fLxCkOt3Yb2krR
         RS/CJu1JRiEQyW/n/c1Zgei1jIql+LuZTZwFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=oBvhQMk4bdHfS2bll4oNwV/+m6mlUBn4mR8eaZdZ7W2hknfDi8Ed4K9rasC4ophYV1
         wambNZZAUiJ2ZoPM7vsCUoAay/951B64P6YvXYD9MeHfXewA+wbicumJm1pkDWZVwy8Y
         lMEoZ7zPe+jiJAMr+6jZUkpua7enH/7FVimGY=
Received: by 10.87.74.15 with SMTP id b15mr3347943fgl.11.1274907942692;
        Wed, 26 May 2010 14:05:42 -0700 (PDT)
Received: from darc.lan (p549A2CA7.dip.t-dialin.net [84.154.44.167])
        by mx.google.com with ESMTPS id p17sm791021fka.46.2010.05.26.14.05.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 May 2010 14:05:42 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OHNn2-0005yQ-3a; Wed, 26 May 2010 23:05:24 +0200
Content-Disposition: inline
In-Reply-To: <7v1vczqmhw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147824>

git ls-files used to error out if given paths which point outside the current
working directory, such as '../'. We now allow such paths and the output is
analogous to git grep -l.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
On Tue, May 25, 2010 at 10:07:39PM -0700, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
> > @@ -456,9 +461,10 @@ static int option_parse_exclude_standard(const struct option *opt,
> >  	return 0;
> >  }
> >  
> > -int cmd_ls_files(int argc, const char **argv, const char *prefix)
> > +int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
> >  {
> >  	int require_work_tree = 0, show_tag = 0;
> > +	const char *max_prefix;
> 
> This variable is used uninitialized when pathspec is NULL, I think.

Indeed, thank you for reviewing.

I also renamed verify_pathspec to pathspec_prefix, since it does
not actually verify anything.

Clemens

 builtin/ls-files.c |   69 ++++++++++++++++++++++++++++++----------------------
 t/t7010-setup.sh   |   12 +++------
 2 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index c0fbcdc..30ebe2c 100644
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
@@ -265,11 +273,16 @@ static void prune_cache(const char *prefix)
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
@@ -291,10 +304,7 @@ static const char *verify_pathspec(const char *prefix)
 		}
 	}
 
-	if (prefix_offset > max || memcmp(prev, prefix, prefix_offset))
-		die("git ls-files: cannot generate relative filenames containing '..'");
-
-	prefix_len = max;
+	max_prefix_len = max;
 	return max ? xmemdupz(prev, max) : NULL;
 }
 
@@ -456,9 +466,10 @@ static int option_parse_exclude_standard(const struct option *opt,
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
@@ -516,6 +527,7 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 	};
 
 	memset(&dir, 0, sizeof(dir));
+	prefix = cmd_prefix;
 	if (prefix)
 		prefix_offset = strlen(prefix);
 	git_config(git_default_config, NULL);
@@ -555,9 +567,8 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 	if (pathspec)
 		strip_trailing_slash_from_submodules();
 
-	/* Verify that the pathspec matches the prefix */
-	if (pathspec)
-		prefix = verify_pathspec(prefix);
+	/* Find common prefix for all pathspec's */
+	max_prefix = pathspec_prefix(prefix);
 
 	/* Treat unmatching pathspec elements as errors */
 	if (pathspec && error_unmatch) {
@@ -575,8 +586,8 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 	      show_killed | show_modified | show_resolve_undo))
 		show_cached = 1;
 
-	if (prefix)
-		prune_cache(prefix);
+	if (max_prefix)
+		prune_cache(max_prefix);
 	if (with_tree) {
 		/*
 		 * Basic sanity check; show-stages and show-unmerged
@@ -584,11 +595,11 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
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
