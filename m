From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] Add git-index-pack -l to list objects in a pack
Date: Wed,  6 Jun 2007 21:39:41 +1200
Message-ID: <11811227811793-git-send-email-sam.vilain@catalyst.net.nz>
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 11:39:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvrzd-0006tK-0t
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 11:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758203AbXFFJjt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 05:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758132AbXFFJjt
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 05:39:49 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:48964 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757769AbXFFJjs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 05:39:48 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1HvrzR-0003ae-Mc; Wed, 06 Jun 2007 21:39:41 +1200
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 9F692CB9E8; Wed,  6 Jun 2007 21:39:41 +1200 (NZST)
X-Mailer: git-send-email 1.5.2.0.45.gfea6d-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49277>

I couldn't figure out how to make git-unpack-objects -n work.
But it seems to be easy in the loop in index-pack
---
 index-pack.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index 82c8da3..f657db7 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -45,6 +45,7 @@ static int nr_resolved_deltas;
 
 static int from_stdin;
 static int verbose;
+static int list_objects;
 
 static struct progress progress;
 
@@ -717,6 +718,8 @@ int main(int argc, char **argv)
 				if (*c)
 					die("bad %s", arg);
 				input_len = sizeof(*hdr);
+			} else if (!strcmp(arg, "-l")) {
+				list_objects = 1;
 			} else if (!strcmp(arg, "-v")) {
 				verbose = 1;
 			} else if (!strcmp(arg, "-o")) {
@@ -802,8 +805,11 @@ int main(int argc, char **argv)
 	free(deltas);
 
 	idx_objects = xmalloc((nr_objects) * sizeof(struct pack_idx_entry *));
-	for (i = 0; i < nr_objects; i++)
+	for (i = 0; i < nr_objects; i++) {
 		idx_objects[i] = &objects[i].idx;
+		if (list_objects)
+			printf("%s\n", sha1_to_hex(idx_objects[i]->sha1));
+	}
 	curr_index = write_idx_file(index_name, idx_objects, nr_objects, sha1);
 	free(idx_objects);
 
-- 
1.5.2.0.45.gfea6d-dirty
