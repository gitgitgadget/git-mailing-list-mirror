From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/4] commit: introduce a config key to allow as-is commit with i-t-a entries
Date: Tue,  7 Feb 2012 19:46:42 +0700
Message-ID: <1328618804-31796-3-git-send-email-pclouds@gmail.com>
References: <1328618804-31796-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 13:42:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RukN0-0006vg-K1
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 13:42:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756335Ab2BGMlx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Feb 2012 07:41:53 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44448 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756027Ab2BGMlw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 07:41:52 -0500
Received: by mail-pw0-f46.google.com with SMTP id u11so5850829pbd.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 04:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Q75FlREgxaLSsQ5YADE4cmSPgEc/SdmQX55rjhu1Mow=;
        b=pgfQq7QWvYzaxlh3T6uMhAX/ZlGKd+CBJlOQXu+vQdGP5FUsM3y3Yu0jlZS7AapqRh
         TjUytLM4FhEgc7hrwDgF5NnfDzPlaZ/BNI2aQ69uukhZfiashps3zxFm544y3q9qOeRk
         XzNiwtB0jc9nm66cBK+49UjhN6McU4QdxouIc=
Received: by 10.68.190.101 with SMTP id gp5mr57237332pbc.31.1328618512184;
        Tue, 07 Feb 2012 04:41:52 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id r9sm46328300pbi.6.2012.02.07.04.41.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Feb 2012 04:41:50 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 07 Feb 2012 19:47:02 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328618804-31796-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190168>

"git add -N" is introduced some time ago to help prevent users's
forgetting to add new files when committing. "git add -N" sets
CE_INTENT_TO_ADD bit to index, hence i-t-a entries from now on. For
safety reasons, as-is commits in the existence of i-t-a entries are
rejected ("I intend to add these files. If I type "git commit -m foo", =
it
may be a mistake if those files's contents are not added yet. Stop me i=
n
that case").

However unless you are doing "commit -a" or "commit pathspec", you are
responsible for adding all contents you want to have in the commit
before you run the "git commit" command (and for the purpose of this
statement, "add -N" to tell Git to keey an eye on a path does _not_ add
contents).

A change to the file in the working tree that is left unadded is what
you decided to deliberately leave out of the commit, be it a change to =
a
path already in HEAD, or a path marked with "add -N". Forgetting to add
modified file and forgetting to add a file you earlier used "add -N"
amount to the same kind of risk, and "git status" is the way to make
sure your partial commit has exactly what you want. If you are not
worried about partial commit, you would be doing "commit -a", so the
"safety" is a moot point.

This patch is the beginning of the deprecation process to remove this
safety check, allowing "git commit" to proceed anyway. The process
consists of three steps to help users get used to new behavior:

1. Introduce a temporary config var, commit.ignoreIntentToAdd to help
the migration process, default to false. If the var is true, the remove
safety check.

Users who encounter the safety check are pointed to
commit.ignoreIntentToAdd documentation and advised to set the variable
to true.

2. A few releases after step 1 is out in the field, turn
commit.ignoreIntentToAdd default value to true (affecting mostly new
users).

Those who decided to stick to "false" from step 1 are warned the "false=
"
support will soon be gone and encouraged to move to "true" (or simply
remove the config variable).

Those who set the config to "true" is advised to remove it to keep
config file clean.

Those who encountered the safety check and did not bother to set this
config var is left out in the cold.

3. A few more releases after step 2, commit.ignoreIntentToAdd is
removed. There's no way to bring back the safety check.

This patch implements step 1.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |   16 ++++++++++++++++
 builtin/commit.c         |   29 ++++++++++++++++++++++++++---
 cache-tree.c             |    8 +++++---
 cache-tree.h             |    1 +
 t/t2203-add-intent.sh    |   21 ++++++++++++++++++++-
 5 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index abeb82b..6839e44 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -831,6 +831,22 @@ commit.template::
 	"{tilde}/" is expanded to the value of `$HOME` and "{tilde}user/" to =
the
 	specified user's home directory.
=20
+commit.ignoreIntentToAdd::
+	When set to `false`, prevent `git commit` from creating a
+	commit from an index that has entries that were added with
+	`git add -N` but have not been updated with real contents, as
+	the user may have forgotten to tell the final contents for
+	these entries.  Setting this to `true` makes `git commit`
+	pretend as if these entries do not exist in the index.
++
+The default for this variable is `false`, but it will change to `true`
+in future releases of git. To ease the transition, you may want to set
+it to `true` now and get used to the new behaviour early, or you may
+want to set it to `false` to keep the old behaviour a bit longer. We
+however expect to support setting this to `false` (to keep the current
+behaviour) only for a limited time after the default is changed to
+`true`.
+
 credential.helper::
 	Specify an external helper to be called when a username or
 	password credential is needed; the helper may consult external
diff --git a/builtin/commit.c b/builtin/commit.c
index bf42bb3..da67653 100644
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
@@ -420,8 +423,21 @@ static char *prepare_index(int argc, const char **=
argv, const char *prefix,
 	if (!pathspec || !*pathspec) {
 		fd =3D hold_locked_index(&index_lock, 1);
 		refresh_cache_or_die(refresh_flags);
+		if (!set_commit_ignoreintenttoadd) {
+			int i;
+			for (i =3D 0; i < active_nr; i++)
+				if (active_cache[i]->ce_flags & CE_INTENT_TO_ADD)
+					break;
+			if (i < active_nr) {
+				error(_("you intended to add \"%s\" but did not add it; not commit=
ting\n"
+					"hint: to commit all changes to tracked files, use \"commit -a\"\=
n"
+					"hint: to commit anyway without adding, set commit.ignoreIntentTo=
Add to true"),
+				      active_cache[i]->name);
+				exit(128); /* die() */
+			}
+		}
 		if (active_cache_changed) {
-			update_main_cache_tree(WRITE_TREE_SILENT);
+			update_main_cache_tree(cache_tree_flags | WRITE_TREE_SILENT);
 			if (write_cache(fd, active_cache, active_nr) ||
 			    commit_locked_index(&index_lock))
 				die(_("unable to write new_index file"));
@@ -870,7 +886,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 	 */
 	discard_cache();
 	read_cache_from(index_file);
-	if (update_main_cache_tree(0)) {
+	if (update_main_cache_tree(cache_tree_flags)) {
 		error(_("Error building trees"));
 		return 0;
 	}
@@ -1338,6 +1354,13 @@ static int git_commit_config(const char *k, cons=
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
