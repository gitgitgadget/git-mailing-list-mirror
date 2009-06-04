From: Sam Vilain <sam@vilain.net>
Subject: [PATCH 3/7] rev-cache: add 'end' objects for caching 'uninteresting' lookups
Date: Fri, 5 Jun 2009 02:05:12 +1200
Message-ID: <0648597b2ac9438e5f0c669720b130c787b6fd92.1244125127.git.sam@vilain.net>
References: <cover.1244125127.git.sam@vilain.net>
Cc: Nick Edelen <sirnot@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 07:46:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCSFw-0001n0-U7
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 07:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755160AbZFEFp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 01:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755129AbZFEFp0
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 01:45:26 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:57203 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754711AbZFEFpE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 01:45:04 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1003)
	id 3CAB821D11B; Fri,  5 Jun 2009 17:45:00 +1200 (NZST)
In-Reply-To: <cover.1244125127.git.sam@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120751>

If we want to be able to accelerate lookups which contain
'uninteresting' revisions, we must be able to specify what those
revisions are.

Signed-off-by: Sam Vilain <sam@vilain.net>
---
 Documentation/technical/revision-cache.txt |   85 +++++++++++++++++++++-------
 1 files changed, 65 insertions(+), 20 deletions(-)

diff --git a/Documentation/technical/revision-cache.txt b/Documentation/technical/revision-cache.txt
index 8349cfe..759d78d 100644
--- a/Documentation/technical/revision-cache.txt
+++ b/Documentation/technical/revision-cache.txt
@@ -8,6 +8,9 @@ A revision cache contains;
 
   - A 'start' object (ie, 'interesting' object ID)
 
+  - A list of 'end' objects, which may be empty (ie, 'uninteresting'
+    object IDs)
+
   - A list of objects which are referred to by the 'start' object
 
     * position when sorted in --date-order
@@ -18,10 +21,14 @@ A revision cache contains;
     the above list
 
 
-Start Object
-------------
+Start Objects and End Object
+----------------------------
+
+The 'start' object, and 'end' objects are the identifying key of the
+revision cache.
 
-The 'start' object is the identifying key of the revision cache.
+The 'end' objects must be reachable from the 'start' objects, and none
+of the 'end' objects may be reachable from other 'end' objects.
 
 
 Topological contents list
@@ -61,14 +68,35 @@ answer.
 Determining Cache Suitability - rev_cache_suitable()
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-This is an auxiliary function used by the other use cases, when 
+This is an auxiliary function used by the other use cases.
+
+A revision cache is suitable whenever the walker encounters the single
+object which is the 'end' object of the revision cache, and none of
+the 'uninteresting' revisions to the walker are in the revision cache.
 
 The function is:
 
-  rev_cache_suitable( rev_cache, object )
+  rev_cache_suitable( rev_cache, interesting, uninteresting [] )
+
+The check is simple and fast - it first compares the 'interesting'
+object to the 'start' object in the revision cache, then the
+'uninteresting' objects that the walker is using are looked up in the
+contents hash table.
+Only if none of them are found is the revision cache suitable.
+
+
+Revision cache stacking
+^^^^^^^^^^^^^^^^^^^^^^^
+
+If there are 'end' objects in the revision cache used, which do not
+match the 'uninteresting' objects in the walker, the function may
+recurse, looking for other revision caches which have the unwanted
+'end' object as their 'start' object.
 
-The check is simple and fast - it just compares the object to the
-'start' object in the revision cache.
+Stacking revision caches is a way to re-use an older index by just
+generating a newer one which covers objects created after it.  This
+approach will be able to answer many questions, but not topological
+ordering between objects which appeared in different caches.
 
 
 Revision Walker
@@ -104,10 +132,12 @@ multiple 'interesting' objects were specified and 'ordered' is true,
 then the function returns false.
 
 If the ordering flag was set to false, then all of the 'interesting'
-objects must be found in separate revision caches.
+objects must be found in separate revision caches for the function to
+return true.
 
 If any 'uninteresting' objects were passed, then the return value is
-always false.
+true if the suitability function passes for the revision caches which
+are used.
 
 
 Returning objects
@@ -118,7 +148,12 @@ list.
 
   rev_cache_fetch() : oid
 
-If returning objects from a single revision cache, it opens the 
+If returning objects from a single or stacked set of revision caches,
+it opens the caches and returns objects from them.  If combining
+results from multiple caches (where topological ordering of returned
+objects is not important) then an in-memory object hash table must be
+built, or the on-disk tables for all of the caches consulted along the
+way.
 
 
 Accelerating in-progress walking
@@ -142,7 +177,7 @@ an 'interesting' object added, then call:
   rev_cache_create( )
 
 This function will not work, if multiple 'interesting' objects are
-passed, or any 'uninteresting' objects were passed.
+passed.
 
 This function must revision walk the commit graph, sorting in
 --date-order along the way, and may emit revisions as they are
@@ -184,9 +219,12 @@ list.
 If multiple revision caches were used for multiple 'interesting'
 objects, then the number of objects can be obtained by building a hash
 table of all the objects in all of the caches, and returning the
-number of hash table entries.
+number of hash table entries.  In the single-file stacked revision
+cache case, the total can be found by adding up the total lengths of
+the object lists.
 
-If 'uninteresting' objects were passed, no cache can be suitable.
+If 'uninteresting' objects were passed, the caches used must be
+suitable according to the cache suitability function.
 
 
 Re-using deltas
@@ -206,8 +244,9 @@ This implies that each delta base must be looked up in the on-disk
 hash table as they are written, which is both low impact and memory
 efficient.
 
-For later fetches, the revision cache is not appropriate as they will
-have 'uninteresting' objects set.
+For later fetches, the revision cache will only be appropriate if the
+'have' objects sent by the remote are not found in the revision
+caches' object hash table.
 
 
 Re-using deltas - 'thin' pack
@@ -217,8 +256,13 @@ This case is much like the normal re-using deltas case, except there
 is the complete set of objects that the remote has claimed to have to
 consider.
 
-The cache is not yet sophisticated enough to assist with this use
-case.
+The revision cache can assist with this case only if the 'have'
+objects sent by the remote match the 'uninteresting' objects in the
+revision cache (or are not found in the object list), and another
+revision cache exists which uses that 'uninteresting' object as its
+'start' object.  In this case, the lower stacked revision cache serves
+as a handy lookup table as to whether the object is known to the
+remote.
 
 
 'shallow' clone considerations
@@ -239,9 +283,10 @@ The cache is not yet sophisticated enough to assist with this case.
 creating bundles
 ~~~~~~~~~~~~~~~~
 
-So long as a bundle has no 'uninteresting' commits, then the revision
-cache is completely appropriate; with the length of the object list it
-can write a header and continue with the 'pack-objects' use case.
+So long as a bundle's 'uninteresting' commits match that of the
+revision cache, then the revision cache is completely appropriate;
+with the length of the object list it can write a header and continue
+with the 'pack-objects' use case.
 
 
 slicing bundles (mirror-sync)
-- 
debian.1.5.6.1
