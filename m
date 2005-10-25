From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Make fetch-pack play nicer with servers which do not speak
 multi_ack
Date: Tue, 25 Oct 2005 08:59:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510250854240.22398@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Oct 25 08:59:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUImC-0005nH-07
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 08:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbVJYG7N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 02:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbVJYG7N
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 02:59:13 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:10466 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751473AbVJYG7M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 02:59:12 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3FD8F13F348; Tue, 25 Oct 2005 08:59:09 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 190FF9AB68; Tue, 25 Oct 2005 08:59:09 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E8AB58E7B2; Tue, 25 Oct 2005 08:59:08 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id ADA6513F348; Tue, 25 Oct 2005 08:59:08 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10567>

Sort the refs by date again (but only the refs). This helps when the 
server does not support multi_ack, since the more likely candidates for 
common revs are the younger ones.

Also, it helps avoid traffic, as younger revs can have older revs as 
ancestors, but not vice versa. Therefore, when the server ack's a younger 
rev, chances are that the older rev never gets sent.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	Yesterday, I pulled from the git repository, and it wanted to give 
	me 961 objects! When analyzing this, I found out that my version 
	of git-fetch-pack sent the oldest refs first. The newest was never 
	sent, because the oldest was ack'ed right away.

 fetch-pack.c |   35 +++++++++++++++++++++++------------
 1 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 57602b9..3efa652 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -22,30 +22,41 @@ static struct commit_list *rev_list = NU
 static struct commit_list *rev_list_end = NULL;
 static unsigned long non_common_revs = 0;
 
-static void rev_list_append(struct commit *commit, int mark)
+static void rev_list_push(struct commit *commit, int mark,
+		int insert)
 {
 	if (!(commit->object.flags & mark)) {
 		commit->object.flags |= mark;
 
-		if (rev_list == NULL) {
+		if (insert)
+			insert_by_date(commit, &rev_list);
+		else
 			commit_list_insert(commit, &rev_list);
+
+		if (!rev_list_end)
 			rev_list_end = rev_list;
-		} else {
-			commit_list_insert(commit, &(rev_list_end->next));
+		else if (rev_list_end->next)
 			rev_list_end = rev_list_end->next;
-		}
 
 		if (!(commit->object.flags & COMMON))
 			non_common_revs++;
 	}
 }
 
-static int rev_list_append_sha1(const char *path, const unsigned char *sha1)
+/*
+   The refs are not just appended to the rev_list, but rather inserted
+   by date. It is just more efficient that way, since the edges of the
+   common commits are more likely to be recent than not.
+   Also, it makes fetch-pack plays nice with servers which do not
+   understand the multi_ack extension.
+*/
+
+static int rev_list_insert_ref(const char *path, const unsigned char *sha1)
 {
 	struct object *o = deref_tag(parse_object(sha1));
 
 	if (o->type == commit_type)
-		rev_list_append((struct commit *)o, SEEN);
+		rev_list_push((struct commit *)o, SEEN, 1);
 
 	return 0;
 }
@@ -56,7 +67,7 @@ static void mark_common(struct commit *c
 		struct object *o = (struct object *)commit;
 		o->flags |= COMMON;
 		if (!(o->flags & SEEN))
-			rev_list_append(commit, SEEN);
+			rev_list_push(commit, SEEN, 0);
 		else {
 			struct commit_list *parents;
 
@@ -111,7 +122,7 @@ static const unsigned char* get_rev()
 			if (mark & COMMON)
 				mark_common(parents->item);
 			else
-				rev_list_append(parents->item, mark);
+				rev_list_push(parents->item, mark, 0);
 			parents = parents->next;
 		}
 
@@ -128,7 +139,7 @@ static int find_common(int fd[2], unsign
 	int count = 0, flushes = 0, multi_ack = 0, retval;
 	const unsigned char *sha1;
 
-	for_each_ref(rev_list_append_sha1);
+	for_each_ref(rev_list_insert_ref);
 
 	fetching = 0;
 	for ( ; refs ; refs = refs->next) {
@@ -150,8 +161,8 @@ static int find_common(int fd[2], unsign
 			o = deref_tag(o);
 
 			if (o->type == commit_type)
-				rev_list_append((struct commit *)o,
-						COMMON_REF | SEEN);
+				rev_list_push((struct commit *)o,
+						COMMON_REF | SEEN, 1);
 
 			continue;
 		}
