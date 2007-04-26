From: Junio C Hamano <junkio@cox.net>
Subject: Re: git died
Date: Thu, 26 Apr 2007 13:55:47 -0700
Message-ID: <7vvefisvn0.fsf@assigned-by-dhcp.cox.net>
References: <46307671.3090109@beronet.com>
	<Pine.LNX.4.64.0704261126300.15751@reaper.quantumfyre.co.uk>
	<46309924.70401@beronet.com>
	<alpine.LFD.0.98.0704261246270.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian <crich-ml@beronet.com>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 26 22:55:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhB0L-0001vz-1R
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 22:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755065AbXDZUzu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 16:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755066AbXDZUzu
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 16:55:50 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:37964 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755058AbXDZUzt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 16:55:49 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070426205548.RZGQ22040.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 26 Apr 2007 16:55:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id rwvn1W00m1kojtg0000000; Thu, 26 Apr 2007 16:55:48 -0400
In-Reply-To: <alpine.LFD.0.98.0704261246270.9964@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 26 Apr 2007 12:51:52 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45654>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 26 Apr 2007, Christian wrote:
>
>> Julian Phillips wrote:
>> 
>> Loaded symbols for /lib/tls/libnss_dns.so.2
>> #0  decode_tree_entry (desc=0xbff5110c, buf=0x0, size=454) at tree-walk.c:10
>> 10              while ((c = *str++) != ' ') {
>> (gdb) bt
>> #0  decode_tree_entry (desc=0xbff5110c, buf=0x0, size=454) at tree-walk.c:10
>> #1  0x0804b9a8 in mark_tree_uninteresting (tree=0x80d0240) at revision.c:65
>> #2  0x080534cd in main (argc=2, argv=Cannot access memory at address 0x1ca
>> ) at http-push.c:1998
>
> It looks like some strange corruption in http-push.
> 
> You seem to have a NULL "buf" pointer (which certainly explains a 
> SIGSEGV!), but mark_tree_uninteresting will have done
>
> 	if (parse_tree(tree) < 0)
> 		die("bad tree %s", sha1_to_hex(obj->sha1));
>
> 	init_tree_desc(&desc, tree->buffer, tree->size);
> 	while (tree_entry(&desc, &entry)) {
> 		..
>
>
> and tree_entry() does
>
> 	*entry = desc->entry;
> 	update_tree_entry(desc);
>
> and none of that sets "entry->buf" to NULL unless "size" was also zero.

This has been bugging me for quite some time by now.

The call to parse_tree is coming from mark_edge_parents_uninteresting(),
which in turn is called from mark_edges_uninteresting(), both in
http-push.c

However, I think these two functions are cut&paste from old rev-list.c,
which we refactored into list-objects.c some time ago (list-objects.c
has almost identical looking functions).

I admit that I do not care much about http-push, but I looked at
these two functions in list-objects.c; it is not clear why we do
not get the same error while running rev-list --objects-edge
(aka "thin pack transfer").

mark_edges_uninteresting calls mark_tree_uninteresting() on the
tree associated with uninteresting edge commits.  I am
reasonably sure that these commits have always been parsed when
prepare_revision_walk() returns.  However, it also calls
mark_edge_parents_uninteresting(), trying to make the parent
commit and its tree uninteresting.  I do not see how we are
guaranteeing that the parents are parsed (and their trees are
available to us).

While I think your analysis above is correct, which means that
the breakage Julian is seeing (which does not have NULL tree
object) has nothing to do with what I observed above, I'd sleep
better if we had something like this patch:


 http-push.c    |    2 ++
 list-objects.c |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/http-push.c b/http-push.c
index e3f7675..156f42e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1995,6 +1995,8 @@ static void mark_edge_parents_uninteresting(struct commit *commit)
 		struct commit *parent = parents->item;
 		if (!(parent->object.flags & UNINTERESTING))
 			continue;
+		if (!parent->object.parsed)
+			parse_object(parent->object.sha1);
 		mark_tree_uninteresting(parent->tree);
 	}
 }
diff --git a/list-objects.c b/list-objects.c
index 310f8d3..c2e74f1 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -109,6 +109,8 @@ static void mark_edge_parents_uninteresting(struct commit *commit,
 		struct commit *parent = parents->item;
 		if (!(parent->object.flags & UNINTERESTING))
 			continue;
+		if (!parent->object.parsed)
+			parse_object(parent->object.sha1);
 		mark_tree_uninteresting(parent->tree);
 		if (revs->edge_hint && !(parent->object.flags & SHOWN)) {
 			parent->object.flags |= SHOWN;
