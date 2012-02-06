From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/4] commit: introduce a config key to allow as-is commit with i-t-a entries
Date: Mon,  6 Feb 2012 17:57:33 +0700
Message-ID: <1328525855-2547-3-git-send-email-pclouds@gmail.com>
References: <1328525855-2547-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 11:53:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuMBx-00054F-5u
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 11:53:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754658Ab2BFKw4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 05:52:56 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:48043 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527Ab2BFKwz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 05:52:55 -0500
Received: by mail-pz0-f46.google.com with SMTP id d14so345838dae.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 02:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TrQfTNOcsX/p5/635zb6fRkjCfOt6q8Loi9ylBPfMCU=;
        b=qDHlCZKdDHtBBCurhzVUG0JP5keY3SI7/7/OOgWZ2SBl0Rbtmqt/YUVRg5VqtSsMl7
         p/r4LKiHVwHnUK97Zt/OlRdV+NkEvITHOEJ223HmcyV2CWC+i0O7nCwUSZbL7O70v7tk
         kYLWwpMEtQ3h4JslTMrs2JzEYSsM96Dh0Whls=
Received: by 10.68.75.11 with SMTP id y11mr46593582pbv.51.1328525575439;
        Mon, 06 Feb 2012 02:52:55 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id p2sm8405931pbb.14.2012.02.06.02.52.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 06 Feb 2012 02:52:54 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Mon, 06 Feb 2012 17:57:50 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328525855-2547-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190064>

This is the start of deprecating current commit behavior (do not allow
commit as-is when there are i-t-a entries in index). Users will be
annoyed by a warning saying the behavior will change in 1.8.0 and asked
to set commit.ignoreIntentToAdd properly.

The plan after that is:

 - Keep it this way until 1.8.0

 - In 1.8.0, we consider the lack of commit.ignoreIntentToAdd means
   "true". A deprecation date is set. The warning message is updated
   stating that from that day, this config key will be ignored. The
   behavior will be as if this config key is always "true".

 - In the chosen release, remove support for this config key.
   WRITE_TREE_IGNORE_INTENT_TO_ADD is set unconditionally.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt  |   10 ++++++++++
 Documentation/git-add.txt |   12 ++++++++++--
 builtin/commit.c          |   28 +++++++++++++++++++++++++---
 cache-tree.c              |    8 +++++---
 cache-tree.h              |    1 +
 t/t2203-add-intent.sh     |   21 ++++++++++++++++++++-
 6 files changed, 71 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index abeb82b..6ec81a8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -831,6 +831,16 @@ commit.template::
 	"{tilde}/" is expanded to the value of `$HOME` and "{tilde}user/" to =
the
 	specified user's home directory.
=20
+commit.ignoreIntentToAdd::
+	Allow to commit the index as-is even if there are
+	intent-to-add entries (see option `-N` in linkgit:git-add[1])
+	in index. Set to `false` to disallow commit in this acase, or `true`
+	to allow it.
++
+By default, `git commit` refuses to commit as-is when you have intent-=
to-add
+entries. This will change in 1.8.0, where `git commit` allows it. If y=
ou
+prefer current behavior, please set it to `false`.
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
diff --git a/builtin/commit.c b/builtin/commit.c
index bf42bb3..af3250c 100644
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
@@ -117,6 +118,8 @@ static enum {
 } status_format =3D STATUS_FORMAT_LONG;
 static int status_show_branch;
=20
+static int set_commit_ignoreintenttoadd;
+
 static int opt_parse_m(const struct option *opt, const char *arg, int =
unset)
 {
 	struct strbuf *buf =3D opt->value;
@@ -400,7 +403,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix,
 		fd =3D hold_locked_index(&index_lock, 1);
 		add_files_to_cache(also ? prefix : NULL, pathspec, 0);
 		refresh_cache_or_die(refresh_flags);
-		update_main_cache_tree(WRITE_TREE_SILENT);
+		update_main_cache_tree(cache_tree_flags | WRITE_TREE_SILENT);
 		if (write_cache(fd, active_cache, active_nr) ||
 		    close_lock_file(&index_lock))
 			die(_("unable to write new_index file"));
@@ -420,8 +423,20 @@ static char *prepare_index(int argc, const char **=
argv, const char *prefix,
 	if (!pathspec || !*pathspec) {
 		fd =3D hold_locked_index(&index_lock, 1);
 		refresh_cache_or_die(refresh_flags);
+		if (!set_commit_ignoreintenttoadd) {
+			int i;
+			for (i =3D 0; i < active_nr; i++)
+				if (active_cache[i]->ce_flags & CE_INTENT_TO_ADD)
+					break;
+			if (i < active_nr)
+				warning(_("You are committing as-is with intent-to-add entries as =
the result of\n"
+					  "\"git add -N\". Git currently forbids this case. This will cha=
nge in\n"
+					  "1.8.0 where intent-to-add entries are simply ignored when comm=
itting\n"
+					  "as-is. Please look up document and set commit.ignoreIntentToAd=
d\n"
+					  "properly to stop this warning."));
+		}
 		if (active_cache_changed) {
-			update_main_cache_tree(WRITE_TREE_SILENT);
+			update_main_cache_tree(cache_tree_flags | WRITE_TREE_SILENT);
 			if (write_cache(fd, active_cache, active_nr) ||
 			    commit_locked_index(&index_lock))
 				die(_("unable to write new_index file"));
@@ -870,7 +885,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 	 */
 	discard_cache();
 	read_cache_from(index_file);
-	if (update_main_cache_tree(0)) {
+	if (update_main_cache_tree(cache_tree_flags)) {
 		error(_("Error building trees"));
 		return 0;
 	}
@@ -1338,6 +1353,13 @@ static int git_commit_config(const char *k, cons=
t char *v, void *cb)
 		include_status =3D git_config_bool(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "commit.ignoreintenttoadd")) {
+		set_commit_ignoreintenttoadd =3D 1;
+		if (git_config_bool(k, v))
+			cache_tree_flags |=3D WRITE_TREE_IGNORE_INTENT_TO_ADD;
+		else
+			cache_tree_flags &=3D ~WRITE_TREE_IGNORE_INTENT_TO_ADD;
+	}
=20
 	status =3D git_gpg_config(k, v, NULL);
 	if (status)
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
index 58a3299..88a508e 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -41,7 +41,26 @@ test_expect_success 'cannot commit with i-t-a entry'=
 '
 	echo frotz >nitfol &&
 	git add rezrov &&
 	git add -N nitfol &&
-	test_must_fail git commit
+	test_must_fail git commit -minitial
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
 '
=20
 test_expect_success 'can commit with an unrelated i-t-a entry in index=
' '
--=20
1.7.8.36.g69ee2
