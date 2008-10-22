From: Jeff King <peff@peff.net>
Subject: [RFC PATCH 3/5] correct cache_entry allocation
Date: Wed, 22 Oct 2008 16:30:58 -0400
Message-ID: <20081022203058.GC4547@coredump.intra.peff.net>
References: <20081022202810.GA4439@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 22:32:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KskNJ-0008BD-Dw
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 22:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755097AbYJVUbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 16:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755008AbYJVUbC
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 16:31:02 -0400
Received: from peff.net ([208.65.91.99]:3572 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754399AbYJVUbA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 16:31:00 -0400
Received: (qmail 4174 invoked by uid 111); 22 Oct 2008 20:30:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 22 Oct 2008 16:30:59 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Oct 2008 16:30:58 -0400
Content-Disposition: inline
In-Reply-To: <20081022202810.GA4439@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98901>

Most cache_entry structs are allocated by using the
cache_entry_size macro, which rounds the size of the struct
up to the nearest multiple of 8 bytes (presumably to avoid
memory fragmentation).

There is one exception: the special "conflict entry" is
allocated with an empty name, and so is explicitly given
just one extra byte to hold the NUL.

However, later code doesn't realize that this particular
struct has been allocated differently, and happily tries
reading and copying it based on the ce_size macro, which
assumes the 8-byte alignment.

This can lead to reading uninitalized data, though since
that data is simply padding, there shouldn't be any problem
as a result. Still, it makes sense to hold the padding
assumption so as not to surprise later maintainers.

This fixes valgrind errors in t1005, t3030, t4002, and
t4114.

Signed-off-by: Jeff King <peff@peff.net>
---
 unpack-trees.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index e59d144..e5749ef 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -382,7 +382,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	o->merge_size = len;
 
 	if (!dfc)
-		dfc = xcalloc(1, sizeof(struct cache_entry) + 1);
+		dfc = xcalloc(1, cache_entry_size(0));
 	o->df_conflict_entry = dfc;
 
 	if (len) {
-- 
1.6.0.2.825.g6d19d
