From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-fetch: print informative messages to stdout, not stderr
Date: Fri, 26 Oct 2007 08:53:55 +0000
Message-ID: <20071026085355.24930.qmail@2c06371a7c3ae6.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 10:53:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlKwx-0006TB-Ux
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 10:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064AbXJZIxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 04:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753020AbXJZIxk
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 04:53:40 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:59618 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752957AbXJZIxj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 04:53:39 -0400
Received: (qmail 24931 invoked by uid 1000); 26 Oct 2007 08:53:55 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62403>

git-fetch writes informations about storing tags and the like to stderr,
which should only be used for errors.  This patch changes it to use
stdout instead.

This was noticed by Joey Hess and asked for through
 http://bugs.debian.org/447395

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 builtin-fetch.c |   32 ++++++++++++--------------------
 1 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index b9d2b0c..2dbfcb6 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -125,7 +125,7 @@ static struct ref *get_ref_map(struct transport *transport,
 
 static void show_new(enum object_type type, unsigned char *sha1_new)
 {
-	fprintf(stderr, "  %s: %s\n", typename(type),
+	printf("  %s: %s\n", typename(type),
 		find_unique_abbrev(sha1_new, DEFAULT_ABBREV));
 }
 
@@ -165,7 +165,7 @@ static int update_local_ref(struct ref *ref,
 	if (!*ref->name) {
 		/* Not storing */
 		if (verbose) {
-			fprintf(stderr, "* fetched %s\n", note);
+			printf("* fetched %s\n", note);
 			show_new(type, ref->new_sha1);
 		}
 		return 0;
@@ -173,8 +173,7 @@ static int update_local_ref(struct ref *ref,
 
 	if (!hashcmp(ref->old_sha1, ref->new_sha1)) {
 		if (verbose) {
-			fprintf(stderr, "* %s: same as %s\n",
-				ref->name, note);
+			printf("* %s: same as %s\n", ref->name, note);
 			show_new(type, ref->new_sha1);
 		}
 		return 0;
@@ -196,8 +195,7 @@ static int update_local_ref(struct ref *ref,
 
 	if (!is_null_sha1(ref->old_sha1) &&
 	    !prefixcmp(ref->name, "refs/tags/")) {
-		fprintf(stderr, "* %s: updating with %s\n",
-			ref->name, note);
+		printf("* %s: updating with %s\n", ref->name, note);
 		show_new(type, ref->new_sha1);
 		return s_update_ref("updating tag", ref, 0);
 	}
@@ -210,8 +208,7 @@ static int update_local_ref(struct ref *ref,
 			msg = "storing tag";
 		else
 			msg = "storing head";
-		fprintf(stderr, "* %s: storing %s\n",
-			ref->name, note);
+		printf("* %s: storing %s\n", ref->name, note);
 		show_new(type, ref->new_sha1);
 		return s_update_ref(msg, ref, 0);
 	}
@@ -220,23 +217,19 @@ static int update_local_ref(struct ref *ref,
 	strcpy(newh, find_unique_abbrev(ref->new_sha1, DEFAULT_ABBREV));
 
 	if (in_merge_bases(current, &updated, 1)) {
-		fprintf(stderr, "* %s: fast forward to %s\n",
-			ref->name, note);
-		fprintf(stderr, "  old..new: %s..%s\n", oldh, newh);
+		printf("* %s: fast forward to %s\n", ref->name, note);
+		printf("  old..new: %s..%s\n", oldh, newh);
 		return s_update_ref("fast forward", ref, 1);
 	}
 	if (!force && !ref->force) {
-		fprintf(stderr,
-			"* %s: not updating to non-fast forward %s\n",
+		printf("* %s: not updating to non-fast forward %s\n",
 			ref->name, note);
-		fprintf(stderr,
-			"  old...new: %s...%s\n", oldh, newh);
+		printf("  old...new: %s...%s\n", oldh, newh);
 		return 1;
 	}
-	fprintf(stderr,
-		"* %s: forcing update to non-fast forward %s\n",
+	printf("* %s: forcing update to non-fast forward %s\n",
 		ref->name, note);
-	fprintf(stderr, "  old...new: %s...%s\n", oldh, newh);
+	printf("  old...new: %s...%s\n", oldh, newh);
 	return s_update_ref("forced-update", ref, 1);
 }
 
@@ -368,8 +361,7 @@ static struct ref *find_non_local_tags(struct transport *transport,
 		if (!path_list_has_path(&existing_refs, ref_name) &&
 		    !path_list_has_path(&new_refs, ref_name) &&
 		    lookup_object(ref->old_sha1)) {
-			fprintf(stderr, "Auto-following %s\n",
-				ref_name);
+			printf("Auto-following %s\n", ref_name);
 
 			path_list_insert(ref_name, &new_refs);
 
-- 
1.5.3.4
