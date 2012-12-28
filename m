From: Aaron Schrab <aaron@schrab.com>
Subject: [PATCH 3/4] push: Add support for pre-push hooks
Date: Fri, 28 Dec 2012 17:57:31 -0500
Message-ID: <1356735452-21667-4-git-send-email-aaron@schrab.com>
References: <1356735452-21667-1-git-send-email-aaron@schrab.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 28 23:58:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Toisa-0001DN-1v
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 23:58:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755054Ab2L1W5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 17:57:54 -0500
Received: from pug.qqx.org ([50.116.43.67]:57406 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754238Ab2L1W5n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 17:57:43 -0500
Received: from zim.qqx.org (cpe-107-015-024-243.nc.res.rr.com [107.15.24.243])
	by pug.qqx.org (Postfix) with ESMTPSA id 0C3091D2D7
	for <git@vger.kernel.org>; Fri, 28 Dec 2012 17:57:41 -0500 (EST)
Received: from ats (uid 1000)
	(envelope-from aaron@schrab.com)
	id 480ab
	by zim.qqx.org (DragonFly Mail Agent);
	Fri, 28 Dec 2012 17:57:41 -0500
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1356735452-21667-1-git-send-email-aaron@schrab.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212273>

Add support for a pre-push hook which can be used to determine if the
set of refs to be pushed is suitable for the target repository.  The
hook should be supplied with:

 1. name of the remote being used, or the URL if not using a named
    remote
 2. the URL to which we're pushing
 3. descriptions of what references are to be pushed

Each reference to be pushed should be described in a separate parameter
to the hook script in the form:

  <local ref>:<local sha1>:<remote ref>:<remote sha1>

This will allow the script to determine if the push is acceptable based
on the target repository and branch(es), the commits which are to be
pushed, and even the source branches in some cases.

Signed-off-by: Aaron Schrab <aaron@schrab.com>
---
 Documentation/githooks.txt |   28 +++++++++
 builtin/push.c             |    1 +
 t/t5571-pre-push-hook.sh   |  145 ++++++++++++++++++++++++++++++++++++++++++++
 transport.c                |   25 ++++++++
 transport.h                |    1 +
 5 files changed, 200 insertions(+)
 create mode 100755 t/t5571-pre-push-hook.sh

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index b9003fe..e9539bb 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -176,6 +176,34 @@ save and restore any form of metadata associated with the working tree
 (eg: permissions/ownership, ACLS, etc).  See contrib/hooks/setgitperms.perl
 for an example of how to do this.
 
+pre-push
+~~~~~~~~
+
+This hook is called by 'git push' and can be used to prevent a push from
+taking place.  The hook is called with a variable number of parameters.
+
+The first parameters provide the name and location of the destination
+remote, if a named remote is not being used both values will be the same.
+
+Remaining parameters provide information about the commits which are to be
+pushed and the ref names being used.  These arguments take the form:
+
+  <local ref>:<local sha1>:<remote ref>:<remote sha1>
+
+For instance, if the command +git push origin master:foreign+ were run the
+hook would be called with a third arugment similar to:
+
+  refs/heads/master:67890:refs/heads/foreign:12345
+
+although the full, 40-character SHA1s would be supplied.  If the foreign ref
+does not yet exist the `<remote SHA1>` will be 40 `0`.  If a ref is to be
+deleted, the `<local ref>` will be supplied as `(delete)` and the `<local
+SHA1>` will be 40 `0`.  If the local commit was specified by something other
+than a name which could be expanded (such as `HEAD~`, or a SHA1) it will be
+supplied as it was originally given.
+
+If this hook exits with a non-zero status, 'git push' will abort.
+
 [[pre-receive]]
 pre-receive
 ~~~~~~~~~~~
diff --git a/builtin/push.c b/builtin/push.c
index db9ba30..c33fb9b 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -399,6 +399,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "progress", &progress, N_("force progress reporting")),
 		OPT_BIT(0, "prune", &flags, N_("prune locally removed refs"),
 			TRANSPORT_PUSH_PRUNE),
+		OPT_BIT(0, "no-verify", &flags, N_("bypass pre-push hook"), TRANSPORT_PUSH_NO_HOOK),
 		OPT_END()
 	};
 
diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
new file mode 100755
index 0000000..5444c9b
--- /dev/null
+++ b/t/t5571-pre-push-hook.sh
@@ -0,0 +1,145 @@
+#!/bin/sh
+
+test_description='check pre-push hooks'
+. ./test-lib.sh
+
+# Setup hook that always succeeds
+HOOKDIR="$(git rev-parse --git-dir)/hooks"
+HOOK="$HOOKDIR/pre-push"
+mkdir -p "$HOOKDIR"
+cat >"$HOOK" <<EOF
+#!/bin/sh
+exit 0
+EOF
+chmod +x "$HOOK"
+
+test_expect_success 'setup' '
+	git config push.default upstream &&
+	git init --bare repo1 &&
+	git remote add parent1 repo1 &&
+	test_commit one &&
+	git push parent1 HEAD:foreign
+'
+cat >"$HOOK" <<EOF
+#!/bin/sh
+exit 1
+EOF
+
+COMMIT1="$(git rev-parse HEAD)"
+export COMMIT1
+
+test_expect_success 'push with failing hook' '
+	test_commit two &&
+	test_must_fail git push parent1 HEAD
+'
+
+test_expect_success '--no-verify bypasses hook' '
+	git push --no-verify parent1 HEAD
+'
+
+COMMIT2="$(git rev-parse HEAD)"
+export COMMIT2
+
+cat >"$HOOK" <<'EOF'
+#!/bin/sh -ex
+test "$#" = 3
+test "$1" = parent1
+test "$2" = repo1
+test "$3" = "refs/heads/master:$COMMIT2:refs/heads/foreign:$COMMIT1"
+EOF
+
+test_expect_success 'push with hook' '
+	git push parent1 master:foreign
+'
+
+test_expect_success 'add a branch' '
+	git checkout -b other &&
+	test_commit three
+'
+
+COMMIT3="$(git rev-parse HEAD)"
+export COMMIT3
+
+cat >"$HOOK" <<'EOF'
+#!/bin/sh -ex
+test "$#" = 4
+test "$1" = parent1
+test "$2" = repo1
+test "$3" = "refs/heads/other:$COMMIT3:refs/heads/foreign:$COMMIT2"
+test "$4" = "refs/heads/master:$COMMIT2:refs/heads/new:$_z40"
+EOF
+
+test_expect_success 'push multiple refs' '
+	git push parent1 other:foreign master:new
+'
+
+test_expect_success 'add a branch with an upstream' '
+	git checkout -t -b tracking parent1/foreign &&
+	test_commit four
+'
+COMMIT4="$(git rev-parse HEAD)"
+export COMMIT4
+
+cat >"$HOOK" <<'EOF'
+#!/bin/sh -ex
+test "$#" = 3
+test "$1" = parent1
+test "$2" = repo1
+test "$3" = "refs/heads/tracking:$COMMIT4:refs/heads/foreign:$COMMIT3"
+EOF
+
+test_expect_success 'push to upstream branch' '
+	git push &&
+	git checkout other
+'
+
+cat >"$HOOK" <<'EOF'
+#!/bin/sh -ex
+test "$#" = 3
+test "$1" = parent1
+test "$2" = repo1
+test "$3" = "(delete):$_z40:refs/heads/new:$COMMIT2"
+EOF
+
+test_expect_success 'push deletion' '
+	git push parent1 :new
+'
+
+cat >"$HOOK" <<'EOF'
+#!/bin/sh -ex
+test "$#" = 3
+test "$1" = repo2
+test "$2" = repo2
+test "$3" = "refs/heads/other:$COMMIT3:refs/heads/new:$_z40"
+EOF
+
+test_expect_success 'push to URL' '
+	git init --bare repo2 &&
+	git push repo2 other:new
+'
+
+ABBR=$(expr substr $COMMIT3 1 8)
+export ABBR
+
+cat >"$HOOK" <<'EOF'
+#!/bin/sh -ex
+test "$#" = 4
+test "$3" = "HEAD~:$COMMIT2:refs/heads/commitish:$_z40"
+test "$4" = "$ABBR:$COMMIT3:refs/heads/sha:$_z40"
+EOF
+
+test_expect_success 'push commit' '
+	git push parent1 HEAD~:refs/heads/commitish $ABBR:refs/heads/sha
+'
+
+cat >"$HOOK" <<'EOF'
+#!/bin/sh -ex
+test "$#" = 3
+test "$3" = "refs/tags/one:$COMMIT1:refs/tags/tagpush:$_z40"
+EOF
+
+test_expect_success 'push tag' '
+	git push parent1 one:tagpush
+'
+
+test_done
diff --git a/transport.c b/transport.c
index 9932f40..b0c9a15 100644
--- a/transport.c
+++ b/transport.c
@@ -1052,6 +1052,7 @@ int transport_push(struct transport *transport,
 		int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
 		int pretend = flags & TRANSPORT_PUSH_DRY_RUN;
 		int push_ret, ret, err;
+		char *hook;
 
 		if (flags & TRANSPORT_PUSH_ALL)
 			match_flags |= MATCH_REFS_ALL;
@@ -1069,6 +1070,30 @@ int transport_push(struct transport *transport,
 			flags & TRANSPORT_PUSH_MIRROR,
 			flags & TRANSPORT_PUSH_FORCE);
 
+		if (!(flags & TRANSPORT_PUSH_NO_HOOK) && (hook = find_hook("pre-push"))) {
+			struct ref *r;
+			struct argv_array argv = ARGV_ARRAY_INIT;
+
+			argv_array_push(&argv, hook);
+			argv_array_push(&argv, transport->remote->name);
+			argv_array_push(&argv, transport->url);
+
+			for (r = remote_refs; r; r = r->next) {
+				if (!r->peer_ref) continue;
+				if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) continue;
+				if (r->status == REF_STATUS_UPTODATE) continue;
+
+				argv_array_pushf(&argv, "%s:%s:%s:%s",
+					r->peer_ref->name, sha1_to_hex(r->new_sha1),
+					r->name, sha1_to_hex(r->old_sha1));
+			}
+
+			ret = run_hook_argv(NULL, argv);
+			argv_array_clear(&argv);
+			if (ret)
+				return -1;
+		}
+
 		if ((flags & TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND) && !is_bare_repository()) {
 			struct ref *ref = remote_refs;
 			for (; ref; ref = ref->next)
diff --git a/transport.h b/transport.h
index 4a61c0c..3bc9863 100644
--- a/transport.h
+++ b/transport.h
@@ -104,6 +104,7 @@ struct transport {
 #define TRANSPORT_RECURSE_SUBMODULES_CHECK 64
 #define TRANSPORT_PUSH_PRUNE 128
 #define TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND 256
+#define TRANSPORT_PUSH_NO_HOOK 512
 
 #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
 #define TRANSPORT_SUMMARY(x) (int)(TRANSPORT_SUMMARY_WIDTH + strlen(x) - gettext_width(x)), (x)
-- 
1.7.10.4
