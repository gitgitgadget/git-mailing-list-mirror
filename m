From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] fix for "index-pack: rationalize delta resolution code"
Date: Mon, 20 Oct 2008 14:12:04 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810201357340.26244@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 00:08:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrzGB-0000vi-Q5
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 20:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbYJTSMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 14:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752406AbYJTSMb
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 14:12:31 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9074 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287AbYJTSMb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 14:12:31 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9100AH3UK4S4O5@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 20 Oct 2008 14:12:05 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98721>

My bad.  A small detail went through the crack: the real_type of
a delta object is the real_type of its base object.

Without this, the created index will be wrong as the actual object SHA1
won't match the object.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

If you got a corrupted .idx file because of this ('git verify-pack' 
should tell) then just toss it and recreate with a fixed 'git 
index-pack'.

Could anyone having problems fetching from kernel.org with git from the 
next branch confirm that this also fixes that? Thanks.

diff --git a/index-pack.c b/index-pack.c
index 0a917d7..8287ebf 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -517,7 +517,7 @@ static void resolve_delta(struct object_entry *delta_obj,
 	void *delta_data;
 	unsigned long delta_size;
 
-	delta_obj->real_type = base->obj->type;
+	delta_obj->real_type = base->obj->real_type;
 	delta_data = get_data_from_pack(delta_obj);
 	delta_size = delta_obj->size;
 	result->obj = delta_obj;
