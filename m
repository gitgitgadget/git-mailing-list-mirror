From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] git-remote: list branches in vertical lists
Date: Tue, 21 Oct 2008 16:43:14 +0200
Message-ID: <48FDEA82.5050903@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 16:52:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsITM-0008CU-Gc
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 16:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbYJUOnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 10:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbYJUOnV
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 10:43:21 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:17572 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbYJUOnU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 10:43:20 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KsIS2-00005v-LN; Tue, 21 Oct 2008 16:43:17 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 615F669F; Tue, 21 Oct 2008 16:43:14 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98787>

From: Johannes Sixt <johannes.sixt@telecom.at>

Previously, branches were listed on a single line in each section. But
if there are many branches, then horizontal, line-wrapped lists are very
inconvenient to scan for a human. This makes the lists vertical, i.e one
branch per line is printed.

This does mean that users' scripts must be updated because the output
format changed, but the result is friendlier to the eye *and* easier to
parse.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Documentation/user-manual.txt |    4 +++-
 builtin-remote.c              |   11 +++++------
 t/t5505-remote.sh             |   14 +++++++++-----
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 08d1310..645d752 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -4356,7 +4356,9 @@ $ git remote show example	# get details
 * remote example
   URL: git://example.com/project.git
   Tracked remote branches
-    master next ...
+    master
+    next
+    ...
 $ git fetch example		# update branches from example
 $ git branch -r			# list all remote branches
 -----------------------------------------------
diff --git a/builtin-remote.c b/builtin-remote.c
index 90a4e35..1b1697b 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -416,10 +416,9 @@ static void show_list(const char *title, struct string_list *list,
 		return;

 	printf(title, list->nr > 1 ? "es" : "", extra_arg);
-	printf("\n    ");
-	for (i = 0; i < list->nr; i++)
-		printf("%s%s", i ? " " : "", list->items[i].string);
 	printf("\n");
+	for (i = 0; i < list->nr; i++)
+		printf("    %s\n", list->items[i].string);
 }

 static int get_remote_ref_states(const char *name,
@@ -515,17 +514,17 @@ static int show(int argc, const char **argv)
 		show_list("  Tracked remote branch%s", &states.tracked, "");

 		if (states.remote->push_refspec_nr) {
-			printf("  Local branch%s pushed with 'git push'\n   ",
+			printf("  Local branch%s pushed with 'git push'\n",
 				states.remote->push_refspec_nr > 1 ?
 					"es" : "");
 			for (i = 0; i < states.remote->push_refspec_nr; i++) {
 				struct refspec *spec = states.remote->push + i;
-				printf(" %s%s%s%s", spec->force ? "+" : "",
+				printf("    %s%s%s%s\n",
+				       spec->force ? "+" : "",
 				       abbrev_branch(spec->src),
 				       spec->dst ? ":" : "",
 				       spec->dst ? abbrev_branch(spec->dst) : "");
 			}
-			printf("\n");
 		}

 		/* NEEDSWORK: free remote */
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index e5137dc..e6cf2c7 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -28,7 +28,7 @@ tokens_match () {
 }

 check_remote_track () {
-	actual=$(git remote show "$1" | sed -n -e '$p') &&
+	actual=$(git remote show "$1" | sed -e '1,/Tracked/d') &&
 	shift &&
 	tokens_match "$*" "$actual"
 }
@@ -118,9 +118,11 @@ cat > test/expect << EOF
   New remote branch (next fetch will store in remotes/origin)
     master
   Tracked remote branches
-    side master
+    side
+    master
   Local branches pushed with 'git push'
-    master:upstream +refs/tags/lastbackup
+    master:upstream
+    +refs/tags/lastbackup
 EOF

 test_expect_success 'show' '
@@ -147,9 +149,11 @@ cat > test/expect << EOF
   Remote branch merged with 'git pull' while on branch master
     master
   Tracked remote branches
-    master side
+    master
+    side
   Local branches pushed with 'git push'
-    master:upstream +refs/tags/lastbackup
+    master:upstream
+    +refs/tags/lastbackup
 EOF

 test_expect_success 'show -n' '
-- 
1.6.0.2.1573.gdf533
