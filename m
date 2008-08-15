From: Marcus Griep <marcus@griep.us>
Subject: [PATCH v3.1 1/3] count-objects: Add total pack size to verbose output
Date: Fri, 15 Aug 2008 11:47:39 -0400
Message-ID: <1218815259-31816-1-git-send-email-marcus@griep.us>
References: <1218774022-30198-1-git-send-email-marcus@griep.us>
Cc: Junio C Hamano <gitster@pobox.com>, Marcus Griep <marcus@griep.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 15 17:48:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU1Xg-0003U0-Gk
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 17:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861AbYHOPrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 11:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754709AbYHOPrk
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 11:47:40 -0400
Received: from boohaunt.net ([209.40.206.144]:44699 "EHLO boohaunt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754553AbYHOPrk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 11:47:40 -0400
Received: by boohaunt.net (Postfix, from userid 1000)
	id 927FD1878CDD; Fri, 15 Aug 2008 11:47:39 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.rc2.6.g8eda3
In-Reply-To: <1218774022-30198-1-git-send-email-marcus@griep.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92489>

Adds the total pack size (including indexes) the verbose count-objects
output, floored to the nearest kilobyte.

As well, t5500 is sensitive to changes in the output of git-count-objects
and is updated for the recent addition of size-pack to that command.

Updates documentation to match this addition.

Signed-off-by: Marcus Griep <marcus@griep.us>
---

 I realized that there was a breaking test in there that depended upon the
 output of git-count-objects.  I updated that test case to understand the
 additional output.

 Documentation/git-count-objects.txt |    5 +++--
 builtin-count-objects.c             |    3 +++
 t/t5500-fetch-pack.sh               |    3 ++-
 3 files changed, 8 insertions(+), 3 deletions(-)

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
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 362cf7e..399c8d9 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -137,7 +137,8 @@ test_expect_success "clone shallow object count" \
 	"test \"in-pack: 18\" = \"$(grep in-pack count.shallow)\""
 
 count_output () {
-	sed -e '/^in-pack:/d' -e '/^packs:/d' -e '/: 0$/d' "$1"
+	sed -e '/^in-pack:/d' -e '/^size-pack:/d' \
+		-e '/^packs:/d' -e '/: 0$/d' "$1"
 }
 
 test_expect_success "clone shallow object count (part 2)" '
-- 
1.6.0.rc2.6.g8eda3
