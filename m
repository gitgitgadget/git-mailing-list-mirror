From: Simon Hausmann <simon@lst.de>
Subject: [PATCH] fast-import: Fix crash when referencing already existing objects
Date: Wed, 23 May 2007 23:01:49 +0200
Message-ID: <200705232301.49667.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed May 23 23:02:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hqxy2-0001DL-1Y
	for gcvg-git@gmane.org; Wed, 23 May 2007 23:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754956AbXEWVBs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 17:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756649AbXEWVBs
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 17:01:48 -0400
Received: from verein.lst.de ([213.95.11.210]:33434 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754956AbXEWVBr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 17:01:47 -0400
Received: from luria.local (157.80-203-65.nextgentel.com [80.203.65.157])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l4NL1fpY029614
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Wed, 23 May 2007 23:01:43 +0200
User-Agent: KMail/1.9.6
Content-Disposition: inline
X-Spam-Score: -0.001 () BAYES_44
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48176>

Commit a5c1780a0355a71b9fb70f1f1977ce726ee5b8d8 sets the pack_id of existing
objects to MAX_PACK_ID. When the same object is referenced later again it is
found in the local object hash. With such a pack_id fast-import should not try
to locate that object in the newly created pack(s).

Signed-off-by: Simon Hausmann <simon@lst.de>
---
 fast-import.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 0ddf8fe..87eaada 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1013,7 +1013,7 @@ static void load_tree(struct tree_entry *root)
 		return;
 
 	myoe = find_object(sha1);
-	if (myoe) {
+	if (myoe && myoe->pack_id != MAX_PACK_ID) {
 		if (myoe->type != OBJ_TREE)
 			die("Not a tree: %s", sha1_to_hex(sha1));
 		t->delta_depth = 0;
-- 
1.5.2.24.g93d4
