From: Sam Vilain <sam@vilain.net>
Subject: [PATCH 4/7] rev-cache: allow multiple 'start' objects per index
Date: Fri, 5 Jun 2009 02:05:12 +1200
Message-ID: <008619a339292ab96f7f64fe5f4437f0f3ad0b86.1244125128.git.sam@vilain.net>
References: <cover.1244125127.git.sam@vilain.net>
Cc: Nick Edelen <sirnot@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 07:46:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCSF3-0000qI-7F
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 07:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754930AbZFEFpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 01:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753942AbZFEFpN
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 01:45:13 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:57191 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753898AbZFEFpD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 01:45:03 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1003)
	id 29DFB21C3EA; Fri,  5 Jun 2009 17:45:00 +1200 (NZST)
In-Reply-To: <cover.1244125127.git.sam@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120748>

We can re-use the index for multiple 'start' objects sharing the same
'end' objects, using one list and a reachability bitmap for each
'start' object.

Signed-off-by: Sam Vilain <sam@vilain.net>
---
 Documentation/technical/revision-cache.txt |  106 +++++++++++++++++++---------
 1 files changed, 73 insertions(+), 33 deletions(-)

diff --git a/Documentation/technical/revision-cache.txt b/Documentation/technical/revision-cache.txt
index 759d78d..198c33a 100644
--- a/Documentation/technical/revision-cache.txt
+++ b/Documentation/technical/revision-cache.txt
@@ -6,12 +6,13 @@ reachability operations to be answered quickly.
 
 A revision cache contains;
 
-  - A 'start' object (ie, 'interesting' object ID)
+  - A list of 'start' objects (ie, 'interesting' object IDs)
 
   - A list of 'end' objects, which may be empty (ie, 'uninteresting'
     object IDs)
 
-  - A list of objects which are referred to by the 'start' object
+  - A list of objects which are referred to by any 'start' object, but
+    not by crossing 'end' objects, including:
 
     * position when sorted in --date-order
 
@@ -20,13 +21,25 @@ A revision cache contains;
   - A hash table from an (abbreviated) object ID to a position into
     the above list
 
+  - For each 'end' object, a bit sequence indicating which of the
+    objects in the object list are reachable from that 'end' object.
+    These bitmaps are stored in the same order as the object list and
+    then RLE-compressed, so in many cases will not take much on-disk
+    space.  A count of how many bits are '1' is included.  A separate
+    bitmap is included for the 'start' objects.
 
-Start Objects and End Object
-----------------------------
+
+Start Objects and End Objects
+-----------------------------
 
 The 'start' object, and 'end' objects are the identifying key of the
 revision cache.
 
+Revision caches for multiple 'start' objects can re-use the same
+object list, conserving space and adding flexibility to the index.  As
+such, a single revision cache is logically considered to be multiple
+indexes, unless it is of benefit to consider it a single index.
+
 The 'end' objects must be reachable from the 'start' objects, and none
 of the 'end' objects may be reachable from other 'end' objects.
 
@@ -71,27 +84,36 @@ Determining Cache Suitability - rev_cache_suitable()
 This is an auxiliary function used by the other use cases.
 
 A revision cache is suitable whenever the walker encounters the single
-object which is the 'end' object of the revision cache, and none of
-the 'uninteresting' revisions to the walker are in the revision cache.
+object which is any of the 'end' objects of the revision cache, and
+none of the 'uninteresting' revisions to the walker are in the
+revision cache.
 
 The function is:
 
   rev_cache_suitable( rev_cache, interesting, uninteresting [] )
 
 The check is simple and fast - it first compares the 'interesting'
-object to the 'start' object in the revision cache, then the
+object to the 'start' object list in the revision cache, then the
 'uninteresting' objects that the walker is using are looked up in the
 contents hash table.
-Only if none of them are found is the revision cache suitable.
+If they are found, then the reachability bitmap for the matching
+'start' objects are consulted for whether the object was actually
+reachable from those 'start' objects.
+Only if none of them are reachable is the revision cache suitable.
 
 
 Revision cache stacking
 ^^^^^^^^^^^^^^^^^^^^^^^
 
-If there are 'end' objects in the revision cache used, which do not
+If there are 'end' objects in the revision cache used, which are
+reachable from the 'start' objects in use, and do not
 match the 'uninteresting' objects in the walker, the function may
 recurse, looking for other revision caches which have the unwanted
-'end' object as their 'start' object.
+'end' object in their 'start' object list.
+
+Allowing multiple 'start' objects allows for more instances of 'single
+file' stacking, where at no point is the stack wider than one revision
+cache.
 
 Stacking revision caches is a way to re-use an older index by just
 generating a newer one which covers objects created after it.  This
@@ -126,18 +148,20 @@ information required, and false if it would require a graph traversal:
   rev_cache_ok( ) : Bool
 
 The rev_cache_ok() function must open all available revision caches,
-and see if their 'interesting' object matches the single 'interesting'
-object passed to rev_cache_add().  If it matches, it returns true.  If
-multiple 'interesting' objects were specified and 'ordered' is true,
-then the function returns false.
+and see if all of the 'interesting' objects passed to rev_cache_add()
+can be found as 'start' objects in available revision caches.
+If they cannot, the function returns false.
+If multiple 'interesting' objects were specified and 'ordered' is
+true, then the function returns false, unless all of the 'interesting'
+objects were found in a single revision cache and no stacking is
+required.
 
-If the ordering flag was set to false, then all of the 'interesting'
-objects must be found in separate revision caches for the function to
-return true.
+If the ordering flag was set to false, then this restriction is
+relaxed.  Objects may be found in separate revision caches.
 
 If any 'uninteresting' objects were passed, then the return value is
-true if the suitability function passes for the revision caches which
-are used.
+true if the suitability function passes for all of the revision caches
+which are used.
 
 
 Returning objects
@@ -176,13 +200,14 @@ an 'interesting' object added, then call:
 
   rev_cache_create( )
 
-This function will not work, if multiple 'interesting' objects are
-passed.
-
 This function must revision walk the commit graph, sorting in
 --date-order along the way, and may emit revisions as they are
-discovered to the topological object list.  It must also build a hash
-table of object IDs and emit it at the end.
+discovered to the topological object list.
+It must also build a hash table of object IDs and emit it at the end.
+Then, it must repeat the topological walk for each of the 'start'
+objects, looking up each object in the contents hash for a sequence
+number, set a bit in the bitmap for that 'start' object, and finally
+RLE compress it.
 
 
 receive-pack/pack-objects
@@ -215,13 +240,23 @@ Returning object counts
 If the revision cache was suitable, eg for a complete fetch, then the
 number of objects can be obtained by counting the size of the object
 list.
-
-If multiple revision caches were used for multiple 'interesting'
-objects, then the number of objects can be obtained by building a hash
-table of all the objects in all of the caches, and returning the
-number of hash table entries.  In the single-file stacked revision
-cache case, the total can be found by adding up the total lengths of
-the object lists.
+If the revision cache was entirely suitable, with all 'start' objects
+matching all 'interesting' objects in the walker, then the total
+number of objects in the cache is the number of objects to be
+returned.
+If a single 'start' object was used, then the count of '1's in the
+bitmap can be used.
+If multiple 'start' objects were used, then the count can be returned
+by decompressing and OR'ing the bitmaps together, counting the total
+number of '1's in the bitmap.
+
+If multiple revision caches were used, but not in single file, then
+the number of objects can be obtained by building a hash table of all
+the objects in all of the caches, and returning the number of hash
+table entries.
+In the single-file stacked revision cache case, the total can be found
+by adding up the total lengths of the object lists that apply to each
+single-file section.
 
 If 'uninteresting' objects were passed, the caches used must be
 suitable according to the cache suitability function.
@@ -241,8 +276,13 @@ detected or the delta base is not in the returned set of objects, then
 the delta is first resolved.
 
 This implies that each delta base must be looked up in the on-disk
-hash table as they are written, which is both low impact and memory
-efficient.
+hash table as they are written to the network, which is both low
+impact and memory efficient.
+In the case where not all of the 'start' objects are used, then the
+bitmaps for the 'start' objects in use will need to be kept in memory
+to supplement the results of this hash lookup.
+This is a small extra indirection likely to have only a minimal
+performance penalty.
 
 For later fetches, the revision cache will only be appropriate if the
 'have' objects sent by the remote are not found in the revision
-- 
debian.1.5.6.1
