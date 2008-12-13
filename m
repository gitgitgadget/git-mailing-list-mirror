From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] pack-objects: don't use too many threads with few objects
Date: Sat, 13 Dec 2008 15:06:40 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812131456040.30035@xanadu.home>
References: <alpine.LFD.2.00.0812111524370.14328@xanadu.home>
 <20081213133238.GA6718@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 13 21:08:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBamj-0001VP-Ez
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 21:08:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbYLMUHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 15:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbYLMUHD
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 15:07:03 -0500
Received: from relais.videotron.ca ([24.201.245.36]:62215 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbYLMUHB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 15:07:01 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KBT00A1ZZV42V50@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 13 Dec 2008 15:06:40 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081213133238.GA6718@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103017>

If there are few objects to deltify, they might be split amongst threads 
so that there is simply no other objects left to delta against within 
the same thread.  Let's use the same 2*window treshold as used for the 
final load balancing to allow extra threads to be created.

This fixes the benign t5300 test failure.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

On Sat, 13 Dec 2008, Jeff King wrote:

> On Thu, Dec 11, 2008 at 03:36:47PM -0500, Nicolas Pitre wrote:
> 
> > ... and display the actual number of threads used when locally 
> > repacking.  A remote server still won't tell you how many threads it 
> > uses during a fetch though.
> 
> Hrm. I have no idea how, but this patch reliably causes t5300 to fail on
> my FreeBSD test box ("next" is broken, bisection pointed to 43cc2b42).

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 619e597..e851534 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1620,6 +1620,10 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 	for (i = 0; i < delta_search_threads; i++) {
 		unsigned sub_size = list_size / (delta_search_threads - i);
 
+		/* don't use too small segments or no deltas will be found */
+		if (sub_size < 2*window && i+1 < delta_search_threads)
+			sub_size = 0;
+
 		p[i].window = window;
 		p[i].depth = depth;
 		p[i].processed = processed;
