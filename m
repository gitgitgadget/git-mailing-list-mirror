From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Do not call git-rev-list from git-fetch-pack
Date: Fri, 21 Oct 2005 23:08:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510212308060.8227@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510210413210.26388@wbgn013.biozentrum.uni-wuerzburg.de>
 <7virvrw8w1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510211111440.4950@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0510211618420.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 23:09:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ET48N-0000wf-Kz
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 23:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbVJUVI7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 17:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVJUVI7
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 17:08:59 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:49052 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751145AbVJUVI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2005 17:08:58 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CA12113F0E4; Fri, 21 Oct 2005 23:08:57 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AFA589EF72; Fri, 21 Oct 2005 23:08:57 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 891A29EEC4; Fri, 21 Oct 2005 23:08:57 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2959313F0E4; Fri, 21 Oct 2005 23:08:55 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0510211618420.25300@iabervon.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10449>

Hi,

here comes a WIP on that patch (needs to be tested lots more):

 fetch-pack.c |  154 ++++++++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 117 insertions(+), 37 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 8566ab1..33ce435 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -13,18 +13,109 @@ static const char fetch_pack_usage[] =
 static const char *exec = "git-upload-pack";
 
 #define COMPLETE	(1U << 0)
+#define COMMON		(1U << 1)
+#define COMMON_REF	(1U << 2 | COMMON)
+#define SEEN		(1U << 3)
+#define POPPED		(1U << 4)
+#define MAX_HAS (16)
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
+static void mark_common(struct object *o)
+{
+	if (o != NULL && !(o->flags & COMMON)) {
+		o->flags |= COMMON;
+		if (!(o->flags & SEEN))
+			rev_list_append((struct commit *)o, SEEN);
+		else if (!(o->flags & POPPED))
+			non_common_revs--;
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
+				mark_common((struct object *)parents->item);
+			else
+				rev_list_append(parents->item, mark);
+			parents = parents->next;
+		}
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
+	int count = 0, flushes = 0, ack_count = 0, retval;
+	const unsigned char *sha1;
+
+	for_each_ref(rev_list_append_sha1);
 
-	strcpy(rev_command, "git-rev-list $(git-rev-parse --all)");
-	rev_command_len = strlen(rev_command);
 	fetching = 0;
 	for ( ; refs ; refs = refs->next) {
 		unsigned char *remote = refs->old_sha1;
@@ -42,25 +133,15 @@ static int find_common(int fd[2], unsign
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
@@ -68,21 +149,16 @@ static int find_common(int fd[2], unsign
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
@@ -92,16 +168,19 @@ static int find_common(int fd[2], unsign
 			if (count == 32)
 				continue;
 			if (get_ack(fd[0], result_sha1)) {
-				flushes = 0;
-				retval = 0;
+				mark_common(lookup_object(result_sha1));
 				if (verbose)
-					fprintf(stderr, "got ack\n");
-				break;
+					fprintf(stderr, "got ack %s\n",
+							sha1_to_hex(result_sha1));
+				if (++ack_count > MAX_HAS) {
+					flushes = 0;
+					retval = 0;
+					break;
+				}
 			}
 			flushes--;
 		}
 	}
-	pclose(revs);
 	packet_write(fd[1], "done\n");
 	if (verbose)
 		fprintf(stderr, "done\n");
@@ -109,7 +188,8 @@ static int find_common(int fd[2], unsign
 		flushes--;
 		if (get_ack(fd[0], result_sha1)) {
 			if (verbose)
-				fprintf(stderr, "got ack\n");
+				fprintf(stderr, "got ack %s\n",
+					sha1_to_hex(result_sha1));
 			return 0;
 		}
 	}
