From: "Scott Chacon" <schacon@gmail.com>
Subject: [PATCH] add a 'pre-push' hook
Date: Tue, 19 Aug 2008 11:55:27 -0700
Message-ID: <d411cc4a0808191155g188b0f10je5fd79afb92f36ef@mail.gmail.com>
References: <1219170876-46893-1-git-send-email-schacon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 20:57:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVWNf-0007Lp-J9
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 20:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbYHSSza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 14:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbYHSSza
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 14:55:30 -0400
Received: from hs-out-0708.google.com ([64.233.178.241]:7341 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbYHSSz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 14:55:29 -0400
Received: by hs-out-0708.google.com with SMTP id 4so42652hsl.5
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 11:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=dRmoiHYd/L6tH1Q7kKqWmMFvwvVeeb9F+qYV4NGy/oA=;
        b=LImoyB3ps+c71NicPMXWsn7GUvkAFHwI2sEO5Zbi9ypeAqzdGVXHTaCSrLrLIyaWDr
         ly24iJH1eGyNhpm8SS8csM9MvGuO9nDiTPkHQYnbgJffvI0BBFq7B8adOBhNiKMO6D+k
         2c6mHZKq7ylYZA5GrlM0pHc1lj5k6YV0jpRww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=YCAnk3qAeBKILQL9QX7RMW3/X06C8cPlsJCg2yH4jpkLmvPDYQv8YXVh+Toa+gTgqy
         jYJR6nqCiJ0ZnKYCyfZwk9Kg19C+Hx7rVN0QmYoIzQxCQSPr2pcVsW7F1W9RGeehG2pA
         QHv6KvZgPlo2qU1+AlQySQRl/onQhW+hoWhX0=
Received: by 10.114.192.3 with SMTP id p3mr7084718waf.112.1219172127566;
        Tue, 19 Aug 2008 11:55:27 -0700 (PDT)
Received: by 10.114.170.3 with HTTP; Tue, 19 Aug 2008 11:55:27 -0700 (PDT)
In-Reply-To: <1219170876-46893-1-git-send-email-schacon@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92900>

This commit adds support for a 'pre-push' hook that can be called before
a `git push` command.

It takes no arguments currently, but if the .git/hooks/pre-push script
exists and is executable, it will be called before the 'git push' command
and will stop the push process if it does not exit with a 0 status.

This hook can be overridden by passing in the --no-verify or -n option to
git push.  Documentation and tests have been updated to reflect the change.

Signed-off-by: Scott Chacon <schacon@gmail.com>
---
 Documentation/git-push.txt |   11 +++-
 builtin-push.c             |   27 +++++++++-
 t/t5550-pre-push-hook.sh   |  132 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+), 2 deletions(-)
 create mode 100644 t/t5550-pre-push-hook.sh

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 45c9643..2b504b3 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git push' [--all] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>]
-          [--repo=all] [-f | --force] [-v | --verbose]
+          [--repo=all] [-f | --force] [-v | --verbose] [-n | --no-verify]
          [<repository> <refspec>...]

 DESCRIPTION
@@ -111,6 +111,10 @@ nor in any Push line of the corresponding remotes
file---see below).
       transfer spends extra cycles to minimize the number of
       objects to be sent and meant to be used on slower connection.

+--no-verify::
+       This option bypasses the pre-push hook.
+       See also linkgit:githooks[5].
+
 -v::
 --verbose::
       Run verbosely.
@@ -193,6 +197,11 @@ git push origin master:refs/heads/experimental::
       needed to create a new branch or tag in the remote repository when
       the local name and the remote name are different; otherwise,
       the ref name on its own will work.
+
+HOOKS
+-----
+This command can run the `pre-push` hook.
+See linkgit:githooks[5] for more information.

 Author
 ------
diff --git a/builtin-push.c b/builtin-push.c
index c1ed68d..f63de9f 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -10,11 +10,12 @@
 #include "parse-options.h"

 static const char * const push_usage[] = {
-       "git push [--all | --mirror] [--dry-run] [--tags]
[--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v]
[<repository> <refspec>...]",
+       "git push [--all | --mirror] [--dry-run] [--tags]
[--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-n |
--no-verify] [-v] [<repository> <refspec>...]",
       NULL,
 };

 static int thin;
+static int skiphook;
 static const char *receivepack;

 static const char **refspec;
@@ -98,6 +99,24 @@ static int do_push(const char *repo, int flags)
       return !!errs;
 }

+static int run_hook(const char *name)
+{
+       struct child_process hook;
+       const char *argv[1];
+
+       argv[0] = git_path("hooks/%s", name);
+
+       if (access(argv[0], X_OK) < 0)
+               return 0;
+
+       memset(&hook, 0, sizeof(hook));
+       hook.argv = argv;
+       hook.no_stdin = 1;
+       hook.stdout_to_stderr = 1;
+
+       return run_command(&hook);
+}
+
 int cmd_push(int argc, const char **argv, const char *prefix)
 {
       int flags = 0;
@@ -115,6 +134,7 @@ int cmd_push(int argc, const char **argv, const
char *prefix)
               OPT_BIT( 0 , "dry-run", &flags, "dry run",
TRANSPORT_PUSH_DRY_RUN),
               OPT_BIT('f', "force", &flags, "force updates",
TRANSPORT_PUSH_FORCE),
               OPT_BOOLEAN( 0 , "thin", &thin, "use thin pack"),
+               OPT_BOOLEAN('n', "no-verify", &skiphook, "skip pre-push hook"),
               OPT_STRING( 0 , "receive-pack", &receivepack,
"receive-pack", "receive pack program"),
               OPT_STRING( 0 , "exec", &receivepack, "receive-pack",
"receive pack program"),
               OPT_END()
@@ -130,6 +150,11 @@ int cmd_push(int argc, const char **argv, const
char *prefix)
               set_refspecs(argv + 1, argc - 1);
       }

+       if (!skiphook && run_hook("pre-push")) {
+               fprintf(stderr, "pre-push script failed: exiting\n");
+               return 128;
+       }
+
       rc = do_push(repo, flags);
       if (rc == -1)
               usage_with_options(push_usage, options);
diff --git a/t/t5550-pre-push-hook.sh b/t/t5550-pre-push-hook.sh
new file mode 100644
index 0000000..f3c9cce
--- /dev/null
+++ b/t/t5550-pre-push-hook.sh
@@ -0,0 +1,132 @@
+#!/bin/sh
+
+test_description='pre-push hook'
+
+. ./test-lib.sh
+
+D=`pwd`
+
+mk_repo_pair () {
+       rm -rf master mirror &&
+       mkdir mirror &&
+       (
+               cd mirror &&
+               git init
+       ) &&
+       mkdir master &&
+       (
+               cd master &&
+               git init &&
+               git remote add $1 up ../mirror
+       )
+}
+
+test_expect_success 'with no hook' '
+       mk_repo_pair &&
+       (
+               cd master &&
+               echo one >foo && git add foo && git commit -m one &&
+               git push --mirror up
+       )
+'
+
+test_expect_success '--no-verify with no hook' '
+       mk_repo_pair &&
+       (
+               cd master &&
+               echo one >foo && git add foo && git commit -m one &&
+               git push --no-verify --mirror up
+       )
+'
+
+# now install hook that always succeeds
+HOOKDIR="master/.git/hooks"
+HOOK="$HOOKDIR/pre-push"
+mk_hook_exec () {
+       mkdir -p "$HOOKDIR"
+cat > "$HOOK" <<EOF
+#!/bin/sh
+exit 0
+EOF
+       chmod +x "$HOOK"
+}
+
+test_expect_success 'with succeeding hook' '
+       mk_repo_pair &&
+       (
+               mk_hook_exec &&
+               cd master &&
+               echo one >foo && git add foo && git commit -m one &&
+               git push --mirror up
+       )
+'
+
+test_expect_success '--no-verify with succeeding hook' '
+       mk_repo_pair &&
+       (
+               mk_hook_exec &&
+               cd master &&
+               echo one >foo && git add foo && git commit -m one &&
+               git push --no-verify --mirror up
+       )
+'
+
+# now a hook that fails
+mk_hook_fail () {
+cat > "$HOOK" <<EOF
+#!/bin/sh
+echo 'test run'
+exit 1
+EOF
+       chmod +x "$HOOK"
+}
+
+test_expect_success 'with failing hook' '
+       mk_repo_pair &&
+       (
+               mk_hook_fail &&
+               cd master &&
+               echo one >foo && git add foo && git commit -m one &&
+               test_must_fail git push --mirror up
+       )
+'
+
+test_expect_success '--no-verify with failing hook' '
+       mk_repo_pair &&
+       (
+               mk_hook_fail &&
+               cd master &&
+               echo one >foo && git add foo && git commit -m one &&
+               git push --no-verify --mirror up
+       )
+'
+
+chmod -x "$HOOK"
+mk_hook_no_exec () {
+cat > "$HOOK" <<EOF
+#!/bin/sh
+echo 'test run'
+exit 0
+EOF
+}
+
+test_expect_success 'with non-executable hook' '
+       mk_repo_pair &&
+       (
+               mk_hook_no_exec &&
+               cd master &&
+               echo one >foo && git add foo && git commit -m one &&
+               git push --mirror up
+       )
+'
+
+test_expect_success '--no-verify with non-executable hook' '
+       mk_repo_pair &&
+       (
+               mk_hook_no_exec &&
+               cd master &&
+               echo one >foo && git add foo && git commit -m one &&
+               git push --no-verify --mirror up
+       )
+'
+test_done
--
1.6.0.GIT
