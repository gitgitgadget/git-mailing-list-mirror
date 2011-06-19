From: Boris Faure <billiob@gmail.com>
Subject: [PATCH/RFC] branch: add optional parameter to -r to specify remote
Date: Sun, 19 Jun 2011 21:19:09 +0200
Message-ID: <1308511149-10933-2-git-send-email-billiob@gmail.com>
References: <1308511149-10933-1-git-send-email-billiob@gmail.com>
Cc: Boris Faure <billiob@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 19 21:09:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYNMv-00021D-La
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 21:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754686Ab1FSTJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 15:09:04 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34395 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651Ab1FSTJA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 15:09:00 -0400
Received: by wwe5 with SMTP id 5so1911769wwe.1
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 12:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=lVL+uooqzn1Rj8zgjI7ilpgkZn1Oz1M0L4HTJl9VUV0=;
        b=tGHABV+Vps9Y4NzhdAHUO8anGcwB0w+Iz5X98imk9ZeXLhVW7ddTFG0hbF8qi6EDmy
         AkB/LI/2HUu5aY5cvU9lLsiX6yZry42aX57leiimM0qAXsciGdNbFsk+J0xsWUbmwS/F
         HOrHimAo4IV+VtZmWzfQf+mjgOkyBzP5sh5G4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bhTGhIwKY2HwDhrpaNhw+a7h1O9ALNSKOopZOVF3eonY+EqUl/FB+113Sl8FEhJuCV
         DN96p3c8Oevd8zTG6sXaUCtCGb56P5fRJJiQRx9ccj0l9rZJYms/ksHqeK6jq7IWdxpM
         rynv6CjOTyvLxco0mN5mQBluCKY3MMGCI8Kn4=
Received: by 10.216.159.75 with SMTP id r53mr3991504wek.98.1308510539111;
        Sun, 19 Jun 2011 12:08:59 -0700 (PDT)
Received: from localhost.localdomain (ADijon-259-1-31-165.w90-33.abo.wanadoo.fr [90.33.98.165])
        by mx.google.com with ESMTPS id g2sm2508004weg.38.2011.06.19.12.08.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 12:08:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc2.4.g36bfb.dirty
In-Reply-To: <1308511149-10933-1-git-send-email-billiob@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176027>

add '--remote' as long version for '-r'
update documentation
add tests
---
 Documentation/git-branch.txt |   10 +++--
 builtin/branch.c             |   72 ++++++++++++++++++++++++++++++++----------
 t/t3200-branch.sh            |   34 ++++++++++++++++++++
 t/t3203-branch-output.sh     |   59 ++++++++++++++++++++++++++++++++++
 4 files changed, 154 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index c50f189..242da9c 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -8,12 +8,12 @@ git-branch - List, create, or delete branches
 SYNOPSIS
 --------
 [verse]
-'git branch' [--color[=<when>] | --no-color] [-r | -a]
+'git branch' [--color[=<when>] | --no-color] [-r[=<remote>] | -a]
 	[-v [--abbrev=<length> | --no-abbrev]]
 	[(--merged | --no-merged | --contains) [<commit>]]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
-'git branch' (-d | -D) [-r] <branchname>...
+'git branch' (-d | -D) [-r[=<remote>]] <branchname>...
 
 DESCRIPTION
 -----------
@@ -99,8 +99,10 @@ OPTIONS
 	default to color output.
 	Same as `--color=never`.
 
--r::
-	List or delete (if used with -d) the remote-tracking branches.
+-r[=<remote>]::
+--remote[=<remote>]::
+	List or delete (if used with -d) the remote-tracking branches from
+	<remote> if specified.
 
 -a::
 	List both remote-tracking branches and local branches.
diff --git a/builtin/branch.c b/builtin/branch.c
index d6ab93b..52dff04 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -17,15 +17,18 @@
 #include "revision.h"
 
 static const char * const builtin_branch_usage[] = {
-	"git branch [options] [-r | -a] [--merged | --no-merged]",
+	"git branch [options] [-r[=<remote>] | -a] [--merged | --no-merged]",
 	"git branch [options] [-l] [-f] <branchname> [<start-point>]",
-	"git branch [options] [-r] (-d | -D) <branchname>",
+	"git branch [options] [-r[=<remote>]] (-d | -D) <branchname>",
 	"git branch [options] (-m | -M) [<oldbranch>] <newbranch>",
 	NULL
 };
 
 #define REF_LOCAL_BRANCH    0x01
 #define REF_REMOTE_BRANCH   0x02
+static int kinds = REF_LOCAL_BRANCH;
+
+static const char *remote = NULL;
 
 static const char *head;
 static unsigned char head_sha1[20];
@@ -144,12 +147,12 @@ static int branch_merged(int kind, const char *name,
 	return merged;
 }
 
-static int delete_branches(int argc, const char **argv, int force, int kinds)
+static int delete_branches(int argc, const char **argv, int force)
 {
 	struct commit *rev, *head_rev = NULL;
 	unsigned char sha1[20];
 	char *name = NULL;
-	const char *fmt, *remote;
+	const char *fmt, *remote_trans;
 	int i;
 	int ret = 0;
 	struct strbuf bname = STRBUF_INIT;
@@ -158,12 +161,12 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 	case REF_REMOTE_BRANCH:
 		fmt = "refs/remotes/%s";
 		/* TRANSLATORS: This is "remote " in "remote branch '%s' not found" */
-		remote = _("remote ");
+		remote_trans = _("remote ");
 		force = 1;
 		break;
 	case REF_LOCAL_BRANCH:
 		fmt = "refs/heads/%s";
-		remote = "";
+		remote_trans = "";
 		break;
 	default:
 		die(_("cannot use -a with -d"));
@@ -175,7 +178,16 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 			die(_("Couldn't look up commit object for HEAD"));
 	}
 	for (i = 0; i < argc; i++, strbuf_release(&bname)) {
-		strbuf_branchname(&bname, argv[i]);
+		if (kinds == REF_REMOTE_BRANCH && remote) {
+			struct strbuf buf = STRBUF_INIT;
+			strbuf_addstr(&buf, remote);
+			strbuf_addch(&buf, '/');
+			strbuf_addstr(&buf, argv[i]);
+			strbuf_branchname(&bname, buf.buf);
+			strbuf_release(&buf);
+		} else {
+			strbuf_branchname(&bname, argv[i]);
+		}
 		if (kinds == REF_LOCAL_BRANCH && !strcmp(head, bname.buf)) {
 			error(_("Cannot delete the branch '%s' "
 			      "which you are currently on."), bname.buf);
@@ -188,7 +200,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 		name = xstrdup(mkpath(fmt, bname.buf));
 		if (!resolve_ref(name, sha1, 1, NULL)) {
 			error(_("%sbranch '%s' not found."),
-					remote, bname.buf);
+			      remote_trans, bname.buf);
 			ret = 1;
 			continue;
 		}
@@ -209,12 +221,13 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 		}
 
 		if (delete_ref(name, sha1, 0)) {
-			error(_("Error deleting %sbranch '%s'"), remote,
+			error(_("Error deleting %sbranch '%s'"), remote_trans,
 			      bname.buf);
 			ret = 1;
 		} else {
 			struct strbuf buf = STRBUF_INIT;
-			printf(_("Deleted %sbranch %s (was %s).\n"), remote,
+			printf(_("Deleted %sbranch %s (was %s).\n"),
+			       remote_trans,
 			       bname.buf,
 			       find_unique_abbrev(sha1, DEFAULT_ABBREV));
 			strbuf_addf(&buf, "branch.%s", bname.buf);
@@ -492,7 +505,7 @@ static void show_detached(struct ref_list *ref_list)
 	}
 }
 
-static int print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit)
+static int print_ref_list(int detached, int verbose, int abbrev, struct commit_list *with_commit)
 {
 	int i;
 	struct append_ref_cb cb;
@@ -533,6 +546,14 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 		char *prefix = (kinds != REF_REMOTE_BRANCH &&
 				ref_list.list[i].kind == REF_REMOTE_BRANCH)
 				? "remotes/" : "";
+		if (kinds == REF_REMOTE_BRANCH && remote &&
+		    ref_list.list[i].kind == REF_REMOTE_BRANCH &&
+		    ref_list.list[i].name) {
+			int remote_len = strlen(remote);
+			if (strncmp(remote, ref_list.list[i].name, strlen(remote)) ||
+			       ref_list.list[i].name[remote_len] != '/')
+				continue;
+		}
 		print_ref_item(&ref_list.list[i], ref_list.maxwidth, verbose,
 			       abbrev, current, prefix);
 	}
@@ -610,13 +631,28 @@ static int opt_parse_merge_filter(const struct option *opt, const char *arg, int
 	return 0;
 }
 
+static int parse_opt_remote_cb(const struct option *opt, const char *arg,
+			       int unset)
+{
+	kinds = REF_REMOTE_BRANCH;
+	if (unset)
+		kinds = REF_LOCAL_BRANCH;
+	if (arg) {
+		if ( *arg == '=')
+			remote = arg + 1; /* skip '=' */
+		else
+			remote = arg;
+	} else
+		remote = NULL;
+	return 0;
+}
+
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, rename = 0, force_create = 0;
 	int verbose = 0, abbrev = DEFAULT_ABBREV, detached = 0;
 	int reflog = 0;
 	enum branch_track track;
-	int kinds = REF_LOCAL_BRANCH;
 	struct commit_list *with_commit = NULL;
 
 	struct option options[] = {
@@ -628,8 +664,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT( 0, "set-upstream",  &track, "change upstream info",
 			BRANCH_TRACK_OVERRIDE),
 		OPT__COLOR(&branch_use_color, "use colored output"),
-		OPT_SET_INT('r', NULL,     &kinds, "act on remote-tracking branches",
-			REF_REMOTE_BRANCH),
+		{
+			OPTION_CALLBACK, 'r', "remote", &kinds, "remote",
+			"act on remote-tracking branches",
+			PARSE_OPT_OPTARG, parse_opt_remote_cb, 0
+		},
 		{
 			OPTION_CALLBACK, 0, "contains", &with_commit, "commit",
 			"print only branches that contain the commit",
@@ -695,11 +734,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			     0);
 	if (!!delete + !!rename + !!force_create > 1)
 		usage_with_options(builtin_branch_usage, options);
-
 	if (delete)
-		return delete_branches(argc, argv, delete > 1, kinds);
+		return delete_branches(argc, argv, delete > 1);
 	else if (argc == 0)
-		return print_ref_list(kinds, detached, verbose, abbrev, with_commit);
+		return print_ref_list(detached, verbose, abbrev, with_commit);
 	else if (rename && (argc == 1))
 		rename_branch(head, argv[0], rename > 1);
 	else if (rename && (argc == 2))
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 9e69c8c..df2f0f8 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -10,6 +10,23 @@ handled.  Specifically, that a bogus branch is not created.
 '
 . ./test-lib.sh
 
+setup_repository () {
+	mkdir "$1" && (
+	cd "$1" &&
+	git init &&
+	>file &&
+	git add file &&
+	test_tick &&
+	git commit -m "Initial" &&
+	git checkout -b side &&
+	>elif &&
+	git add elif &&
+	test_tick &&
+	git commit -m "Second" &&
+	git checkout master
+	)
+}
+
 test_expect_success \
     'prepare a trivial repository' \
     'echo Hello > A &&
@@ -542,4 +559,21 @@ test_expect_success 'attempt to delete a branch merged to its base' '
 	test_must_fail git branch -d my10
 '
 
+test_expect_success 'git branch -d -r=one another should delete another branch from remote one' '
+	setup_repository one &&
+	setup_repository onelong &&
+	(
+		cd one && git branch another
+	) &&
+	git remote add -f one one &&
+	git remote add -f onelong onelong &&
+	git branch -d -r=one another &&
+	test ! -f .git/refs/remotes/one/another &&
+	test ! -f .git/logs/refs/remotes/one/another'
+
+test_expect_success 'git branch -d --remote=one master should delete master branch from remote one' '
+	git branch -d --remote=one master &&
+	test ! -f .git/refs/remotes/one/master &&
+	test ! -f .git/logs/refs/remotes/one/master'
+
 test_done
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 6b7c118..aa8cba6 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -3,6 +3,23 @@
 test_description='git branch display tests'
 . ./test-lib.sh
 
+setup_repository () {
+	mkdir "$1" && (
+	cd "$1" &&
+	git init &&
+	>file &&
+	git add file &&
+	test_tick &&
+	git commit -m "Initial" &&
+	git checkout -b side &&
+	>elif &&
+	git add elif &&
+	test_tick &&
+	git commit -m "Second" &&
+	git checkout master
+	)
+}
+
 test_expect_success 'make commits' '
 	echo content >file &&
 	git add file &&
@@ -43,6 +60,26 @@ test_expect_success 'git branch -r shows remote branches' '
 '
 
 cat >expect <<'EOF'
+  origin/HEAD -> origin/branch-one
+  origin/branch-one
+  origin/branch-two
+EOF
+test_expect_success 'git branch -r=origin shows remote branches from origin' '
+	git branch -r=origin >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+  origin/HEAD -> origin/branch-one
+  origin/branch-one
+  origin/branch-two
+EOF
+test_expect_success 'git branch --remote=origin shows remote branches from origin' '
+	git branch --remote=origin >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
   branch-one
   branch-two
 * master
@@ -78,4 +115,26 @@ test_expect_success 'git branch shows detached HEAD properly' '
 	test_i18ncmp expect actual
 '
 
+
+cat >expect <<'EOF'
+  one/another
+  one/master
+  one/side
+EOF
+
+test_expect_success 'git branch -r=one shows only branches from remote one' '
+	setup_repository one &&
+	setup_repository onelong &&
+	(
+		cd one && git branch another
+	) &&
+	git remote add -f one one &&
+	git remote add -f onelong onelong &&
+	git branch -r=one >actual &&
+	test_cmp expect actual'
+
+test_expect_success 'git branch --remote=one shows only branches from remote one' '
+	git branch --remote=one >actual &&
+	test_cmp expect actual'
+
 test_done
-- 
1.7.6.rc2.4.g36bfb.dirty
