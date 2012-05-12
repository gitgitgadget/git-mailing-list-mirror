From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Update "gc" behavior in commit, merge, am, rebase and index-pack
Date: Sat, 12 May 2012 15:08:54 +0700
Message-ID: <1336810134-3103-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 10:13:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ST7S6-0006KH-5C
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 10:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157Ab2ELIMt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 May 2012 04:12:49 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56281 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724Ab2ELIMl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2012 04:12:41 -0400
Received: by obbtb18 with SMTP id tb18so4377494obb.19
        for <git@vger.kernel.org>; Sat, 12 May 2012 01:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=TFIpkh8nsG+ZrqFv2Q0K3/IeOOkqPx7aUvEMwRDP2Vo=;
        b=DsYSRrnUQbkj3GV2uJAu0ZyiqqQxcjFAwfQ1bc5ydkkFj2LnzD9uu37ruXnNHsqwAd
         +TTNr73PAzWYVGkceJr1YI628CzZX/wBiiVHxwzgNjCpx2/CQhHKN93MTkUI5ZU3VKgt
         3JdaGIx0uvCwuqvVme198DflfksVLE1yePzKcJnTzAtMhNpPsqvOuzodMVdbYXwkeFTN
         3cqO3QokynzCBz9b4rPs0HMB1zcbfDSGd7WFw2lKP5aV+Cv4y4yGy25BnLWm2okDgQ15
         PQmp4E/uFIOW2jGfocTKqukHoQeeZwQbA+/OZJk5QIL2/1bu+gGaP8a1fLMDP1RSVJYX
         HzjQ==
Received: by 10.60.32.204 with SMTP id l12mr1296276oei.47.1336810361064;
        Sat, 12 May 2012 01:12:41 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.59.131])
        by mx.google.com with ESMTPS id zn5sm12117023obb.18.2012.05.12.01.12.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 12 May 2012 01:12:40 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 12 May 2012 15:08:55 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197716>

A few attempts have been made in the past to change 'gc --auto' [1]
[2]. This is another such attempt.

Commit d4bb43e (Invoke "git gc --auto" from commit, merge, am and
rebase. - 2007-09-05) used the rule to put "gc --auto" is "where
update-ref occurs". I would argue that this is not a good condition to
run gc, because (at least current) gc is slow. We encourage commit
often and rebase to make all patches in good shape and this workflow
should not be interrupted/slowed down by random "gc --auto".

Instead, we could just inform users that "gc" should be run soon in
commonly used commands (this patch also reinstates "gc" check in
commit, which was lost at the sh->C conversion). [1] and [2] can annoy
users constantly with warnings. This patch shows the warning at most
once a day.

There are commands that are not expected to return immediately. These
are more suitable for "gc --auto". One of them is receive-pack, which
already calls "gc --auto". The other one is index-pack, which "gc
--auto" is added in by this patch.

In short, after this patch:

 - receive-pack and index-pack (or push, pull/fetch at high level) can
   do "gc --auto".
 - commmit, merge, am, rebase warns once a day, no actual gc.

[1] http://thread.gmane.org/gmane.comp.version-control.git/184848
   adds an config option to turn --auto to warning only

[2] http://thread.gmane.org/gmane.comp.version-control.git/187711
   make it warn early before actual do the house keeping

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c           |    2 ++
 builtin/gc.c               |   21 ++++++++++++++++++++-
 builtin/index-pack.c       |   16 ++++++++++++++--
 builtin/merge.c            |    2 +-
 git-am.sh                  |    2 +-
 git-rebase--interactive.sh |    2 +-
 6 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index a2ec73d..4ba5677 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1418,6 +1418,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
=20
 		OPT_END()
 	};
+	const char *argv_gc_auto[] =3D { "gc", "--check", NULL };
=20
 	struct strbuf sb =3D STRBUF_INIT;
 	struct strbuf author_ident =3D STRBUF_INIT;
@@ -1589,6 +1590,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 		     "new_index file. Check that disk is not full or quota is\n"
 		     "not exceeded, and then \"git reset HEAD\" to recover."));
=20
+	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 	rerere(0);
 	run_hook(get_index_file(), "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
diff --git a/builtin/gc.c b/builtin/gc.c
index 9b4232c..a85f71c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -171,6 +171,7 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 {
 	int aggressive =3D 0;
 	int auto_gc =3D 0;
+	int check_gc =3D 0;
 	int quiet =3D 0;
=20
 	struct option builtin_gc_options[] =3D {
@@ -180,12 +181,16 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
 			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire },
 		OPT_BOOLEAN(0, "aggressive", &aggressive, "be more thorough (increas=
ed runtime)"),
 		OPT_BOOLEAN(0, "auto", &auto_gc, "enable auto-gc mode"),
+		OPT_BOOLEAN(0, "check", &check_gc, "enable auto-gc mode"),
 		OPT_END()
 	};
=20
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_gc_usage, builtin_gc_options);
=20
+	if (auto_gc && check_gc)
+		die(_("--auto and --check are incompatible"));
+
 	argv_array_pushl(&pack_refs_cmd, "pack-refs", "--all", "--prune", NUL=
L);
 	argv_array_pushl(&reflog, "reflog", "expire", "--all", NULL);
 	argv_array_pushl(&repack, "repack", "-d", "-l", NULL);
@@ -211,12 +216,26 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
 	if (quiet)
 		argv_array_push(&repack, "-q");
=20
-	if (auto_gc) {
+	if (auto_gc || check_gc) {
 		/*
 		 * Auto-gc should be least intrusive as possible.
 		 */
 		if (!need_to_gc())
 			return 0;
+		if (check_gc) {
+			struct stat st;
+			if (stat(git_path("gc_needed"), &st))
+				open(git_path("gc_needed"), O_CREAT | O_RDWR);
+			else {
+				/* do not bother users more than once a day */
+				if (time(NULL) - st.st_mtime < 86400)
+					return 0;
+				utime(git_path("gc_needed"), NULL);
+			}
+			warning(_("This repository needs maintenance. "
+				  "Please run \"git gc\" as soon as possible."));
+			return 0;
+		}
 		if (quiet)
 			fprintf(stderr, _("Auto packing the repository for optimum performa=
nce.\n"));
 		else
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 83555e5..438245c 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -9,6 +9,7 @@
 #include "progress.h"
 #include "fsck.h"
 #include "exec_cmd.h"
+#include "run-command.h"
=20
 static const char index_pack_usage[] =3D
 "git index-pack [-v] [-o <index-file>] [--keep | --keep=3D<msg>] [--ve=
rify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
@@ -63,6 +64,7 @@ static int nr_resolved_deltas;
 static int from_stdin;
 static int strict;
 static int verbose;
+static int auto_gc;
=20
 static struct progress *progress;
=20
@@ -968,6 +970,10 @@ static int git_index_pack_config(const char *k, co=
nst char *v, void *cb)
 			die("bad pack.indexversion=3D%"PRIu32, opts->version);
 		return 0;
 	}
+	if (strcmp(k, "receive.autogc") =3D=3D 0) {
+		auto_gc =3D git_config_bool(k, v);
+		return 0;
+	}
 	return git_default_config(k, v, cb);
 }
=20
@@ -1254,12 +1260,18 @@ int cmd_index_pack(int argc, const char **argv,=
 const char *prefix)
 	curr_index =3D write_idx_file(index_name, idx_objects, nr_objects, &o=
pts, pack_sha1);
 	free(idx_objects);
=20
-	if (!verify)
+	if (!verify) {
 		final(pack_name, curr_pack,
 		      index_name, curr_index,
 		      keep_name, keep_msg,
 		      pack_sha1);
-	else
+		if (auto_gc) {
+			const char *argv_gc_auto[] =3D {
+				"gc", "--auto", "--quiet", NULL,
+			};
+			run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+		}
+	} else
 		close(input_fd);
 	free(objects);
 	free(index_name_buf);
diff --git a/builtin/merge.c b/builtin/merge.c
index 470fc57..8b8716e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -385,7 +385,7 @@ static void finish(struct commit *head_commit,
 		if (verbosity >=3D 0 && !merge_msg.len)
 			printf(_("No merge message -- not updating HEAD\n"));
 		else {
-			const char *argv_gc_auto[] =3D { "gc", "--auto", NULL };
+			const char *argv_gc_auto[] =3D { "gc", "--check", NULL };
 			update_ref(reflog_message.buf, "HEAD",
 				new_head, head, 0,
 				DIE_ON_ERR);
diff --git a/git-am.sh b/git-am.sh
index f8b7a0c..0f2dbc4 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -902,4 +902,4 @@ if test -s "$dotest"/rewritten; then
 fi
=20
 rm -fr "$dotest"
-git gc --auto
+git gc --check
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0c19b7c..89996a3 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -573,7 +573,7 @@ do_next () {
 		true # we don't care if this hook failed
 	fi &&
 	rm -rf "$state_dir" &&
-	git gc --auto &&
+	git gc --check &&
 	warn "Successfully rebased and updated $head_name."
=20
 	exit
--=20
1.7.8.36.g69ee2
