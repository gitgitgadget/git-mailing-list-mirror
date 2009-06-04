From: Sam Vilain <sam@vilain.net>
Subject: [PATCH 5/7] revision cache: maps of 'new' objects
Date: Fri, 5 Jun 2009 02:05:12 +1200
Message-ID: <a3798f6363249996f03771bd286bb2b1db10ea24.1244125128.git.sam@vilain.net>
References: <cover.1244125127.git.sam@vilain.net>
Cc: Nick Edelen <sirnot@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 07:46:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCSF2-0000qI-Gi
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 07:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754951AbZFEFpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 01:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754930AbZFEFpM
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 01:45:12 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:57192 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753716AbZFEFpD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 01:45:03 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1003)
	id 25A7121D112; Fri,  5 Jun 2009 17:45:00 +1200 (NZST)
In-Reply-To: <cover.1244125127.git.sam@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120747>

When making a pack, it is useful to know if an object is already
reachable from any of the objects that the receiving party is known to
have; it allows the object to be excluded from the pack.  Allow
optional bitmaps for 'start' objects which permit storage of this
information.

Signed-off-by: Sam Vilain <sam@vilain.net>
---
 Documentation/technical/revision-cache.txt |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/Documentation/technical/revision-cache.txt b/Documentation/technical/revision-cache.txt
index 198c33a..e0adb26 100644
--- a/Documentation/technical/revision-cache.txt
+++ b/Documentation/technical/revision-cache.txt
@@ -28,6 +28,11 @@ A revision cache contains;
     space.  A count of how many bits are '1' is included.  A separate
     bitmap is included for the 'start' objects.
 
+  - Optionally, for any 'end' object, a 'newness' bitmap indicating
+    which of the objects in the object list are reachable from that
+    'end' object, but not reachable from the 'start' objects reachable
+    from that 'end' object.
+
 
 Start Objects and End Objects
 -----------------------------
@@ -120,6 +125,9 @@ generating a newer one which covers objects created after it.  This
 approach will be able to answer many questions, but not topological
 ordering between objects which appeared in different caches.
 
+Stacking revision caches is essential for being able to generate the
+'newness' bitmaps efficiently.
+
 
 Revision Walker
 ~~~~~~~~~~~~~~~
@@ -144,7 +152,7 @@ required.  Some API exists to do this, and the return value from
 'rev_cache_ok' is true if suitable caches were found for the
 information required, and false if it would require a graph traversal:
 
-  rev_cache_options( ordered? )
+  rev_cache_options( ordered?, new? )
   rev_cache_ok( ) : Bool
 
 The rev_cache_ok() function must open all available revision caches,
@@ -163,6 +171,11 @@ If any 'uninteresting' objects were passed, then the return value is
 true if the suitability function passes for all of the revision caches
 which are used.
 
+If the 'new' flag is set to true, then the return value is only true
+if the 'uninteresting' objects also have suitable revision caches
+leading back to the start of history (or last 'shallow' point), or the
+'newness' bitmaps are present for all of the 'start' references used.
+
 
 Returning objects
 ^^^^^^^^^^^^^^^^^
@@ -208,6 +221,10 @@ Then, it must repeat the topological walk for each of the 'start'
 objects, looking up each object in the contents hash for a sequence
 number, set a bit in the bitmap for that 'start' object, and finally
 RLE compress it.
+If there are suitable other revision caches available, then the
+'newness' bitmaps are built by checking with the stacked revision
+caches whether the object exists and is reachable from the 'start'
+objects which connect to those stacked caches.
 
 
 receive-pack/pack-objects
@@ -250,6 +267,11 @@ If multiple 'start' objects were used, then the count can be returned
 by decompressing and OR'ing the bitmaps together, counting the total
 number of '1's in the bitmap.
 
+If the 'newness' bitmaps are available, then these can be used to
+avoid sending objects which the other end will already have.
+When applicable the 'newness' bitmaps will be masked against the
+combined reachability bitmaps to derive a shorter list of objects.
+
 If multiple revision caches were used, but not in single file, then
 the number of objects can be obtained by building a hash table of all
 the objects in all of the caches, and returning the number of hash
-- 
debian.1.5.6.1
