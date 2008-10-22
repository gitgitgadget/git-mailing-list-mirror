From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-remote: list branches in vertical lists
Date: Wed, 22 Oct 2008 09:39:47 +0200
Message-ID: <48FED8C3.20003@viscovery.net>
References: <48FDEA82.5050903@viscovery.net> <alpine.DEB.1.00.0810211847410.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 22 09:41:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsYL4-0004Zq-0d
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 09:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbYJVHjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 03:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbYJVHjw
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 03:39:52 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:13066 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbYJVHjv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 03:39:51 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KsYJn-0007Yb-E6; Wed, 22 Oct 2008 09:39:47 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3535D6EF; Wed, 22 Oct 2008 09:39:47 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.DEB.1.00.0810211847410.22125@pacific.mpi-cbg.de.mpi-cbg.de>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98836>

From: Johannes Sixt <j6t@kdbg.org>

Previously, branches were listed on a single line in each section. But
if there are many branches, then horizontal, line-wrapped lists are very
inconvenient to scan for a human. This makes the lists vertical, i.e one
branch per line is printed.

Since "git remote" is porcelain, we can easily make this
backwards-incompatible change.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Johannes Schindelin schrieb:
> On Tue, 21 Oct 2008, Johannes Sixt wrote:
>> This does mean that users' scripts must be updated because the output 
>> format changed, but the result is friendlier to the eye *and* easier to 
>> parse.
> 
> My initial reaction to that was: add an option, and keep the old behavior 
> then.
> 
> But on second thought: No script has any business scanning the output of 
> git-remote.  That command is a pure convenience wrapper, and scripts 
> trying to list remote branches should use git show-ref instead.
> 
> So I'd say: replace the last comment with
> 
> 	Since "git remote" is porcelain, we can easily make this 
> 	backwards-incompatible change.

Here we go.

Note the new email address, too. I'm afraid the old one, @telecom.at, goes
out of service by the end of the year.

-- Hannes

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
