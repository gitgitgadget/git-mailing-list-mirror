From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] read-tree A B C: do not create a bogus index and do not
 segfault
Date: Thu, 12 Mar 2009 00:29:13 -0700
Message-ID: <7v3adjjj1y.fsf_-_@gitster.siamese.dyndns.org>
References: <35476bd20903101234q71bc520fh18828d7170a4a2f5@mail.gmail.com>
 <alpine.DEB.1.00.0903102120290.14295@intel-tinevez-2-302>
 <35476bd20903110059v7d6d8aa0g93af17a940c91919@mail.gmail.com>
 <alpine.DEB.1.00.0903111300330.10279@pacific.mpi-cbg.de>
 <7vtz5zjnai.fsf@gitster.siamese.dyndns.org>
 <7vfxhjjkcm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 12 08:31:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhfOI-0001fC-Ng
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 08:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728AbZCLH31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 03:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbZCLH31
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 03:29:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40163 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbZCLH30 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 03:29:26 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7D407A1E5F;
	Thu, 12 Mar 2009 03:29:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1FDBDA1E5C; Thu,
 12 Mar 2009 03:29:15 -0400 (EDT)
In-Reply-To: <7vfxhjjkcm.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 12 Mar 2009 00:01:13 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 825299C6-0ED7-11DE-965C-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113009>

"git read-tree A B C..." without the "-m" (merge) option is a way to read
these trees on top of each other to get an overlay of them.

An ancient commit ee6566e (Rewrite read-tree, 2005-09-05) passed the
ADD_CACHE_SKIP_DFCHECK flag when calling add_index_entry() to add the
paths obtained from these trees to the index, but it is an incorrect use
of the flag.  The flag is meant to be used by callers who know the
addition of the entry does not introduce a D/F conflict to the index in
order to avoid the overhead of checking.

This bug resulted in a bogus index that records both "x" and "x/z" as a
blob after reading three trees that have paths ("x"), ("x", "y"), and
("x/z", "y") respectively.  34110cd (Make 'unpack_trees()' have a separate
source and destination index, 2008-03-06) refactored the callsites of
add_index_entry() incorrectly and added more codepaths that use this flag
when it shouldn't be used.

Also, 0190457 (Move 'unpack_trees()' over to 'traverse_trees()' interface,
2008-03-05) introduced a bug to call add_index_entry() for the tree that
does not have the path in it, passing NULL as a cache entry.  This caused
reading multiple trees, one of which has path "x" but another doesn't, to
segfault.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * I suspect that we can probably remove SKIP_DFCHECK option by fixing
   tree.c::read_tree(); the only caller the big comment at the beginning
   of it talks about is overlay_tree_on_cache() in builtin-ls-files.c and
   we haven't gained any new callers of the function.

   It is a bit sad that a very good looking refactoring and rewriting
   patch introduced this kind of regression that has gone unnoticed for a
   long time.  I managed to point three fingers and they turn out to be
   all ancient commits before v1.5.5.

 unpack-trees.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index cba0aca..5b0a8c1 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -49,7 +49,7 @@ static void add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
 	memcpy(new, ce, size);
 	new->next = NULL;
 	new->ce_flags = (new->ce_flags & ~clear) | set;
-	add_index_entry(&o->result, new, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE|ADD_CACHE_SKIP_DFCHECK);
+	add_index_entry(&o->result, new, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
 }
 
 /* Unlink the last component and attempt to remove leading
@@ -283,9 +283,9 @@ static int unpack_nondirectories(int n, unsigned long mask, unsigned long dirmas
 	if (o->merge)
 		return call_unpack_fn(src, o);
 
-	n += o->merge;
 	for (i = 0; i < n; i++)
-		add_entry(o, src[i], 0, 0);
+		if (src[i] && src[i] != o->df_conflict_entry)
+			add_entry(o, src[i], 0, 0);
 	return 0;
 }
 
-- 
1.6.2.249.g770a0
