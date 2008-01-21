From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] parse_object_buffer: don't ignore errors from the object specific parsing functions
Date: Mon, 21 Jan 2008 08:21:52 +0100
Message-ID: <1200900112513-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 08:22:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGqzI-0003PP-2q
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 08:22:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbYAUHVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 02:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752661AbYAUHVy
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 02:21:54 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:39449 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbYAUHVx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 02:21:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id C20E4680BECA;
	Mon, 21 Jan 2008 08:21:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YrEmdO27KK4A; Mon, 21 Jan 2008 08:21:52 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id A535B680BEAC; Mon, 21 Jan 2008 08:21:52 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71236>

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
gitgui.0.9.1.gf4a7e2
