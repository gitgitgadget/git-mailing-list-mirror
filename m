From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] use delta index data when finding best delta matches
Date: Thu, 27 Apr 2006 18:08:57 -0700
Message-ID: <7vy7xqh5g6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604252330190.18520@localhost.localdomain>
	<7vpsj4sxer.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604261341200.18520@localhost.localdomain>
	<Pine.LNX.4.64.0604262210120.18520@localhost.localdomain>
	<Pine.LNX.4.64.0604262351221.18520@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 28 03:09:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZHTj-0007Q1-EV
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 03:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135AbWD1BI7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 21:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbWD1BI7
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 21:08:59 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:47078 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S965135AbWD1BI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Apr 2006 21:08:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060428010858.VFOF19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 27 Apr 2006 21:08:58 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0604262351221.18520@localhost.localdomain>
	(Nicolas Pitre's message of "Wed, 26 Apr 2006 23:58:00 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19260>

Nicolas Pitre <nico@cam.org> writes:

> This patch allows for computing the delta index for each base object 
> only once and reuse it when trying to find the best delta match.
>
> This should set the mark and pave the way for possibly better delta 
> generator algorithms.
>
> Signed-off-by: Nicolas Pitre <nico@cam.org>

My understanding is that theoretically this should not make any
difference to the result, and should run faster when the memory
pressure does not cause the machine to thrash.  However,....

I am seeing some differences.  Even with the smallish "git.git"
repository, packing is slightly slower, and the end result is
smaller.

Here are full packing experiments in a fully unpacked git.git
repository.

("next" version)
Total 17724, written 17724 (delta 11779), reused 0 (delta 0)
31.61user 6.24system 0:37.97elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+431995minor)pagefaults 0swaps

 6520520 pack-next-f1fac077a093ffdaf094aab2b7f11859ec0c18f1.pack

(with "use delta index" patch)
Total 17724, written 17724 (delta 12002), reused 0 (delta 0)
33.26user 6.00system 0:39.33elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+434451minor)pagefaults 0swaps

 6188418 pack-nico-f1fac077a093ffdaf094aab2b7f11859ec0c18f1.pack

Not that I am complaining that it produces better results with a
small performance penalty.  I am curious because I do not
understand where the differences are coming from, and I was
reluctant to merge it in "next" until I understand what is going
on.

But I think I know where the differences come from:

-	sizediff = oldsize > size ? oldsize - size : size - oldsize;
+	sizediff = src_size < size ? size - src_size : 0;

There is another "omit smaller than 50" difference but that
should not trigger -- we do not have files that small.

The size-diff change sort-of makes sense -- you are counting how
much the target grew, which you are likely to need to represent
as additions of literal data, and there is no reason to limit
the diff if the size difference that is greater than maxsize is
in the other direction (deletion).

So, I "backported" that part of the change on top of "next" and
tried the same experiment.

(without "use delta index" but the size heuristics part ported to "next")
Total 17724, written 17724 (delta 12002), reused 0 (delta 0)
36.92user 6.55system 0:43.75elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+431860minor)pagefaults 0swaps

 6188418 pack-size-f1fac077a093ffdaf094aab2b7f11859ec0c18f1.pack

And now the resulting pack is the same as what you produce.

So comparing 31.61 seconds vs 33.26 seconds and complaining you
made it slower is not fair.  You fixed the size heuristic logic
in the current code to produce 5% smaller pack (which made
things slower to spend 36.92 seconds while doing so -- that's
15% slowdown), and then reusing delta-index brought that penalty
down to 5% or so.


-- >8 --

This patch applies on top of "next" to match the size heuristics
used in the "reuse delta index" patch.

 pack-objects.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/pack-objects.c b/pack-objects.c
index c0acc46..6604338 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -1032,12 +1032,6 @@ static int try_delta(struct unpacked *cu
 		max_depth -= cur_entry->delta_limit;
 	}
 
-	size = cur_entry->size;
-	oldsize = old_entry->size;
-	sizediff = oldsize > size ? oldsize - size : size - oldsize;
-
-	if (size < 50)
-		return -1;
 	if (old_entry->depth >= max_depth)
 		return 0;
 
@@ -1048,9 +1042,12 @@ static int try_delta(struct unpacked *cu
 	 * more space-efficient (deletes don't have to say _what_ they
 	 * delete).
 	 */
+	size = cur_entry->size;
 	max_size = size / 2 - 20;
 	if (cur_entry->delta)
 		max_size = cur_entry->delta_size-1;
+	oldsize = old_entry->size;
+	sizediff = oldsize < size ? size - oldsize : 0;
 	if (sizediff >= max_size)
 		return 0;
 	delta_buf = diff_delta(old->data, oldsize,
@@ -1109,6 +1106,9 @@ static void find_deltas(struct object_en
 			 */
 			continue;
 
+		if (entry->size < 50)
+			continue;
+
 		free(n->data);
 		n->entry = entry;
 		n->data = read_sha1_file(entry->sha1, type, &size);
