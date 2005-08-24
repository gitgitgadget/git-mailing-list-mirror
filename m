From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Fix "prefix" mixup in git-rev-list
Date: Wed, 24 Aug 2005 17:58:42 -0400
Message-ID: <1124920722.17909.9.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 25 00:00:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E83HI-0001GJ-Ju
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 23:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbVHXV6x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 17:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbVHXV6x
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 17:58:53 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:56528 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932298AbVHXV6x
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2005 17:58:53 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1E83GY-0006PY-BB
	for git@vger.kernel.org; Wed, 24 Aug 2005 17:58:38 -0400
Received: from localhost.localdomain ([127.0.0.1] helo=dv.roinet.com)
	by dv.roinet.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.52)
	id 1E83Gd-0006ZM-Nr
	for git@vger.kernel.org; Wed, 24 Aug 2005 17:58:43 -0400
Received: (from proski@localhost)
	by dv.roinet.com (8.13.4/8.13.4/Submit) id j7OLwhNY025253
	for git@vger.kernel.org; Wed, 24 Aug 2005 17:58:43 -0400
X-Authentication-Warning: dv.roinet.com: proski set sender to proski@gnu.org using -f
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7733>

Hello!

Recent changes in git have broken cg-log.  git-rev-list no longer prints
"commit" in front of commit hashes.  It turn out a local "prefix"
variable in main() shadows a file-scoped "prefix" variable.

The patch removed the local "prefix" variable since its value is never
used (in the intended way, that is).  The call to setup_git_directory()
is kept since it has useful side effects.

The file-scoped "prefix" variable is renamed to "commit_prefix" just in
case someone reintroduces "prefix" to hold the return value of
setup_git_directory().

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -33,7 +33,7 @@ static int blob_objects = 0;
 static int verbose_header = 0;
 static int show_parents = 0;
 static int hdr_termination = 0;
-static const char *prefix = "";
+static const char *commit_prefix = "";
 static unsigned long max_age = -1;
 static unsigned long min_age = -1;
 static int max_count = -1;
@@ -48,14 +48,14 @@ static void show_commit(struct commit *c
 {
 	commit->object.flags |= SHOWN;
 	if (show_breaks) {
-		prefix = "| ";
+		commit_prefix = "| ";
 		if (commit->object.flags & DISCONTINUITY) {
-			prefix = "^ ";     
+			commit_prefix = "^ ";     
 		} else if (commit->object.flags & BOUNDARY) {
-			prefix = "= ";
+			commit_prefix = "= ";
 		} 
         }        		
-	printf("%s%s", prefix, sha1_to_hex(commit->object.sha1));
+	printf("%s%s", commit_prefix, sha1_to_hex(commit->object.sha1));
 	if (show_parents) {
 		struct commit_list *parents = commit->parents;
 		while (parents) {
@@ -481,9 +481,9 @@ static void handle_one_commit(struct com
 int main(int argc, char **argv)
 {
 	struct commit_list *list = NULL;
-	const char *prefix = setup_git_directory();
 	int i, limited = 0;
 
+	setup_git_directory();
 	for (i = 1 ; i < argc; i++) {
 		int flags;
 		char *arg = argv[i];
@@ -511,9 +511,9 @@ int main(int argc, char **argv)
 			verbose_header = 1;
 			hdr_termination = '\n';
 			if (commit_format == CMIT_FMT_ONELINE)
-				prefix = "";
+				commit_prefix = "";
 			else
-				prefix = "commit ";
+				commit_prefix = "commit ";
 			continue;
 		}
 		if (!strncmp(arg, "--no-merges", 11)) {


-- 
Regards,
Pavel Roskin
