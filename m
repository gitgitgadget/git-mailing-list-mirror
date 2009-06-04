From: Sam Vilain <sam@vilain.net>
Subject: [PATCH 7/7] revision cache: be even stricter with sort order
Date: Fri, 5 Jun 2009 02:05:13 +1200
Message-ID: <00f8798ca56481f207983f6f26fc5fda1f12f337.1244125128.git.sam@vilain.net>
References: <cover.1244125127.git.sam@vilain.net>
Cc: Nick Edelen <sirnot@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 07:45:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCSF1-0000qI-2W
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 07:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888AbZFEFpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 01:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754294AbZFEFpG
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 01:45:06 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:57195 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751284AbZFEFpD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 01:45:03 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1003)
	id 0DC3E21C440; Fri,  5 Jun 2009 17:45:00 +1200 (NZST)
In-Reply-To: <cover.1244125127.git.sam@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120743>

For sliced bundles, there must be absolutely no ambiguity at all about
the sort order.  Define how to break ties, and describe why this
affects mirror-sync.

Signed-off-by: Sam Vilain <sam@vilain.net>
---
 Documentation/technical/revision-cache.txt |   79 +++++++++++++++++++---------
 1 files changed, 54 insertions(+), 25 deletions(-)

diff --git a/Documentation/technical/revision-cache.txt b/Documentation/technical/revision-cache.txt
index 0cd7b08..7aaab38 100644
--- a/Documentation/technical/revision-cache.txt
+++ b/Documentation/technical/revision-cache.txt
@@ -14,7 +14,7 @@ A revision cache contains;
   - A list of objects which are referred to by any 'start' object, but
     not by crossing 'end' objects, including:
 
-    * position when sorted in --date-order
+    * position when sorted in --date-order, with ties broken by SHA1
 
     * object ID
 
@@ -33,9 +33,15 @@ A revision cache contains;
     'end' object, but not reachable from the 'start' objects reachable
     from that 'end' object.
 
-  - a list of 'foreign end' objects, for which not all reachable
-    objects are in the object list, but can have reachability or a
-    'newness' bitmap.
+  - a list of 'foreign start' objects, for which not all reachable
+    objects are in the object list, but can have reachability and
+    'newness' bitmaps.
+
+  - a list of object types for each object, in the order they appear
+    in the object list.
+
+  - a list of object lengths for each object, in the order they appear
+    in the object list.
 
 
 Start Objects and End Objects
@@ -64,7 +70,9 @@ from the offset.
 this still only specifies an ordering for commit objects.  Other
 objects will appear after the object which first refers to them.  Tag
 objects are sorted as if they were commit objects with a single
-parent, the object they tag.
+parent, the object they tag.  No object is allowed to appear before
+another object which refers to it, unless it is a 'start' object.
+Ties in the order are broken by SHA1.
 
 
 Included object hash table
@@ -231,6 +239,23 @@ caches whether the object exists and is reachable from the 'start'
 objects which connect to those stacked caches.
 
 
+Extending Revision Caches
+^^^^^^^^^^^^^^^^^^^^^^^^^
+
+  rev_cache_extend( rev_cache, quasi_interesting[] )
+
+The function works on an existing revision cache, and calculates just
+the 'reachability' and 'newness' bitmaps.
+
+These are calculated by marking the quasi_interesting[] commits as
+interesting, the 'end' objects in the revision cache as
+'uninteresting', and walking.
+Objects which are encountered which exist in the revision cache are
+converted to bits in the emitted bitmap, and the 'newness' bitmap is
+built as with the normal case once the reachable 'end' objects are
+known.
+
+
 receive-pack/pack-objects
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -360,28 +385,32 @@ slicing bundles (mirror-sync)
 
 For 'slicing' bundles, a deterministic method is required for chopping
 up the list of objects, which can be calculated by any node which has
-the 'interesting' commits.
-
-To determine the objects which fall within a given slice, the object
-list must be enumerated and then divided evenly.  As the compressed
-size on one node cannot be reproduced on another node, the
-uncompressed size of the object is used instead, with the hope that
-slices will generally end up of roughly even size once compressed.
-
-To calculate the object boundaries, the list of objects in
---date-order must first be tie-broken, eg for commits with the same
-commitdate and topological order.  If slices are allowed to be
-sub-commit level, then objects between commits (ie blobs and trees)
-are also sorted.  Once this deterministic list has been built, then
-all of the objects must be accessed to determine their length.  The
-objects which start within a given range are the ones in the slice.
+the 'interesting' commits.  As topological order is important, bundles
+must only consist of objects from a single revision cache to be sliced
+in this manner.
+
+To determine the objects which fall within a given slice, the new
+object list in the bundle must be enumerated (such as by decompressing
+and masking bitmaps) and then divided evenly, using the (masked)
+object lengths list.  As the compressed size on one node cannot be
+reproduced on another node, the uncompressed size of the object is
+used instead, with the hope that slices will generally end up of
+roughly even size once compressed.
+
+The objects which start within a given range in this list of objects
+are the ones in the slice.  If slices are not allowed at the
+sub-commit level, then the requirement to tie-break ordering of
+non-commit/tag objects is relaxed, however the list of per-object
+types is required to know where the boundaries are.
 
 For re-using deltas in sliced bundles, the delta base is looked up in
-the deterministic list.  If it has an earlier sequence, then the delta
-can be safely re-used.  If it has a later sequence, then the delta
-must be resolved and then the object re-deltified/compressed, using
-only objects with an earlier sequence (or in the returned pack) as a
-base.
+the deterministic list of objects.  If it has an earlier sequence,
+then the delta can be safely re-used.  If it has a later sequence,
+then the delta must be resolved and then the object
+re-deltified/compressed, using only objects with an earlier sequence
+(or in the returned pack) as a base.
 
 This requirement is so that a collection of 'sliced' bundles can
 successfully re-assemble, while still allowing them to be 'thin'.
+Without thin packs, download spreading from multiple mirrors will
+result in a much larger download.
-- 
debian.1.5.6.1
