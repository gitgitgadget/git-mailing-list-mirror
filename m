From: linux@horizon.com
Subject: Re: [PATCH] provide advance warning of some future pack default changes
Date: 14 Dec 2007 06:28:14 -0500
Message-ID: <20071214112814.11083.qmail@science.horizon.com>
Cc: linux@horizon.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 12:28:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J38ie-0003yx-Av
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 12:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763014AbXLNL2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 06:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762997AbXLNL2Q
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 06:28:16 -0500
Received: from science.horizon.com ([192.35.100.1]:13074 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753942AbXLNL2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 06:28:16 -0500
Received: (qmail 11084 invoked by uid 1000); 14 Dec 2007 06:28:14 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68298>

>+ * From v1.5.5, the pack.indexversion config option will default to 2,
>+   which is slightly more efficient, and makes repacking more immune to
>+   data corruptions.  Git older than version 1.5.2 may revert to version 1
>+   of the pack index with a manual "git index-pack" to be able to directly
>+   access corresponding pack files.

You might want to mention that it's slightly more TIME efficient,
but takes 16% more space (28 bytes per object rather than 24).

If it helps, I documented the v2 index file format (a lot stolen
from commit c553ca25bd60dc9fd50b8bc7bd329601b81cee66 message).
(Public domain, copyright abandoned, if it breaks you get to keep both
pieces, yadda yadda.)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index e5b31c8..a80baa4 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -1,9 +1,9 @@
 GIT pack format
 ===============
 
-= pack-*.pack file has the following format:
+= pack-*.pack files have the following format:
 
-   - The header appears at the beginning and consists of the following:
+   - A header appears at the beginning and consists of the following:
 
      4-byte signature:
          The signature is: {'P', 'A', 'C', 'K'}
@@ -34,18 +34,14 @@ GIT pack format
 
   - The trailer records 20-byte SHA1 checksum of all of the above.
 
-= pack-*.idx file has the following format:
+= Original (version 1) pack-*.idx files have the following format:
 
   - The header consists of 256 4-byte network byte order
     integers.  N-th entry of this table records the number of
     objects in the corresponding pack, the first byte of whose
-    object name are smaller than N.  This is called the
+    object name is less than or equal to N.  This is called the
     'first-level fan-out' table.
 
-    Observation: we would need to extend this to an array of
-    8-byte integers to go beyond 4G objects per pack, but it is
-    not strictly necessary.
-
   - The header is followed by sorted 24-byte entries, one entry
     per object in the pack.  Each entry is:
 
@@ -55,10 +51,6 @@ GIT pack format
 
     20-byte object name.
 
-    Observation: we would definitely need to extend this to
-    8-byte integer plus 20-byte object name to handle a packfile
-    that is larger than 4GB.
-
   - The file is concluded with a trailer:
 
     A copy of the 20-byte SHA1 checksum at the end of
@@ -68,31 +60,30 @@ GIT pack format
 
 Pack Idx file:
 
-	idx
-	    +--------------------------------+
-	    | fanout[0] = 2                  |-.
-	    +--------------------------------+ |
+	--  +--------------------------------+
+fanout	    | fanout[0] = 2 (for example)    |-.
+table	    +--------------------------------+ |
 	    | fanout[1]                      | |
 	    +--------------------------------+ |
 	    | fanout[2]                      | |
 	    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ |
-	    | fanout[255]                    | |
-	    +--------------------------------+ |
-main	    | offset                         | |
-index	    | object name 00XXXXXXXXXXXXXXXX | |
-table	    +--------------------------------+ |
-	    | offset                         | |
-	    | object name 00XXXXXXXXXXXXXXXX | |
-	    +--------------------------------+ |
-	  .-| offset                         |<+
-	  | | object name 01XXXXXXXXXXXXXXXX |
-	  | +--------------------------------+
-	  | | offset                         |
-	  | | object name 01XXXXXXXXXXXXXXXX |
-	  | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-	  | | offset                         |
-	  | | object name FFXXXXXXXXXXXXXXXX |
-	  | +--------------------------------+
+	    | fanout[255] = total objects    |---.
+	--  +--------------------------------+ | |
+main	    | offset                         | | |
+index	    | object name 00XXXXXXXXXXXXXXXX | | |
+table	    +--------------------------------+ | |
+	    | offset                         | | |
+	    | object name 00XXXXXXXXXXXXXXXX | | |
+	    +--------------------------------+<+ |
+	  .-| offset                         |   |
+	  | | object name 01XXXXXXXXXXXXXXXX |   |
+	  | +--------------------------------+   |
+	  | | offset                         |   |
+	  | | object name 01XXXXXXXXXXXXXXXX |   |
+	  | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   |
+	  | | offset                         |   |
+	  | | object name FFXXXXXXXXXXXXXXXX |   |
+	--| +--------------------------------+<--+
 trailer	  | | packfile checksum              |
 	  | +--------------------------------+
 	  | | idxfile checksum               |
@@ -116,3 +107,40 @@ Pack file entry: <+
 	  20-byte base object name SHA1 (the size above is the
 		size of the delta data that follows).
           delta data, deflated.
+
+
+= Version 2 pack-*.idx files support packs larger than 4 GiB, and
+  have some other reorganizations.  They have the format:
+
+  - A 4-byte magic number '\377tOc' which is an unreasonable
+    fanout[0] value.
+
+  - A 4-byte version number (= 2)
+
+  - A 256-entry fan-out table just like v1.
+
+  - A table of sorted 20-byte SHA1 object names.  These are
+    packed together without offset values to reduce the cache
+    footprint of the binary search for a specific object name.
+
+  - A table of 4-byte CRC32 values of the packed object data.
+    This is new in v2 so compressed data can be copied directly
+    from pack to pack during repacking withough undetected
+    data corruption.
+
+  - A table of 4-byte offset values (in network byte order).
+    These are usually 31-bit pack file offsets, but large
+    offsets are encoded as an index into the next table with
+    the msbit set.
+
+  - A table of 8-byte offset entries (empty for pack files less
+    than 2 GiB).  Pack files are organized with heavily used
+    objects toward the front, so most object references should
+    not need to refer to this table.
+
+  - The same trailer as a v1 pack file:
+
+    A copy of the 20-byte SHA1 checksum at the end of
+    corresponding packfile.
+
+    20-byte SHA1-checksum of all of the above.
