From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH 2/2] branch: Do not lookup commits when they will not be
 used
Date: Wed, 27 May 2009 15:24:41 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.0905271523541.24169@vinegar-pot.mit.edu>
References: <alpine.DEB.2.00.0905271518540.24169@vinegar-pot.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed May 27 21:24:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9Ok8-0007SK-FX
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 21:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbZE0TYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 15:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbZE0TYo
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 15:24:44 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:57647 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751144AbZE0TYn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2009 15:24:43 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n4RJOg3m015977;
	Wed, 27 May 2009 15:24:42 -0400 (EDT)
Received: from localhost (VINEGAR-POT.MIT.EDU [18.181.0.51])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n4RJOfYS007872;
	Wed, 27 May 2009 15:24:42 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.0905271518540.24169@vinegar-pot.mit.edu>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120097>

This makes `git branch` without -v, --merged, --no-merged, or --contains 
run about 5 times faster on an uncached repository (4 s intead of 18 s on 
my linux-2.6 repository with several remotes).

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 builtin-branch.c |   33 ++++++++++++++++++++-------------
 1 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 91098ca..7ca2834 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -195,6 +195,7 @@ struct ref_list {
 	struct ref_item *list;
 	struct commit_list *with_commit;
 	int kinds;
+	int lookup_commits;
 };
 
 static char *resolve_symref(const char *src, const char *prefix)
@@ -215,7 +216,7 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 {
 	struct ref_list *ref_list = (struct ref_list*)(cb_data);
 	struct ref_item *newitem;
-	struct commit *commit;
+	struct commit *commit = NULL;
 	int kind, i;
 	const char *prefix, *orig_refname = refname;
 
@@ -240,21 +241,25 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	if (ARRAY_SIZE(ref_kind) <= i)
 		return 0;
 
-	commit = lookup_commit_reference_gently(sha1, 1);
-	if (!commit)
-		return error("branch '%s' does not point at a commit", refname);
-
-	/* Filter with with_commit if specified */
-	if (!is_descendant_of(commit, ref_list->with_commit))
-		return 0;
-
 	/* Don't add types the caller doesn't want */
 	if ((kind & ref_list->kinds) == 0)
 		return 0;
 
-	if (merge_filter != NO_FILTER)
-		add_pending_object(&ref_list->revs,
-				   (struct object *)commit, refname);
+
+	if (ref_list->lookup_commits) {
+		commit = lookup_commit_reference_gently(sha1, 1);
+		if (!commit)
+			return error("branch '%s' does not point at a commit",
+				     refname);
+
+		/* Filter with with_commit if specified */
+		if (!is_descendant_of(commit, ref_list->with_commit))
+			return 0;
+
+		if (merge_filter != NO_FILTER)
+			add_pending_object(&ref_list->revs,
+					   (struct object *)commit, refname);
+	}
 
 	/* Resize buffer */
 	if (ref_list->index >= ref_list->alloc) {
@@ -426,7 +431,9 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
 	ref_list.with_commit = with_commit;
 	if (merge_filter != NO_FILTER)
 		init_revisions(&ref_list.revs, NULL);
-	for_each_ref(append_ref, &ref_list);
+	ref_list.lookup_commits =
+	    with_commit || merge_filter != NO_FILTER || verbose;
+	for_each_rawref(append_ref, &ref_list);
 	if (merge_filter != NO_FILTER) {
 		struct commit *filter;
 		filter = lookup_commit_reference_gently(merge_filter_ref, 0);
-- 
1.6.3.1
