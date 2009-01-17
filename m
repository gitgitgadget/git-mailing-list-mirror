From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH/RFC v3bis 2/2] checkout: implement '@{-N}' and '-' special abbreviations
Date: Sat, 17 Jan 2009 14:40:21 +0100
Message-ID: <1232199621-31072-2-git-send-email-trast@student.ethz.ch>
References: <200901171438.22504.trast@student.ethz.ch>
 <1232199621-31072-1-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 14:41:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOBQn-0005AP-Vv
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 14:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757156AbZAQNkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 08:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756794AbZAQNkW
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 08:40:22 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:24164 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754791AbZAQNkU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 08:40:20 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 14:40:16 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 14:40:16 +0100
X-Mailer: git-send-email 1.6.1.315.g92577
In-Reply-To: <1232199621-31072-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 17 Jan 2009 13:40:16.0342 (UTC) FILETIME=[217D0F60:01C978A9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106051>

Checks if the branch to be checked out is either '@{-N}' or the
special shorthand '-' for '@{-1}' (i.e. the last checked out branch).
If so, we take it to mean the branch name, not the corresponding SHA,
so that we check out an attached HEAD on that branch.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-checkout.txt |    4 +++
 builtin-checkout.c             |   15 ++++++++++-
 t/t2012-checkout-last.sh       |   50 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 2 deletions(-)
 create mode 100755 t/t2012-checkout-last.sh

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 9cd5151..3bccffa 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -133,6 +133,10 @@ the conflicted merge in the specified paths.
 +
 When this parameter names a non-branch (but still a valid commit object),
 your HEAD becomes 'detached'.
++
+As a special case, the "`@\{-N\}`" syntax for the N-th last branch
+checks out the branch (instead of detaching).  You may also specify
+"`-`" which is synonymous with "`@\{-1\}`".
 
 
 Detached HEAD
diff --git a/builtin-checkout.c b/builtin-checkout.c
index b5dd9c0..b0a101b 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -361,8 +361,16 @@ struct branch_info {
 static void setup_branch_path(struct branch_info *branch)
 {
 	struct strbuf buf = STRBUF_INIT;
-	strbuf_addstr(&buf, "refs/heads/");
-	strbuf_addstr(&buf, branch->name);
+	int ret;
+
+	if ((ret = interpret_nth_last_branch(branch->name, &buf))
+	    && ret == strlen(branch->name)) {
+		branch->name = xstrdup(buf.buf);
+		strbuf_splice(&buf, 0, 0, "refs/heads/", 11);
+	} else {
+		strbuf_addstr(&buf, "refs/heads/");
+		strbuf_addstr(&buf, branch->name);
+	}
 	branch->path = strbuf_detach(&buf, NULL);
 }
 
@@ -671,6 +679,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		arg = argv[0];
 		has_dash_dash = (argc > 1) && !strcmp(argv[1], "--");
 
+		if (!strcmp(arg, "-"))
+			arg = "@{-1}";
+
 		if (get_sha1(arg, rev)) {
 			if (has_dash_dash)          /* case (1) */
 				die("invalid reference: %s", arg);
diff --git a/t/t2012-checkout-last.sh b/t/t2012-checkout-last.sh
new file mode 100755
index 0000000..320f6eb
--- /dev/null
+++ b/t/t2012-checkout-last.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+test_description='checkout can switch to last branch'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo hello >world &&
+	git add world &&
+	git commit -m initial &&
+	git branch other &&
+	echo "hello again" >>world &&
+	git add world &&
+	git commit -m second
+'
+
+test_expect_success '"checkout -" does not work initially' '
+	test_must_fail git checkout -
+'
+
+test_expect_success 'first branch switch' '
+	git checkout other
+'
+
+test_expect_success '"checkout -" switches back' '
+	git checkout - &&
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/master"
+'
+
+test_expect_success '"checkout -" switches forth' '
+	git checkout - &&
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/other"
+'
+
+test_expect_success 'detach HEAD' '
+	git checkout $(git rev-parse HEAD)
+'
+
+test_expect_success '"checkout -" attaches again' '
+	git checkout - &&
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/other"
+'
+
+test_expect_success '"checkout -" detaches again' '
+	git checkout - &&
+	test "z$(git rev-parse HEAD)" = "z$(git rev-parse other)" &&
+	test_must_fail git symbolic-ref HEAD
+'
+
+test_done
-- 
1.6.1.315.g92577
