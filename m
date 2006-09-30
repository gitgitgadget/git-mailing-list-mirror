From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] refs: minor restructuring of cached refs data.
Date: Sat, 30 Sep 2006 12:49:03 -0700
Message-ID: <7vr6xtcez4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Sep 30 21:49:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTkpm-0004z3-Ou
	for gcvg-git@gmane.org; Sat, 30 Sep 2006 21:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbWI3TtH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Sep 2006 15:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbWI3TtH
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 15:49:07 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:9103 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751791AbWI3TtF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Sep 2006 15:49:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060930194904.FHVW6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Sat, 30 Sep 2006 15:49:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Ujp61V01S1kojtg0000000
	Sat, 30 Sep 2006 15:49:07 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28149>

Once we read packed and loose refs, for_each_ref() and friends
kept using them even after write_ref_sha1() and delete_ref()
changed the refs.  This adds invalidate_cached_refs() as a way
to flush the cached information.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * This should not change the behaviour of the existing code in
   any way, but is a necessary step to handle ref deletion
   correctly.

 refs.c |   56 +++++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index b433c0c..6ee5f96 100644
--- a/refs.c
+++ b/refs.c
@@ -66,12 +66,42 @@ static struct ref_list *add_ref(const ch
 	return list;
 }
 
-static struct ref_list *get_packed_refs(void)
+/*
+ * Future: need to be in "struct repository"
+ * when doing a full libification.
+ */
+struct cached_refs {
+	char did_loose;
+	char did_packed;
+	struct ref_list *loose;
+	struct ref_list *packed;
+} cached_refs;
+
+static void free_ref_list(struct ref_list *list)
+{
+	struct ref_list *next;
+	for ( ; list; list = next) {
+		next = list->next;
+		free(list);
+	}
+}
+
+static void invalidate_cached_refs(void)
 {
-	static int did_refs = 0;
-	static struct ref_list *refs = NULL;
+	struct cached_refs *ca = &cached_refs;
+
+	if (ca->did_loose && ca->loose)
+		free_ref_list(ca->loose);
+	if (ca->did_packed && ca->packed)
+		free_ref_list(ca->packed);
+	ca->loose = ca->packed = NULL;
+	ca->did_loose = ca->did_packed = 0;
+}
 
-	if (!did_refs) {
+static struct ref_list *get_packed_refs(void)
+{
+	if (!cached_refs.did_packed) {
+		struct ref_list *refs = NULL;
 		FILE *f = fopen(git_path("packed-refs"), "r");
 		if (f) {
 			struct ref_list *list = NULL;
@@ -86,9 +116,10 @@ static struct ref_list *get_packed_refs(
 			fclose(f);
 			refs = list;
 		}
-		did_refs = 1;
+		cached_refs.packed = refs;
+		cached_refs.did_packed = 1;
 	}
-	return refs;
+	return cached_refs.packed;
 }
 
 static struct ref_list *get_ref_dir(const char *base, struct ref_list *list)
@@ -138,14 +169,11 @@ static struct ref_list *get_ref_dir(cons
 
 static struct ref_list *get_loose_refs(void)
 {
-	static int did_refs = 0;
-	static struct ref_list *refs = NULL;
-
-	if (!did_refs) {
-		refs = get_ref_dir("refs", NULL);
-		did_refs = 1;
+	if (!cached_refs.did_loose) {
+		cached_refs.loose = get_ref_dir("refs", NULL);
+		cached_refs.did_loose = 1;
 	}
-	return refs;
+	return cached_refs.loose;
 }
 
 /* We allow "recursive" symbolic refs. Only within reason, though */
@@ -401,6 +429,7 @@ int delete_ref(const char *refname, unsi
 		fprintf(stderr, "warning: unlink(%s) failed: %s",
 			lock->log_file, strerror(errno));
 
+	invalidate_cached_refs();
 	return ret;
 }
 
@@ -665,6 +694,7 @@ int write_ref_sha1(struct ref_lock *lock
 		unlock_ref(lock);
 		return -1;
 	}
+	invalidate_cached_refs();
 	if (log_ref_write(lock, sha1, logmsg) < 0) {
 		unlock_ref(lock);
 		return -1;
-- 
1.4.2.1.g5a98f
