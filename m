From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] fsck --lost-found: write blob's contents, not their SHA-1
Date: Sun, 22 Jul 2007 21:20:26 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707222120100.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jul 22 22:20:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IChv2-0000W7-JT
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 22:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762714AbXGVUUl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 16:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762745AbXGVUUk
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 16:20:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:50821 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762502AbXGVUUj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 16:20:39 -0400
Received: (qmail invoked by alias); 22 Jul 2007 20:20:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 22 Jul 2007 22:20:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18oyT1EuI4oLRUNFjgTI7mlPpOAg8d8Yrh1TAf/pj
	K03tTkwjwW5tmr
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53311>


When looking for a lost blob, it is much nicer to be able to grep
through .git/lost-found/other/* than to write an inefficient loop
over the file names.  So write the contents of the dangling blobs,
not their object names.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	While working on filter-branch, I inadvertently said
	"git reset --hard" without having committed first.  That's
	when I was almost happy to have "git fsck --lost-found".
	But when grepping through the "other" found objects, nothing
	turned up... because there were only SHA-1s.

 Documentation/git-fsck.txt |    6 ++++--
 builtin-fsck.c             |   12 +++++++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 1a432f2..45c0bee 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -65,8 +65,10 @@ index file and all SHA1 references in .git/refs/* as heads.
 	Be chatty.
 
 --lost-found::
-	Write dangling refs into .git/lost-found/commit/ or
-	.git/lost-found/other/, depending on type.
+	Write dangling objects into .git/lost-found/commit/ or
+	.git/lost-found/other/, depending on type.  If the object is
+	a blob, the contents are written into the file, rather than
+	its object name.
 
 It tests SHA1 and general object sanity, and it does full tracking of
 the resulting reachability and everything else. It prints out any
diff --git a/builtin-fsck.c b/builtin-fsck.c
index 350ec5e..8d12287 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -152,7 +152,17 @@ static void check_unreachable_object(struct object *obj)
 			}
 			if (!(f = fopen(filename, "w")))
 				die("Could not open %s", filename);
-			fprintf(f, "%s\n", sha1_to_hex(obj->sha1));
+			if (obj->type == OBJ_BLOB) {
+				enum object_type type;
+				unsigned long size;
+				char *buf = read_sha1_file(obj->sha1,
+						&type, &size);
+				if (buf) {
+					fwrite(buf, size, 1, f);
+					free(buf);
+				}
+			} else
+				fprintf(f, "%s\n", sha1_to_hex(obj->sha1));
 			fclose(f);
 		}
 		return;
-- 
1.5.3.rc2.32.g35c5b
