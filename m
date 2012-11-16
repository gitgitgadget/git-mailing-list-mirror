From: Aske Olsson <askeolsson@gmail.com>
Subject: [PATCH] Add support for a 'pre-push' hook
Date: Fri, 16 Nov 2012 20:42:59 +0100
Message-ID: <CAJwKrPYwCE4ExmK09PURMfjYezn6vdCH_BBXU4WCwrnotyV9CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 16 20:43:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZRoq-0003vd-Ds
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 20:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354Ab2KPTnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 14:43:01 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:60231 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983Ab2KPTnA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 14:43:00 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so1968027qcr.19
        for <git@vger.kernel.org>; Fri, 16 Nov 2012 11:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=tF5mlErnIV9+u5Uo9gjyVyYIuWzs3PWRqdsGAT9gPaw=;
        b=fXrW8X4g9aFfnAoNDl1oPEJ8sQq8eW3dc75WIzKmkadYihwtbpX1EXQkImdQq7qvbI
         8wcDrYGoJXW7vNIYEGasQZLde+KbahXZ4l1/WppUmWLWIIGr1niQ4i2lzltiJGPNnMuR
         0n4siEqAflhIPRovtV9/XCqp2pigHy0Zlm+6yTW3yAYOCmIuJz+DTBeJ2e+sserAk1f0
         hHXY1eZrhtv93tftmMfwpMO00AmAxtMeWhpycVazbVVWeedR7D1Jw0OVqa86fPYNR64U
         h42+L9ojMBrnOR6aeZyI8PZsAtHKfb8dwS4FdzNkPGi9hEjhdszcn/Lsh4WFz5krFRXD
         8Oqg==
Received: by 10.49.4.168 with SMTP id l8mr5935711qel.57.1353094979751; Fri, 16
 Nov 2012 11:42:59 -0800 (PST)
Received: by 10.49.108.170 with HTTP; Fri, 16 Nov 2012 11:42:59 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209897>

If the script .git/hooks/pre-push exists and is executable it will be
called before a `git push` command, and when the script exits with a
non-zero status the push will be aborted.
The hook can be overridden by passing the '--no-verify' option to
`git push`.

The pre-push hook is usefull to run tests etc. before push. Or to make
sure that if a binary solution like git-media, git-annex or git-bin is
used the binaries are uploaded before the push, so when others do a
fetch the binaries will be available already. This also reduces the
need for introducing extra (git) commands to e.g. sync binaries.

Signed-off-by: Aske Olsson <askeolsson@gmail.com>
---
 Documentation/git-push.txt |  11 +++-
 Documentation/githooks.txt |  12 +++++
 builtin/push.c             |   6 +++
 t/t5542-pre-push-hook.sh   | 132 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 160 insertions(+), 1 deletion(-)
 create mode 100644 t/t5542-pre-push-hook.sh

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index fe46c42..5807b6a 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git push' [--all | --mirror | --tags] [-n | --dry-run]
[--receive-pack=<git-receive-pack>]
    [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose]
[-u | --set-upstream]
-   [<repository> [<refspec>...]]
+   [ --no-verify] [<repository> [<refspec>...]]

 DESCRIPTION
 -----------
@@ -157,6 +157,10 @@ useful if you write an alias or script around 'git push'.
  receiver share many of the same objects in common. The default is
  \--thin.

+--no-verify::
+ This option bypasses the pre-push hook.
+ See also linkgit:githooks[5].
+
 -q::
 --quiet::
  Suppress all output, including the listing of updated refs,
@@ -430,6 +434,11 @@ Commits A and B would no longer belong to a
branch with a symbolic name,
 and so would be unreachable.  As such, these commits would be removed by
 a `git gc` command on the origin repository.

+HOOKS
+-----
+This command can run the `pre-push` hook.  See linkgit:githooks[5] for
+more information.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index b9003fe..847e0f8 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -176,6 +176,18 @@ save and restore any form of metadata associated
with the working tree
 (eg: permissions/ownership, ACLS, etc).  See contrib/hooks/setgitperms.perl
 for an example of how to do this.

+[[pre-push]]
+pre-push
+~~~~~~~~
+
+This hook is invoked by 'git push' and can be bypassed with the
+`--no-verify` option. It takes no parameter, and is invoked before
+the push happens.
+Exiting with a non-zero status from this script causes 'git push'
+to abort.
+
+
+
 [[pre-receive]]
 pre-receive
 ~~~~~~~~~~~
diff --git a/builtin/push.c b/builtin/push.c
index db9ba30..9c4d2ec 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -16,6 +16,7 @@ static const char * const push_usage[] = {
 };

 static int thin;
+static int no_verify;
 static int deleterefs;
 static const char *receivepack;
 static int verbosity;
@@ -392,6 +393,7 @@ int cmd_push(int argc, const char **argv, const
char *prefix)
  N_("control recursive pushing of submodules"),
  PARSE_OPT_OPTARG, option_parse_recurse_submodules },
  OPT_BOOLEAN( 0 , "thin", &thin, N_("use thin pack")),
+ OPT_BOOLEAN('0', "no-verify", &no_verify, "bypass pre-push hook"),
  OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack",
N_("receive pack program")),
  OPT_STRING( 0 , "exec", &receivepack, "receive-pack", N_("receive
pack program")),
  OPT_BIT('u', "set-upstream", &flags, N_("set upstream for git pull/status"),
@@ -419,6 +421,10 @@ int cmd_push(int argc, const char **argv, const
char *prefix)
  set_refspecs(argv + 1, argc - 1);
  }

+ if (!no_verify && run_hook(NULL, "pre-push")) {
+ die(_("pre-push hook failed: exiting\n"));
+ }
+
  rc = do_push(repo, flags);
  if (rc == -1)
  usage_with_options(push_usage, options);
diff --git a/t/t5542-pre-push-hook.sh b/t/t5542-pre-push-hook.sh
new file mode 100644
index 0000000..842aa23
--- /dev/null
+++ b/t/t5542-pre-push-hook.sh
@@ -0,0 +1,132 @@
+#!/bin/sh
+
+test_description='pre-push hook'
+
+. ./test-lib.sh
+
+D=`pwd`
+HOOK="master/.git/hooks/pre-push"
+
+# Repo pair
+mk_repo_pair () {
+ rm -rf master mirror &&
+ mkdir mirror &&
+ (
+ cd mirror &&
+ git init &&
+ git config receive.denyCurrentBranch warn
+ )
+ mkdir master &&
+ (
+ cd master &&
+ git init &&
+ git remote add $1 up ../mirror
+ )
+}
+
+# hook that always succeeds
+mk_hook_exec () {
+cat > "$HOOK" <<EOF
+#!/bin/sh
+exit 0
+EOF
+chmod +x "$HOOK"
+}
+
+# hook that fails
+mk_hook_fail () {
+cat > "$HOOK" <<EOF
+#!/bin/sh
+exit 1
+EOF
+chmod +x "$HOOK"
+}
+
+# nonexecutable hook
+mk_hook_no_exec () {
+rm -f "$HOOK"
+cat > "$HOOK" <<EOF
+#!/bin/sh
+echo 'test run'
+exit 0
+EOF
+}
+
+test_expect_success 'push with no pre-push hook' '
+ mk_repo_pair &&
+ (
+ cd master &&
+ echo one >foo && git add foo && git commit -m one &&
+ git push --mirror up
+ )
+'
+
+test_expect_success 'push --no-verify with no pre-push hook' '
+ mk_repo_pair &&
+ (
+ cd master &&
+ echo one >foo && git add foo && git commit -m one &&
+ git push --no-verify --mirror up
+ )
+'
+
+test_expect_success 'push with succeeding pre-push hook' '
+ mk_repo_pair &&
+ (
+ mk_hook_exec &&
+ cd master &&
+ echo one >foo && git add foo && git commit -m one &&
+ git push --mirror up
+ )
+'
+
+test_expect_success 'push --no-verify with succeeding pre-push hook' '
+ mk_repo_pair &&
+ (
+ mk_hook_exec &&
+ cd master &&
+ echo one >foo && git add foo && git commit -m one &&
+ git push --no-verify --mirror up
+ )
+'
+
+test_expect_success 'push with failing pre-push hook' '
+ mk_repo_pair &&
+ (
+ mk_hook_fail &&
+ cd master &&
+ echo one >foo && git add foo && git commit -m one &&
+ test_must_fail git push --mirror up
+ )
+'
+
+test_expect_success 'push --no-verify with failing hook' '
+ mk_repo_pair &&
+ (
+ mk_hook_fail &&
+ cd master &&
+ echo one >foo && git add foo && git commit -m one &&
+ git push --no-verify --mirror up
+ )
+'
+
+test_expect_success 'push with non-executable pre-push hook' '
+ mk_repo_pair &&
+ (
+ mk_hook_no_exec &&
+ cd master &&
+ echo one >foo && git add foo && git commit -m one &&
+ git push --mirror up
+ )
+'
+
+test_expect_success 'push --no-verify with non-executable pre-push hook' '
+ mk_repo_pair &&
+ (
+ mk_hook_no_exec &&
+ cd master &&
+ echo one >foo && git add foo && git commit -m one &&
+ git push --no-verify --mirror up
+ )
+'
+test_done
--
1.8.0
