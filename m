From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 11/17] object_array: add function object_array_filter()
Date: Sun, 19 May 2013 22:27:06 +0200
Message-ID: <1368995232-11042-12-git-send-email-mhagger@alum.mit.edu>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 19 22:28:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeADY-0004ax-5H
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 22:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805Ab3ESU2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 16:28:16 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:63557 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754167Ab3ESU2N (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 16:28:13 -0400
X-AuditID: 12074414-b7fb86d000000905-4c-519935dcb517
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 84.59.02309.CD539915; Sun, 19 May 2013 16:28:12 -0400 (EDT)
Received: from michael.fritz.box (p57A25040.dip0.t-ipconnect.de [87.162.80.64])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4JKRX5U026019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 19 May 2013 16:28:11 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqHvHdGagwZFrJhZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYHVg9/r7/wORx6eV3No9nvXsYPS5eUvb4vEkugDWK2yYpsaQsODM9
	T98ugTtj3bb5jAVTZSu+zjjE3MD4TLyLkZNDQsBEonNPHyuELSZx4d56ti5GLg4hgcuMEv++
	LWGFcM4zSfxac5kJpIpNQFdiUU8zmC0iICvx/fBGRhCbWWACo8TS/sIuRg4OYQF3iemreUHC
	LAKqEv939ICV8wq4SvzduJUFYpmCxOVZa5hBbE6g+Jb2XWBHCAm4SPzrv806gZF3ASPDKka5
	xJzSXN3cxMyc4tRk3eLkxLy81CJdC73czBK91JTSTYyQkBLZwXjkpNwhRgEORiUe3oYP0wOF
	WBPLiitzDzFKcjApifIuV50ZKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEd48QUI43JbGyKrUo
	HyYlzcGiJM77bbG6n5BAemJJanZqakFqEUxWhoNDSYLX3QSoUbAoNT21Ii0zpwQhzcTBCSK4
	QDbwAG1YBFLIW1yQmFucmQ5RdIpRUUqc9yJIQgAkkVGaBzcAFv2vGMWB/hHmPQJSxQNMHHDd
	r4AGMwENZr02FWRwSSJCSqqBcWHfcf7Jp1W7NI8t7jHd8eLf9kM+v6cVfMw72752Utqdx/oM
	13rznWX+TY6v3v5Vf9qCjzWzDm9z9GL4+edTifTdJ7MeC9Y/KTTl3vfmS9+bE9qhAvfUjmXV
	uLkYnnMxPvvuhW7ATVPdCQUBEV5RT5X/lMzQlDNQXnrln1q/3E+/2wd2dOxkFlRi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224912>

Add a function that allows unwanted entries in an object_array to be
removed.  This encapsulation is a step towards giving object_array
ownership of its entries' name memory.

Use the new function to replace revision.c:gc_boundary().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 object.c   | 16 ++++++++++++++++
 object.h   | 11 +++++++++++
 revision.c | 28 ++++++++++------------------
 3 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/object.c b/object.c
index 20703f5..fcd4a82 100644
--- a/object.c
+++ b/object.c
@@ -278,6 +278,22 @@ void add_object_array_with_mode(struct object *obj, const char *name, struct obj
 	array->nr = ++nr;
 }
 
+void object_array_filter(struct object_array *array,
+			 object_array_each_func_t want, void *cb_data)
+{
+	unsigned nr = array->nr, src, dst;
+	struct object_array_entry *objects = array->objects;
+
+	for (src = dst = 0; src < nr; src++) {
+		if (want(&objects[src], cb_data)) {
+			if (src != dst)
+				objects[dst] = objects[src];
+			dst++;
+		}
+	}
+	array->nr = dst;
+}
+
 void object_array_remove_duplicates(struct object_array *array)
 {
 	unsigned int ref, src, dst;
diff --git a/object.h b/object.h
index 97d384b..0d39ff4 100644
--- a/object.h
+++ b/object.h
@@ -85,6 +85,17 @@ int object_list_contains(struct object_list *list, struct object *obj);
 /* Object array handling .. */
 void add_object_array(struct object *obj, const char *name, struct object_array *array);
 void add_object_array_with_mode(struct object *obj, const char *name, struct object_array *array, unsigned mode);
+
+typedef int (*object_array_each_func_t)(struct object_array_entry *, void *);
+
+/*
+ * Apply want to each entry in array, retaining only the entries for
+ * which the function returns true.  Preserve the order of the entries
+ * that are retained.
+ */
+void object_array_filter(struct object_array *array,
+			 object_array_each_func_t want, void *cb_data);
+
 void object_array_remove_duplicates(struct object_array *);
 
 void clear_object_flags(unsigned flags);
diff --git a/revision.c b/revision.c
index 19c59f4..ddc6d7c 100644
--- a/revision.c
+++ b/revision.c
@@ -2435,23 +2435,6 @@ static struct commit *get_revision_1(struct rev_info *revs)
 	return NULL;
 }
 
-static void gc_boundary(struct object_array *array)
-{
-	unsigned nr = array->nr, i, j;
-	struct object_array_entry *objects = array->objects;
-
-	for (i = j = 0; i < nr; i++) {
-		if (objects[i].item->flags & SHOWN)
-			continue;
-		if (i != j)
-			objects[j] = objects[i];
-		j++;
-	}
-	for (i = j; i < nr; i++)
-		objects[i].item = NULL;
-	array->nr = j;
-}
-
 static void create_boundary_commit_list(struct rev_info *revs)
 {
 	unsigned i;
@@ -2493,6 +2476,15 @@ static void create_boundary_commit_list(struct rev_info *revs)
 	sort_in_topological_order(&revs->commits, revs->lifo);
 }
 
+/*
+ * Return true for entries that have not yet been shown.  (This is an
+ * object_array_each_func_t.)
+ */
+static int entry_unshown(struct object_array_entry *entry, void *cb_data_unused)
+{
+	return !(entry->item->flags & SHOWN);
+}
+
 static struct commit *get_revision_internal(struct rev_info *revs)
 {
 	struct commit *c = NULL;
@@ -2575,7 +2567,7 @@ static struct commit *get_revision_internal(struct rev_info *revs)
 		p->flags |= CHILD_SHOWN;
 		if (revs->boundary_commits.nr == revs->boundary_commits.alloc) {
 			/* Try to make space and thereby avoid a realloc(): */
-			gc_boundary(&revs->boundary_commits);
+			object_array_filter(&revs->boundary_commits, entry_unshown, NULL);
 		}
 		add_object_array(p, NULL, &revs->boundary_commits);
 	}
-- 
1.8.2.3
