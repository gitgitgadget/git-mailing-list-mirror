From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC 2/4] Use 'lstat_cache()' instead of
 'has_symlink_leading_path()'
Date: Mon, 05 Jan 2009 14:09:59 +0100
Message-ID: <1231161001-32599-3-git-send-email-barvik@broadpark.no>
References: <1231161001-32599-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 05 15:12:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJqBX-0003nN-Pv
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 15:12:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754235AbZAEOKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 09:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754178AbZAEOKQ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 09:10:16 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:55082 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754160AbZAEOKL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 09:10:11 -0500
X-Greylist: delayed 3603 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Jan 2009 09:10:08 EST
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KD000DEI1WSOL50@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Mon, 05 Jan 2009 14:10:04 +0100 (CET)
Received: from localhost.localdomain ([80.202.166.236])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KD000I6W1WPP470@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Mon, 05 Jan 2009 14:10:04 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc1.49.g7f705
In-reply-to: <1231161001-32599-1-git-send-email-barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104572>

Start using the optimised, faster and more effective symlink/directory
cache.  The previously used call:

   has_symlink_leading_path(len, name);

should be identically with the following call to lstat_cache():

   lstat_cache(len, name,
               LSTAT_SYMLINK|LSTAT_DIR,
               LSTAT_SYMLINK);

The primary reason for the new name of the function (instead of using
the old name and add 2 extra arguments), is that it is now more
general, for instance, it now also can cache the fact that a directory
does not exists.

I noticed that inside the unlink_entry() function in unpack-trees.c,
one could often end up calling rmdir() lots and lots of times on
none-empty directories.  Maybe one should schedule each directory for
removal by an appropriate function, and then at the end call a new
function to clean all the directories at once?

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
:100644 100644 719de8b... 152c52c... M	builtin-add.c
:100644 100644 a8f75ed... 0eb2b21... M	builtin-apply.c
:100644 100644 65d5775... fa7d994... M	builtin-update-index.c
:100644 100644 ae96c64... 127bdf2... M	diff-lib.c
:100644 100644 0131983... 9f2a1b1... M	dir.c
:100644 100644 54f301d... 93923db... M	unpack-trees.c
 builtin-add.c          |    5 ++++-
 builtin-apply.c        |    5 ++++-
 builtin-update-index.c |    5 ++++-
 diff-lib.c             |    5 ++++-
 dir.c                  |    4 +++-
 unpack-trees.c         |    9 +++++++--
 6 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 719de8b0f2d2d831f326d948aa18700e5c474950..152c52c0f22b3e71931b2a5629e1472602817785 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -121,7 +121,9 @@ static const char **validate_pathspec(int argc, const char **argv, const char *p
 	if (pathspec) {
 		const char **p;
 		for (p = pathspec; *p; p++) {
-			if (has_symlink_leading_path(strlen(*p), *p)) {
+			if (lstat_cache(strlen(*p), *p,
+					LSTAT_SYMLINK|LSTAT_DIR,
+					LSTAT_SYMLINK)) {
 				int len = prefix ? strlen(prefix) : 0;
 				die("'%s' is beyond a symbolic link", *p + len);
 			}
@@ -225,6 +227,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, builtin_add_options,
 			  builtin_add_usage, 0);
+	clear_lstat_cache();
 	if (patch_interactive)
 		add_interactive = 1;
 	if (add_interactive)
diff --git a/builtin-apply.c b/builtin-apply.c
index a8f75ed3ed411d8cf7a3ec9dfefef7407c50f447..0eb2b21ee245919189c780a64cc494ca35f7934a 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2354,7 +2354,9 @@ static int check_to_create_blob(const char *new_name, int ok_if_exists)
 		 * In such a case, path "new_name" does not exist as
 		 * far as git is concerned.
 		 */
-		if (has_symlink_leading_path(strlen(new_name), new_name))
+		if (lstat_cache(strlen(new_name), new_name,
+				LSTAT_SYMLINK|LSTAT_DIR,
+				LSTAT_SYMLINK))
 			return 0;
 
 		return error("%s: already exists in working directory", new_name);
@@ -3154,6 +3156,7 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 	if (apply_default_whitespace)
 		parse_whitespace_option(apply_default_whitespace);
 
+	clear_lstat_cache();
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		char *end;
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 65d5775107f9013526cc5b288a80a00b449e8814..fa7d994b3cfe7343c1a181f4c6f6a4c6ee6cea75 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -195,7 +195,9 @@ static int process_path(const char *path)
 	struct stat st;
 
 	len = strlen(path);
-	if (has_symlink_leading_path(len, path))
+	if (lstat_cache(len, path,
+			LSTAT_SYMLINK|LSTAT_DIR,
+			LSTAT_SYMLINK))
 		return error("'%s' is beyond a symbolic link", path);
 
 	/*
@@ -581,6 +583,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	if (entries < 0)
 		die("cache corrupted");
 
+	clear_lstat_cache();
 	for (i = 1 ; i < argc; i++) {
 		const char *path = argv[i];
 		const char *p;
diff --git a/diff-lib.c b/diff-lib.c
index ae96c64ca209f4df9008198e8a04b160bed618c7..127bdf2dfbeb3538fa01e500ed8bcd3f4c8d422b 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -31,7 +31,9 @@ static int check_removed(const struct cache_entry *ce, struct stat *st)
 			return -1;
 		return 1;
 	}
-	if (has_symlink_leading_path(ce_namelen(ce), ce->name))
+	if (lstat_cache(ce_namelen(ce), ce->name,
+			LSTAT_SYMLINK|LSTAT_NOTDIR|LSTAT_DIR,
+			LSTAT_SYMLINK))
 		return 1;
 	if (S_ISDIR(st->st_mode)) {
 		unsigned char sub[20];
@@ -69,6 +71,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		diff_unmerged_stage = 2;
 	entries = active_nr;
 	symcache[0] = '\0';
+	clear_lstat_cache();
 	for (i = 0; i < entries; i++) {
 		struct stat st;
 		unsigned int oldmode, newmode;
diff --git a/dir.c b/dir.c
index 0131983dfbc143ce5dae77e067663bb2e7d5f126..9f2a1b1f245c3f1d4f12d54d45bb193c53fa15b5 100644
--- a/dir.c
+++ b/dir.c
@@ -719,7 +719,9 @@ int read_directory(struct dir_struct *dir, const char *path, const char *base, i
 {
 	struct path_simplify *simplify;
 
-	if (has_symlink_leading_path(strlen(path), path))
+	if (lstat_cache(strlen(path), path,
+			LSTAT_SYMLINK|LSTAT_DIR,
+			LSTAT_SYMLINK))
 		return dir->nr;
 
 	simplify = create_simplify(pathspec);
diff --git a/unpack-trees.c b/unpack-trees.c
index 54f301da67be879c80426bc21776427fdd38c02e..93923dbbc6ab80deadfd737aa9975f6e5a4d1e89 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -61,7 +61,9 @@ static void unlink_entry(struct cache_entry *ce)
 	char *cp, *prev;
 	char *name = ce->name;
 
-	if (has_symlink_leading_path(ce_namelen(ce), ce->name))
+	if (lstat_cache(ce_namelen(ce), ce->name,
+			LSTAT_SYMLINK|LSTAT_NOTDIR|LSTAT_DIR,
+			LSTAT_SYMLINK|LSTAT_NOTDIR))
 		return;
 	if (unlink(name))
 		return;
@@ -105,6 +107,7 @@ static int check_updates(struct unpack_trees_options *o)
 		cnt = 0;
 	}
 
+	clear_lstat_cache();
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
@@ -584,7 +587,9 @@ static int verify_absent(struct cache_entry *ce, const char *action,
 	if (o->index_only || o->reset || !o->update)
 		return 0;
 
-	if (has_symlink_leading_path(ce_namelen(ce), ce->name))
+	if (lstat_cache(ce_namelen(ce), ce->name,
+			LSTAT_SYMLINK|LSTAT_NOTDIR|LSTAT_DIR,
+			LSTAT_SYMLINK|LSTAT_NOTDIR))
 		return 0;
 
 	if (!lstat(ce->name, &st)) {
-- 
1.6.1.rc1.49.g7f705
