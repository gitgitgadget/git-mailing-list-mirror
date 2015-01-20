From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/24] nd/untracked-cache update
Date: Tue, 20 Jan 2015 20:03:09 +0700
Message-ID: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 20 14:03:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDYT1-000379-Ss
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 14:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754824AbbATND0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2015 08:03:26 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:37173 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119AbbATNDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 08:03:25 -0500
Received: by mail-pd0-f170.google.com with SMTP id p10so31330220pdj.1
        for <git@vger.kernel.org>; Tue, 20 Jan 2015 05:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=AXvAMuuH662naYK0G2ocHB9fcmn9e53WfiAQRz0niqQ=;
        b=f5z6t6BmuqH8bjiJvta/yKdQZgXuU51hs3NojSx3lcQ+2Y5IajR19IaiYlakX3DEWo
         9Sk6xoOd3HwhuttzYHxxR63n0o5jgN2Z0krjb+yeugqUosCEmrIzr08V+EuDqatH27pG
         Csd0dNerW3YMIfMAoDj8MFl0wTkCfzXAYS4O+oAucyqJKkZNRMFpve3uPUmqoI6C15DH
         90sUvT9zjvZkfmInomEwk02VNIs76PEjj3Sp56r05TJwmzO+fy+6tmDN2phlwcZHBcxa
         sMI9Xc8vdg+BczW9o0qcr4nYoehAcBhrWbBtRQUzPvA3CfDVXKFZpnHkTfnS2lC+n9KU
         zWeg==
X-Received: by 10.70.48.201 with SMTP id o9mr14839874pdn.4.1421759005201;
        Tue, 20 Jan 2015 05:03:25 -0800 (PST)
Received: from lanh ([115.73.212.1])
        by mx.google.com with ESMTPSA id pf10sm2885486pbc.82.2015.01.20.05.03.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2015 05:03:24 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 20 Jan 2015 20:03:34 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262652>

Sorry for this really late update. This fixes bugs in extension
writing code (10/24), support using the same cache from different
hosts (23/24), and adds a new bug to point the user to untracked cache from
'git status -uno' (new patch 24/24)

Diff from 'pu'
-- 8< --
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index def635f..7850f53 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -58,7 +58,10 @@ When `-u` option is not used, untracked files and directories are
 shown (i.e. the same as specifying `normal`), to help you avoid
 forgetting to add newly created files.  Because it takes extra work
 to find untracked files in the filesystem, this mode may take some
-time in a large working tree.  You can use `no` to have `git status`
+time in a large working tree.
+Consider to enable untracked cache and split index if supported (see
+`git update-index --untracked-cache` and `git update-index
+--split-index`), Otherwise you can use `no` to have `git status`
 return more quickly without showing untracked files.
 +
 The default can be changed using the status.showUntrackedFiles
diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index 5dc2bee..0045b89 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -242,8 +242,9 @@ Git index format
 
   The extension starts with
 
-  - A NUL-terminated string describing the environment when the cache
-    is created.
+  - A sequence of NUL-terminated strings, preceded by the size of the
+    sequence in variable width encoding. Each string describes the
+    environment where the cache can be used.
 
   - Stat data of $GIT_DIR/info/exclude. See "Index entry" section from
     ctime field until "file size".
diff --git a/builtin/update-index.c b/builtin/update-index.c
index f23ec83..e76740d 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1083,7 +1083,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		the_index.split_index = NULL;
 		the_index.cache_changed |= SOMETHING_CHANGED;
 	}
-	if (untracked_cache > 0 && !the_index.untracked) {
+	if (untracked_cache > 0) {
 		struct untracked_cache *uc;
 
 		if (untracked_cache < 2) {
@@ -1091,11 +1091,15 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			if (!test_if_untracked_cache_is_supported())
 				return 1;
 		}
-		uc = xcalloc(1, sizeof(*uc));
-		uc->exclude_per_dir = ".gitignore";
-		/* should be the same flags used by git-status */
-		uc->dir_flags = DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
-		the_index.untracked = uc;
+		if (!the_index.untracked) {
+			uc = xcalloc(1, sizeof(*uc));
+			strbuf_init(&uc->ident, 100);
+			uc->exclude_per_dir = ".gitignore";
+			/* should be the same flags used by git-status */
+			uc->dir_flags = DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
+			the_index.untracked = uc;
+		}
+		add_untracked_ident(the_index.untracked);
 		the_index.cache_changed |= UNTRACKED_CHANGED;
 	} else if (!untracked_cache && the_index.untracked) {
 		the_index.untracked = NULL;
diff --git a/dir.c b/dir.c
index 95ff3f0..b8a4f9e 100644
--- a/dir.c
+++ b/dir.c
@@ -1793,6 +1793,40 @@ static int treat_leading_path(struct dir_struct *dir,
 	return rc;
 }
 
+static const char *get_ident_string(void)
+{
+	static struct strbuf sb = STRBUF_INIT;
+	struct utsname uts;
+
+	if (sb.len)
+		return sb.buf;
+	if (uname(&uts))
+		die_errno(_("failed to get kernel name and information"));
+	strbuf_addf(&sb, "Location %s, system %s %s %s", get_git_work_tree(),
+		    uts.sysname, uts.release, uts.version);
+	return sb.buf;
+}
+
+static int ident_in_untracked(const struct untracked_cache *uc)
+{
+	const char *end = uc->ident.buf + uc->ident.len;
+	const char *p   = uc->ident.buf;
+
+	for (p = uc->ident.buf; p < end; p += strlen(p) + 1)
+		if (!strcmp(p, get_ident_string()))
+			return 1;
+	return 0;
+}
+
+void add_untracked_ident(struct untracked_cache *uc)
+{
+	if (ident_in_untracked(uc))
+		return;
+	strbuf_addstr(&uc->ident, get_ident_string());
+	/* this strbuf contains a list of strings, save NUL too */
+	strbuf_addch(&uc->ident, 0);
+}
+
 static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
 						      int base_len,
 						      const struct pathspec *pathspec)
@@ -1859,6 +1893,11 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 		if (ce_skip_worktree(active_cache[i]))
 			return NULL;
 
+	if (!ident_in_untracked(dir->untracked)) {
+		warning(_("Untracked cache is disabled on this system."));
+		return NULL;
+	}
+
 	if (!dir->untracked->root) {
 		const int len = sizeof(*dir->untracked->root);
 		dir->untracked->root = xmalloc(len);
@@ -2169,9 +2208,11 @@ struct ondisk_untracked_cache {
 	uint32_t dir_flags;
 	unsigned char info_exclude_sha1[20];
 	unsigned char excludes_file_sha1[20];
-	char exclude_per_dir[1];
+	char exclude_per_dir[FLEX_ARRAY];
 };
 
+#define ouc_size(len) (offsetof(struct ondisk_untracked_cache, exclude_per_dir) + len + 1)
+
 struct write_data {
 	int index;	   /* number of written untracked_cache_dir */
 	struct ewah_bitmap *check_only; /* from untracked_cache_dir */
@@ -2246,26 +2287,15 @@ static void write_one_dir(struct untracked_cache_dir *untracked,
 			write_one_dir(untracked->dirs[i], wd);
 }
 
-static void get_ident_string(struct strbuf *sb)
-{
-	struct utsname uts;
-
-	if (uname(&uts))
-		die_errno(_("failed to get kernel name and information"));
-	strbuf_addf(sb, "Location %s, system %s %s %s", get_git_work_tree(),
-		    uts.sysname, uts.release, uts.version);
-}
-
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked)
 {
 	struct ondisk_untracked_cache *ouc;
 	struct write_data wd;
-	struct strbuf sb = STRBUF_INIT;
 	unsigned char varbuf[16];
 	int len = 0, varint_len;
 	if (untracked->exclude_per_dir)
 		len = strlen(untracked->exclude_per_dir);
-	ouc = xmalloc(sizeof(*ouc) + len);
+	ouc = xmalloc(sizeof(*ouc) + len + 1);
 	stat_data_to_disk(&ouc->info_exclude_stat, &untracked->ss_info_exclude.stat);
 	stat_data_to_disk(&ouc->excludes_file_stat, &untracked->ss_excludes_file.stat);
 	hashcpy(ouc->info_exclude_sha1, untracked->ss_info_exclude.sha1);
@@ -2273,11 +2303,11 @@ void write_untracked_extension(struct strbuf *out, struct untracked_cache *untra
 	ouc->dir_flags = htonl(untracked->dir_flags);
 	memcpy(ouc->exclude_per_dir, untracked->exclude_per_dir, len + 1);
 
-	get_ident_string(&sb);
-	strbuf_add(out, sb.buf, sb.len + 1);
-	strbuf_release(&sb);
+	varint_len = encode_varint(untracked->ident.len, varbuf);
+	strbuf_add(out, varbuf, varint_len);
+	strbuf_add(out, untracked->ident.buf, untracked->ident.len);
 
-	strbuf_add(out, ouc, sizeof(*ouc) + len);
+	strbuf_add(out, ouc, ouc_size(len));
 	if (!untracked->root) {
 		varint_len = encode_varint(0, varbuf);
 		strbuf_add(out, varbuf, varint_len);
@@ -2460,29 +2490,26 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 	struct untracked_cache *uc;
 	struct read_data rd;
 	const unsigned char *next = data, *end = (const unsigned char *)data + sz;
-	struct strbuf sb = STRBUF_INIT;
-	int len;
+	const char *ident;
+	int ident_len, len;
 
 	if (sz <= 1 || end[-1] != '\0')
 		return NULL;
 	end--;
 
-	get_ident_string(&sb);
-	if (strcmp(sb.buf, (const char *)next)) {
-		warning(_("system identification does not match, untracked cache disabled.\n"
-			  "Stored: %s\nCurrent: %s\n"),
-			next, sb.buf);
-		strbuf_release(&sb);
+	ident_len = decode_varint(&next);
+	if (next + ident_len > end)
 		return NULL;
-	}
-	next += sb.len + 1;
-	strbuf_release(&sb);
+	ident = (const char *)next;
+	next += ident_len;
 
 	ouc = (const struct ondisk_untracked_cache *)next;
-	if (next + sizeof(*ouc) > end)
+	if (next + ouc_size(0) > end)
 		return NULL;
 
 	uc = xcalloc(1, sizeof(*uc));
+	strbuf_init(&uc->ident, ident_len);
+	strbuf_add(&uc->ident, ident, ident_len);
 	load_sha1_stat(&uc->ss_info_exclude, &ouc->info_exclude_stat,
 		       ouc->info_exclude_sha1);
 	load_sha1_stat(&uc->ss_excludes_file, &ouc->excludes_file_stat,
@@ -2490,7 +2517,7 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 	uc->dir_flags = get_be32(&ouc->dir_flags);
 	uc->exclude_per_dir = xstrdup(ouc->exclude_per_dir);
 	/* NUL after exclude_per_dir is covered by sizeof(*ouc) */
-	next += sizeof(*ouc) + strlen(ouc->exclude_per_dir);
+	next += ouc_size(strlen(ouc->exclude_per_dir));
 	if (next >= end)
 		goto done2;
 
diff --git a/dir.h b/dir.h
index 2ce7dd3..6ccbc45 100644
--- a/dir.h
+++ b/dir.h
@@ -127,6 +127,7 @@ struct untracked_cache {
 	struct sha1_stat ss_info_exclude;
 	struct sha1_stat ss_excludes_file;
 	const char *exclude_per_dir;
+	struct strbuf ident;
 	/*
 	 * dir_struct#flags must match dir_flags or the untracked
 	 * cache is ignored.
@@ -305,4 +306,5 @@ void untracked_cache_add_to_index(struct index_state *, const char *);
 void free_untracked_cache(struct untracked_cache *);
 struct untracked_cache *read_untracked_extension(const void *data, unsigned long sz);
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
+void add_untracked_ident(struct untracked_cache *);
 #endif
-- 8< --
-- 
2.2.0.84.ge9c7a8a
