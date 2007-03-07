From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 5/5] Teach receive-pack to run pre-receive/post-receive hooks
Date: Wed, 7 Mar 2007 16:52:05 -0500
Message-ID: <20070307215205.GE28649@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 22:52:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP43Z-0004wG-9M
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 22:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992634AbXCGVwM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 16:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992641AbXCGVwM
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 16:52:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53903 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992634AbXCGVwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 16:52:09 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HP43C-0003cu-Bm; Wed, 07 Mar 2007 16:51:58 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9C8B420FBAE; Wed,  7 Mar 2007 16:52:05 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41695>

Bill Lear pointed out that it is easy to send out notifications of
changes with the update hook, but successful execution of the update
hook does not necessarily mean that the ref was actually updated.
Lock contention on the ref or being unable to append to the reflog
may prevent the ref from being changed.  Sending out notifications
prior to the ref actually changing is very misleading.

To help this situation I am introducing two new hooks to the
receive-pack flow: pre-receive and post-receive.  These new hooks
are invoked only once per receive-pack execution and are passed
three arguments per ref (refname, old-sha1, new-sha1).

The new post-receive hook is ideal for sending out notifications,
as it has the complete list of all refnames that were successfully
updated as well as the old and new SHA-1 values.  This allows more
interesting notifications to be sent.  Multiple ref updates could
be easily summarized into one email, for example.

The new pre-receive hook is ideal for logging update attempts, as it
is run only once for the entire receive-pack operation.  It can also
be used to verify multiple updates happen at once, e.g. an update
to the `maint` head must also be accompained by a new annotated tag.

Lots of documentation improvements for receive-pack are included
in this change, as we want to make sure the new hooks are clearly
explained.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-receive-pack.txt |  149 ++++++++++++++++++++++++++----------
 receive-pack.c                     |   11 +++
 t/t5401-update-hooks.sh            |   93 ++++++++++++++++++-----
 3 files changed, 191 insertions(+), 62 deletions(-)

diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 10e8c46..3cf5511 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -25,61 +25,126 @@ The command allows for creation and fast forwarding of sha1 refs
 local end receive-pack runs, but to the user who is sitting at
 the send-pack end, it is updating the remote.  Confused?)
 
-Before each ref is updated, if $GIT_DIR/hooks/update file exists
-and executable, it is called with three parameters:
+There are other real-world examples of using update and
+post-update hooks found in the Documentation/howto directory.
 
-       $GIT_DIR/hooks/update refname sha1-old sha1-new
+git-receive-pack honours the receive.denyNonFastForwards config
+option, which tells it if updates to a ref should be denied if they
+are not fast-forwards.
+
+OPTIONS
+-------
+<directory>::
+	The repository to sync into.
+
+pre-receive Hook
+----------------
+Before any ref is updated, if $GIT_DIR/hooks/pre-receive file exists
+and is executable, it will be invoked once, with three parameters
+per ref to be updated:
+
+       $GIT_DIR/hooks/pre-receive (refname sha1-old sha1-new)+
+
+The refname parameter is relative to $GIT_DIR; e.g. for the master
+head this is "refs/heads/master".  The two sha1 arguments after
+each refname are the object names for the refname before and after
+the update.  Refs to be created will have sha1-old equal to 0{40},
+while refs to be deleted will have sha1-new equal to 0{40}, otherwise
+sha1-old and sha1-new should be valid objects in the repository.
+
+This hook is called before any refname is updated and before any
+fast-forward checks are performed.
+
+If the pre-receive hook exits with a non-zero exit status no updates
+will be performed, and the update, post-receive and post-update
+hooks will not be invoked either.  This can be useful to quickly
+bail out if the update is not to be supported.
 
-The refname parameter is relative to $GIT_DIR; e.g. for the
-master head this is "refs/heads/master".  Two sha1 are the
-object names for the refname before and after the update.  Note
-that the hook is called before the refname is updated, so either
-sha1-old is 0{40} (meaning there is no such ref yet), or it
-should match what is recorded in refname.
+update Hook
+-----------
+Before each ref is updated, if $GIT_DIR/hooks/update file exists
+and is executable, it is invoked once per ref, with three parameters:
 
-The hook should exit with non-zero status if it wants to
-disallow updating the named ref.  Otherwise it should exit with
-zero.
+       $GIT_DIR/hooks/update refname sha1-old sha1-new
 
-Using this hook, it is easy to generate mails on updates to
-the local repository. This example script sends a mail with
-the commits pushed to the repository:
+The refname parameter is relative to $GIT_DIR; e.g. for the master
+head this is "refs/heads/master".  The two sha1 arguments are
+the object names for the refname before and after the update.
+Note that the hook is called before the refname is updated,
+so either sha1-old is 0{40} (meaning there is no such ref yet),
+or it should match what is recorded in refname.
+
+The hook should exit with non-zero status if it wants to disallow
+updating the named ref.  Otherwise it should exit with zero.
+
+Successful execution (a zero exit status) of this hook does not
+ensure the ref will actully be updated, it is only a prerequisite.
+As such it is not a good idea to send notices (e.g. email) from
+this hook.  Consider using the post-receive hook instead.
+
+post-receive Hook
+-----------------
+After all refs were updated (or attempted to be updated), if any
+ref update was successful, and if $GIT_DIR/hooks/post-receive
+file exists and is executable, it will be invoke once with three
+parameters for each successfully updated ref:
+
+       $GIT_DIR/hooks/post-receive (refname sha1-old sha1-new)+
+
+The refname parameter is relative to $GIT_DIR; e.g. for the master
+head this is "refs/heads/master".  The two sha1 arguments after
+each refname are the object names for the refname before and after
+the update.  Refs that were created will have sha1-old equal to
+0{40}, while refs that were deleted will have sha1-new equal to
+0{40}, otherwise sha1-old and sha1-new should be valid objects in
+the repository.
+
+Using this hook, it is easy to generate mails describing the updates
+to the repository.  This example script sends one mail message per
+ref listing the commits pushed to the repository:
 
 	#!/bin/sh
 	# mail out commit update information.
-	if expr "$2" : '0*$' >/dev/null
-	then
-		echo "Created a new ref, with the following commits:"
-		git-rev-list --pretty "$2"
-	else
-		echo "New commits:"
-		git-rev-list --pretty "$3" "^$2"
-	fi |
-	mail -s "Changes to ref $1" commit-list@mydomain
+	while test $# -gt 0
+	do
+		if expr "$2" : '0*$' >/dev/null
+		then
+			echo "Created a new ref, with the following commits:"
+			git-rev-list --pretty "$2"
+		else
+			echo "New commits:"
+			git-rev-list --pretty "$3" "^$2"
+		fi |
+		mail -s "Changes to ref $1" commit-list@mydomain
+		shift; shift; shift; # discard this ref's args
+	done
 	exit 0
 
-Another hook $GIT_DIR/hooks/post-update, if exists and
-executable, is called with the list of refs that have been
-updated.  This can be used to implement repository wide cleanup
-task if needed.  The exit code from this hook invocation is
-ignored; the only thing left for git-receive-pack to do at that
-point is to exit itself anyway.  This hook can be used, for
-example, to run "git-update-server-info" if the repository is
-packed and is served via a dumb transport.
+The exit code from this hook invocation is ignored, however a
+non-zero exit code will generate an error message.
 
-	#!/bin/sh
-	exec git-update-server-info
+Note that it is possible for refname to not have sha1-new when this
+hook runs.  This can easily occur if another user modifies the ref
+after it was updated by receive-pack, but before the hook was able
+to evaluate it.  It is recommended that hooks rely on sha1-new
+rather than the current value of refname.
 
-There are other real-world examples of using update and
-post-update hooks found in the Documentation/howto directory.
+post-update Hook
+----------------
+After all other processing, if at least one ref was updated, and
+if $GIT_DIR/hooks/post-update file exists and is executable, then
+post-update will called with the list of refs that have been updated.
+This can be used to implement any repository wide cleanup tasks.
 
-git-receive-pack honours the receive.denyNonFastforwards flag, which
-tells it if updates to a ref should be denied if they are not fast-forwards.
+The exit code from this hook invocation is ignored; the only thing
+left for git-receive-pack to do at that point is to exit itself
+anyway.
 
-OPTIONS
--------
-<directory>::
-	The repository to sync into.
+This hook can be used, for example, to run "git-update-server-info"
+if the repository is packed and is served via a dumb transport.
+
+	#!/bin/sh
+	exec git-update-server-info
 
 
 SEE ALSO
diff --git a/receive-pack.c b/receive-pack.c
index ff746e7..675c88f 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -68,6 +68,8 @@ struct command {
 static struct command *commands;
 
 static const char update_hook[] = "hooks/update";
+static const char pre_receive_hook[] = "hooks/pre-receive";
+static const char post_receive_hook[] = "hooks/post-receive";
 
 static int run_hook(const char *hook_name,
 	struct command *first_cmd,
@@ -236,6 +238,14 @@ static void execute_commands(const char *unpacker_error)
 		return;
 	}
 
+	if (run_hook(pre_receive_hook, commands, 0)) {
+		while (cmd) {
+			cmd->error_string = "pre-receive hook declined";
+			cmd = cmd->next;
+		}
+		return;
+	}
+
 	while (cmd) {
 		cmd->error_string = update(cmd);
 		cmd = cmd->next;
@@ -483,6 +493,7 @@ int main(int argc, char **argv)
 			unlink(pack_lockfile);
 		if (report_status)
 			report(unpack_status);
+		run_hook(post_receive_hook, commands, 0);
 		run_update_post_hook(commands);
 	}
 	return 0;
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 460c9fd..cf6306c 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -11,47 +11,91 @@ test_expect_success setup '
 	git-update-index --add a &&
 	tree0=$(git-write-tree) &&
 	commit0=$(echo setup | git-commit-tree $tree0) &&
-	git-update-ref HEAD $commit0 &&
-	git-clone ./. victim &&
 	echo We hope it works. >a &&
 	git-update-index a &&
 	tree1=$(git-write-tree) &&
 	commit1=$(echo modify | git-commit-tree $tree1 -p $commit0) &&
-	git-update-ref HEAD $commit1
+	git-update-ref refs/heads/master $commit0 &&
+	git-update-ref refs/heads/tofail $commit1 &&
+	git-clone ./. victim &&
+	GIT_DIR=victim/.git git-update-ref refs/heads/tofail $commit1 &&
+	git-update-ref refs/heads/master $commit1 &&
+	git-update-ref refs/heads/tofail $commit0
 '
 
+cat >victim/.git/hooks/pre-receive <<'EOF'
+#!/bin/sh
+echo "$@" >>$GIT_DIR/pre-receive.args
+read x; printf "$x" >$GIT_DIR/pre-receive.stdin
+echo STDOUT pre-receive
+echo STDERR pre-receive >&2
+EOF
+chmod u+x victim/.git/hooks/pre-receive
+
 cat >victim/.git/hooks/update <<'EOF'
 #!/bin/sh
-echo "$@" >$GIT_DIR/update.args
+echo "$@" >>$GIT_DIR/update.args
 read x; printf "$x" >$GIT_DIR/update.stdin
-echo STDOUT update
-echo STDERR update >&2
+echo STDOUT update $1
+echo STDERR update $1 >&2
+test "$1" = refs/heads/master || exit
 EOF
 chmod u+x victim/.git/hooks/update
 
+cat >victim/.git/hooks/post-receive <<'EOF'
+#!/bin/sh
+echo "$@" >>$GIT_DIR/post-receive.args
+read x; printf "$x" >$GIT_DIR/post-receive.stdin
+echo STDOUT post-receive
+echo STDERR post-receive >&2
+EOF
+chmod u+x victim/.git/hooks/post-receive
+
 cat >victim/.git/hooks/post-update <<'EOF'
 #!/bin/sh
-echo "$@" >$GIT_DIR/post-update.args
+echo "$@" >>$GIT_DIR/post-update.args
 read x; printf "$x" >$GIT_DIR/post-update.stdin
 echo STDOUT post-update
 echo STDERR post-update >&2
 EOF
 chmod u+x victim/.git/hooks/post-update
 
-test_expect_success push '
-	git-send-pack ./victim/.git/ master >send.out 2>send.err
+test_expect_failure push '
+	git-send-pack --force ./victim/.git master tofail >send.out 2>send.err
+'
+
+test_expect_success 'updated as expected' '
+	test $(GIT_DIR=victim/.git git-rev-parse master) = $commit1 &&
+	test $(GIT_DIR=victim/.git git-rev-parse tofail) = $commit1
 '
 
 test_expect_success 'hooks ran' '
+	test -f victim/.git/pre-receive.args &&
+	test -f victim/.git/pre-receive.stdin &&
 	test -f victim/.git/update.args &&
 	test -f victim/.git/update.stdin &&
+	test -f victim/.git/post-receive.args &&
+	test -f victim/.git/post-receive.stdin &&
 	test -f victim/.git/post-update.args &&
 	test -f victim/.git/post-update.stdin
 '
 
+test_expect_success 'pre-receive hook arguments' '
+	echo \
+	 refs/heads/master $commit0 $commit1 \
+	 refs/heads/tofail $commit1 $commit0 \
+	| git diff - victim/.git/pre-receive.args
+'
+
 test_expect_success 'update hook arguments' '
+	(echo refs/heads/master $commit0 $commit1;
+	 echo refs/heads/tofail $commit1 $commit0
+	) | git diff - victim/.git/update.args
+'
+
+test_expect_success 'post-receive hook arguments' '
 	echo refs/heads/master $commit0 $commit1 |
-	git diff - victim/.git/update.args
+	git diff - victim/.git/post-receive.args
 '
 
 test_expect_success 'post-update hook arguments' '
@@ -59,23 +103,32 @@ test_expect_success 'post-update hook arguments' '
 	git diff - victim/.git/post-update.args
 '
 
-test_expect_failure 'update hook stdin is /dev/null' '
-	test -s victim/.git/update.stdin
-'
-
-test_expect_failure 'post-update hook stdin is /dev/null' '
-	test -s victim/.git/post-update.stdin
+test_expect_success 'all hook stdin is /dev/null' '
+	! test -s victim/.git/pre-receive.stdin &&
+	! test -s victim/.git/update.stdin &&
+	! test -s victim/.git/post-receive.stdin &&
+	! test -s victim/.git/post-update.stdin
 '
 
 test_expect_failure 'send-pack produced no output' '
 	test -s send.out
 '
 
+cat <<EOF >expect
+STDOUT pre-receive
+STDERR pre-receive
+STDOUT update refs/heads/master
+STDERR update refs/heads/master
+STDOUT update refs/heads/tofail
+STDERR update refs/heads/tofail
+STDOUT post-receive
+STDERR post-receive
+STDOUT post-update
+STDERR post-update
+EOF
 test_expect_success 'send-pack stderr contains hook messages' '
-	grep "STDOUT update" send.err &&
-	grep "STDERR update" send.err &&
-	grep "STDOUT post-update" send.err &&
-	grep "STDERR post-update" send.err
+	egrep ^STD send.err >actual &&
+	git diff - actual <expect
 '
 
 test_done
-- 
1.5.0.3.895.g09890
