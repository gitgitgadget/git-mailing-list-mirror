From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/8] Make maximal use of the remote refs
Date: Fri, 28 Oct 2005 04:47:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510280446410.20516@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Oct 28 04:48:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVKGu-0000ba-FC
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 04:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbVJ1CrJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 22:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbVJ1CrJ
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 22:47:09 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:37071 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965064AbVJ1CrI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 22:47:08 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 82E6913F2ED; Fri, 28 Oct 2005 04:47:07 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5A9849EFCF; Fri, 28 Oct 2005 04:47:07 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3BF039EFC9; Fri, 28 Oct 2005 04:47:07 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 34FAF13F2ED; Fri, 28 Oct 2005 04:47:07 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10745>


When git-fetch-pack gets the remote refs, it does not need to filter them
right away, but it can see which refs are common (taking advantage of the
patch which makes git-fetch-pack not use git-rev-list).

This means that we ask get_remote_heads() to return all remote refs,
including the funny refs, and filtering them with a separate function later.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 fetch-pack.c |   72 ++++++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 52 insertions(+), 20 deletions(-)

applies-to: 828f6fc88faefd10f2b09b11a2758afde21049c7
c3c4f518f0174292917d01734f58a57b6eb9871e
diff --git a/fetch-pack.c b/fetch-pack.c
index 3be77c3..b584264 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -153,16 +153,7 @@ static int find_common(int fd[2], unsign
 		 * reachable and we have already scanned it.
 		 */
 		if (((o = lookup_object(remote)) != NULL) &&
-		    (o->flags & COMPLETE)) {
-			o = deref_tag(o);
-
-			if (o->type == commit_type) {
-				struct commit *commit = (struct commit *)o;
-
-				rev_list_push(commit, COMMON_REF | SEEN);
-
-				mark_common(commit, 1, 1);
-			}
+				(o->flags & COMPLETE)) {
 			continue;
 		}
 
@@ -247,7 +238,29 @@ static void mark_recent_complete_commits
 	}
 }
 
-static int everything_local(struct ref *refs)
+static void filter_refs(struct ref **refs, int nr_match, char **match)
+{
+	struct ref *prev, *current, *next;
+
+	if (!nr_match)
+		return;
+
+	for (prev = NULL, current = *refs; current; current = next) {
+		next = current->next;
+		if ((!memcmp(current->name, "refs/", 5) &&
+					check_ref_format(current->name + 5)) ||
+				!path_match(current->name, nr_match, match)) {
+			if (prev == NULL)
+				*refs = next;
+			else
+				prev->next = next;
+			free(current);
+		} else
+			prev = current;
+	}
+}
+
+static int everything_local(struct ref **refs, int nr_match, char **match)
 {
 	struct ref *ref;
 	int retval;
@@ -256,7 +269,7 @@ static int everything_local(struct ref *
 	track_object_refs = 0;
 	save_commit_buffer = 0;
 
-	for (ref = refs; ref; ref = ref->next) {
+	for (ref = *refs; ref; ref = ref->next) {
 		struct object *o;
 
 		o = parse_object(ref->old_sha1);
@@ -278,28 +291,47 @@ static int everything_local(struct ref *
 	if (cutoff)
 		mark_recent_complete_commits(cutoff);
 
-	for (retval = 1; refs ; refs = refs->next) {
-		const unsigned char *remote = refs->old_sha1;
+	/*
+	 * Mark all complete remote refs as common refs.
+	 * Don't mark them common yet; the server has to be told so first.
+	 */
+	for (ref = *refs; ref; ref = ref->next) {
+		struct object *o = deref_tag(lookup_object(ref->old_sha1));
+
+		if (!o || o->type != commit_type || !(o->flags & COMPLETE))
+			continue;
+
+		if (!(o->flags & SEEN)) {
+			rev_list_push((struct commit *)o, COMMON_REF | SEEN);
+
+			mark_common((struct commit *)o, 1, 1);
+		}
+	}
+
+	filter_refs(refs, nr_match, match);
+
+	for (retval = 1, ref = *refs; ref ; ref = ref->next) {
+		const unsigned char *remote = ref->old_sha1;
 		unsigned char local[20];
 		struct object *o;
 
-		o = parse_object(remote);
+		o = lookup_object(remote);
 		if (!o || !(o->flags & COMPLETE)) {
 			retval = 0;
 			if (!verbose)
 				continue;
 			fprintf(stderr,
 				"want %s (%s)\n", sha1_to_hex(remote),
-				refs->name);
+				ref->name);
 			continue;
 		}
 
-		memcpy(refs->new_sha1, local, 20);
+		memcpy(ref->new_sha1, local, 20);
 		if (!verbose)
 			continue;
 		fprintf(stderr,
 			"already have %s (%s)\n", sha1_to_hex(remote),
-			refs->name);
+			ref->name);
 	}
 	return retval;
 }
@@ -311,12 +343,12 @@ static int fetch_pack(int fd[2], int nr_
 	int status;
 	pid_t pid;
 
-	get_remote_heads(fd[0], &ref, nr_match, match, 1);
+	get_remote_heads(fd[0], &ref, 0, NULL, 0);
 	if (!ref) {
 		packet_flush(fd[1]);
 		die("no matching remote head");
 	}
-	if (everything_local(ref)) {
+	if (everything_local(&ref, nr_match, match)) {
 		packet_flush(fd[1]);
 		goto all_done;
 	}
---
0.99.8.GIT
