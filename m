From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 3/3] parse_object_buffer: don't ignore errors from the object specific parsing functions
Date: Sun,  3 Feb 2008 22:22:39 +0100
Message-ID: <12020737603543-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <12020737593747-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12020737601683-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 22:23:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLmJW-0001mO-PM
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 22:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036AbYBCVWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 16:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753695AbYBCVWo
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 16:22:44 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:43562 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753939AbYBCVWm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 16:22:42 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 54C74680BF6B;
	Sun,  3 Feb 2008 22:22:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4gMH0eZJ+FFW; Sun,  3 Feb 2008 22:22:40 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 18B8A680BF77; Sun,  3 Feb 2008 22:22:40 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <12020737601683-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72405>

In the case of an malformed object, the object specific parsing functions
would return an error, which is currently ignored. The object can be partial
initialized in this case.

This patch make parse_object_buffer propagate such errors.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 object.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/object.c b/object.c
index 5a5ebe2..4e7f27a 100644
--- a/object.c
+++ b/object.c
@@ -140,7 +140,8 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t
 	if (type == OBJ_BLOB) {
 		struct blob *blob = lookup_blob(sha1);
 		if (blob) {
-			parse_blob_buffer(blob, buffer, size);
+			if (parse_blob_buffer(blob, buffer, size))
+				return NULL;
 			obj = &blob->object;
 		}
 	} else if (type == OBJ_TREE) {
@@ -148,14 +149,16 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t
 		if (tree) {
 			obj = &tree->object;
 			if (!tree->object.parsed) {
-				parse_tree_buffer(tree, buffer, size);
+				if (parse_tree_buffer(tree, buffer, size))
+					return NULL;
 				eaten = 1;
 			}
 		}
 	} else if (type == OBJ_COMMIT) {
 		struct commit *commit = lookup_commit(sha1);
 		if (commit) {
-			parse_commit_buffer(commit, buffer, size);
+			if (parse_commit_buffer(commit, buffer, size))
+				return NULL;	
 			if (!commit->buffer) {
 				commit->buffer = buffer;
 				eaten = 1;
@@ -165,7 +168,8 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t
 	} else if (type == OBJ_TAG) {
 		struct tag *tag = lookup_tag(sha1);
 		if (tag) {
-			parse_tag_buffer(tag, buffer, size);
+			if (parse_tag_buffer(tag, buffer, size))
+			       return NULL;
 			obj = &tag->object;
 		}
 	} else {
-- 
1.5.4.g22bc
