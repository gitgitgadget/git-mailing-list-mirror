From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] commit, write-tree: allow to ignore CE_INTENT_TO_ADD while writing trees
Date: Mon, 16 Jan 2012 09:36:47 +0700
Message-ID: <1326681407-6344-3-git-send-email-pclouds@gmail.com>
References: <1326681407-6344-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 03:37:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmcRt-0006dB-9h
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 03:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189Ab2APChW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Jan 2012 21:37:22 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57717 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139Ab2APChQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2012 21:37:16 -0500
Received: by mail-iy0-f174.google.com with SMTP id f6so1796054iag.19
        for <git@vger.kernel.org>; Sun, 15 Jan 2012 18:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=64onKjLDdzoQTlSFwnfpovI0nuKTFHtN0S8l0YMsMFg=;
        b=Zc0z79kmhN1hbeF0LNR7FxuNSPCGLOHEjwOC3gMOGyg7y1WXkPA3lekfFDei9FKivB
         Rrisby4D19CSNYrnWmg8lDRM45CczIeh3UAiKnaVm0r0EwBMyLaEeUmjlQohfnDawatl
         YbPLVuNacmrHWgHylJaam7cBXdwYrWRwfiTog=
Received: by 10.42.150.6 with SMTP id y6mr8873750icv.14.1326681435999;
        Sun, 15 Jan 2012 18:37:15 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id or2sm18700264igc.5.2012.01.15.18.37.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 Jan 2012 18:37:15 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 16 Jan 2012 09:37:06 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326681407-6344-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188607>

Normally cache-tree will not produce trees from an index that has
CE_INTENT_TO_ADD entries. This is a safe measure to avoid
mis-interpreting user's intention regarding this flag.

There are situations however where users want to create trees/commits
regardless i-t-a entries. Allow such cases with commit.ignoreIntentToAd=
d
for git-commit and --ignore-intent-to-add for git-write-tree.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt         |    5 +++++
 Documentation/git-add.txt        |   12 ++++++++++--
 Documentation/git-write-tree.txt |    8 +++++++-
 builtin/commit.c                 |   13 ++++++++++---
 builtin/write-tree.c             |    2 ++
 cache-tree.c                     |    8 +++++---
 cache-tree.h                     |    1 +
 t/t2203-add-intent.sh            |   30 ++++++++++++++++++++++++++++++
 8 files changed, 70 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index abeb82b..10c3767 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -831,6 +831,11 @@ commit.template::
 	"{tilde}/" is expanded to the value of `$HOME` and "{tilde}user/" to =
the
 	specified user's home directory.
=20
+commit.ignoreIntentToAdd::
+	Allow to commit the index as-is even if there are
+	intent-to-add entries (see option `-N` in linkgit:git-add[1])
+	in index.
+
 credential.helper::
 	Specify an external helper to be called when a username or
 	password credential is needed; the helper may consult external
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 9c1d395..ec548ea 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -123,8 +123,16 @@ subdirectories.
 	Record only the fact that the path will be added later. An entry
 	for the path is placed in the index with no content. This is
 	useful for, among other things, showing the unstaged content of
-	such files with `git diff` and committing them with `git commit
-	-a`.
+	such files with `git diff`.
++
+Paths added with this option have intent-to-add flag in index. The
+flag is removed once real content is added or updated. By default you
+cannot commit the index as-is from until this flag is removed from all
+entries (i.e. all entries have real content). See commit.ignoreIntentT=
oAdd
+regardless the flag.
++
+Committing with `git commit -a` or with selected paths works
+regardless the config key and the flag.
=20
 --refresh::
 	Don't add the file(s), but only refresh their stat()
diff --git a/Documentation/git-write-tree.txt b/Documentation/git-write=
-tree.txt
index f22041a..d511d3a 100644
--- a/Documentation/git-write-tree.txt
+++ b/Documentation/git-write-tree.txt
@@ -9,7 +9,7 @@ git-write-tree - Create a tree object from the current =
index
 SYNOPSIS
 --------
 [verse]
-'git write-tree' [--missing-ok] [--prefix=3D<prefix>/]
+'git write-tree' [--missing-ok] [--ignore-intent-to-add] [--prefix=3D<=
prefix>/]
=20
 DESCRIPTION
 -----------
@@ -32,6 +32,12 @@ OPTIONS
 	directory exist in the object database.  This option disables this
 	check.
=20
+--ignore-intent-to-add::
+	Normally 'git write-tree' will refuse to proceed if there are any
+	intent-to-add entries (see `-N` option in linkgit:git-add[1]).
+	This option continues to create object tree as if there are no
+	intent-to-add entries in index.
+
 --prefix=3D<prefix>/::
 	Writes a tree object that represents a subdirectory
 	`<prefix>`.  This can be used to write the tree object
diff --git a/builtin/commit.c b/builtin/commit.c
index bf42bb3..097699e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -86,6 +86,7 @@ static int all, also, interactive, patch_interactive,=
 only, amend, signoff;
 static int edit_flag =3D -1; /* unspecified */
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_auth=
orship;
 static int no_post_rewrite, allow_empty_message;
+static int cache_tree_flags;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
 static char *sign_commit;
=20
@@ -400,7 +401,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix,
 		fd =3D hold_locked_index(&index_lock, 1);
 		add_files_to_cache(also ? prefix : NULL, pathspec, 0);
 		refresh_cache_or_die(refresh_flags);
-		update_main_cache_tree(WRITE_TREE_SILENT);
+		update_main_cache_tree(cache_tree_flags | WRITE_TREE_SILENT);
 		if (write_cache(fd, active_cache, active_nr) ||
 		    close_lock_file(&index_lock))
 			die(_("unable to write new_index file"));
@@ -421,7 +422,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix,
 		fd =3D hold_locked_index(&index_lock, 1);
 		refresh_cache_or_die(refresh_flags);
 		if (active_cache_changed) {
-			update_main_cache_tree(WRITE_TREE_SILENT);
+			update_main_cache_tree(cache_tree_flags | WRITE_TREE_SILENT);
 			if (write_cache(fd, active_cache, active_nr) ||
 			    commit_locked_index(&index_lock))
 				die(_("unable to write new_index file"));
@@ -870,7 +871,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 	 */
 	discard_cache();
 	read_cache_from(index_file);
-	if (update_main_cache_tree(0)) {
+	if (update_main_cache_tree(cache_tree_flags)) {
 		error(_("Error building trees"));
 		return 0;
 	}
@@ -1338,6 +1339,12 @@ static int git_commit_config(const char *k, cons=
t char *v, void *cb)
 		include_status =3D git_config_bool(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "commit.ignoreintenttoadd")) {
+		if (git_config_bool(k, v))
+			cache_tree_flags |=3D WRITE_TREE_IGNORE_INTENT_TO_ADD;
+		else
+			cache_tree_flags &=3D ~WRITE_TREE_IGNORE_INTENT_TO_ADD;
+	}
=20
 	status =3D git_gpg_config(k, v, NULL);
 	if (status)
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index b223af4..07797bb 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -23,6 +23,8 @@ int cmd_write_tree(int argc, const char **argv, const=
 char *unused_prefix)
 	struct option write_tree_options[] =3D {
 		OPT_BIT(0, "missing-ok", &flags, "allow missing objects",
 			WRITE_TREE_MISSING_OK),
+		OPT_BIT(0, "ignore-intent-to-add", &flags, "ignore i-t-a entries in =
index",
+			WRITE_TREE_IGNORE_INTENT_TO_ADD ),
 		{ OPTION_STRING, 0, "prefix", &prefix, "<prefix>/",
 		  "write tree object for a subdirectory <prefix>" ,
 		  PARSE_OPT_LITERAL_ARGHELP },
diff --git a/cache-tree.c b/cache-tree.c
index 16355d6..d0be159 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -159,7 +159,9 @@ static int verify_cache(struct cache_entry **cache,
 	funny =3D 0;
 	for (i =3D 0; i < entries; i++) {
 		struct cache_entry *ce =3D cache[i];
-		if (ce_stage(ce) || (ce->ce_flags & CE_INTENT_TO_ADD)) {
+		if (ce_stage(ce) ||
+		    ((flags & WRITE_TREE_IGNORE_INTENT_TO_ADD) =3D=3D 0 &&
+		     (ce->ce_flags & CE_INTENT_TO_ADD))) {
 			if (silent)
 				return -1;
 			if (10 < ++funny) {
@@ -339,8 +341,8 @@ static int update_one(struct cache_tree *it,
 				mode, sha1_to_hex(sha1), entlen+baselen, path);
 		}
=20
-		if (ce->ce_flags & CE_REMOVE)
-			continue; /* entry being removed */
+		if (ce->ce_flags & (CE_REMOVE | CE_INTENT_TO_ADD))
+			continue; /* entry being removed or placeholder */
=20
 		strbuf_grow(&buffer, entlen + 100);
 		strbuf_addf(&buffer, "%o %.*s%c", mode, entlen, path + baselen, '\0'=
);
diff --git a/cache-tree.h b/cache-tree.h
index d8cb2e9..af3b917 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -38,6 +38,7 @@ int update_main_cache_tree(int);
 #define WRITE_TREE_IGNORE_CACHE_TREE 2
 #define WRITE_TREE_DRY_RUN 4
 #define WRITE_TREE_SILENT 8
+#define WRITE_TREE_IGNORE_INTENT_TO_ADD 16
=20
 /* error return codes */
 #define WRITE_TREE_UNREADABLE_INDEX (-1)
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 58a3299..7b447d3 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -44,6 +44,36 @@ test_expect_success 'cannot commit with i-t-a entry'=
 '
 	test_must_fail git commit
 '
=20
+test_expect_success 'can write-tree with i-t-a entry' '
+	git reset --hard &&
+	echo xyzzy >rezrov &&
+	echo frotz >nitfol &&
+	git add rezrov &&
+	git add -N nitfol &&
+	git write-tree --ignore-intent-to-add >actual &&
+	echo 150389afa1ccf46e4104667c741cd0e598269511 >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'can commit tree with i-t-a entry' '
+	git reset --hard &&
+	echo xyzzy >rezrov &&
+	echo frotz >nitfol &&
+	git add rezrov &&
+	git add -N nitfol &&
+	git config commit.ignoreIntentToAdd true &&
+	git commit -m initial &&
+	git ls-tree -r HEAD >actual &&
+	cat >expected <<EOF &&
+100644 blob ce013625030ba8dba906f756967f9e9ca394464a	elif
+100644 blob ce013625030ba8dba906f756967f9e9ca394464a	file
+100644 blob cf7711b63209d0dbc2d030f7fe3513745a9880e4	rezrov
+EOF
+	test_cmp expected actual &&
+	git config commit.ignoreIntentToAdd false &&
+	git reset HEAD^
+'
+
 test_expect_success 'can commit with an unrelated i-t-a entry in index=
' '
 	git reset --hard &&
 	echo xyzzy >rezrov &&
--=20
1.7.3.1.256.g2539c.dirty
