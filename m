From: Nicolas Pitre <nico@cam.org>
Subject: Re: Preferring shallower deltas on repack
Date: Mon, 09 Jul 2007 11:58:06 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707090954550.26459@xanadu.home>
References: <20070709044326.GH4087@lavos.net>
 <7v1wfixhvk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Brian Downing <bdowning@lavos.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 17:58:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7vcr-0001cd-0w
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 17:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754438AbXGIP6I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 11:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754372AbXGIP6I
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 11:58:08 -0400
Received: from relais.videotron.ca ([24.201.245.36]:27151 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754192AbXGIP6H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 11:58:07 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JKX006YG5OUM0C0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Jul 2007 11:58:06 -0400 (EDT)
In-reply-to: <7v1wfixhvk.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52003>

On Sun, 8 Jul 2007, Junio C Hamano wrote:

> It would become worrysome (*BUT* infinitely more interesting)
> once you start talking about a tradeoff between slightly larger
> delta and much shorter delta.  Such a tradeoff, if done right,
> would make a lot of sense, but I do not offhand think of a way
> to strike a proper balance between them efficiently.

We already do something similar to that with max_size being a function 
of the delta depth.  This already has the effect of favoring shalower 
deltas even if deeper deltas could be smaller, and therefore creating a 
wider delta tree (see commits 4e8da195 and c3b06a69).

Maybe this max_size curve could be modified a bit to increase the bias 
towards shallow deltas even in the case where a delta was already found 
instead of the current constant flat curve.

[...]

OK here it is.  And results on the GIT repo and another patalogical test 
repo I keep around are actually really nice!  Not only the pack itself 
is a bit smaller, but the delta depth distribution as shown by 
git-verify-pack -v is much nicer with the bulk of deltas in the low 
depth end of the spectrum and no more peak at the max depth level.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 54b9d26..1eb86ed 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1332,12 +1332,14 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 
 	/* Now some size filtering heuristics. */
 	trg_size = trg_entry->size;
-	max_size = trg_size/2 - 20;
+	if (!trg_entry->delta)
+		max_size = trg_size/2 - 20;
+	else
+		max_size = trg_entry->delta_size * max_depth /
+				(max_depth - trg_entry->depth + 1);
 	max_size = max_size * (max_depth - src_entry->depth) / max_depth;
 	if (max_size == 0)
 		return 0;
-	if (trg_entry->delta && trg_entry->delta_size <= max_size)
-		max_size = trg_entry->delta_size;
 	src_size = src_entry->size;
 	sizediff = src_size < trg_size ? trg_size - src_size : 0;
 	if (sizediff >= max_size)
