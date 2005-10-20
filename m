From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Do not use git-rev-list in git-fetch-pack
Date: Thu, 20 Oct 2005 17:12:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510201707560.29282@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Oct 20 17:12:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESc5a-00082G-Bo
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 17:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbVJTPMJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 11:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbVJTPMI
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 11:12:08 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:47281 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751579AbVJTPMH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 11:12:07 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2971113EE14; Thu, 20 Oct 2005 17:12:02 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 04115B4E15; Thu, 20 Oct 2005 17:12:02 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CBF1CB4E01; Thu, 20 Oct 2005 17:12:01 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A931913EE14; Thu, 20 Oct 2005 17:12:01 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10364>

The code used to call git-rev-list to enumerate the local revisions.
A disadvantage of that method was that git-fetch-pack would happily
enumerate ancestors of acknowledged common commits, which was just
taking unnecessary bandwidth.

Further, git-upload-pack makes use only of the first MAX_HAS == 16
revisions! So if git-fetch-pack has something to say, it better does
so concisely.

Therefore, do not use git-rev-list on the fetching side. Send the
revisions starting with the local heads, ignoring the acknowledged
revisions and their ancestors.

When git-fetch-pack is verbose, it now says which sha1 got acknowledged.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	I am quite certain that MAX_HAS is too low. Since
	MAX_NEEDS == 256, I think this value would be better for
	MAX_HAS, too, especially since git-fetch-pack no longer
	sends so much crud with this patch.

	Also: If I read the code correctly, find_common() only sends
	"have" lines as long as it does not receive an "ACK" line,
	i.e. in effect git-fetch-pack sends only up to the first
	common revision (plus at most 31 others).

	That is all well if we are expecting only one upstream
	repository, but not in a truly distributed environment.

	Maybe it is time to revise that behaviour? For example,
	fetch-pack could stop when it is out of non-common revs,
	or when it got MAX_HAS "ACK" lines.

	Also, git-upload-pack could accept only up to a certain
	number of "have" lines.

 fetch-pack.c |  143 ++++++++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 109 insertions(+), 34 deletions(-)

applies-to: 50f9bed9a78e1f51178ebf6be3cd9c20b2ffcb0b
2b5886e2198ea4b8403839b7188e8ad9e6f1713b
diff --git a/fetch-pack.c b/fetch-pack.c
index 8566ab1..cdde008 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -13,18 +13,110 @@ static const char fetch_pack_usage[] =
 static const char *exec = "git-upload-pack";
 
 #define COMPLETE	(1U << 0)
+#define COMMON		(1U << 1)
+#define COMMON_REF	(1U << 2)
+#define TO_SCAN		(1U << 3)
+
+struct commit_list *rev_list = NULL;
+
+/*
+   Unfortunately, we want not only commits, but sometimes also tags.
+*/
+
+static struct commit *fake_commit(struct object *object) {
+	struct commit *ret;
+
+	if (object->type == commit_type)
+		return (struct commit *)object;
+
+	ret = xmalloc(sizeof(struct commit));
+
+	memset(ret, 0, sizeof(struct commit));
+	ret->object = *object;
+
+	/* insert_by_date() shall put it at the end */
+	ret->date = 0;
+
+	return ret;
+}
+
+static int rev_list_insert(const char *path, const unsigned char *sha1)
+{
+	struct commit *commit  = fake_commit(parse_object(sha1));
+
+	/*
+	   Local heads are much more likely to be common, so send them first.
+	*/
+	if (commit->object.type == commit_type)
+		commit_list_insert(commit, &rev_list);
+	else {
+		insert_by_date(commit, &rev_list);
+
+		if (commit->object.type == tag_type) {
+			/* This commit has been faked. Reget. */
+			struct object *o = lookup_object(commit->object.sha1);
+			o = deref_tag(o);
+			if (o->type == commit_type)
+				insert_by_date((struct commit *)o, &rev_list);
+		}
+	}
+
+	return 0;
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
+
+		if (rev_list == NULL)
+			return NULL;
+
+		commit = rev_list->item;
+
+		if (commit->object.flags&COMMON) {
+			/* do not send "have", and ignore ancestors */
+			commit = NULL;
+			mark = COMMON | TO_SCAN;
+		} else if (commit->object.flags&COMMON_REF)
+			/* send "have", and ignore ancestors */
+			mark = COMMON | TO_SCAN;
+		else
+			/* send "have", also for ancestors, until one is ack'ed */
+			mark = TO_SCAN;
+
+		pop_most_recent_commit(&rev_list, mark);
+	}
+
+	return commit->object.sha1;
+}
+
+static void mark_common(const unsigned char* sha1)
+{
+	struct object *o = lookup_object(sha1);
+
+	if (o != NULL && !(o->flags&COMMON)) {
+		o->flags |= COMMON;
+		if (o->type == commit_type)
+			insert_by_date((struct commit *)o, &rev_list);
+	}
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
+	for_each_ref(rev_list_insert);
 
-	strcpy(rev_command, "git-rev-list $(git-rev-parse --all)");
-	rev_command_len = strlen(rev_command);
 	fetching = 0;
 	for ( ; refs ; refs = refs->next) {
 		unsigned char *remote = refs->old_sha1;
@@ -42,25 +134,11 @@ static int find_common(int fd[2], unsign
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
+			o->flags |= COMMON_REF | TO_SCAN;
+			commit_list_insert(fake_commit(o), &rev_list);
 			continue;
 		}
-	repair:
+
 		packet_write(fd[1], "want %s\n", sha1_to_hex(remote));
 		fetching++;
 	}
@@ -68,21 +146,16 @@ static int find_common(int fd[2], unsign
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
 		if (!(31 & ++count)) {
 			packet_flush(fd[1]);
+			if (verbose)
+				fprintf(stderr, "flush\n");
 			flushes++;
 
 			/*
@@ -92,16 +165,17 @@ static int find_common(int fd[2], unsign
 			if (count == 32)
 				continue;
 			if (get_ack(fd[0], result_sha1)) {
+				mark_common(result_sha1);
 				flushes = 0;
 				retval = 0;
 				if (verbose)
-					fprintf(stderr, "got ack\n");
+					fprintf(stderr, "got ack %s\n",
+						sha1_to_hex(result_sha1));
 				break;
 			}
 			flushes--;
 		}
 	}
-	pclose(revs);
 	packet_write(fd[1], "done\n");
 	if (verbose)
 		fprintf(stderr, "done\n");
@@ -109,7 +183,8 @@ static int find_common(int fd[2], unsign
 		flushes--;
 		if (get_ack(fd[0], result_sha1)) {
 			if (verbose)
-				fprintf(stderr, "got ack\n");
+				fprintf(stderr, "got ack %s\n",
+					sha1_to_hex(result_sha1));
 			return 0;
 		}
 	}
---
0.99.8.GIT
