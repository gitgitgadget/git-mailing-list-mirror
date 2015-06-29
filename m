From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] worktree: new place for "git prune --worktrees"
Date: Mon, 29 Jun 2015 19:51:18 +0700
Message-ID: <1435582278-31158-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 29 14:51:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9YWg-0002T6-I4
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 14:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980AbbF2MvB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Jun 2015 08:51:01 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:33676 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889AbbF2Mu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 08:50:59 -0400
Received: by pdjn11 with SMTP id n11so116903495pdj.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 05:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=sabwqljK4jo0EObN33lWX4R54nGQqavYnXRuZsnfUxw=;
        b=q+pETE0LaudOQD3M3TamLBdBvv/IY5npBjcu3CKjc1dhLl9ju0QShtz5zD+knVt4fx
         lAMeI2S3T3clnprZ3vQ87T2pchbQxpoqwbP4BwOEKZBxMRG/TJ8GUyZGqQilL8s18a+W
         QqbchHV4KQqKgJckzf5AZK7zfPcFMqhM+N6tmN6vjNWCxjnIGTLTn/GgJ98YbpyRlQXp
         uLc5w7XSgpMucih+BnO5wNHCOfZup3LBTFZLr69y0XpO6tXz9V0/haLdlklLsQfkVgOz
         gx2TNcsJygzBrRxRc5v3n1rtxw5ovJyDM18hAHzmxqpZZRylcEFOWi3nZMtzsszF1gj9
         50yw==
X-Received: by 10.66.63.9 with SMTP id c9mr31608188pas.40.1435582258907;
        Mon, 29 Jun 2015 05:50:58 -0700 (PDT)
Received: from lanh ([115.73.54.177])
        by mx.google.com with ESMTPSA id nb10sm42269344pdb.76.2015.06.29.05.50.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2015 05:50:58 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 29 Jun 2015 19:51:34 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272949>

Commit 23af91d (prune: strategies for linked checkouts - 2014-11-30)
adds "--worktrees" to "git prune" without realizing that "git prune" is
for object database only. This patch moves the same functionality to a
new command "git worktree".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 In future I probably move the big block of text in git-checkout.txt to
 git-worktree.txt and add "git worktree list". But let's start with
 something small and simple before "git prune --worktrees" is shipped
 out.

 .gitignore                           |   1 +
 Documentation/git-prune.txt          |   3 -
 Documentation/git-worktree.txt (new) |  48 +++++++++++++
 Makefile                             |   1 +
 builtin.h                            |   1 +
 builtin/gc.c                         |   2 +-
 builtin/prune.c                      |  99 --------------------------
 builtin/worktree.c (new)             | 133 +++++++++++++++++++++++++++=
++++++++
 command-list.txt                     |   1 +
 git.c                                |   1 +
 t/t2026-prune-linked-checkouts.sh    |  22 +++---
 11 files changed, 198 insertions(+), 114 deletions(-)
 create mode 100644 Documentation/git-worktree.txt
 create mode 100644 builtin/worktree.c

diff --git a/.gitignore b/.gitignore
index 422c538..a685ec1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -171,6 +171,7 @@
 /git-verify-tag
 /git-web--browse
 /git-whatchanged
+/git-worktree
 /git-write-tree
 /git-core-*/?*
 /gitweb/GITWEB-BUILD-OPTIONS
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 1cf3bed..7a493c8 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -48,9 +48,6 @@ OPTIONS
 --expire <time>::
 	Only expire loose objects older than <time>.
=20
---worktrees::
-	Prune dead working tree information in $GIT_DIR/worktrees.
-
 <head>...::
 	In addition to objects
 	reachable from any of our references, keep objects
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
new file mode 100644
index 0000000..b9072e0
--- /dev/null
+++ b/Documentation/git-worktree.txt
@@ -0,0 +1,48 @@
+git-worktree(1)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+git-worktree - Manage multiple worktrees
+
+
+SYNOPSIS
+--------
+[verse]
+'git worktree prune' [-n] [-v] [--expire <expire>]
+
+DESCRIPTION
+-----------
+
+Manage multiple worktrees attached to the same repository. These are
+created by the command `git checkout --to`.
+
+COMMANDS
+--------
+prune::
+
+Prune working tree information in $GIT_DIR/worktrees.
+
+OPTIONS
+-------
+
+-n::
+--dry-run::
+	Do not remove anything; just report what it would
+	remove.
+
+-v::
+--verbose::
+	Report all removals.
+
+--expire <time>::
+	Only expire unused worktrees older than <time>.
+
+SEE ALSO
+--------
+
+linkgit:git-checkout[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 149f1c7..89785f6 100644
--- a/Makefile
+++ b/Makefile
@@ -909,6 +909,7 @@ BUILTIN_OBJS +=3D builtin/var.o
 BUILTIN_OBJS +=3D builtin/verify-commit.o
 BUILTIN_OBJS +=3D builtin/verify-pack.o
 BUILTIN_OBJS +=3D builtin/verify-tag.o
+BUILTIN_OBJS +=3D builtin/worktree.o
 BUILTIN_OBJS +=3D builtin/write-tree.o
=20
 GITLIBS =3D $(LIB_FILE) $(XDIFF_LIB)
diff --git a/builtin.h b/builtin.h
index b87df70..9e04f97 100644
--- a/builtin.h
+++ b/builtin.h
@@ -133,6 +133,7 @@ extern int cmd_verify_commit(int argc, const char *=
*argv, const char *prefix);
 extern int cmd_verify_tag(int argc, const char **argv, const char *pre=
fix);
 extern int cmd_version(int argc, const char **argv, const char *prefix=
);
 extern int cmd_whatchanged(int argc, const char **argv, const char *pr=
efix);
+extern int cmd_worktree(int argc, const char **argv, const char *prefi=
x);
 extern int cmd_write_tree(int argc, const char **argv, const char *pre=
fix);
 extern int cmd_verify_pack(int argc, const char **argv, const char *pr=
efix);
 extern int cmd_show_ref(int argc, const char **argv, const char *prefi=
x);
diff --git a/builtin/gc.c b/builtin/gc.c
index 36fe333..4957c39 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -293,7 +293,7 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 	argv_array_pushl(&reflog, "reflog", "expire", "--all", NULL);
 	argv_array_pushl(&repack, "repack", "-d", "-l", NULL);
 	argv_array_pushl(&prune, "prune", "--expire", NULL);
-	argv_array_pushl(&prune_worktrees, "prune", "--worktrees", "--expire"=
, NULL);
+	argv_array_pushl(&prune_worktrees, "worktree", "prune", "--expire", N=
ULL);
 	argv_array_pushl(&rerere, "rerere", "gc", NULL);
=20
 	gc_config();
diff --git a/builtin/prune.c b/builtin/prune.c
index 0c73246..10b03d3 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -6,7 +6,6 @@
 #include "reachable.h"
 #include "parse-options.h"
 #include "progress.h"
-#include "dir.h"
=20
 static const char * const prune_usage[] =3D {
 	N_("git prune [-n] [-v] [--expire <time>] [--] [<head>...]"),
@@ -76,95 +75,6 @@ static int prune_subdir(int nr, const char *path, vo=
id *data)
 	return 0;
 }
=20
-static int prune_worktree(const char *id, struct strbuf *reason)
-{
-	struct stat st;
-	char *path;
-	int fd, len;
-
-	if (!is_directory(git_path("worktrees/%s", id))) {
-		strbuf_addf(reason, _("Removing worktrees/%s: not a valid directory"=
), id);
-		return 1;
-	}
-	if (file_exists(git_path("worktrees/%s/locked", id)))
-		return 0;
-	if (stat(git_path("worktrees/%s/gitdir", id), &st)) {
-		strbuf_addf(reason, _("Removing worktrees/%s: gitdir file does not e=
xist"), id);
-		return 1;
-	}
-	fd =3D open(git_path("worktrees/%s/gitdir", id), O_RDONLY);
-	if (fd < 0) {
-		strbuf_addf(reason, _("Removing worktrees/%s: unable to read gitdir =
file (%s)"),
-			    id, strerror(errno));
-		return 1;
-	}
-	len =3D st.st_size;
-	path =3D xmalloc(len + 1);
-	read_in_full(fd, path, len);
-	close(fd);
-	while (len && (path[len - 1] =3D=3D '\n' || path[len - 1] =3D=3D '\r'=
))
-		len--;
-	if (!len) {
-		strbuf_addf(reason, _("Removing worktrees/%s: invalid gitdir file"),=
 id);
-		free(path);
-		return 1;
-	}
-	path[len] =3D '\0';
-	if (!file_exists(path)) {
-		struct stat st_link;
-		free(path);
-		/*
-		 * the repo is moved manually and has not been
-		 * accessed since?
-		 */
-		if (!stat(git_path("worktrees/%s/link", id), &st_link) &&
-		    st_link.st_nlink > 1)
-			return 0;
-		if (st.st_mtime <=3D expire) {
-			strbuf_addf(reason, _("Removing worktrees/%s: gitdir file points to=
 non-existent location"), id);
-			return 1;
-		} else {
-			return 0;
-		}
-	}
-	free(path);
-	return 0;
-}
-
-static void prune_worktrees(void)
-{
-	struct strbuf reason =3D STRBUF_INIT;
-	struct strbuf path =3D STRBUF_INIT;
-	DIR *dir =3D opendir(git_path("worktrees"));
-	struct dirent *d;
-	int ret;
-	if (!dir)
-		return;
-	while ((d =3D readdir(dir)) !=3D NULL) {
-		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
-			continue;
-		strbuf_reset(&reason);
-		if (!prune_worktree(d->d_name, &reason))
-			continue;
-		if (show_only || verbose)
-			printf("%s\n", reason.buf);
-		if (show_only)
-			continue;
-		strbuf_reset(&path);
-		strbuf_addstr(&path, git_path("worktrees/%s", d->d_name));
-		ret =3D remove_dir_recursively(&path, 0);
-		if (ret < 0 && errno =3D=3D ENOTDIR)
-			ret =3D unlink(path.buf);
-		if (ret)
-			error(_("failed to remove: %s"), strerror(errno));
-	}
-	closedir(dir);
-	if (!show_only)
-		rmdir(git_path("worktrees"));
-	strbuf_release(&reason);
-	strbuf_release(&path);
-}
-
 /*
  * Write errors (particularly out of space) can result in
  * failed temporary packs (and more rarely indexes and other
@@ -191,12 +101,10 @@ int cmd_prune(int argc, const char **argv, const =
char *prefix)
 {
 	struct rev_info revs;
 	struct progress *progress =3D NULL;
-	int do_prune_worktrees =3D 0;
 	const struct option options[] =3D {
 		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
 		OPT__VERBOSE(&verbose, N_("report pruned objects")),
 		OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
-		OPT_BOOL(0, "worktrees", &do_prune_worktrees, N_("prune .git/worktre=
es")),
 		OPT_EXPIRY_DATE(0, "expire", &expire,
 				N_("expire objects older than <time>")),
 		OPT_END()
@@ -211,13 +119,6 @@ int cmd_prune(int argc, const char **argv, const c=
har *prefix)
=20
 	argc =3D parse_options(argc, argv, prefix, options, prune_usage, 0);
=20
-	if (do_prune_worktrees) {
-		if (argc)
-			die(_("--worktrees does not take extra arguments"));
-		prune_worktrees();
-		return 0;
-	}
-
 	while (argc--) {
 		unsigned char sha1[20];
 		const char *name =3D *argv++;
diff --git a/builtin/worktree.c b/builtin/worktree.c
new file mode 100644
index 0000000..2a729c6
--- /dev/null
+++ b/builtin/worktree.c
@@ -0,0 +1,133 @@
+#include "cache.h"
+#include "builtin.h"
+#include "dir.h"
+#include "parse-options.h"
+
+static const char * const worktree_usage[] =3D {
+	N_("git worktree prune [<options>]"),
+	NULL
+};
+
+static int show_only;
+static int verbose;
+static unsigned long expire;
+
+static int prune_worktree(const char *id, struct strbuf *reason)
+{
+	struct stat st;
+	char *path;
+	int fd, len;
+
+	if (!is_directory(git_path("worktrees/%s", id))) {
+		strbuf_addf(reason, _("Removing worktrees/%s: not a valid directory"=
), id);
+		return 1;
+	}
+	if (file_exists(git_path("worktrees/%s/locked", id)))
+		return 0;
+	if (stat(git_path("worktrees/%s/gitdir", id), &st)) {
+		strbuf_addf(reason, _("Removing worktrees/%s: gitdir file does not e=
xist"), id);
+		return 1;
+	}
+	fd =3D open(git_path("worktrees/%s/gitdir", id), O_RDONLY);
+	if (fd < 0) {
+		strbuf_addf(reason, _("Removing worktrees/%s: unable to read gitdir =
file (%s)"),
+			    id, strerror(errno));
+		return 1;
+	}
+	len =3D st.st_size;
+	path =3D xmalloc(len + 1);
+	read_in_full(fd, path, len);
+	close(fd);
+	while (len && (path[len - 1] =3D=3D '\n' || path[len - 1] =3D=3D '\r'=
))
+		len--;
+	if (!len) {
+		strbuf_addf(reason, _("Removing worktrees/%s: invalid gitdir file"),=
 id);
+		free(path);
+		return 1;
+	}
+	path[len] =3D '\0';
+	if (!file_exists(path)) {
+		struct stat st_link;
+		free(path);
+		/*
+		 * the repo is moved manually and has not been
+		 * accessed since?
+		 */
+		if (!stat(git_path("worktrees/%s/link", id), &st_link) &&
+		    st_link.st_nlink > 1)
+			return 0;
+		if (st.st_mtime <=3D expire) {
+			strbuf_addf(reason, _("Removing worktrees/%s: gitdir file points to=
 non-existent location"), id);
+			return 1;
+		} else {
+			return 0;
+		}
+	}
+	free(path);
+	return 0;
+}
+
+static void prune_worktrees(void)
+{
+	struct strbuf reason =3D STRBUF_INIT;
+	struct strbuf path =3D STRBUF_INIT;
+	DIR *dir =3D opendir(git_path("worktrees"));
+	struct dirent *d;
+	int ret;
+	if (!dir)
+		return;
+	while ((d =3D readdir(dir)) !=3D NULL) {
+		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+			continue;
+		strbuf_reset(&reason);
+		if (!prune_worktree(d->d_name, &reason))
+			continue;
+		if (show_only || verbose)
+			printf("%s\n", reason.buf);
+		if (show_only)
+			continue;
+		strbuf_reset(&path);
+		strbuf_addstr(&path, git_path("worktrees/%s", d->d_name));
+		ret =3D remove_dir_recursively(&path, 0);
+		if (ret < 0 && errno =3D=3D ENOTDIR)
+			ret =3D unlink(path.buf);
+		if (ret)
+			error(_("failed to remove: %s"), strerror(errno));
+	}
+	closedir(dir);
+	if (!show_only)
+		rmdir(git_path("worktrees"));
+	strbuf_release(&reason);
+	strbuf_release(&path);
+}
+
+static int prune(int ac, const char **av, const char *prefix)
+{
+	struct option options[] =3D {
+		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
+		OPT__VERBOSE(&verbose, N_("report pruned objects")),
+		OPT_EXPIRY_DATE(0, "expire", &expire,
+				N_("expire objects older than <time>")),
+		OPT_END()
+	};
+
+	expire =3D ULONG_MAX;
+	ac =3D parse_options(ac, av, prefix, options, worktree_usage, 0);
+	if (ac)
+		usage_with_options(worktree_usage, options);
+	prune_worktrees();
+	return 0;
+}
+
+int cmd_worktree(int ac, const char **av, const char *prefix)
+{
+	struct option options[] =3D {
+		OPT_END()
+	};
+
+	if (ac < 2)
+		usage_with_options(worktree_usage, options);
+	if (!strcmp(av[1], "prune"))
+		return prune(ac - 1, av + 1, prefix);
+	usage_with_options(worktree_usage, options);
+}
diff --git a/command-list.txt b/command-list.txt
index b17c011..2a94137 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -148,4 +148,5 @@ git-verify-pack                         plumbingint=
errogators
 git-verify-tag                          ancillaryinterrogators
 gitweb                                  ancillaryinterrogators
 git-whatchanged                         ancillaryinterrogators
+git-worktree                            mainporcelain
 git-write-tree                          plumbingmanipulators
diff --git a/git.c b/git.c
index 44374b1..fa77bc9 100644
--- a/git.c
+++ b/git.c
@@ -483,6 +483,7 @@ static struct cmd_struct commands[] =3D {
 	{ "verify-tag", cmd_verify_tag, RUN_SETUP },
 	{ "version", cmd_version },
 	{ "whatchanged", cmd_whatchanged, RUN_SETUP },
+	{ "worktree", cmd_worktree, RUN_SETUP },
 	{ "write-tree", cmd_write_tree, RUN_SETUP },
 };
=20
diff --git a/t/t2026-prune-linked-checkouts.sh b/t/t2026-prune-linked-c=
heckouts.sh
index 1821a48..e872f02 100755
--- a/t/t2026-prune-linked-checkouts.sh
+++ b/t/t2026-prune-linked-checkouts.sh
@@ -8,15 +8,15 @@ test_expect_success initialize '
 	git commit --allow-empty -m init
 '
=20
-test_expect_success 'prune --worktrees on normal repo' '
-	git prune --worktrees &&
-	test_must_fail git prune --worktrees abc
+test_expect_success 'worktree prune on normal repo' '
+	git worktree prune &&
+	test_must_fail git worktree prune abc
 '
=20
 test_expect_success 'prune files inside $GIT_DIR/worktrees' '
 	mkdir .git/worktrees &&
 	: >.git/worktrees/abc &&
-	git prune --worktrees --verbose >actual &&
+	git worktree prune --verbose >actual &&
 	cat >expect <<EOF &&
 Removing worktrees/abc: not a valid directory
 EOF
@@ -31,7 +31,7 @@ test_expect_success 'prune directories without gitdir=
' '
 	cat >expect <<EOF &&
 Removing worktrees/def: gitdir file does not exist
 EOF
-	git prune --worktrees --verbose >actual &&
+	git worktree prune --verbose >actual &&
 	test_i18ncmp expect actual &&
 	! test -d .git/worktrees/def &&
 	! test -d .git/worktrees
@@ -42,7 +42,7 @@ test_expect_success SANITY 'prune directories with un=
readable gitdir' '
 	: >.git/worktrees/def/def &&
 	: >.git/worktrees/def/gitdir &&
 	chmod u-r .git/worktrees/def/gitdir &&
-	git prune --worktrees --verbose >actual &&
+	git worktree prune --verbose >actual &&
 	test_i18ngrep "Removing worktrees/def: unable to read gitdir file" ac=
tual &&
 	! test -d .git/worktrees/def &&
 	! test -d .git/worktrees
@@ -52,7 +52,7 @@ test_expect_success 'prune directories with invalid g=
itdir' '
 	mkdir -p .git/worktrees/def/abc &&
 	: >.git/worktrees/def/def &&
 	: >.git/worktrees/def/gitdir &&
-	git prune --worktrees --verbose >actual &&
+	git worktree prune --verbose >actual &&
 	test_i18ngrep "Removing worktrees/def: invalid gitdir file" actual &&
 	! test -d .git/worktrees/def &&
 	! test -d .git/worktrees
@@ -62,7 +62,7 @@ test_expect_success 'prune directories with gitdir po=
inting to nowhere' '
 	mkdir -p .git/worktrees/def/abc &&
 	: >.git/worktrees/def/def &&
 	echo "$(pwd)"/nowhere >.git/worktrees/def/gitdir &&
-	git prune --worktrees --verbose >actual &&
+	git worktree prune --verbose >actual &&
 	test_i18ngrep "Removing worktrees/def: gitdir file points to non-exis=
tent location" actual &&
 	! test -d .git/worktrees/def &&
 	! test -d .git/worktrees
@@ -72,7 +72,7 @@ test_expect_success 'not prune locked checkout' '
 	test_when_finished rm -r .git/worktrees &&
 	mkdir -p .git/worktrees/ghi &&
 	: >.git/worktrees/ghi/locked &&
-	git prune --worktrees &&
+	git worktree prune &&
 	test -d .git/worktrees/ghi
 '
=20
@@ -82,14 +82,14 @@ test_expect_success 'not prune recent checkouts' '
 	mkdir -p .git/worktrees/jlm &&
 	echo "$(pwd)"/zz >.git/worktrees/jlm/gitdir &&
 	rmdir zz &&
-	git prune --worktrees --verbose --expire=3D2.days.ago &&
+	git worktree prune --verbose --expire=3D2.days.ago &&
 	test -d .git/worktrees/jlm
 '
=20
 test_expect_success 'not prune proper checkouts' '
 	test_when_finished rm -r .git/worktrees &&
 	git checkout "--to=3D$PWD/nop" --detach master &&
-	git prune --worktrees &&
+	git worktree prune &&
 	test -d .git/worktrees/nop
 '
=20
--=20
2.3.0.rc1.137.g477eb31
