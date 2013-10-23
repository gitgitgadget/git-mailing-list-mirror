From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 06/15] ref_remove_duplicates(): avoid redundant bisection
Date: Wed, 23 Oct 2013 17:50:39 +0200
Message-ID: <1382543448-2586-7-git-send-email-mhagger@alum.mit.edu>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 17:52:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ0jE-00025n-So
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 17:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412Ab3JWPwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 11:52:06 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42198 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751674Ab3JWPwE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Oct 2013 11:52:04 -0400
X-AuditID: 12074414-b7fb46d000002a4d-63-5267f0a2359a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 5A.D2.10829.2A0F7625; Wed, 23 Oct 2013 11:52:02 -0400 (EDT)
Received: from localhost.localdomain (p57A247B5.dip0.t-ipconnect.de [87.162.71.181])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9NFpLsx009100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 Oct 2013 11:51:59 -0400
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqLvoQ3qQwfXtQhbTu1azWHRd6Way
	aOi9wmwx7+4uJotVt5YxW6yccYPR4vaK+cwWTzsrLea9eMFm8aOlh9mBy+Pv+w9MHpfWvWTy
	OPRnCrvHsxPtbB6XXn5n83jWu4fR4+IlZY8ZLa9ZPD5vkvM4cPkxWwBXFLdNUmJJWXBmep6+
	XQJ3xuqd19kLFilULHh9mb2B8ZBkFyMnh4SAicTzT1OZIGwxiQv31rN1MXJxCAlcZpS4tn8r
	O4RzhUli5+2pjCBVbAK6Eot6msE6RATUJCa2HWIBKWIWmMgscXz6IhaQhLCAp8SWUzPAilgE
	VCWu/N7NBmLzCjhLNLT/AqrhAFonJ/HwWyxImFPAReLC8emsILYQUMmEhVPZJzDyLmBkWMUo
	l5hTmqubm5iZU5yarFucnJiXl1qka6GXm1mil5pSuokRErYiOxiPnJQ7xCjAwajEw/ugJS1I
	iDWxrLgy9xCjJAeTkijvnHfpQUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeHfcBcrxpiRWVqUW
	5cOkpDlYlMR5vy1W9xMSSE8sSc1OTS1ILYLJynBwKEnwur4HahQsSk1PrUjLzClBSDNxcIII
	LpANPEAbYkAKeYsLEnOLM9Mhik4xKkqJ8zaAJARAEhmleXADYAnmFaM40D/CvIkgVTzA5ATX
	/QpoMBPQ4ClL0kAGlyQipKQaGJWmPjqfLz11X8dGwyqrNxx5IcdPVHm5MMu2/TmVt/exn0J5
	NOvO7lcruOdqlKzRUpt9eb/Pp997wtZ8NipMl3jq8ujckeRnq1f4xfze8S20XSpE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236516>

The old code called string_list_lookup(), and if that failed called
string_list_insert(), thus doing the bisection search through the
string list twice in the latter code path.

Instead, just call string_list_insert() right away.  If an entry for
that peer reference name already existed, then its util pointer is
always non-NULL.

Of course this doesn't change the fact that the repeated
string_list_insert() calls make the function scale like O(N^2) if the
input reference list is not already approximately sorted.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

The O(N^2) algorithm mentioned above essentially boils down to

    for each reference:
        insert reference into string_list (sorted)

Because the insertion requires later array entries to be shifted to
the right, the algorithm scales like O(N^2) if the entries are not
already approximately in order.

I can think of three easy ways to fix this:

* Use a hash map instead of a sorted string_list to record which
  entries have already been seen.

* If the order of the result doesn't matter and it doesn't matter
  *which* of the duplicates is retained, then insert all of the names
  into the string_list unsorted, then sort them all in one go, then
  iterate through looking for duplicates and stringing the survivors
  together in a new linked list.

* If the order is important, or it is important that the *first* of
  duplicates be retained, then iterate through the linked list twice.
  The first time, just add the entries to the string_list.  Then sort
  the string_list using a stable sort (e.g., git_qsort()).  Then
  iterate through the linked list a second time as in the current
  code.

See also my comments to commit 10.

However, I believe that the O(N^2) worst case is unlikely to bite in
most cases.  This function is called from
builtin/fetch.c:get_ref_map(), and the input list is the concatenation
of several sub-lists.  Most sublists come from resolving refspecs, and
the last comes from find_non_local_tags().  I believe that each of the
sublists is sorted.  So the O(N^2) worst-case could only occur if more
than one of the sublists is large and at least two of the large
sublists are not in the correct order relative to each other.

I tried to concoct such a test case by creating a repository with
about 20k branches and 20k tags, instrumenting
ref_remove_duplicates(), and then fetching with something like

    git fetch --prune origin refs/heads/*:refs/remotes/origin/* \
                             refs/tags/*:refs/tags/*

Indeed, the running time of ref_remove_duplicates() became significant
when the order of the refspecs was reversed, but it was still less
than a second out of a much longer command invocation.

So I didn't bother fixing the O(N^2) algorithm.  If somebody reports
real-world slowness here, we can always come back to it.

 remote.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/remote.c b/remote.c
index e9fedfa..a44e897 100644
--- a/remote.c
+++ b/remote.c
@@ -750,13 +750,15 @@ void ref_remove_duplicates(struct ref *ref_map)
 	struct string_list refs = STRING_LIST_INIT_NODUP;
 	struct string_list_item *item = NULL;
 	struct ref *prev = NULL, *next = NULL;
+
 	for (; ref_map; prev = ref_map, ref_map = next) {
 		next = ref_map->next;
 		if (!ref_map->peer_ref)
 			continue;
 
-		item = string_list_lookup(&refs, ref_map->peer_ref->name);
-		if (item) {
+		item = string_list_insert(&refs, ref_map->peer_ref->name);
+		if (item->util) {
+			/* Entry already existed */
 			if (strcmp(((struct ref *)item->util)->name,
 				   ref_map->name))
 				die("%s tracks both %s and %s",
@@ -767,11 +769,9 @@ void ref_remove_duplicates(struct ref *ref_map)
 			free(ref_map->peer_ref);
 			free(ref_map);
 			ref_map = prev; /* skip this; we freed it */
-			continue;
+		} else {
+			item->util = ref_map;
 		}
-
-		item = string_list_insert(&refs, ref_map->peer_ref->name);
-		item->util = ref_map;
 	}
 	string_list_clear(&refs, 0);
 }
-- 
1.8.4
