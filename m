From: Aaron Schrab <aaron@schrab.com>
Subject: [PATCH v2 2/3] push: Add support for pre-push hooks
Date: Sun, 13 Jan 2013 00:17:03 -0500
Message-ID: <1358054224-7710-3-git-send-email-aaron@schrab.com>
References: <1358054224-7710-1-git-send-email-aaron@schrab.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 06:18:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuFyA-0003db-0q
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 06:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988Ab3AMFSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 00:18:33 -0500
Received: from pug.qqx.org ([50.116.43.67]:36689 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746Ab3AMFSd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 00:18:33 -0500
Received: from zim.qqx.org (cpe-107-015-024-243.nc.res.rr.com [107.15.24.243])
	by pug.qqx.org (Postfix) with ESMTPSA id 769141D0C0
	for <git@vger.kernel.org>; Sun, 13 Jan 2013 00:18:32 -0500 (EST)
Received: from ats (uid 1000)
	(envelope-from aaron@schrab.com)
	id 401f0
	by zim.qqx.org (DragonFly Mail Agent);
	Sun, 13 Jan 2013 00:18:31 -0500
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1358054224-7710-1-git-send-email-aaron@schrab.com>
In-Reply-To: <1356735452-21667-1-git-send-email-aaron@schrab.com>
References: <1356735452-21667-1-git-send-email-aaron@schrab.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213333>

Add support for a pre-push hook which can be used to determine if the
set of refs to be pushed is suitable for the target repository.  The
hook is run with two arguments specifying the name and location of the
destination repository.

Information about what is to be pushed is provided by sending lines of
the following form to the hook's standard input:

  <local ref> SP <local sha1> SP <remote ref> SP <remote sha1> LF

If the hook exits with a non-zero status, the push will be aborted.

This will allow the script to determine if the push is acceptable based
on the target repository and branch(es), the commits which are to be
pushed, and even the source branches in some cases.

Signed-off-by: Aaron Schrab <aaron@schrab.com>
---
 Documentation/githooks.txt |  29 ++++++++++
 builtin/push.c             |   1 +
 t/t5571-pre-push-hook.sh   | 129 +++++++++++++++++++++++++++++++++++++++++++++
 transport.c                |  60 +++++++++++++++++++++
 transport.h                |   1 +
 5 files changed, 220 insertions(+)
 create mode 100755 t/t5571-pre-push-hook.sh

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index b9003fe..d839233 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -176,6 +176,35 @@ save and restore any form of metadata associated with the working tree
 (eg: permissions/ownership, ACLS, etc).  See contrib/hooks/setgitperms.perl
 for an example of how to do this.
 
+pre-push
+~~~~~~~~
+
+This hook is called by 'git push' and can be used to prevent a push from taking
+place.  The hook is called with two parameters which provide the name and
+location of the destination remote, if a named remote is not being used both
+values will be the same.
+
+Information about what is to be pushed is provided on the hook's standard
+input with lines of the form:
+
+  <local ref> SP <local sha1> SP <remote ref> SP <remote sha1> LF
+
+For instance, if the command +git push origin master:foreign+ were run the
+hook would receive a line like the following:
+
+  refs/heads/master 67890 refs/heads/foreign 12345
+
+although the full, 40-character SHA1s would be supplied.  If the foreign ref
+does not yet exist the `<remote SHA1>` will be 40 `0`.  If a ref is to be
+deleted, the `<local ref>` will be supplied as `(delete)` and the `<local
+SHA1>` will be 40 `0`.  If the local commit was specified by something other
+than a name which could be expanded (such as `HEAD~`, or a SHA1) it will be
+supplied as it was originally given.
+
+If this hook exits with a non-zero status, 'git push' will abort without
+pushing anything.  Information about why the push is rejected may be sent
+to the user by writing to standard error.
+
 [[pre-receive]]
 pre-receive
 ~~~~~~~~~~~
diff --git a/builtin/push.c b/builtin/push.c
index 8491e43..b158028 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -407,6 +407,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "progress", &progress, N_("force progress reporting")),
 		OPT_BIT(0, "prune", &flags, N_("prune locally removed refs"),
 			TRANSPORT_PUSH_PRUNE),
+		OPT_BIT(0, "no-verify", &flags, N_("bypass pre-push hook"), TRANSPORT_PUSH_NO_HOOK),
 		OPT_END()
 	};
 
diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
new file mode 100755
index 0000000..d68fed7
--- /dev/null
+++ b/t/t5571-pre-push-hook.sh
@@ -0,0 +1,129 @@
+#!/bin/sh
+
+test_description='check pre-push hooks'
+. ./test-lib.sh
+
+# Setup hook that always succeeds
+HOOKDIR="$(git rev-parse --git-dir)/hooks"
+HOOK="$HOOKDIR/pre-push"
+mkdir -p "$HOOKDIR"
+write_script "$HOOK" <<EOF
+exit 0
+EOF
+
+test_expect_success 'setup' '
+	git config push.default upstream &&
+	git init --bare repo1 &&
+	git remote add parent1 repo1 &&
+	test_commit one &&
+	git push parent1 HEAD:foreign
+'
+write_script "$HOOK" <<EOF
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
+write_script "$HOOK" <<'EOF'
+echo "$1" >actual
+echo "$2" >>actual
+cat >>actual
+EOF
+
+cat >expected <<EOF
+parent1
+repo1
+refs/heads/master $COMMIT2 refs/heads/foreign $COMMIT1
+EOF
+
+test_expect_success 'push with hook' '
+	git push parent1 master:foreign &&
+	diff expected actual
+'
+
+test_expect_success 'add a branch' '
+	git checkout -b other parent1/foreign &&
+	test_commit three
+'
+
+COMMIT3="$(git rev-parse HEAD)"
+export COMMIT3
+
+cat >expected <<EOF
+parent1
+repo1
+refs/heads/other $COMMIT3 refs/heads/foreign $COMMIT2
+EOF
+
+test_expect_success 'push to default' '
+	git push &&
+	diff expected actual
+'
+
+cat >expected <<EOF
+parent1
+repo1
+refs/tags/one $COMMIT1 refs/tags/tag1 $_z40
+HEAD~ $COMMIT2 refs/heads/prev $_z40
+EOF
+
+test_expect_success 'push non-branches' '
+	git push parent1 one:tag1 HEAD~:refs/heads/prev &&
+	diff expected actual
+'
+
+cat >expected <<EOF
+parent1
+repo1
+(delete) $_z40 refs/heads/prev $COMMIT2
+EOF
+
+test_expect_success 'push delete' '
+	git push parent1 :prev &&
+	diff expected actual
+'
+
+cat >expected <<EOF
+repo1
+repo1
+HEAD $COMMIT3 refs/heads/other $_z40
+EOF
+
+test_expect_success 'push to URL' '
+	git push repo1 HEAD &&
+	diff expected actual
+'
+
+# Test that filling pipe buffers doesn't cause failure
+# Too slow to leave enabled for general use
+if false
+then
+	printf 'parent1\nrepo1\n' >expected
+	nr=1000
+	while test $nr -lt 2000
+	do
+		nr=$(( $nr + 1 ))
+		git branch b/$nr $COMMIT3
+		echo "refs/heads/b/$nr $COMMIT3 refs/heads/b/$nr $_z40" >>expected
+	done
+
+	test_expect_success 'push many refs' '
+		git push parent1 "refs/heads/b/*:refs/heads/b/*" &&
+		diff expected actual
+	'
+fi
+
+test_done
diff --git a/transport.c b/transport.c
index 2673d27..0750a5f 100644
--- a/transport.c
+++ b/transport.c
@@ -1034,6 +1034,62 @@ static void die_with_unpushed_submodules(struct string_list *needs_pushing)
 	die("Aborting.");
 }
 
+static int run_pre_push_hook(struct transport *transport,
+			     struct ref *remote_refs)
+{
+	int ret = 0, x;
+	struct ref *r;
+	struct child_process proc;
+	struct strbuf buf;
+	const char *argv[4];
+
+	if (!(argv[0] = find_hook("pre-push")))
+		return 0;
+
+	argv[1] = transport->remote->name;
+	argv[2] = transport->url;
+	argv[3] = NULL;
+
+	memset(&proc, 0, sizeof(proc));
+	proc.argv = argv;
+	proc.in = -1;
+
+	if (start_command(&proc)) {
+		finish_command(&proc);
+		return -1;
+	}
+
+	strbuf_init(&buf, 256);
+
+	for (r = remote_refs; r; r = r->next) {
+		if (!r->peer_ref) continue;
+		if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) continue;
+		if (r->status == REF_STATUS_UPTODATE) continue;
+
+		strbuf_reset(&buf);
+		strbuf_addf( &buf, "%s %s %s %s\n",
+			 r->peer_ref->name, sha1_to_hex(r->new_sha1),
+			 r->name, sha1_to_hex(r->old_sha1));
+
+		if (write_in_full(proc.in, buf.buf, buf.len) != buf.len) {
+			ret = -1;
+			break;
+		}
+	}
+
+	strbuf_release(&buf);
+
+	x = close(proc.in);
+	if (!ret)
+		ret = x;
+
+	x = finish_command(&proc);
+	if (!ret)
+		ret = x;
+
+	return ret;
+}
+
 int transport_push(struct transport *transport,
 		   int refspec_nr, const char **refspec, int flags,
 		   unsigned int *reject_reasons)
@@ -1074,6 +1130,10 @@ int transport_push(struct transport *transport,
 			flags & TRANSPORT_PUSH_MIRROR,
 			flags & TRANSPORT_PUSH_FORCE);
 
+		if (!(flags & TRANSPORT_PUSH_NO_HOOK))
+			if (run_pre_push_hook(transport, remote_refs))
+				return -1;
+
 		if ((flags & TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND) && !is_bare_repository()) {
 			struct ref *ref = remote_refs;
 			for (; ref; ref = ref->next)
diff --git a/transport.h b/transport.h
index bfd2df5..ac5a9f5 100644
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
1.8.1.340.g425b78d
