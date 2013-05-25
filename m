From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 05/25] cmd_diff(): use an object_array for holding trees
Date: Sat, 25 May 2013 11:08:04 +0200
Message-ID: <1369472904-12875-6-git-send-email-mhagger@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johan Herland <johan@herland.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 25 11:09:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgATT-00052T-DF
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 11:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465Ab3EYJJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 05:09:08 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:52887 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752678Ab3EYJJA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 05:09:00 -0400
X-AuditID: 1207440d-b7fd06d000000905-77-51a07facc0fb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 6E.12.02309.CAF70A15; Sat, 25 May 2013 05:09:00 -0400 (EDT)
Received: from michael.fritz.box (p4FDD49F3.dip0.t-ipconnect.de [79.221.73.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4P98guf000489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 May 2013 05:08:58 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqLumfkGgwdrDchZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLe5eXsXuwObx9/0HJo9LL7+zedx+PZ/Z41nvHkaPi5eUPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgzlhzuLRgumTFjRkcDYy7hbsYOTkkBEwk9iyYywhhi0lcuLeerYuR
	i0NI4DKjxJuON2wgCSGBC0wSva02IDabgK7Eop5mJhBbRMBR4sSD66wgDcwCvYwSDx99B0sI
	C3hLzL+xiB3EZhFQlTi56RILiM0r4CLx6WkzC8Q2BYnLs9YwdzFycHAKuEq8PcEJsctF4vmn
	c6wTGHkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI10svNLNFLTSndxAgJMd4djP/XyRxi
	FOBgVOLh3VEyP1CINbGsuDL3EKMkB5OSKC9/7YJAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8
	DClAOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBK9HHVCjYFFqempF
	WmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCgq4ouBcQGS4gHaGwjSzltckJgLFIVoPcWoy7H5
	/OR3jEIsefl5qVLivBNBigRAijJK8+BWwBLKK0ZxoI+FeVNAqniAyQhu0iugJUxAS27mzgdZ
	UpKIkJJqYJQIcztyy+qOUN+s8x8W9cZenz1beOL/5HhhzZKUpXcqH1q+/VLRIXWlx6qlZ+/W
	xJqGzreln0V2KnxrUV6evS7M5zzT0oVLphi9DxHY3ulrs/i65dPIF9sDXHS8RZ7c 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225496>

Change cmd_diff() to use a (struct object_array) for holding the trees
that it accumulates, rather than rolling its own equivalent.

Incidentally, this change removes a hard-coded limit of 100 trees in
combined diff, not that it matters in practice.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/diff.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index abdd613..661fdde 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -253,8 +253,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	struct rev_info rev;
-	struct object_array_entry ent[100];
-	int ents = 0, blobs = 0, paths = 0;
+	struct object_array ent = OBJECT_ARRAY_INIT;
+	int blobs = 0, paths = 0;
 	const char *path = NULL;
 	struct blobinfo blob[2];
 	int nongit;
@@ -351,13 +351,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		if (obj->type == OBJ_COMMIT)
 			obj = &((struct commit *)obj)->tree->object;
 		if (obj->type == OBJ_TREE) {
-			if (ARRAY_SIZE(ent) <= ents)
-				die(_("more than %d trees given: '%s'"),
-				    (int) ARRAY_SIZE(ent), name);
 			obj->flags |= flags;
-			ent[ents].item = obj;
-			ent[ents].name = name;
-			ents++;
+			add_object_array(obj, name, &ent);
 			continue;
 		}
 		if (obj->type == OBJ_BLOB) {
@@ -381,7 +376,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	/*
 	 * Now, do the arguments look reasonable?
 	 */
-	if (!ents) {
+	if (!ent.nr) {
 		switch (blobs) {
 		case 0:
 			result = builtin_diff_files(&rev, argc, argv);
@@ -402,22 +397,26 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	}
 	else if (blobs)
 		usage(builtin_diff_usage);
-	else if (ents == 1)
+	else if (ent.nr == 1)
 		result = builtin_diff_index(&rev, argc, argv);
-	else if (ents == 2)
-		result = builtin_diff_tree(&rev, argc, argv, &ent[0], &ent[1]);
-	else if (ent[0].item->flags & UNINTERESTING) {
+	else if (ent.nr == 2)
+		result = builtin_diff_tree(&rev, argc, argv,
+					   &ent.objects[0], &ent.objects[1]);
+	else if (ent.objects[0].item->flags & UNINTERESTING) {
 		/*
 		 * diff A...B where there is at least one merge base
-		 * between A and B.  We have ent[0] == merge-base,
-		 * ent[ents-2] == A, and ent[ents-1] == B.  Show diff
-		 * between the base and B.  Note that we pick one
-		 * merge base at random if there are more than one.
+		 * between A and B.  We have ent.objects[0] ==
+		 * merge-base, ent.objects[ents-2] == A, and
+		 * ent.objects[ents-1] == B.  Show diff between the
+		 * base and B.  Note that we pick one merge base at
+		 * random if there are more than one.
 		 */
-		result = builtin_diff_tree(&rev, argc, argv, &ent[0], &ent[ents-1]);
+		result = builtin_diff_tree(&rev, argc, argv,
+					   &ent.objects[0],
+					   &ent.objects[ent.nr-1]);
 	} else
 		result = builtin_diff_combined(&rev, argc, argv,
-					       ent, ents);
+					       ent.objects, ent.nr);
 	result = diff_result_code(&rev.diffopt, result);
 	if (1 < rev.diffopt.skip_stat_unmatch)
 		refresh_index_quietly();
-- 
1.8.2.3
