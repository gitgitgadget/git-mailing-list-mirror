From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 4/5] git-commit-tree: add support for prior
Date: Tue, 25 Apr 2006 16:31:07 +1200
Message-ID: <20060425043107.18382.21313.stgit@localhost.localdomain>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
X-From: git-owner@vger.kernel.org Tue Apr 25 06:32:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYFDX-0000IJ-Pu
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 06:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWDYEb5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 00:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWDYEb4
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 00:31:56 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:49130 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751261AbWDYEbw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 00:31:52 -0400
Received: from samv by mail1.catalyst.net.nz with local (Exim 4.50)
	id 1FYFDK-0004Dq-Ld
	for git@vger.kernel.org; Tue, 25 Apr 2006 16:31:50 +1200
To: git@vger.kernel.org
In-Reply-To: <20060425035421.18382.51677.stgit@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19122>

From: Sam Vilain <sam.vilain@catalyst.net.nz>

Add support in git-commit-tree for -r as well as associated
documentation.
---

 Documentation/git-commit-tree.txt |    6 ++++++
 commit-tree.c                     |   26 +++++++++++++++++++++-----
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 27b3d12..e11ba1f 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -20,6 +20,9 @@ A commit object usually has 1 parent (a 
 to 16 parents.  More than one parent represents a merge of branches
 that led to them.
 
+A commit object can have 1 prior commit.  This represents the previous
+commit that this one replaces (including history).
+
 While a tree represents a particular directory state of a working
 directory, a commit represents that state in "time", and explains how
 to get there.
@@ -38,6 +41,8 @@ OPTIONS
 -p <parent commit>::
 	Each '-p' indicates the id of a parent commit object.
 	
+-r <other commit>::
+	One '-r' indicates the id of a prior commit object.
 
 Commit Information
 ------------------
@@ -45,6 +50,7 @@ Commit Information
 A commit encapsulates:
 
 - all parent object ids
+- a prior object id (optional)
 - author name, email and date
 - committer name and email and the commit time.
 
diff --git a/commit-tree.c b/commit-tree.c
index 2d86518..6660b01 100644
--- a/commit-tree.c
+++ b/commit-tree.c
@@ -61,8 +61,9 @@ static void check_valid(unsigned char *s
  */
 #define MAXPARENT (16)
 static unsigned char parent_sha1[MAXPARENT][20];
+static unsigned char prior_sha1[21] = "\0";
 
-static const char commit_tree_usage[] = "git-commit-tree <sha1> [-p <sha1>]* < changelog";
+static const char commit_tree_usage[] = "git-commit-tree <sha1> [-p <sha1>]* [-r <sha1>] < changelog";
 
 static int new_parent(int idx)
 {
@@ -99,11 +100,22 @@ int main(int argc, char **argv)
 	for (i = 2; i < argc; i += 2) {
 		char *a, *b;
 		a = argv[i]; b = argv[i+1];
-		if (!b || strcmp(a, "-p") || get_sha1(b, parent_sha1[parents]))
+		if (!b)
 			usage(commit_tree_usage);
-		check_valid(parent_sha1[parents], commit_type);
-		if (new_parent(parents))
-			parents++;
+		if (!strcmp(a, "-p")) {
+			if (get_sha1(b, parent_sha1[parents]) < 0)
+				usage(commit_tree_usage);
+			check_valid(parent_sha1[parents], commit_type);
+			if (new_parent(parents))
+				parents++;
+		}
+		else if (!strcmp(a, "-r")) {
+			if (strcmp(&prior_sha1, "") || get_sha1(b, &prior_sha1) < 0)
+				usage(commit_tree_usage);
+		}
+		else {
+			usage(commit_tree_usage);
+		}
 	}
 	if (!parents)
 		fprintf(stderr, "Committing initial tree %s\n", argv[1]);
@@ -118,6 +130,10 @@ int main(int argc, char **argv)
 	 */
 	for (i = 0; i < parents; i++)
 		add_buffer(&buffer, &size, "parent %s\n", sha1_to_hex(parent_sha1[i]));
+	if (strcmp(&prior_sha1, "")) {
+		fprintf(stderr, "Setting prior to %s\n", sha1_to_hex(&prior_sha1));
+		add_buffer(&buffer, &size, "prior %s\n", sha1_to_hex(&prior_sha1));
+	}
 
 	/* Person/date information */
 	add_buffer(&buffer, &size, "author %s\n", git_author_info(1));
