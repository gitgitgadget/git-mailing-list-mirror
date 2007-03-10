From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 8/8] Change {pre,post}-receive hooks to use stdin
Date: Sat, 10 Mar 2007 03:28:16 -0500
Message-ID: <20070310082816.GH4133@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 10 09:28:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPwwJ-0003b1-8d
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 09:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932787AbXCJI2Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 03:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766903AbXCJI2X
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 03:28:23 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60143 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1766583AbXCJI2U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 03:28:20 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HPww5-0003aS-Bf; Sat, 10 Mar 2007 03:28:17 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 034DB20FBAE; Sat, 10 Mar 2007 03:28:17 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41858>

Sergey Vlasov, Andy Parkins and Alex Riesen all pointed out that it
is possible for a single invocation of receive-pack to be given more
refs than the OS might allow us to pass as command line parameters
to a single hook invocation.

We don't want to break these up into multiple invocations (like
xargs might do) as that makes it impossible for the pre-receive
hook to verify multiple related ref updates occur at the same time,
and it makes it harder for post-receive to send out a single batch
notification.

Instead we pass the reference data on a pipe connected to the
hook's stdin, supplying one ref per line to the hook.  This way a
single hook invocation can obtain an infinite amount of ref data,
without bumping into any operating system limits.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-receive-pack.txt |   32 ++++++++++----------
 receive-pack.c                     |   58 ++++++++++++++++++-----------------
 t/t5401-update-hooks.sh            |   30 ++++++++++--------
 3 files changed, 62 insertions(+), 58 deletions(-)

diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 3cf5511..6914aa5 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -40,13 +40,13 @@ OPTIONS
 pre-receive Hook
 ----------------
 Before any ref is updated, if $GIT_DIR/hooks/pre-receive file exists
-and is executable, it will be invoked once, with three parameters
-per ref to be updated:
+and is executable, it will be invoked once with no parameters.  The
+standard input of the hook will be one line per ref to be updated:
 
-       $GIT_DIR/hooks/pre-receive (refname sha1-old sha1-new)+
+       sha1-old SP sha1-new SP refname LF
 
-The refname parameter is relative to $GIT_DIR; e.g. for the master
-head this is "refs/heads/master".  The two sha1 arguments after
+The refname value is relative to $GIT_DIR; e.g. for the master
+head this is "refs/heads/master".  The two sha1 values before
 each refname are the object names for the refname before and after
 the update.  Refs to be created will have sha1-old equal to 0{40},
 while refs to be deleted will have sha1-new equal to 0{40}, otherwise
@@ -86,13 +86,14 @@ post-receive Hook
 -----------------
 After all refs were updated (or attempted to be updated), if any
 ref update was successful, and if $GIT_DIR/hooks/post-receive
-file exists and is executable, it will be invoke once with three
-parameters for each successfully updated ref:
+file exists and is executable, it will be invoke once with no
+parameters.  The standard input of the hook will be one line
+for each successfully updated ref:
 
-       $GIT_DIR/hooks/post-receive (refname sha1-old sha1-new)+
+       sha1-old SP sha1-new SP refname LF
 
-The refname parameter is relative to $GIT_DIR; e.g. for the master
-head this is "refs/heads/master".  The two sha1 arguments after
+The refname value is relative to $GIT_DIR; e.g. for the master
+head this is "refs/heads/master".  The two sha1 values before
 each refname are the object names for the refname before and after
 the update.  Refs that were created will have sha1-old equal to
 0{40}, while refs that were deleted will have sha1-new equal to
@@ -105,18 +106,17 @@ ref listing the commits pushed to the repository:
 
 	#!/bin/sh
 	# mail out commit update information.
-	while test $# -gt 0
+	while read oval nval ref
 	do
-		if expr "$2" : '0*$' >/dev/null
+		if expr "$oval" : '0*$' >/dev/null
 		then
 			echo "Created a new ref, with the following commits:"
-			git-rev-list --pretty "$2"
+			git-rev-list --pretty "$nval"
 		else
 			echo "New commits:"
-			git-rev-list --pretty "$3" "^$2"
+			git-rev-list --pretty "$nval" "^$oval"
 		fi |
-		mail -s "Changes to ref $1" commit-list@mydomain
-		shift; shift; shift; # discard this ref's args
+		mail -s "Changes to ref $ref" commit-list@mydomain
 	done
 	exit 0
 
diff --git a/receive-pack.c b/receive-pack.c
index 4d7170f..7cf5878 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -79,6 +79,8 @@ static int hook_status(int code, const char *hook_name)
 		return error("hook fork failed");
 	case -ERR_RUN_COMMAND_EXEC:
 		return error("hook execute failed");
+	case -ERR_RUN_COMMAND_PIPE:
+		return error("hook pipe failed");
 	case -ERR_RUN_COMMAND_WAITPID:
 		return error("waitpid failed");
 	case -ERR_RUN_COMMAND_WAITPID_WRONG_PID:
@@ -93,44 +95,44 @@ static int hook_status(int code, const char *hook_name)
 	}
 }
 
-static int run_hook(const char *hook_name,
-	struct command *first_cmd,
-	int single)
+static int run_hook(const char *hook_name)
 {
+	static char buf[sizeof(commands->old_sha1) * 2 + PATH_MAX + 4];
 	struct command *cmd;
-	int argc, code;
-	const char **argv;
+	struct child_process proc;
+	const char *argv[2];
+	int have_input = 0, code;
 
-	for (argc = 0, cmd = first_cmd; cmd; cmd = cmd->next) {
+	for (cmd = commands; !have_input && cmd; cmd = cmd->next) {
 		if (!cmd->error_string)
-			argc += 3;
-		if (single)
-			break;
+			have_input = 1;
 	}
 
-	if (!argc || access(hook_name, X_OK) < 0)
+	if (!have_input || access(hook_name, X_OK) < 0)
 		return 0;
 
-	argv = xmalloc(sizeof(*argv) * (2 + argc));
 	argv[0] = hook_name;
-	for (argc = 1, cmd = first_cmd; cmd; cmd = cmd->next) {
+	argv[1] = NULL;
+
+	memset(&proc, 0, sizeof(proc));
+	proc.argv = argv;
+	proc.in = -1;
+	proc.stdout_to_stderr = 1;
+
+	code = start_command(&proc);
+	if (code)
+		return hook_status(code, hook_name);
+	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (!cmd->error_string) {
-			argv[argc++] = xstrdup(cmd->ref_name);
-			argv[argc++] = xstrdup(sha1_to_hex(cmd->old_sha1));
-			argv[argc++] = xstrdup(sha1_to_hex(cmd->new_sha1));
+			size_t n = snprintf(buf, sizeof(buf), "%s %s %s\n",
+				sha1_to_hex(cmd->old_sha1),
+				sha1_to_hex(cmd->new_sha1),
+				cmd->ref_name);
+			if (write_in_full(proc.in, buf, n) != n)
+				break;
 		}
-		if (single)
-			break;
 	}
-	argv[argc] = NULL;
-
-	code = run_command_v_opt(argv,
-		RUN_COMMAND_NO_STDIN | RUN_COMMAND_STDOUT_TO_STDERR);
-	while (--argc > 0)
-		free((char*)argv[argc]);
-	free(argv);
-
-	return hook_status(code, hook_name);
+	return hook_status(finish_command(&proc), hook_name);
 }
 
 static int run_update_hook(struct command *cmd)
@@ -265,7 +267,7 @@ static void execute_commands(const char *unpacker_error)
 		return;
 	}
 
-	if (run_hook(pre_receive_hook, commands, 0)) {
+	if (run_hook(pre_receive_hook)) {
 		while (cmd) {
 			cmd->error_string = "pre-receive hook declined";
 			cmd = cmd->next;
@@ -520,7 +522,7 @@ int main(int argc, char **argv)
 			unlink(pack_lockfile);
 		if (report_status)
 			report(unpack_status);
-		run_hook(post_receive_hook, commands, 0);
+		run_hook(post_receive_hook);
 		run_update_post_hook(commands);
 	}
 	return 0;
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index c10721b..2d4b481 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -25,8 +25,8 @@ test_expect_success setup '
 
 cat >victim/.git/hooks/pre-receive <<'EOF'
 #!/bin/sh
-echo "$@" >>$GIT_DIR/pre-receive.args
-read x; printf "$x" >$GIT_DIR/pre-receive.stdin
+printf "$@" >>$GIT_DIR/pre-receive.args
+cat - >$GIT_DIR/pre-receive.stdin
 echo STDOUT pre-receive
 echo STDERR pre-receive >&2
 EOF
@@ -44,8 +44,8 @@ chmod u+x victim/.git/hooks/update
 
 cat >victim/.git/hooks/post-receive <<'EOF'
 #!/bin/sh
-echo "$@" >>$GIT_DIR/post-receive.args
-read x; printf "$x" >$GIT_DIR/post-receive.stdin
+printf "$@" >>$GIT_DIR/post-receive.args
+cat - >$GIT_DIR/post-receive.stdin
 echo STDOUT post-receive
 echo STDERR post-receive >&2
 EOF
@@ -80,11 +80,10 @@ test_expect_success 'hooks ran' '
 	test -f victim/.git/post-update.stdin
 '
 
-test_expect_success 'pre-receive hook arguments' '
-	echo \
-	 refs/heads/master $commit0 $commit1 \
-	 refs/heads/tofail $commit1 $commit0 \
-	| diff - victim/.git/pre-receive.args
+test_expect_success 'pre-receive hook input' '
+	(echo $commit0 $commit1 refs/heads/master;
+	 echo $commit1 $commit0 refs/heads/tofail
+	) | diff - victim/.git/pre-receive.stdin
 '
 
 test_expect_success 'update hook arguments' '
@@ -93,9 +92,9 @@ test_expect_success 'update hook arguments' '
 	) | diff - victim/.git/update.args
 '
 
-test_expect_success 'post-receive hook arguments' '
-	echo refs/heads/master $commit0 $commit1 |
-	git diff - victim/.git/post-receive.args
+test_expect_success 'post-receive hook input' '
+	echo $commit0 $commit1 refs/heads/master |
+	git diff - victim/.git/post-receive.stdin
 '
 
 test_expect_success 'post-update hook arguments' '
@@ -104,12 +103,15 @@ test_expect_success 'post-update hook arguments' '
 '
 
 test_expect_success 'all hook stdin is /dev/null' '
-	! test -s victim/.git/pre-receive.stdin &&
 	! test -s victim/.git/update.stdin &&
-	! test -s victim/.git/post-receive.stdin &&
 	! test -s victim/.git/post-update.stdin
 '
 
+test_expect_success 'all *-receive hook args are empty' '
+	! test -s victim/.git/pre-receive.args &&
+	! test -s victim/.git/post-receive.args
+'
+
 test_expect_failure 'send-pack produced no output' '
 	test -s send.out
 '
-- 
1.5.0.3.942.g299f
