From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] commit-tree: lift completely arbitrary limit of 16 parents
Date: Fri, 27 Jun 2008 13:24:47 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806271324010.9925@racer>
References: <alpine.LFD.1.10.0806262243130.2988@localhost.localdomain> <alpine.DEB.1.00.0806271259440.9925@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Len Brown <lenb@kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 27 14:27:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCD3K-0000KX-3a
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 14:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274AbYF0M0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 08:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756786AbYF0M0s
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 08:26:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:46092 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754994AbYF0M0r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 08:26:47 -0400
Received: (qmail invoked by alias); 27 Jun 2008 12:26:45 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp006) with SMTP; 27 Jun 2008 14:26:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX182MQAg6L02FQ+GIxJEUojKUcGE3bEATJqoktbN0f
	c4SdEuTznvLqNm
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0806271259440.9925@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86543>


There is no really good reason to have a merge with more than 16
parents, but we have a history of giving our users rope.

Combined with the fact that there was no good reason for that
arbitrary limit in the first place, here is an all-too-easy to fix.

Kind of wished-for by Len Brown.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Fri, 27 Jun 2008, Johannes Schindelin wrote:

	> On Thu, 26 Jun 2008, Len Brown wrote:
	> 
	> > it would be nice if a merge of more than 16 branches failed 
	> > right at the start, rather than chunking along doing merges and then 
	> > giving up, leaving my repo in an intermediate state.
	> 
	> FWIW I think the rewrite of git-merge as a builtin, which is 
	> currently in the works, lifts the limit.  However, this is only true if 
	> you do not use a custom script which calls commit-tree.

	And here is a patch to fix commit-tree.

 builtin-commit-tree.c |   43 ++++++++++++++++++++-----------------------
 1 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index e5e4bdb..5931a92 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -24,26 +24,20 @@ static void check_valid(unsigned char *sha1, enum object_type expect)
 		    typename(expect));
 }
 
-/*
- * Having more than two parents is not strange at all, and this is
- * how multi-way merges are represented.
- */
-#define MAXPARENT (16)
-static unsigned char parent_sha1[MAXPARENT][20];
-
 static const char commit_tree_usage[] = "git-commit-tree <sha1> [-p <sha1>]* < changelog";
 
-static int new_parent(int idx)
+static void new_parent(struct commit *parent, struct commit_list **parents_p)
 {
-	int i;
-	unsigned char *sha1 = parent_sha1[idx];
-	for (i = 0; i < idx; i++) {
-		if (!hashcmp(parent_sha1[i], sha1)) {
+	unsigned char *sha1 = parent->object.sha1;
+	struct commit_list *parents;
+	for (parents = *parents_p; parents; parents = parents->next) {
+		if (!hashcmp(parents->item->object.sha1, sha1)) {
 			error("duplicate parent %s ignored", sha1_to_hex(sha1));
-			return 0;
+			return;
 		}
+		parents_p = &parents->next;
 	}
-	return 1;
+	commit_list_insert(parent, parents_p);
 }
 
 static const char commit_utf8_warn[] =
@@ -54,7 +48,7 @@ static const char commit_utf8_warn[] =
 int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	int parents = 0;
+	struct commit_list *parents = NULL;
 	unsigned char tree_sha1[20];
 	unsigned char commit_sha1[20];
 	struct strbuf buffer;
@@ -69,18 +63,16 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 
 	check_valid(tree_sha1, OBJ_TREE);
 	for (i = 2; i < argc; i += 2) {
+		unsigned char sha1[40];
 		const char *a, *b;
 		a = argv[i]; b = argv[i+1];
 		if (!b || strcmp(a, "-p"))
 			usage(commit_tree_usage);
 
-		if (parents >= MAXPARENT)
-			die("Too many parents (%d max)", MAXPARENT);
-		if (get_sha1(b, parent_sha1[parents]))
+		if (get_sha1(b, sha1))
 			die("Not a valid object name %s", b);
-		check_valid(parent_sha1[parents], OBJ_COMMIT);
-		if (new_parent(parents))
-			parents++;
+		check_valid(sha1, OBJ_COMMIT);
+		new_parent(lookup_commit(sha1), &parents);
 	}
 
 	/* Not having i18n.commitencoding is the same as having utf-8 */
@@ -94,8 +86,13 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	 * different order of parents will be a _different_ changeset even
 	 * if everything else stays the same.
 	 */
-	for (i = 0; i < parents; i++)
-		strbuf_addf(&buffer, "parent %s\n", sha1_to_hex(parent_sha1[i]));
+	while (parents) {
+		struct commit_list *next = parents->next;
+		strbuf_addf(&buffer, "parent %s\n",
+			sha1_to_hex(parents->item->object.sha1));
+		free(parents);
+		parents = next;
+	}
 
 	/* Person/date information */
 	strbuf_addf(&buffer, "author %s\n", git_author_info(IDENT_ERROR_ON_NO_NAME));
-- 
1.5.6.173.gde14c
