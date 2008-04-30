From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] add merge.renamelimit config option
Date: Wed, 30 Apr 2008 13:23:55 -0400
Message-ID: <20080430172354.GA23747@sigill.intra.peff.net>
References: <20080430172136.GA22601@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 19:24:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrG2w-00045Q-I9
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 19:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758092AbYD3RX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 13:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758070AbYD3RX6
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 13:23:58 -0400
Received: from peff.net ([208.65.91.99]:3517 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758068AbYD3RX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 13:23:57 -0400
Received: (qmail 27910 invoked by uid 111); 30 Apr 2008 17:23:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 30 Apr 2008 13:23:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Apr 2008 13:23:55 -0400
Content-Disposition: inline
In-Reply-To: <20080430172136.GA22601@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80854>

The point of rename limiting is to bound the amount of time
we spend figuring out inexact renames. Currently we use a
single value, diff.renamelimit, for all situations. However,
it is probably the case that a user is willing to spend more
time finding renames during a merge than they are while
looking at git-log.

This patch provides a way of setting those values separately
(though for backwards compatibility, merge still falls back
on the diff renamelimit).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/merge-config.txt |    5 +++
 builtin-merge-recursive.c      |   13 +++++--
 t/t6032-merge-large-rename.sh  |   73 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 3 deletions(-)
 create mode 100755 t/t6032-merge-large-rename.sh

diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 9719311..48ce747 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -6,6 +6,11 @@ merge.log::
 	Whether to include summaries of merged commits in newly created
 	merge commit messages. False by default.
 
+merge.renameLimit::
+	The number of files to consider when performing rename detection
+	during a merge; if not specified, defaults to the value of
+	diff.renameLimit.
+
 merge.tool::
 	Controls which merge resolution program is used by
 	linkgit:git-mergetool[1].  Valid built-in values are: "kdiff3",
diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 910c0d2..1293e3d 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -92,7 +92,8 @@ static struct path_list current_directory_set = {NULL, 0, 0, 1};
 
 static int call_depth = 0;
 static int verbosity = 2;
-static int rename_limit = -1;
+static int diff_rename_limit = -1;
+static int merge_rename_limit = -1;
 static int buffer_output = 1;
 static struct strbuf obuf = STRBUF_INIT;
 
@@ -361,7 +362,9 @@ static struct path_list *get_renames(struct tree *tree,
 	diff_setup(&opts);
 	DIFF_OPT_SET(&opts, RECURSIVE);
 	opts.detect_rename = DIFF_DETECT_RENAME;
-	opts.rename_limit = rename_limit;
+	opts.rename_limit = merge_rename_limit >= 0 ? merge_rename_limit :
+			    diff_rename_limit >= 0 ? diff_rename_limit :
+			    100;
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	if (diff_setup_done(&opts) < 0)
 		die("diff setup failed");
@@ -1343,7 +1346,11 @@ static int merge_config(const char *var, const char *value)
 		return 0;
 	}
 	if (!strcasecmp(var, "diff.renamelimit")) {
-		rename_limit = git_config_int(var, value);
+		diff_rename_limit = git_config_int(var, value);
+		return 0;
+	}
+	if (!strcasecmp(var, "merge.renamelimit")) {
+		merge_rename_limit = git_config_int(var, value);
 		return 0;
 	}
 	return git_default_config(var, value);
diff --git a/t/t6032-merge-large-rename.sh b/t/t6032-merge-large-rename.sh
new file mode 100755
index 0000000..eac5eba
--- /dev/null
+++ b/t/t6032-merge-large-rename.sh
@@ -0,0 +1,73 @@
+#!/bin/sh
+
+test_description='merging with large rename matrix'
+. ./test-lib.sh
+
+count() {
+	i=1
+	while test $i -le $1; do
+		echo $i
+		i=$(($i + 1))
+	done
+}
+
+test_expect_success 'setup (initial)' '
+	touch file &&
+	git add . &&
+	git commit -m initial &&
+	git tag initial
+'
+
+make_text() {
+	echo $1: $2
+	for i in `count 20`; do
+		echo $1: $i
+	done
+	echo $1: $3
+}
+
+test_rename() {
+	test_expect_success "rename ($1, $2)" '
+	n='$1'
+	expect='$2'
+	git checkout -f master &&
+	git branch -D test$n || true &&
+	git reset --hard initial &&
+	for i in $(count $n); do
+		make_text $i initial initial >$i
+	done &&
+	git add . &&
+	git commit -m add=$n &&
+	for i in $(count $n); do
+		make_text $i changed initial >$i
+	done &&
+	git commit -a -m change=$n &&
+	git checkout -b test$n HEAD^ &&
+	for i in $(count $n); do
+		git rm $i
+		make_text $i initial changed >$i.moved
+	done &&
+	git add . &&
+	git commit -m change+rename=$n &&
+	case "$expect" in
+		ok) git merge master ;;
+		 *) test_must_fail git merge master ;;
+	esac
+	'
+}
+
+test_rename 5 ok
+
+test_expect_success 'set diff.renamelimit to 4' '
+	git config diff.renamelimit 4
+'
+test_rename 4 ok
+test_rename 5 fail
+
+test_expect_success 'set merge.renamelimit to 5' '
+	git config merge.renamelimit 5
+'
+test_rename 5 ok
+test_rename 6 fail
+
+test_done
-- 
1.5.5.1.177.g8182d.dirty
