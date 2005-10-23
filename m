From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/4] git-fetch-pack: Do not use git-rev-list
Date: Sun, 23 Oct 2005 03:39:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510230337460.21239@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Oct 23 03:39:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETUpN-0007ng-VJ
	for gcvg-git@gmane.org; Sun, 23 Oct 2005 03:39:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbVJWBjK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Oct 2005 21:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbVJWBjK
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Oct 2005 21:39:10 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:2451 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751373AbVJWBjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2005 21:39:09 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 496A213F0B6; Sun, 23 Oct 2005 03:39:08 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2FD689EF6E; Sun, 23 Oct 2005 03:39:08 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0665D90236; Sun, 23 Oct 2005 03:39:08 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id EC1E713F0B6; Sun, 23 Oct 2005 03:39:07 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10484>

The code used to call git-rev-list to enumerate the local revisions. A 
disadvantage of that method was that git-rev-list, lacking a control apart 
from the command line, would happily enumerate ancestors of acknowledged 
common commits, which was just taking unnecessary bandwidth.

Therefore, do not use git-rev-list on the fetching side, but rather 
construct the list on the go. Send the revisions starting from the local 
heads, ignoring the revisions known to be common.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 fetch-pack.c |  151 ++++++++++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 119 insertions(+), 32 deletions(-)

applies-to: da61ef5f5dbbe9d0f926f47ae0bd594cdff80d64
8078a74c5b771352d9a7d3979c8dd7e7858ccbaa
diff --git a/fetch-pack.c b/fetch-pack.c
index 8566ab1..3a903c4 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -13,18 +13,123 @@ static const char fetch_pack_usage[] =
 static const char *exec = "git-upload-pack";
 
 #define COMPLETE	(1U << 0)
+#define COMMON		(1U << 1)
+#define COMMON_REF	(1U << 2 | COMMON)
+#define SEEN		(1U << 3)
+#define POPPED		(1U << 4)
+
+static struct commit_list *rev_list = NULL;
+static struct commit_list *rev_list_end = NULL;
+static unsigned long non_common_revs = 0;
+
+static void rev_list_append(struct commit *commit, int mark)
+{
+	if (!(commit->object.flags & mark)) {
+		commit->object.flags |= mark;
+
+		if (rev_list == NULL) {
+			commit_list_insert(commit, &rev_list);
+			rev_list_end = rev_list;
+		} else {
+			commit_list_insert(commit, &(rev_list_end->next));
+			rev_list_end = rev_list_end->next;
+		}
+
+		if (!(commit->object.flags & COMMON))
+			non_common_revs++;
+	}
+}
+
+static int rev_list_append_sha1(const char *path, const unsigned char *sha1)
+{
+	struct object *o = deref_tag(parse_object(sha1));
+
+	if (o->type == commit_type)
+		rev_list_append((struct commit *)o, SEEN);
+
+	return 0;
+}
+
+static void mark_common(struct commit *commit)
+{
+	if (commit != NULL && !(commit->object.flags & COMMON)) {
+		struct object *o = (struct object *)commit;
+		o->flags |= COMMON;
+		if (!(o->flags & SEEN))
+			rev_list_append(commit, SEEN);
+		else {
+			struct commit_list *parents;
+
+			if (!(o->flags & POPPED))
+				non_common_revs--;
+			if (!o->parsed)
+				parse_commit(commit);
+			for (parents = commit->parents;
+					parents;
+					parents = parents->next)
+				mark_common(parents->item);
+		}
+	}
+}
+
+/*
+  Get the next rev to send, ignoring the common.
+*/
+
+static const unsigned char* get_rev()
+{
+	struct commit *commit = NULL;
+
+	while (commit == NULL) {
+		unsigned int mark;
+		struct commit_list* parents;
+
+		if (rev_list == NULL || non_common_revs == 0)
+			return NULL;
+
+		commit = rev_list->item;
+		if (!(commit->object.parsed))
+			parse_commit(commit);
+		commit->object.flags |= POPPED;
+		if (!(commit->object.flags & COMMON))
+			non_common_revs--;
+	
+		parents = commit->parents;
+
+		if (commit->object.flags & COMMON) {
+			/* do not send "have", and ignore ancestors */
+			commit = NULL;
+			mark = COMMON | SEEN;
+		} else if (commit->object.flags & COMMON_REF)
+			/* send "have", and ignore ancestors */
+			mark = COMMON | SEEN;
+		else
+			/* send "have", also for its ancestors */
+			mark = SEEN;
+
+		while (parents) {
+			if (mark & COMMON)
+				mark_common(parents->item);
+			else
+				rev_list_append(parents->item, mark);
+			parents = parents->next;
+		}
+
+		rev_list = rev_list->next;
+	}
+
+	return commit->object.sha1;
+}
 
 static int find_common(int fd[2], unsigned char *result_sha1,
 		       struct ref *refs)
 {
 	int fetching;
-	static char line[1000];
-	static char rev_command[1024];
-	int count = 0, flushes = 0, retval, rev_command_len;
-	FILE *revs;
+	int count = 0, flushes = 0, retval;
+	const unsigned char *sha1;
+
+	for_each_ref(rev_list_append_sha1);
 
-	strcpy(rev_command, "git-rev-list $(git-rev-parse --all)");
-	rev_command_len = strlen(rev_command);
 	fetching = 0;
 	for ( ; refs ; refs = refs->next) {
 		unsigned char *remote = refs->old_sha1;
@@ -42,25 +147,15 @@ static int find_common(int fd[2], unsign
 		 */
 		if (((o = lookup_object(remote)) != NULL) &&
 		    (o->flags & COMPLETE)) {
-			struct commit_list *p;
-			struct commit *commit =
-				(struct commit *) (o = deref_tag(o));
-			if (!o)
-				goto repair;
-			if (o->type != commit_type)
-				continue;
-			p = commit->parents;
-			while (p &&
-			       rev_command_len + 44 < sizeof(rev_command)) {
-				snprintf(rev_command + rev_command_len, 44,
-					 " ^%s",
-					 sha1_to_hex(p->item->object.sha1));
-				rev_command_len += 43;
-				p = p->next;
-			}
+			o = deref_tag(o);
+
+			if (o->type == commit_type)
+				rev_list_append((struct commit *)o,
+						COMMON_REF | SEEN);
+
 			continue;
 		}
-	repair:
+
 		packet_write(fd[1], "want %s\n", sha1_to_hex(remote));
 		fetching++;
 	}
@@ -68,16 +163,9 @@ static int find_common(int fd[2], unsign
 	if (!fetching)
 		return 1;
 
-	revs = popen(rev_command, "r");
-	if (!revs)
-		die("unable to run 'git-rev-list'");
-
 	flushes = 1;
 	retval = -1;
-	while (fgets(line, sizeof(line), revs) != NULL) {
-		unsigned char sha1[20];
-		if (get_sha1_hex(line, sha1))
-			die("git-fetch-pack: expected object name, got crud");
+	while ((sha1 = get_rev())) {
 		packet_write(fd[1], "have %s\n", sha1_to_hex(sha1));
 		if (verbose)
 			fprintf(stderr, "have %s\n", sha1_to_hex(sha1));
@@ -101,7 +189,6 @@ static int find_common(int fd[2], unsign
 			flushes--;
 		}
 	}
-	pclose(revs);
 	packet_write(fd[1], "done\n");
 	if (verbose)
 		fprintf(stderr, "done\n");
---
0.99.8.GIT
