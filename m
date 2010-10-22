From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH] make pack-objects a bit more resilient to repo corruption
Date: Fri, 22 Oct 2010 00:53:32 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010220037250.2764@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 06:53:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P99dL-00052r-ER
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 06:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521Ab0JVExe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 00:53:34 -0400
Received: from relais.videotron.ca ([24.201.245.36]:40583 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098Ab0JVExd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 00:53:33 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LAO00E0IDL8OE30@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 22 Oct 2010 00:53:33 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159639>

Right now, packing valid objects could fail when creating a thin pack 
simply because a pack edge object used as a preferred base is corrupted.
Since preferred base objects are not strictly needed to produce a valid
pack, let's not consider the inability to read them as a fatal error.
Delta compression may well be attempted against other objects in the
search window.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---

I wrote this patch while helping Uwe with his repo corruption.  While 
his problem turned out to be different from the one this patch is 
addressing (see previous patch I posted) I think that since I did the 
patch already then this wouldn't hurt to have this one merged too.

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f8eba53..674247e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1298,9 +1298,19 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		read_lock();
 		src->data = read_sha1_file(src_entry->idx.sha1, &type, &sz);
 		read_unlock();
-		if (!src->data)
+		if (!src->data) {
+			if (src_entry->preferred_base) {
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
