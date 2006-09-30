From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/6] refs: minor restructuring of cached refs data.
Date: Sat, 30 Sep 2006 15:30:06 -0700
Message-ID: <7vr6xt9edt.fsf@assigned-by-dhcp.cox.net>
References: <20060930220158.d331bb7c.chriscool@tuxfamily.org>
	<7vmz8hccxl.fsf@assigned-by-dhcp.cox.net>
	<7v1wptc7ou.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Oct 01 00:30:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTnLe-0002ri-NH
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 00:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbWI3WaL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Sep 2006 18:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWI3WaL
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 18:30:11 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:34544 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751519AbWI3WaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Sep 2006 18:30:09 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060930223009.NQVD16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Sat, 30 Sep 2006 18:30:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UmWA1V0071kojtg0000000
	Sat, 30 Sep 2006 18:30:11 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28157>

Once we read packed and loose refs, for_each_ref() and friends
kept using them even after write_ref_sha1() and delete_ref()
changed the refs.  This adds invalidate_cached_refs() as a way
to flush the cached information.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * This and the previous one are essentially the same as my previous
   two patch series.

   getting rid of "we run only once" mentality.  otherwise we
   can never libify the thing...

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
