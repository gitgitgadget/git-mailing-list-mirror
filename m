From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Replace parse_blob() with an explanatory comment
Date: Mon, 18 Jan 2010 13:06:28 -0500 (EST)
Message-ID: <alpine.LNX.2.00.1001181301070.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 19:06:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWvzn-0002aF-60
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 19:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754030Ab0ARSGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 13:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753529Ab0ARSGa
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 13:06:30 -0500
Received: from iabervon.org ([66.92.72.58]:44566 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753226Ab0ARSG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 13:06:29 -0500
Received: (qmail 27624 invoked by uid 1000); 18 Jan 2010 18:06:28 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Jan 2010 18:06:28 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137395>

parse_blob() has never actually been used; it has served simply to
avoid having a confusing gap in the API. Instead of leaving it, put in
a comment that explains what "parsing a blob" entails (making sure the
object is actually readable), and why code might care whether a blob
has been parsed or not.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
I also realized that the code that used to use the "parsed" bit to 
distinguish blobs that had actually be read from blobs that had only been 
referenced (fsck-cache, at the time) no longer works that way, as far as I 
can tell. However, I think it's worth maintaining the convention that it 
used, and better not to say that nothing known presently relies on it, 
since that could change.

 blob.c |   21 ---------------------
 blob.h |    9 ++++++++-
 2 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/blob.c b/blob.c
index bd7d078..ae320bd 100644
--- a/blob.c
+++ b/blob.c
@@ -23,24 +23,3 @@ int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size)
 	item->object.parsed = 1;
 	return 0;
 }
-
-int parse_blob(struct blob *item)
-{
-        enum object_type type;
-        void *buffer;
-        unsigned long size;
-	int ret;
-
-        if (item->object.parsed)
-                return 0;
-        buffer = read_sha1_file(item->object.sha1, &type, &size);
-        if (!buffer)
-                return error("Could not read %s",
-                             sha1_to_hex(item->object.sha1));
-        if (type != OBJ_BLOB)
-                return error("Object %s not a blob",
-                             sha1_to_hex(item->object.sha1));
-	ret = parse_blob_buffer(item, buffer, size);
-	free(buffer);
-	return ret;
-}
diff --git a/blob.h b/blob.h
index ea5d9e9..38ea395 100644
--- a/blob.h
+++ b/blob.h
@@ -13,6 +13,13 @@ struct blob *lookup_blob(const unsigned char *sha1);
 
 int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size);
 
-int parse_blob(struct blob *item);
+/** 
+ * Blobs do not contain references to other objects and do not have
+ * structured data that needs parsing. However, code may use the
+ * "parsed" bit in the struct object for a blob to determine whether
+ * its content has been found to actually be available, so
+ * parse_blob_buffer() is used (by object.c) to flag that the object
+ * has been read successfully from the database.
+ **/
 
 #endif /* BLOB_H */
-- 
1.6.6.rc0.354.g373a9.dirty
