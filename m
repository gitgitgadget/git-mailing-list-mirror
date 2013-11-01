From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] unpack-trees: fix "read-tree -u --reset A B" with conflicted index
Date: Fri,  1 Nov 2013 15:44:53 -0700
Message-ID: <1383345895-23341-2-git-send-email-gitster@pobox.com>
References: <20131031172116.GA19428@sigill.intra.peff.net>
 <1383345895-23341-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 01 23:45:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcNSq-0002B6-63
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 23:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755850Ab3KAWpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Nov 2013 18:45:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40452 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754646Ab3KAWpE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 18:45:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E62604D12B;
	Fri,  1 Nov 2013 18:45:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=uk1w
	6X3DylMm9dOvuXYLR9o3eyc=; b=N5JauRvvWwAeRuIciUtj7K+xRvpmMiwWccd7
	1nDRW8i6HXfVtD9bV62vKAf/ndbvPTb+F9c7/U7cYdNL8n6lGgziPWMSwNScnkgb
	IFLph/PsGhsbMpcR6UErR36AU68kLZvtNVy4B5C0cJ9c23Oyf287zuAw7sTyc/B2
	p8XI7F4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	eJc9b82hnOMGYOCF3ZJ/yi7uvGNJWx3vNKLhN2dArV5+z0jq83IjZPzcHUbA2DBe
	rtolHaq4xgaHjB60hRHqlVWXf5HJ2/vEZpUlVi5ljQr9q0jA4KYLIwX458+tIqkl
	GV2BhgX/NQZjXgN3koyX3syLD5VkXgQ41Wdf0E1Uy8Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D61974D12A;
	Fri,  1 Nov 2013 18:45:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32F454D129;
	Fri,  1 Nov 2013 18:45:03 -0400 (EDT)
X-Mailer: git-send-email 1.8.5-rc0-281-g8951339
In-Reply-To: <1383345895-23341-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 3F21B692-4347-11E3-8C76-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237225>

From: Jeff King <peff@peff.net>

When we call "read-tree --reset -u HEAD ORIG_HEAD", the first thing we
do with the index is to call read_cache_unmerged.  Originally that
would read the index, leaving aside any unmerged entries.  However, as
of d1a43f2 (reset --hard/read-tree --reset -u: remove unmerged new
paths, 2008-10-15), it actually creates a new cache entry to serve as
a placeholder, so that we later know to update the working tree.

However, we later noticed that the sha1 of that unmerged entry was
just copied from some higher stage, leaving you with random content in
the index.  That was fixed by e11d7b5 ("reset --merge": fix unmerged
case, 2009-12-31), which instead puts the null sha1 into the newly
created entry, and sets a CE_CONFLICTED flag. At the same time, it
teaches the unpack-trees machinery to pay attention to this flag, so
that oneway_merge throws away the current value.

However, it did not update the code paths for twoway_merge, which is
where we end up in the two-way read-tree with --reset. We notice that
the HEAD and ORIG_HEAD versions are the same, and say "oh, we can just
reuse the current version". But that's not true. The current version
is bogus.

Notice this case and make sure we do not keep the bogus entry; either
we do not have that path in the tree we are moving to (i.e. remove
it), or we want to have the cache entry we created for the tree we are
moving to (i.e. resolve by explicitly saying the "newtree" version is
what we want).

[jc: this is from the almost year-old $gmane/212316; the credit goes
to Peff, but we need his sign-off]

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 unpack-trees.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 7c9ecf6..bf978e1 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1728,14 +1728,23 @@ int twoway_merge(struct cache_entry **src, struct unpack_trees_options *o)
 		newtree = NULL;
 
 	if (current) {
-		if ((!oldtree && !newtree) || /* 4 and 5 */
-		    (!oldtree && newtree &&
-		     same(current, newtree)) || /* 6 and 7 */
-		    (oldtree && newtree &&
-		     same(oldtree, newtree)) || /* 14 and 15 */
-		    (oldtree && newtree &&
-		     !same(oldtree, newtree) && /* 18 and 19 */
-		     same(current, newtree))) {
+		if (current->ce_flags & CE_CONFLICTED) {
+			if (same(oldtree, newtree) || o->reset) {
+				if (!newtree)
+					return deleted_entry(current, current, o);
+				else
+					return merged_entry(newtree, current, o);
+			}
+			return o->gently ? -1 : reject_merge(current, o);
+		}
+		else if ((!oldtree && !newtree) || /* 4 and 5 */
+			 (!oldtree && newtree &&
+			  same(current, newtree)) || /* 6 and 7 */
+			 (oldtree && newtree &&
+			  same(oldtree, newtree)) || /* 14 and 15 */
+			 (oldtree && newtree &&
+			  !same(oldtree, newtree) && /* 18 and 19 */
+			  same(current, newtree))) {
 			return keep_entry(current, o);
 		}
 		else if (oldtree && !newtree && same(current, oldtree)) {
-- 
1.8.5-rc0-281-g8951339
