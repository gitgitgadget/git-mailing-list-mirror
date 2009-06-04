From: Sam Vilain <sam@vilain.net>
Subject: [PATCH 1/7] revision-cache: define revision cache as simple list of revisions
Date: Fri, 5 Jun 2009 02:05:12 +1200
Message-ID: <b054cddea58213268b872cf43c725960e6e2dc5b.1244125127.git.sam@vilain.net>
References: <cover.1244125127.git.sam@vilain.net>
Cc: Nick Edelen <sirnot@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 07:46:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCSFw-0001n0-5U
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 07:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755050AbZFEFpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 01:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755087AbZFEFpX
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 01:45:23 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:57207 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754827AbZFEFpE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 01:45:04 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1003)
	id 5F48D21D11A; Fri,  5 Jun 2009 17:45:00 +1200 (NZST)
In-Reply-To: <cover.1244125127.git.sam@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120750>

The very first thing that we want out of the revision cache is to be
able to go from a commit to all of its referred objects.  Define a
revision cache that includes just that.

Signed-off-by: Sam Vilain <sam@vilain.net>
---
 Documentation/technical/revision-cache.txt |  260 ++++++++++++++++++++++++++++
 1 files changed, 260 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/technical/revision-cache.txt

diff --git a/Documentation/technical/revision-cache.txt b/Documentation/technical/revision-cache.txt
new file mode 100644
index 0000000..cc18535
--- /dev/null
+++ b/Documentation/technical/revision-cache.txt
@@ -0,0 +1,260 @@
+Revision Cache Format
+=====================
+
+The revision cache is an on-disk format which allows for certain graph
+reachability operations to be answered quickly.
+
+A revision cache contains;
+
+  - A 'start' object (ie, 'interesting' object ID)
+
+  - A list of objects which are referred to by the 'start' object
+
+    * position when sorted in --date-order
+
+    * object ID
+
+
+Start Object
+------------
+
+The 'start' object is the identifying key of the revision cache.
+
+
+Topological contents list
+-------------------------
+
+This list has fixed-length records, so the topological position into
+the list does not need to be stored in each record - it is implicit
+from the offset.
+
+--date-order is used as it is the strictest sort order available, but
+this still only specifies an ordering for commit objects.  Other
+objects will appear after the object which first refers to them.  Tag
+objects are sorted as if they were commit objects with a single
+parent, the object they tag.
+
+
+Use Cases
+---------
+In this section, the key functions and operations that this index is
+designed to answer are explored.  For each, their efficiency is
+considered in terms of what must be carried out to calculate the
+answer.
+
+
+Determining Cache Suitability - rev_cache_suitable()
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+This is an auxiliary function used by the other use cases, when 
+
+The function is:
+
+  rev_cache_suitable( rev_cache, object )
+
+The check is simple and fast - it just compares the object to the
+'start' object in the revision cache.
+
+
+Revision Walker
+~~~~~~~~~~~~~~~
+
+The revision walker is the main user of this cache; there is the
+generic function of revision walking, as well as commands that want
+specific information which they normally derive from the revision
+walker output.
+
+
+Setting up the walker
+^^^^^^^^^^^^^^^^^^^^^
+
+The functions for this are (intentionally resembling the current
+revision walker API):
+
+  rev_cache_init()
+  rev_cache_add( interesting?, oid )
+
+As well as this setup, it is necessary to specify which options are
+required.  Some API exists to do this, and the return value from
+'rev_cache_ok' is true if suitable caches were found for the
+information required, and false if it would require a graph traversal:
+
+  rev_cache_options( ordered? )
+  rev_cache_ok( ) : Bool
+
+The rev_cache_ok() function must open all available revision caches,
+and see if their 'interesting' object matches the single 'interesting'
+object passed to rev_cache_add().  If it matches, it returns true.  If
+multiple 'interesting' objects were specified and 'ordered' is true,
+then the function returns false.
+
+If the ordering flag was set to false, then all of the 'interesting'
+objects must be found in separate revision caches.
+
+If any 'uninteresting' objects were passed, then the return value is
+always false.
+
+
+Returning objects
+^^^^^^^^^^^^^^^^^
+
+The 'rev_cache_fetch()' iterator returns entries from the topological
+list.
+
+  rev_cache_fetch() : oid
+
+If returning objects from a single revision cache, it opens the 
+
+
+Accelerating in-progress walking
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+It is possible that during a revision iteration operation, a revision
+is discovered that may mean the rest of the revision walking can be
+achieved faster.
+
+In practice, this is likely to be implemented by making in-core cache
+entries for objects with revision caches prior to walking; then when
+encountered the special action can be taken.
+
+
+Creating Revision Caches
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Once the revision cache is setup via rev_cache_init() and
+an 'interesting' object added, then call:
+
+  rev_cache_create( )
+
+This function will not work, if multiple 'interesting' objects are
+passed, or any 'uninteresting' objects were passed.
+
+This function must revision walk the commit graph, sorting in
+--date-order along the way, and may emit revisions as they are
+discovered to the topological object list.
+
+
+receive-pack/pack-objects
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+pack-objects when called from pack-objects is a special user of the
+revision cache; it has the extra requirements of wanting to know;
+
+* how many objects are between 'interesting' and 'uninteresting'
+  objects, at the beginning of the run, to emit the pack header
+
+* for checking re-usability of deltas, whether the delta base object
+  in the pack is in the received set of objects.
+
+* for 'thin' pack generation, whether the delta base object is in the
+  received set of objects, -or- reachable from any 'uninteresting'
+  objects
+
+* for 'shallow' clone, whether the delta base object is reachable
+  without passing any of the 'uninteresting' objects
+
+The aim is for 'pack-objects' to be able to start returning objects
+immediately in the case where a suitable revision cache is returned,
+without waiting for revision counting or repacking.
+
+
+Returning object counts
+^^^^^^^^^^^^^^^^^^^^^^^
+
+If the revision cache was suitable, eg for a complete fetch, then the
+number of objects can be obtained by counting the size of the object
+list.
+
+If multiple revision caches were used for multiple 'interesting'
+objects, then the number of objects can be obtained by building a hash
+table of all the objects in all of the caches, and returning the
+number of hash table entries.
+
+If 'uninteresting' objects were passed, no cache can be suitable.
+
+
+Re-using deltas
+^^^^^^^^^^^^^^^
+
+This applies to the 'Compressing Objects' phase, previously known as
+the 'Deltafying Objects' phase.  Instead of searching for deltas, if
+we can be sure that the existing delta can be resolved on the remote,
+then we can re-use it.
+
+For the initial clone, this operation is simple - as objects are
+emitted, the delta from the packfile is re-used.  If a loop is
+detected or the delta base is not in the returned set of objects, then
+the delta is first resolved.
+
+This implies that the list of objects is first loaded into a hash
+table prior to returning any objects; however this is probably
+acceptable as the entire list is in one stream and will load quickly.
+
+For later fetches, the revision cache is not appropriate as they will
+have 'uninteresting' objects set.
+
+
+Re-using deltas - 'thin' pack
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+This case is much like the normal re-using deltas case, except there
+is the complete set of objects that the remote has claimed to have to
+consider.
+
+The cache is not yet sophisticated enough to assist with this use
+case.
+
+
+'shallow' clone considerations
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+For enumerating objects, the list of objects between the
+'uninteresting' and the 'shallow' commits must first be enumerated,
+and then subtracted from the objects between the 'interesting' and the
+'uninteresting' list.
+
+For re-using deltas for 'thin' packs, the list of objects between
+'uninteresting' and 'shallow' commits are enumerated and marked as
+valid for delta bases.
+
+The cache is not yet sophisticated enough to assist with this case.
+
+
+creating bundles
+~~~~~~~~~~~~~~~~
+
+So long as a bundle has no 'uninteresting' commits, then the revision
+cache is completely appropriate; with the length of the object list it
+can write a header and continue with the 'pack-objects' use case.
+
+
+slicing bundles (mirror-sync)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+For 'slicing' bundles, a deterministic method is required for chopping
+up the list of objects, which can be calculated by any node which has
+the 'interesting' commits.
+
+To determine the objects which fall within a given slice, the object
+list must be enumerated and then divided evenly.  As the compressed
+size on one node cannot be reproduced on another node, the
+uncompressed size of the object is used instead, with the hope that
+slices will generally end up of roughly even size once compressed.
+
+To calculate the object boundaries, the list of objects in
+--date-order must first be tie-broken, eg for commits with the same
+commitdate and topological order.  If slices are allowed to be
+sub-commit level, then objects between commits (ie blobs and trees)
+are also sorted.  Once this deterministic list has been built, then
+all of the objects must be accessed to determine their length.  The
+objects which start within a given range are the ones in the slice.
+
+For re-using deltas in sliced bundles, the delta base is looked up in
+the deterministic list.  If it has an earlier sequence, then the delta
+can be safely re-used.  If it has a later sequence, then the delta
+must be resolved and then the object re-deltified/compressed, using
+only objects with an earlier sequence (or in the returned pack) as a
+base.
+
+This requirement is so that a collection of 'sliced' bundles can
+successfully re-assemble, while still allowing them to be 'thin'.
-- 
debian.1.5.6.1
