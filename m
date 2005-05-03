From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Make git-*-pull say who wants it for missing objects.
Date: Mon, 02 May 2005 17:13:52 -0700
Message-ID: <7voebtnp33.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 02:08:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSkx4-0007sZ-FU
	for gcvg-git@gmane.org; Tue, 03 May 2005 02:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVECAOA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 20:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVECAOA
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 20:14:00 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:13517 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261244AbVECANy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2005 20:13:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050503001352.UHWU19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 2 May 2005 20:13:52 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch updates pull.c, the engine that decides what object is needed
given a commit to traverse from, to report which commit was calling for
the object that cannot be retrieved from the remote side.  This complements
git-fsck-cache in that it checks the consistency of the remote repository
for reachability.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

pull.c |   37 ++++++++++++++++++++++++++++++-------
1 files changed, 30 insertions(+), 7 deletions(-)

--- a/pull.c
+++ b/pull.c
@@ -7,12 +7,31 @@
 int get_tree = 0;
 int get_history = 0;
 int get_all = 0;
+static unsigned char current_commit_sha1[20];
 
-static int make_sure_we_have_it(unsigned char *sha1)
+static const char commitS[] = "commit";
+static const char treeS[] = "tree";
+static const char blobS[] = "blob";
+
+static void report_missing(const char *what, const unsigned char *missing)
+{
+	char missing_hex[41];
+
+	strcpy(missing_hex, sha1_to_hex(missing));;
+	fprintf(stderr,
+		"Cannot obtain needed %s %s\nwhile processing commit %s.\n",
+		what, missing_hex, sha1_to_hex(current_commit_sha1));
+}
+
+static int make_sure_we_have_it(const char *what, unsigned char *sha1)
 {
+	int status;
 	if (has_sha1_file(sha1))
 		return 0;
-	return fetch(sha1);	
+	status = fetch(sha1);
+	if (status && what)
+		report_missing(what, sha1);
+	return status;
 }
 
 static int process_tree(unsigned char *sha1)
@@ -24,7 +43,8 @@ static int process_tree(unsigned char *s
 		return -1;
 
 	for (entries = tree->entries; entries; entries = entries->next) {
-		if (make_sure_we_have_it(entries->item.tree->object.sha1))
+		const char *what = entries->directory ? treeS : blobS;
+		if (make_sure_we_have_it(what, entries->item.tree->object.sha1))
 			return -1;
 		if (entries->directory) {
 			if (process_tree(entries->item.tree->object.sha1))
@@ -38,14 +58,14 @@ static int process_commit(unsigned char 
 {
 	struct commit *obj = lookup_commit(sha1);
 
-	if (make_sure_we_have_it(sha1))
+	if (make_sure_we_have_it(commitS, sha1))
 		return -1;
 
 	if (parse_commit(obj))
 		return -1;
 
 	if (get_tree) {
-		if (make_sure_we_have_it(obj->tree->object.sha1))
+		if (make_sure_we_have_it(treeS, obj->tree->object.sha1))
 			return -1;
 		if (process_tree(obj->tree->object.sha1))
 			return -1;
@@ -57,7 +77,8 @@ static int process_commit(unsigned char 
 		for (; parents; parents = parents->next) {
 			if (has_sha1_file(parents->item->object.sha1))
 				continue;
-			if (make_sure_we_have_it(parents->item->object.sha1)) {
+			if (make_sure_we_have_it(NULL,
+						 parents->item->object.sha1)) {
 				/* The server might not have it, and
 				 * we don't mind. 
 				 */
@@ -65,6 +86,7 @@ static int process_commit(unsigned char 
 			}
 			if (process_commit(parents->item->object.sha1))
 				return -1;
+			memcpy(current_commit_sha1, sha1, 20);
 		}
 	}
 	return 0;
@@ -77,8 +99,9 @@ int pull(char *target)
 	retval = get_sha1_hex(target, sha1);
 	if (retval)
 		return retval;
-	retval = make_sure_we_have_it(sha1);
+	retval = make_sure_we_have_it(commitS, sha1);
 	if (retval)
 		return retval;
+	memcpy(current_commit_sha1, sha1, 20);
 	return process_commit(sha1);
 }

