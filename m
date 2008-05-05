From: Florian Ragwitz <rafl@debian.org>
Subject: [PATCH] Add a --signoff option to cherry-pick/revert.
Date: Mon,  5 May 2008 02:25:09 +0200
Message-ID: <1209947109-13910-1-git-send-email-rafl@debian.org>
Cc: Florian Ragwitz <rafl@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 05 02:55:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsoyv-0007nv-Pb
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 02:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbYEEAyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 20:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbYEEAyS
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 20:54:18 -0400
Received: from weedy.perldition.org ([85.10.210.75]:58155 "EHLO
	weedy.perldition.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbYEEAyR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 20:54:17 -0400
X-Greylist: delayed 1743 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 May 2008 20:54:16 EDT
Received: from p4fd720ca.dip0.t-ipconnect.de ([79.215.32.202]:49027 helo=ata.xb.lan)
	by weedy.perldition.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60)
	(envelope-from <rafl@debian.org>)
	id 1JsoUw-0005DB-B0; Mon, 05 May 2008 02:24:06 +0200
Received: from rafl by ata.xb.lan with local (Exim 4.69)
	(envelope-from <rafl@debian.org>)
	id 1JsoVx-0003ck-Jw; Mon, 05 May 2008 02:25:09 +0200
X-Mailer: git-send-email 1.5.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81214>

Also modify documentation and tests to reflect this change.

Signed-off-by: Florian Ragwitz <rafl@debian.org>
---
 Documentation/git-cherry-pick.txt |    3 +++
 Documentation/git-revert.txt      |    3 +++
 builtin-revert.c                  |   25 ++++++++++++++++++++-----
 t/t3501-revert-cherry-pick.sh     |   19 +++++++++++++++++++
 4 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index f0beb41..ec8bd50 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -39,6 +39,9 @@ OPTIONS
 	development branch), adding this information can be
 	useful.
 
+-s|--signoff::
+	Add Signed-off-by line at the end of the commit message.
+
 -r::
 	It used to be that the command defaulted to do `-x`
 	described above, and `-r` was to disable it.  Now the
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 93e20f7..a35a376 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -27,6 +27,9 @@ OPTIONS
 	message prior to committing the revert. This is the default if
 	you run the command from a terminal.
 
+-s|--signoff::
+	Add Signed-off-by line at the end of the commit message.
+
 -m parent-number|--mainline parent-number::
 	Usually you cannot revert a merge because you do not know which
 	side of the merge should be considered the mainline.  This
diff --git a/builtin-revert.c b/builtin-revert.c
index 607a2f0..ccf591c 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -33,7 +33,7 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-static int edit, no_replay, no_commit, mainline;
+static int edit, no_replay, no_commit, mainline, signoff;
 static enum { REVERT, CHERRY_PICK } action;
 static struct commit *commit;
 
@@ -53,6 +53,7 @@ static void parse_args(int argc, const char **argv)
 		OPT_BOOLEAN('e', "edit", &edit, "edit the commit message"),
 		OPT_BOOLEAN('x', NULL, &no_replay, "append commit name when cherry-picking"),
 		OPT_BOOLEAN('r', NULL, &noop, "no-op (backward compatibility)"),
+		OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
 		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
 		OPT_END(),
 	};
@@ -404,10 +405,24 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	 */
 
 	if (!no_commit) {
-		if (edit)
-			return execl_git_cmd("commit", "-n", NULL);
-		else
-			return execl_git_cmd("commit", "-n", "-F", defmsg, NULL);
+		const char *args[6];
+		int i = 0;
+
+		args[i++] = "commit";
+		args[i++] = "-n";
+
+		if (!edit) {
+			args[i++] = "-F";
+			args[i++] = defmsg;
+		}
+
+		if (signoff) {
+			args[i++] = "-s";
+		}
+
+		args[i] = NULL;
+
+		return execv_git_cmd(args);
 	}
 	free(reencoded_message);
 
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 6da2128..2f74f74 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -50,6 +50,25 @@ test_expect_success 'cherry-pick after renaming branch' '
 
 '
 
+test_expect_success 'cherry-pick signoff' '
+
+	git checkout rename2 &&
+	git cherry-pick -s added &&
+	test -f opos &&
+	git cat-file commit HEAD | sed "1,/^$/d" > output &&
+	grep Signed-off-by output
+'
+
+test_expect_success 'revert signoff' '
+
+	git checkout rename1 &&
+	git revert -s added &&
+	test -f spoo &&
+	git cat-file commit HEAD | sed "1,/^$/d" > output &&
+	grep Signed-off-by output
+
+'
+
 test_expect_success 'revert after renaming branch' '
 
 	git checkout rename1 &&
-- 
1.5.5.1
