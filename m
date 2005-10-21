From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Do not call git-rev-list from git-fetch-pack
Date: Fri, 21 Oct 2005 04:15:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510210413210.26388@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Oct 21 04:17:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESmRy-0005h6-HE
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 04:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbVJUCPz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 22:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbVJUCPz
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 22:15:55 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:22681 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964842AbVJUCPy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 22:15:54 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 797B013EBC1; Fri, 21 Oct 2005 04:15:53 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 527259EF50; Fri, 21 Oct 2005 04:15:53 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2F42B9EDBD; Fri, 21 Oct 2005 04:15:53 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1B20513EBC1; Fri, 21 Oct 2005 04:15:53 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10406>

It is much easier to avoid sending unneeded data when putting the rev list
together in a customized manner. In particular, the tips of the local
branches are sent first, and only then their ancestors.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	This supersedes my earlier attempt. SHA1s of tags are no longer
	sent via "have" lines. This makes the code much simpler. Also,
	it does not buy us much to send them:

	Either we have the tag object already, pointed to by a ref (thus 
	not "want"ing it in the first place), or we fetch at most
	a couple of tag objects we already have.

 fetch-pack.c |  139 ++++++++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 106 insertions(+), 33 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 8566ab1..260de90 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -13,18 +13,102 @@ static const char fetch_pack_usage[] =
 static const char *exec = "git-upload-pack";
 
 #define COMPLETE	(1U << 0)
+#define COMMON		(1U << 1)
+#define COMMON_REF	(1U << 2)
+#define SEEN		(1U << 3)
+
+struct commit_list *rev_list = NULL;
+
+static int rev_list_insert(const char *path, const unsigned char *sha1)
+{
+	struct object *o = deref_tag(parse_object(sha1));
+
+	/*
+	   The real problem is that find_common will stop very soon
+	   after seeing a common revision.
+
+	   However, that does not always make sense. Example:
+
+	   Branch1 has 40 commits since it last merged with branch2,
+	   and branch2 has 2 more commits since then.
+
+	   On the other end, branch1 is up-to-date, but branch2 is not.
+	   When fetching branch1, the 40 commits get sent, the first
+	   is acknowledged as common, and the local head of branch2
+	   never gets sent.
+
+	   As a consequence, the whole history of branch2
+	   (git-rev-list branch2 ^branch1) gets packed and transmitted.
+
+	   The workaround is to pretend that the tips of the local
+	   branches are 10 years younger, so that they are sent before
+	   everything else.
+	*/
+
+	if (o->type == commit_type && !(o->flags & SEEN)) {
+		struct commit *commit = (struct commit *)o;
+		o->flags |= SEEN;
+		/* The head's tips get handled before everything else. */
+		commit->date += 10*365*86400;
+		insert_by_date(commit, &rev_list);
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
+	if (o != NULL && !(o->flags & COMMON)) {
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
@@ -42,25 +126,17 @@ static int find_common(int fd[2], unsign
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
+			o = deref_tag(o);
+			o->flags |= COMMON_REF;
+
+			if (o->type == commit_type && !(o->flags & SEEN)) {
+				o->flags |= SEEN;
+				insert_by_date((struct commit *)o, &rev_list);
 			}
+
 			continue;
 		}
-	repair:
+
 		packet_write(fd[1], "want %s\n", sha1_to_hex(remote));
 		fetching++;
 	}
@@ -68,21 +144,16 @@ static int find_common(int fd[2], unsign
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
@@ -92,16 +163,17 @@ static int find_common(int fd[2], unsign
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
@@ -109,7 +181,8 @@ static int find_common(int fd[2], unsign
 		flushes--;
 		if (get_ack(fd[0], result_sha1)) {
 			if (verbose)
-				fprintf(stderr, "got ack\n");
+				fprintf(stderr, "got ack %s\n",
+					sha1_to_hex(result_sha1));
 			return 0;
 		}
 	}
