From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 2/3] rev-list: add an option to mark fewer edges as uninteresting
Date: Sat, 20 Dec 2014 22:51:12 +0000
Message-ID: <1419115873-166686-3-git-send-email-sandals@crustytoothpaste.net>
References: <1419115873-166686-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 20 23:51:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2Ss8-0001Kp-QH
	for gcvg-git-2@plane.gmane.org; Sat, 20 Dec 2014 23:51:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbaLTWvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2014 17:51:32 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55865 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752368AbaLTWvY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Dec 2014 17:51:24 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id AD0ED28092;
	Sat, 20 Dec 2014 22:51:21 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1419115873-166686-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261610>

In commit fbd4a70 (list-objects: mark more commits as edges in
mark_edges_uninteresting - 2013-08-16), we marked an increasing number
of edges uninteresting.  This change, and the subsequent change to make
this conditional on --objects-edge, are used by --thin to make much
smaller packs for shallow clones.

Unfortunately, they cause a significant performance regression when
pushing non-shallow clones with lots of refs (23.322 seconds vs.
4.785 seconds with 22400 refs).  Add an option to git rev-list,
--objects-edge-aggressive, that preserves this more aggressive behavior,
while leaving --objects-edge to provide more performant behavior.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-rev-list.txt     | 3 ++-
 Documentation/rev-list-options.txt | 4 ++++
 list-objects.c                     | 4 ++--
 revision.c                         | 6 ++++++
 revision.h                         | 1 +
 5 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index fd7f8b5..5b11922 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -46,7 +46,8 @@ SYNOPSIS
 	     [ \--extended-regexp | -E ]
 	     [ \--fixed-strings | -F ]
 	     [ \--date=(local|relative|default|iso|iso-strict|rfc|short) ]
-	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
+	     [ [ \--objects | \--objects-edge | \--objects-edge-aggressive ]
+	       [ \--unpacked ] ]
 	     [ \--pretty | \--header ]
 	     [ \--bisect ]
 	     [ \--bisect-vars ]
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 2277fcb..8cb6f92 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -657,6 +657,10 @@ These options are mostly targeted for packing of Git repositories.
 	objects in deltified form based on objects contained in these
 	excluded commits to reduce network traffic.
 
+--objects-edge-aggressive::
+	Similar to `--objects-edge`, but it tries harder to find excluded
+	commits at the cost of increased time.
+
 --unpacked::
 	Only useful with `--objects`; print the object IDs that are not
 	in packs.
diff --git a/list-objects.c b/list-objects.c
index 2910bec..2a139b6 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -157,7 +157,7 @@ void mark_edges_uninteresting(struct rev_info *revs, show_edge_fn show_edge)
 
 		if (commit->object.flags & UNINTERESTING) {
 			mark_tree_uninteresting(commit->tree);
-			if (revs->edge_hint && !(commit->object.flags & SHOWN)) {
+			if (revs->edge_hint_aggressive && !(commit->object.flags & SHOWN)) {
 				commit->object.flags |= SHOWN;
 				show_edge(commit);
 			}
@@ -165,7 +165,7 @@ void mark_edges_uninteresting(struct rev_info *revs, show_edge_fn show_edge)
 		}
 		mark_edge_parents_uninteresting(commit, revs, show_edge);
 	}
-	if (revs->edge_hint) {
+	if (revs->edge_hint_aggressive) {
 		for (i = 0; i < revs->cmdline.nr; i++) {
 			struct object *obj = revs->cmdline.rev[i].item;
 			struct commit *commit = (struct commit *)obj;
diff --git a/revision.c b/revision.c
index 75dda92..753dd2f 100644
--- a/revision.c
+++ b/revision.c
@@ -1853,6 +1853,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->tree_objects = 1;
 		revs->blob_objects = 1;
 		revs->edge_hint = 1;
+	} else if (!strcmp(arg, "--objects-edge-aggressive")) {
+		revs->tag_objects = 1;
+		revs->tree_objects = 1;
+		revs->blob_objects = 1;
+		revs->edge_hint = 1;
+		revs->edge_hint_aggressive = 1;
 	} else if (!strcmp(arg, "--verify-objects")) {
 		revs->tag_objects = 1;
 		revs->tree_objects = 1;
diff --git a/revision.h b/revision.h
index 9cb5adc..033a244 100644
--- a/revision.h
+++ b/revision.h
@@ -93,6 +93,7 @@ struct rev_info {
 			blob_objects:1,
 			verify_objects:1,
 			edge_hint:1,
+			edge_hint_aggressive:1,
 			limited:1,
 			unpacked:1,
 			boundary:2,
-- 
2.2.1.209.g41e5f3a
