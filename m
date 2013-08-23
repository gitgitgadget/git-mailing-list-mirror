From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/2] dir: fix core.ignorecase inconsistency with missing '/'
Date: Fri, 23 Aug 2013 16:29:19 -0400
Message-ID: <1377289759-46838-3-git-send-email-sunshine@sunshineco.com>
References: <1377289759-46838-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 23 22:29:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCxzR-0003HZ-47
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 22:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755824Ab3HWU3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 16:29:45 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:33974 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755787Ab3HWU3o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 16:29:44 -0400
Received: by mail-ie0-f170.google.com with SMTP id 17so1676648iea.29
        for <git@vger.kernel.org>; Fri, 23 Aug 2013 13:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CNWruQNUXgNWdPbQ52ILpoxPVLYWld1SI2fjEo/pGEA=;
        b=smDoQUfokZ3rrcTTekhKvdEMtdSzlLg/Il6YeKj7QtBsUXOydM8iSeg6reSEqIYenQ
         UQEwfaSkt2WBwbEaLOrFD4SwRt316u/Un/HRbtZfex+2Oop4PudGRtY2nXDwfjeTPp37
         07cSim6ijf7Q7hBtIjqOLQCCu5xMHcDlSvbM+us4DwdE7VJfWx3vNoRGIQR4pGkCQ3aC
         Lnlr8qY6mZd9yhNhCX7EH0rgkyhTbDFj/jKniD93cA0/I/NyYzDEz34ghYSmiXcAiel5
         /Ni1l1gqTQiQGFWhGb2Ma1uHGMsPoFMh28jpC4+sEojdDAurmDr4qzTW+NyQIhqV7Iyb
         4vJg==
X-Received: by 10.50.36.5 with SMTP id m5mr2849026igj.3.1377289783828;
        Fri, 23 Aug 2013 13:29:43 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id cl4sm89620igc.1.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 23 Aug 2013 13:29:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.557.g46c5bb2
In-Reply-To: <1377289759-46838-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232835>

Although undocumented, directory_exists_in_index_icase(dirname,len)
unconditionally assumes the presence of a '/' at dirname[len], despite
being past the end-of-string. Callers are expected to respect this
assumption by ensuring that a '/' is present beyond the last character
of the passed path.

directory_exists_in_index(), on the other hand, expects no trailing '/'
(and never looks beyond end-of-string). Callers are expected to respect
this by ensuring the absence of '/'.

2eac2a4cc4bdc8d7 (ls-files -k: a directory only can be killed if the
index has a non-directory; 2013-08-15) adds a caller which forgets to
ensure the trailing '/' beyond end-of-string, which leads to
inconsistent behavior between directory_exists_in_index() and
directory_exists_in_index_icase(), depending upon the setting of
core.ignorecase.

One approach to fix this would be to augment the new caller (added by
2eac2a4cc4bdc8d7) to add a '/' beyond end-of-string, but this places
extra burden on the caller to account for an implementation detail of
directory_exists_in_index_icase().

Another approach would be for directory_exists_in_index_icase() to take
responsibility for its own requirements by copying the incoming path and
adding a trailing '/', but such copying can become expensive.

The approach taken by this patch is to pass the strbufs already used by
their callers into directory_exists_in_index() and
directory_exists_in_index_icase() rather than 'const char *' + 'size_t
len'. This allows both functions to satisfy their own internal
requirements -- by manipulating the strbuf to add or remove the trailing
'/' -- without placing burden upon callers and without having to make
expensive copies of each incoming string.

This also fixes an initially-unnoticed failure, when core.ignorecase is
true, in a t3010 test added by 3c56875176390eee (t3010: update to
demonstrate "ls-files -k" optimization pitfalls; 2013-08-15).

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 dir.c                               | 42 +++++++++++++++++++++++--------------
 t/t3010-ls-files-killed-modified.sh |  2 +-
 2 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/dir.c b/dir.c
index edd666a..6f761a1 100644
--- a/dir.c
+++ b/dir.c
@@ -887,14 +887,21 @@ enum exist_status {
  * the directory name; instead, use the case insensitive
  * name hash.
  */
-static enum exist_status directory_exists_in_index_icase(const char *dirname, int len)
+static enum exist_status directory_exists_in_index_icase(struct strbuf *dirname)
 {
-	const struct cache_entry *ce = cache_name_exists(dirname, len + 1, ignore_case);
+	const struct cache_entry *ce;
 	unsigned char endchar;
+	size_t len = dirname->len;
+	int need_slash = len && dirname->buf[len - 1] != '/';
+
+	if (need_slash)
+		strbuf_addch(dirname, '/');
+	ce = cache_name_exists(dirname->buf, dirname->len, ignore_case);
+	strbuf_setlen(dirname, len);
 
 	if (!ce)
 		return index_nonexistent;
-	endchar = ce->name[len];
+	endchar = ce->name[need_slash ? len : len - 1];
 
 	/*
 	 * The cache_entry structure returned will contain this dirname
@@ -922,21 +929,25 @@ static enum exist_status directory_exists_in_index_icase(const char *dirname, in
  * the files it contains) will sort with the '/' at the
  * end.
  */
-static enum exist_status directory_exists_in_index(const char *dirname, int len)
+static enum exist_status directory_exists_in_index(struct strbuf *dirname)
 {
-	int pos;
+	int pos, len;
 
 	if (ignore_case)
-		return directory_exists_in_index_icase(dirname, len);
+		return directory_exists_in_index_icase(dirname);
+
+	len = dirname->len;
+	if (len && dirname->buf[len - 1] == '/')
+		len--;
 
-	pos = cache_name_pos(dirname, len);
+	pos = cache_name_pos(dirname->buf, len);
 	if (pos < 0)
 		pos = -pos-1;
 	while (pos < active_nr) {
 		const struct cache_entry *ce = active_cache[pos++];
 		unsigned char endchar;
 
-		if (strncmp(ce->name, dirname, len))
+		if (strncmp(ce->name, dirname->buf, len))
 			break;
 		endchar = ce->name[len];
 		if (endchar > '/')
@@ -983,11 +994,10 @@ static enum exist_status directory_exists_in_index(const char *dirname, int len)
  *  (c) otherwise, we recurse into it.
  */
 static enum path_treatment treat_directory(struct dir_struct *dir,
-	const char *dirname, int len, int exclude,
+	struct strbuf *dirname, int exclude,
 	const struct path_simplify *simplify)
 {
-	/* The "len-1" is to strip the final '/' */
-	switch (directory_exists_in_index(dirname, len-1)) {
+	switch (directory_exists_in_index(dirname)) {
 	case index_directory:
 		return path_recurse;
 
@@ -999,7 +1009,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 			break;
 		if (!(dir->flags & DIR_NO_GITLINKS)) {
 			unsigned char sha1[20];
-			if (resolve_gitlink_ref(dirname, "HEAD", sha1) == 0)
+			if (!resolve_gitlink_ref(dirname->buf, "HEAD", sha1))
 				return path_untracked;
 		}
 		return path_recurse;
@@ -1010,7 +1020,8 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
 		return exclude ? path_excluded : path_untracked;
 
-	return read_directory_recursive(dir, dirname, len, 1, simplify);
+	return read_directory_recursive(dir, dirname->buf, dirname->len, 1,
+					simplify);
 }
 
 /*
@@ -1161,7 +1172,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	if ((dir->flags & DIR_COLLECT_KILLED_ONLY) &&
 	    (dtype == DT_DIR) &&
 	    !has_path_in_index &&
-	    (directory_exists_in_index(path->buf, path->len) == index_nonexistent))
+	    (directory_exists_in_index(path) == index_nonexistent))
 		return path_none;
 
 	exclude = is_excluded(dir, path->buf, &dtype);
@@ -1178,8 +1189,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 		return path_none;
 	case DT_DIR:
 		strbuf_addch(path, '/');
-		return treat_directory(dir, path->buf, path->len, exclude,
-			simplify);
+		return treat_directory(dir, path, exclude, simplify);
 	case DT_REG:
 	case DT_LNK:
 		return exclude ? path_excluded : path_untracked;
diff --git a/t/t3010-ls-files-killed-modified.sh b/t/t3010-ls-files-killed-modified.sh
index 198d308..78954bd 100755
--- a/t/t3010-ls-files-killed-modified.sh
+++ b/t/t3010-ls-files-killed-modified.sh
@@ -107,7 +107,7 @@ test_expect_success 'git ls-files -k to show killed files (icase).' '
 	git -c core.ignorecase=true ls-files -k >.output
 '
 
-test_expect_failure 'validate git ls-files -k output (icase).' '
+test_expect_success 'validate git ls-files -k output (icase).' '
 	test_cmp .expected .output
 '
 
-- 
1.8.4.rc4.557.g46c5bb2
