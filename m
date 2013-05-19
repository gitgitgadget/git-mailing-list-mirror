From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 05/17] cmd_diff(): use an object_array for holding trees
Date: Sun, 19 May 2013 22:27:00 +0200
Message-ID: <1368995232-11042-6-git-send-email-mhagger@alum.mit.edu>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 19 22:28:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeADI-0004Pr-U1
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 22:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767Ab3ESU2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 16:28:08 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:45968 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754714Ab3ESU2E (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 16:28:04 -0400
X-AuditID: 12074412-b7f216d0000008d4-e8-519935d3693c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 70.13.02260.3D539915; Sun, 19 May 2013 16:28:03 -0400 (EDT)
Received: from michael.fritz.box (p57A25040.dip0.t-ipconnect.de [87.162.80.64])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4JKRX5O026019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 19 May 2013 16:28:02 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsUixO6iqHvZdGagwaF2aYuuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MDqwef99/YPK49PI7m8ez3j2MHhcvKXt83iQXwBrFbZOUWFIWnJme
	p2+XwJ3xfs8kloJ5EhXfGuewNDDeFOpi5OSQEDCReNHykxHCFpO4cG89WxcjF4eQwGVGiaZN
	25ggnPNMEq1NvUwgVWwCuhKLeprBbBEBWYnvhzeCdTMLTGCUWNpfCGILC3hI/FjUxQ5iswio
	Sjz8DLGBV8BFYv6x3SwQ2xQkLs9awwxicwq4Smxp38UKYgsB1fzrv806gZF3ASPDKka5xJzS
	XN3cxMyc4tRk3eLkxLy81CJdM73czBK91JTSTYyQoBLawbj+pNwhRgEORiUe3oYP0wOFWBPL
	iitzDzFKcjApifK+M5kZKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEd48QUI43JbGyKrUoHyYl
	zcGiJM77c7G6n5BAemJJanZqakFqEUxWhoNDSYLXHBg9QoJFqempFWmZOSUIaSYOTpDhXFIi
	xal5KalFiaUlGfGg2IgvBkYHSIoHaK80SDtvcUFiLlAUovUUoy7H5vOT3zEKseTl56VKifNe
	BDlcAKQoozQPbgUshbxiFAf6WJjXFmQUDzD9wE16BbSECWgJ67WpIEtKEhFSUg2MziEe5UHP
	rJm89742kpyj5Dx71ZdbM81abXqYQq6w/N7KcXZOHOduJdOEzHu3nzNf0+H6c5+Dr/tV/7vr
	Ckfudz++Ue194oj4qhfzdp76oFBa5Phr5q1nupd7jBm+3Z8l1WbK92OZY/tl/ilL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224911>

Change cmd_diff() to use a (struct object_array) for holding the trees
that it accumulates, rather than rolling its own equivalent.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/diff.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index ba68c6c..72d99c0 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -252,8 +252,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
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
@@ -350,13 +350,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
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
@@ -380,7 +375,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	/*
 	 * Now, do the arguments look reasonable?
 	 */
-	if (!ents) {
+	if (!ent.nr) {
 		switch (blobs) {
 		case 0:
 			result = builtin_diff_files(&rev, argc, argv);
@@ -401,22 +396,26 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
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
