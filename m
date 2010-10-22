From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH v2] make pack-objects a bit more resilient to repo corruption
Date: Fri, 22 Oct 2010 16:26:23 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010221606550.2764@xanadu.home>
References: <alpine.LFD.2.00.1010220037250.2764@xanadu.home>
 <20101022144600.GA5554@sigill.intra.peff.net>
 <alpine.LFD.2.00.1010221427390.2764@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 22 22:26:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9OC6-0001YJ-8R
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 22:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757297Ab0JVU0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 16:26:25 -0400
Received: from relais.videotron.ca ([24.201.245.36]:56630 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab0JVU0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 16:26:24 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LAP009ATKRQO2C0@vl-mh-mrz21.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 22 Oct 2010 16:26:15 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.2.00.1010221427390.2764@xanadu.home>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159745>

Right now, packing valid objects could fail when creating a thin pack
simply because a pack edge object used as a preferred base is corrupted.
Since preferred base objects are not strictly needed to produce a valid
pack, let's not consider the inability to read them as a fatal error.
Delta compression may well be attempted against other objects in the
search window.  To avoid warning storms (we are in the inner loop of
the delta search window) a warning is emitted only on the first 
occurrence.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---

On Fri, 22 Oct 2010, Nicolas Pitre wrote:

> On Fri, 22 Oct 2010, Jeff King wrote:
> 
> > By converting this die() into a silent return, are we losing a place
> > where git might previously have alerted a user to corruption? In this
> > case, we can continue the operation without the object, but if we have
> > detected corruption, letting the user know as soon as possible is
> > probably a good idea.
> > 
> > In other words, should this instead be:
> > 
> >   warning("unable to read preferred base object: %s", ...);
> >   return 0;
> 
> Well, this get called repeatedly, being within the inner part of the 
> delta search loop.  So you might get that warning as many times as the 
> delta window which is not that nice.  If anything a static flag to 
> display the warning only once would be needed.  But you're pretty likely 
> to have met that warning/error already from other operations, which is 
> why I didn't bother.
> 
> > Or will some other part of the code already complained to stderr?
> 
> Some other part is likely to already have complained, through 
> check_object() -> sha1_object_info().  But not necessarily in all cases.

OK... After further analysis, it seems that the cases when problem 
objects are already warned about through sha1_object_info(), those 
objects will never end up in the delta search window, as their type ends 
up being a negative error code.  We already support that possibility on 
purpose even.

So let's add a warning for when check_object() was able to bypass
the more expensive sha1_object_info() call and therefore object 
corruptions remain undetected until that point.

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f8eba53..81155b4 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1298,9 +1298,23 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		read_lock();
 		src->data = read_sha1_file(src_entry->idx.sha1, &type, &sz);
 		read_unlock();
-		if (!src->data)
+		if (!src->data) {
+			if (src_entry->preferred_base) {
+				static int warned = 0;
+				if (!warned++)
+					warning("object %s cannot be read",
+						sha1_to_hex(src_entry->idx.sha1));
+				/* 
+				 * Those objects are not included in the
+				 * resulting pack.  Be resilient and ignore
+				 * them if they can't be read, in case the
+				 * pack could be created nevertheless.
+				 */
+				return 0;
+			}
 			die("object %s cannot be read",
 			    sha1_to_hex(src_entry->idx.sha1));
+		}
 		if (sz != src_size)
 			die("object %s inconsistent object length (%lu vs %lu)",
 			    sha1_to_hex(src_entry->idx.sha1), sz, src_size);
