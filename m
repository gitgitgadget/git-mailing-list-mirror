From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH] Update, and clear up the pack format documentation a bit
Date: Sat, 5 Apr 2008 20:07:59 +0200
Message-ID: <20080405180759.GA29710@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 05 20:08:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiCor-0001yZ-Vo
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 20:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbYDESIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 14:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752756AbYDESIE
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 14:08:04 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:44788 "HELO bohr.gbar.dtu.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752655AbYDESID (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 14:08:03 -0400
Received: (qmail 29760 invoked by uid 5842); 5 Apr 2008 20:07:59 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78857>

The current documentation does not mention the ofs_delta pack
object type. This patch is also supposed to make the text a bit
more readable, since it moves the object entry header
description earlier.

I fixes one error in these lines:

        If it is DELTA, then
          20-byte base object name SHA1 (the size above is the
                size of the delta data that follows).

The size given in the object header is actually the inflated size
of the delta data that follows, since the call chain goes like
this:

For delta objects:

unpack_entry()
    unpack_object_header()
    unpack_delta_entry()
        unpack_compressed_entry()

For non-delta objects:

unpack_entry()
    unpack_object_header()
    unpack_compressed_entry()

unpack_compressed_entry() allocates a buffer of the size
given in its last argument, and inflates the data into
this buffer.

So all objects have in fact their inflated size given
in the packed object header.

Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>
---
 Documentation/technical/pack-format.txt |   43
++++++++++++++++--------------
 1 files changed, 23 insertions(+), 20 deletions(-)

Did I understand this right especially the part
with what the length field in the packed objects
headers mean?

diff --git a/Documentation/technical/pack-format.txt
b/Documentation/technical/pack-format.txt
index aa87756..35ee01d 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -19,15 +19,34 @@ GIT pack format
 
    - The header is followed by number of object entries, each of
      which looks like this:
+     
+     An n-byte header encoding the
+         type of the object
+         length of the object before compression
+          
+     The format of the header:
+	1-byte size extension bit (MSB)
+	       type (next 3 bit)
+	       size0 (lower 4-bit)
+        n-byte sizeN (as long as MSB is set, each 7-bit)
+		size0..sizeN form 4+7+7+..+7 bit integer, size0
+		is the least significant part, and sizeN is the
+		most significant part.
+
 
-     (undeltified representation)
-     n-byte type and length (3-bit type, (n-1)*7+4-bit length)
+     The header is followed by:
+
+     (for object types: commit, tree, blob, and tag)
      compressed data
 
-     (deltified representation)
-     n-byte type and length (3-bit type, (n-1)*7+4-bit length)
+     (for object type ref_delta)
      20-byte base object name
      compressed delta data
+ 
+     (for object type ofs_delta)
+     n-byte offset (n*7-bit as above, but with size0 being 7 bit)     
+     compressed delta data
+
 
      Observation: length of each object is encoded in a variable
      length format and is not constrained to 32-bit or anything.
@@ -92,22 +111,6 @@ trailer	  | | packfile checksum              |
                   |
 Pack file entry: <+
 
-     packed object header:
-	1-byte size extension bit (MSB)
-	       type (next 3 bit)
-	       size0 (lower 4-bit)
-        n-byte sizeN (as long as MSB is set, each 7-bit)
-		size0..sizeN form 4+7+7+..+7 bit integer, size0
-		is the least significant part, and sizeN is the
-		most significant part.
-     packed object data:
-        If it is not DELTA, then deflated bytes (the size above
-		is the size before compression).
-	If it is DELTA, then
-	  20-byte base object name SHA1 (the size above is the
-		size of the delta data that follows).
-          delta data, deflated.
-
 
 = Version 2 pack-*.idx files support packs larger than 4 GiB, and
   have some other reorganizations.  They have the format:
-- 
1.5.5-rc3.GIT
