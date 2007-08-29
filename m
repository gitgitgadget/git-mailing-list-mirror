From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Keep last used delta base in the delta window
Date: Wed, 29 Aug 2007 17:02:06 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0708291656410.16727@xanadu.home>
References: <11881617934179-git-send-email-mkoegler@auto.tuwien.ac.at>
 <7v3ay5l5wq.fsf@gitster.siamese.dyndns.org>
 <7vy7fxyy52.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999.0708291339580.16727@xanadu.home>
 <7vsl62p2gg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 23:02:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQUg3-00006G-GP
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 23:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755532AbXH2VCL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 17:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755405AbXH2VCL
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 17:02:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61907 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755340AbXH2VCK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 17:02:10 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JNJ00F2EZRKUTS0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 29 Aug 2007 17:02:09 -0400 (EDT)
In-reply-to: <7vsl62p2gg.fsf@gitster.siamese.dyndns.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56982>

On Wed, 29 Aug 2007, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> >> > Instead of treating the "the last used one happened to be on the
> >> > horizon -- try not to drop it" special case, I wonder if it
> >> > makes sense to float the last used delta base object early in
> >> > the window _after_ it is used.  Wouldn't we keep more than one
> >> > very recently used delta base objects in the window that way?
> >> 
> >> The attached is my quick-and-dirty one.  
> >
> > I like this.  A LRU sorting of base objects is obviously a good thing to 
> > do.  Some comments below.
> 
> Well, I said it is Q&D, because _I_ didn't like what I did ;-).
> 
> The original implementation of window as a plain array of
> "struct unpacked" made perfect sense because its use was strict
> FIFO.  Adding new element and expiring oldest element was just
> an increment of the "idx" integer, and there was no memmove
> overhead.
> 
> If we are to make this into LRU (which I _do_ like), however,
> the data structure's circular FIFO origin makes the code
> unnecessary complex and inefficient, I think.
> 
>  - We can always say 0 is the bottom and (window-1) is the top.
>    Then ((idx+1)%window) becomes unnecessary.  As a bonus, we do
>    not have to disagree if it should be (window <= idx) or (idx
>    >= window).
> 
>  - Shifting elements down to make room can become a single
>    memmove() if we remove the circular FIFO origin from the
>    window implementation.  The Q&D one has tons of structure
>    assignments in each iteration.  It might even make sense to
>    change the window itself an array of "struct unpacked *" and
>    make LRU management into just memmove() of bunch of pointers.

Right.

In the mean time, here's a simplification of your code.  Given that 
runtime appears to be unchanged, this could be used as is and a separate 
patch to clean LRU handling.

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 9b3ef94..c33d00f 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1456,7 +1456,7 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 	do {
 		struct object_entry *entry = list[--i];
 		struct unpacked *n = array + idx;
-		int j;
+		int j, best_base = -1;
 
 		if (!entry->preferred_base)
 			processed++;
@@ -1501,6 +1501,7 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 
 		j = window;
 		while (--j > 0) {
+			int ret;
 			uint32_t other_idx = idx + j;
 			struct unpacked *m;
 			if (other_idx >= window)
@@ -1508,8 +1509,11 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 			m = array + other_idx;
 			if (!m->entry)
 				break;
-			if (try_delta(n, m, max_depth) < 0)
+			ret = try_delta(n, m, max_depth);
+			if (ret < 0)
 				break;
+			else if (ret > 0)
+				best_base = other_idx;
 		}
 
 		/* if we made n a delta, and if n is already at max
@@ -1519,6 +1523,23 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 		if (entry->delta && depth <= n->depth)
 			continue;
 
+		/*
+		 * Move the best delta base up in the window, after the
+		 * currently deltified object, to keep it longer.  It will
+		 * be the first base object to be attempted next.
+		 */
+		if (entry->delta) {
+			struct unpacked swap = array[best_base];
+			int dist = (window + idx - best_base) % window;
+			int dst = best_base;
+			while (dist--) {
+				int src = (dst + 1) % window;
+				array[dst] = array[src];
+				dst = src;
+			}
+			array[dst] = swap;
+		}
+
 		next:
 		idx++;
 		if (count + 1 < window)
