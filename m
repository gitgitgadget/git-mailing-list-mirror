From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] avoid possible overflow in delta size filtering computation
Date: Tue, 24 Mar 2009 15:56:12 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903241535010.26337@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Kjetil Barvik <barvik@broadpark.no>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 20:58:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmCky-0006wg-1I
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 20:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756659AbZCXT4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 15:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756528AbZCXT4V
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 15:56:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:19061 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566AbZCXT4U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 15:56:20 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KH100AIY0PO58J1@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 24 Mar 2009 15:56:12 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114485>

On a 32-bit system, the maximum possible size for an object is less than 
4GB, while 64-bit systems may cope with larger objects.  Due to this 
limitation, variables holding object sizes are using an unsigned long 
type (32 bits on 32-bit systems, or 64 bits on 64-bit systems).

When large objects are encountered, and/or people play with large delta 
depth values, it is possible for the maximum allowed delta size 
computation to overflow, especially on a 32-bit system.  When this 
occurs, surviving result bits may represent a value much smaller than 
what it is supposed to be, or even zero.  This prevents some objects 
from being deltified although they do get deltified when a smaller depth 
limit is used.  Fix this by always performing a 64-bit multiplication.

Signed-off-by: Nicolas Pitre <nico@cam.org>

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 3a4bdbb..9fc3b35 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1293,7 +1293,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		max_size = trg_entry->delta_size;
 		ref_depth = trg->depth;
 	}
-	max_size = max_size * (max_depth - src->depth) /
+	max_size = (uint64_t)max_size * (max_depth - src->depth) /
 						(max_depth - ref_depth + 1);
 	if (max_size == 0)
 		return 0;
