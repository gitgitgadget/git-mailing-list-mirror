From: Sam Vilain <sam@vilain.net>
Subject: [PATCH 2/7] rev-cache: add on-disk format for fast reachability lookup
Date: Fri, 5 Jun 2009 02:05:12 +1200
Message-ID: <25e92985a657be1d7ea3dd8486cbe404b072a2a2.1244125127.git.sam@vilain.net>
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
	id 1MCSF3-0000qI-U5
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 07:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755033AbZFEFpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 01:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755007AbZFEFpS
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 01:45:18 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:57202 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752800AbZFEFpE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 01:45:04 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1003)
	id 51DD621D11C; Fri,  5 Jun 2009 17:45:00 +1200 (NZST)
In-Reply-To: <cover.1244125127.git.sam@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120745>

As well as storing the sorted list of objects, store a hash table for
faster lookup.

Signed-off-by: Sam Vilain <sam@vilain.net>
---
 Documentation/technical/revision-cache.txt |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/revision-cache.txt b/Documentation/technical/revision-cache.txt
index cc18535..8349cfe 100644
--- a/Documentation/technical/revision-cache.txt
+++ b/Documentation/technical/revision-cache.txt
@@ -14,6 +14,9 @@ A revision cache contains;
 
     * object ID
 
+  - A hash table from an (abbreviated) object ID to a position into
+    the above list
+
 
 Start Object
 ------------
@@ -35,6 +38,18 @@ objects are sorted as if they were commit objects with a single
 parent, the object they tag.
 
 
+Included object hash table
+--------------------------
+
+This index is used to quickly determine if an object exists in the
+index without scanning the entire topological list.
+
+Entries in the object hash table can be shortened, eg to 3 or 4 bytes;
+basically they just need to be long enough to avoid collisions within
+the objects which exist in the list.  Any match must be confirmed by
+checking the full SHA1 in the topological list.
+
+
 Use Cases
 ---------
 In this section, the key functions and operations that this index is
@@ -131,7 +146,8 @@ passed, or any 'uninteresting' objects were passed.
 
 This function must revision walk the commit graph, sorting in
 --date-order along the way, and may emit revisions as they are
-discovered to the topological object list.
+discovered to the topological object list.  It must also build a hash
+table of object IDs and emit it at the end.
 
 
 receive-pack/pack-objects
@@ -186,9 +202,9 @@ emitted, the delta from the packfile is re-used.  If a loop is
 detected or the delta base is not in the returned set of objects, then
 the delta is first resolved.
 
-This implies that the list of objects is first loaded into a hash
-table prior to returning any objects; however this is probably
-acceptable as the entire list is in one stream and will load quickly.
+This implies that each delta base must be looked up in the on-disk
+hash table as they are written, which is both low impact and memory
+efficient.
 
 For later fetches, the revision cache is not appropriate as they will
 have 'uninteresting' objects set.
-- 
debian.1.5.6.1
