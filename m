From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] merge: use editor by default in interactive sessions
Date: Mon, 23 Jan 2012 14:18:40 -0800
Message-ID: <7vipk26p1b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 23 23:18:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpSDy-0006Uq-Hj
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 23:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996Ab2AWWSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 17:18:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38091 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753530Ab2AWWSo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 17:18:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A16E79E9;
	Mon, 23 Jan 2012 17:18:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=/
	UQI2sh4NNaC1Ya5bcHCx2E3ptY=; b=PQh2lF6IOYSC0DeBV9S0gPL9ItH8Vmax4
	ZK7+w+qoKzZbyK9z1X296EUD8G7PqPxEYkpHM4ehUQAN22sE4v5f9umFLWxaYELq
	8BQwwcRb+S6HfbJWDzCPE+/LzsfC8/2yG6ytKmsA2gv2u05hA6tqFgGyv0Wr3eRb
	yBlUGzIvz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=N3F
	P3KvrHyS/usWSvtyg7ENYO64xt6JuNXu3wUGWnLSowjHpnRHmA+arcvMV03cyy23
	SxG25N/pZz/EpGgLw87IPVFz6quxsOP06Cz1FOH592rkluq2sP+wtY7LrZm9L/KT
	5md6/dBjDb8woSgTxtdPSOfS4pRrmdp/ga+Z+i/0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 793C579E8;
	Mon, 23 Jan 2012 17:18:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B12579E6; Mon, 23 Jan 2012
 17:18:42 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3533ACC0-4610-11E1-818C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189018>

Traditionally, a cleanly resolved merge was committed by "git merge" using
the auto-generated merge commit log message with invoking the editor.

After 5 years of use in the field, it turns out that people perform too
many unjustified merges of the upstream history into their topic branches.
These merges are not just useless, but they are often not explained well,
and making the end result unreadable when it gets time for merging their
history back to their upstream.

Earlier we added the "--edit" option to the command, so that people can
edit the log message to explain and justify their merge commits. Let's
take it one step further and spawn the editor by default when we are in an
interactive session (i.e. the standard input and the standard output are
pointing at the same tty device).

There may be existing scripts that leave the standard input and the
standard output of the "git merge" connected to whatever environment the
scripts were started, and such invocation might trigger the above
"interactive session" heuristics.  GIT_MERGE_AUTOEDIT environment variable
can be set to "no" at the beginning of such scripts to use the historical
behaviour while the script runs.

Note that this backward compatibility is meant only for scripts, and we
deliberately do *not* support "merge.edit = yes/no/auto" configuration
option to allow people to keep the historical behaviour.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * With an update to the documentation, so that I won't forget, even
   though this topic came too late in the cycle and not meant for the
   upcoming 1.7.9.

 Documentation/git-merge.txt     |    2 +-
 Documentation/merge-options.txt |   16 +++++++++++++---
 builtin/merge.c                 |   38 ++++++++++++++++++++++++++++++++++----
 t/test-lib.sh                   |    3 ++-
 4 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index e2e6aba..3ceefb8 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -9,7 +9,7 @@ git-merge - Join two or more development histories together
 SYNOPSIS
 --------
 [verse]
-'git merge' [-n] [--stat] [--no-commit] [--squash]
+'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
 	[-s <strategy>] [-X <strategy-option>]
 	[--[no-]rerere-autoupdate] [-m <msg>] [<commit>...]
 'git merge' <msg> HEAD <commit>...
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 6bd0b04..f2f1d0f 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -8,10 +8,20 @@ failed and do not autocommit, to give the user a chance to
 inspect and further tweak the merge result before committing.
 
 --edit::
--e::
+--no-edit::
+	Invoke an editor before committing successful mechanical merge to
+	further edit the auto-generated merge message, so that the user
+	can explain and justify the merge. The `--no-edit` option can be
+	used to accept the auto-generated message (this is generally
+	discouraged). The `--edit` option is still useful if you are
+	giving a draft message with the `-m` option from the command line
+	and want to edit it in the editor.
 +
-	Invoke editor before committing successful merge to further
-	edit the default merge message.
+Older scripts may depend on the historical behaviour of not allowing the
+user to edit the merge log message. They will see an editor opened when
+they run `git merge`. To make it easier to adjust such scripts to the
+updated behaviour, the environment variable `GIT_MERGE_AUTOEDIT` can be
+set to `no` at the beginning of them.
 
 --ff::
 --no-ff::
diff --git a/builtin/merge.c b/builtin/merge.c
index 99f1429..0006175 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -46,7 +46,7 @@ static const char * const builtin_merge_usage[] = {
 
 static int show_diffstat = 1, shortlog_len, squash;
 static int option_commit = 1, allow_fast_forward = 1;
-static int fast_forward_only, option_edit;
+static int fast_forward_only, option_edit = -1;
 static int allow_trivial = 1, have_message;
 static struct strbuf merge_msg;
 static struct commit_list *remoteheads;
@@ -189,7 +189,7 @@ static struct option builtin_merge_options[] = {
 		"create a single commit instead of doing a merge"),
 	OPT_BOOLEAN(0, "commit", &option_commit,
 		"perform a commit if the merge succeeds (default)"),
-	OPT_BOOLEAN('e', "edit", &option_edit,
+	OPT_BOOL('e', "edit", &option_edit,
 		"edit message before committing"),
 	OPT_BOOLEAN(0, "ff", &allow_fast_forward,
 		"allow fast-forward (default)"),
@@ -877,12 +877,12 @@ static void prepare_to_commit(void)
 	write_merge_msg(&msg);
 	run_hook(get_index_file(), "prepare-commit-msg",
 		 git_path("MERGE_MSG"), "merge", NULL, NULL);
-	if (option_edit) {
+	if (0 < option_edit) {
 		if (launch_editor(git_path("MERGE_MSG"), NULL, NULL))
 			abort_commit(NULL);
 	}
 	read_merge_msg(&msg);
-	stripspace(&msg, option_edit);
+	stripspace(&msg, 0 < option_edit);
 	if (!msg.len)
 		abort_commit(_("Empty commit message."));
 	strbuf_release(&merge_msg);
@@ -1076,6 +1076,33 @@ static void write_merge_state(void)
 	close(fd);
 }
 
+static int default_edit_option(void)
+{
+	static const char name[] = "GIT_MERGE_AUTOEDIT";
+	const char *e = getenv(name);
+	struct stat st_stdin, st_stdout;
+
+	if (have_message)
+		/* an explicit -m msg without --[no-]edit */
+		return 0;
+
+	if (e) {
+		int v = git_config_maybe_bool(name, e);
+		if (v < 0)
+			die("Bad value '%s' in environment '%s'", e, name);
+		return v;
+	}
+
+	/* Use editor if stdin and stdout are the same and is a tty */
+	return (!fstat(0, &st_stdin) &&
+		!fstat(1, &st_stdout) &&
+		isatty(0) &&
+		st_stdin.st_dev == st_stdout.st_dev &&
+		st_stdin.st_ino == st_stdout.st_ino &&
+		st_stdin.st_mode == st_stdout.st_mode);
+}
+
+
 int cmd_merge(int argc, const char **argv, const char *prefix)
 {
 	unsigned char result_tree[20];
@@ -1261,6 +1288,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (option_edit < 0)
+		option_edit = default_edit_option();
+
 	if (!use_strategies) {
 		if (!remoteheads->next)
 			add_strategies(pull_twohead, DEFAULT_TWOHEAD);
diff --git a/t/test-lib.sh b/t/test-lib.sh
index bdd9513..ed32c2a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -63,7 +63,8 @@ GIT_AUTHOR_NAME='A U Thor'
 GIT_COMMITTER_EMAIL=committer@example.com
 GIT_COMMITTER_NAME='C O Mitter'
 GIT_MERGE_VERBOSITY=5
-export GIT_MERGE_VERBOSITY
+GIT_MERGE_AUTOEDIT=no
+export GIT_MERGE_VERBOSITY GIT_MERGE_AUTOEDIT
 export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR
-- 
1.7.9.rc2.48.g92994
