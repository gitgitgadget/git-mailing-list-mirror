From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] improve depth heuristic for maximum delta size
Date: Tue, 16 May 2006 16:29:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605161510200.18071@localhost.localdomain>
References: <Pine.LNX.4.64.0605132305580.18071@localhost.localdomain>
 <Pine.LNX.4.64.0605151129540.18071@localhost.localdomain>
 <7v4pzqhh3t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 16 22:29:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fg6AR-00083V-0W
	for gcvg-git@gmane.org; Tue, 16 May 2006 22:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWEPU3P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 16:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWEPU3P
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 16:29:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:15228 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750703AbWEPU3P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 May 2006 16:29:15 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IZD0034LKWQDO60@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 16 May 2006 16:29:14 -0400 (EDT)
In-reply-to: <7v4pzqhh3t.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20134>

This provides a linear decrement on the penalty related to delta depth
instead of being an 1/x function.  With this another 5% reduction is 
observed on packs for both the GIT repo and the Linux kernel repo, as 
well as fixing a pack size regression in another sample repo I have.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

On Mon, 15 May 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > @@ -1038,8 +1038,8 @@ static int try_delta(struct unpacked *tr
> >  
> >  	/* Now some size filtering euristics. */
> >  	size = trg_entry->size;
> > -	max_size = size / 2 - 20;
> > -	if (trg_entry->delta)
> > +	max_size = (size/2 - 20) / (src_entry->depth + 1);
> > +	if (trg_entry->delta && trg_entry->delta_size <= max_size)
> >  		max_size = trg_entry->delta_size-1;
> >  	src_size = src_entry->size;
> >  	sizediff = src_size < size ? size - src_size : 0;
> 
> At the first glance, this seems rather too agressive.  It makes
> me wonder if it is a good balance to penalize the second
> generation base by requiring it to produce a small delta that is
> at most half as we normally would (and the third generation a
> third), or maybe the penalty should kick in more gradually, like
> e.g. ((max_depth * 2 - src_entry->depth) / (max_depth * 2).

You are right.  However your formula converge towards 0.5 which is not 
enough to be sure the bad effect with early eviction of max depth object 
from the object window won't come back.  I prefer this patch with a 
formula converging toward 0.

diff --git a/pack-objects.c b/pack-objects.c
index 566a2a2..3116020 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -1036,9 +1036,12 @@ static int try_delta(struct unpacked *tr
 	if (src_entry->depth >= max_depth)
 		return 0;
 
-	/* Now some size filtering euristics. */
+	/* Now some size filtering heuristics. */
 	size = trg_entry->size;
-	max_size = (size/2 - 20) / (src_entry->depth + 1);
+	max_size = size/2 - 20;
+	max_size = max_size * (max_depth - src_entry->depth) / max_depth;
+	if (max_size == 0)
+		return 0;
 	if (trg_entry->delta && trg_entry->delta_size <= max_size)
 		max_size = trg_entry->delta_size-1;
 	src_size = src_entry->size;
