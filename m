From: Marcus Griep <marcus@griep.us>
Subject: [PATCH v3 1/3] count-objects: Add total pack size to verbose output
Date: Fri, 15 Aug 2008 00:20:20 -0400
Message-ID: <1218774022-30198-1-git-send-email-marcus@griep.us>
References: <1218752308-3173-1-git-send-email-marcus@griep.us>
Cc: Junio C Hamano <gitster@pobox.com>, Marcus Griep <marcus@griep.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 15 06:21:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTqoj-00080F-KJ
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 06:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbYHOEUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 00:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbYHOEUY
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 00:20:24 -0400
Received: from boohaunt.net ([209.40.206.144]:32793 "EHLO boohaunt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795AbYHOEUX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 00:20:23 -0400
Received: by boohaunt.net (Postfix, from userid 1000)
	id A62B81878CC7; Fri, 15 Aug 2008 00:20:22 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.rc2.6.g8eda3
In-Reply-To: <1218752308-3173-1-git-send-email-marcus@griep.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92459>

Adds the total pack size (including indexes) the verbose count-objects
output, floored to the nearest kilobyte.

Updates documentation to match this addition.

Signed-off-by: Marcus Griep <marcus@griep.us>
---
 Documentation/git-count-objects.txt |    5 +++--
 builtin-count-objects.c             |    3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.txt
index 75a8da1..6bc1c21 100644
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -21,8 +21,9 @@ OPTIONS
 --verbose::
 	In addition to the number of loose objects and disk
 	space consumed, it reports the number of in-pack
-	objects, number of packs, and number of objects that can be
-	removed by running `git prune-packed`.
+	objects, number of packs, disk space consumed by those packs,
+	and number of objects that can be removed by running
+	`git prune-packed`.
 
 
 Author
diff --git a/builtin-count-objects.c b/builtin-count-objects.c
index 91b5487..249040b 100644
--- a/builtin-count-objects.c
+++ b/builtin-count-objects.c
@@ -104,6 +104,7 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 	if (verbose) {
 		struct packed_git *p;
 		unsigned long num_pack = 0;
+		unsigned long size_pack = 0;
 		if (!packed_git)
 			prepare_packed_git();
 		for (p = packed_git; p; p = p->next) {
@@ -112,12 +113,14 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 			if (open_pack_index(p))
 				continue;
 			packed += p->num_objects;
+			size_pack += p->pack_size + p->index_size;
 			num_pack++;
 		}
 		printf("count: %lu\n", loose);
 		printf("size: %lu\n", loose_size / 2);
 		printf("in-pack: %lu\n", packed);
 		printf("packs: %lu\n", num_pack);
+		printf("size-pack: %lu\n", size_pack / 1024);
 		printf("prune-packable: %lu\n", packed_loose);
 		printf("garbage: %lu\n", garbage);
 	}
-- 
1.6.0.rc2.6.g8eda3
