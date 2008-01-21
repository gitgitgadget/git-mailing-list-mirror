From: Nicolas Pitre <nico@cam.org>
Subject: Re: pack-objects: Fix segfault when object count is less than thread
 count
Date: Mon, 21 Jan 2008 11:07:15 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0801211103480.20753@xanadu.home>
References: <1200926145-14625-1-git-send-email-vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sergey Vlasov <vsu@altlinux.ru>
X-From: git-owner@vger.kernel.org Mon Jan 21 17:08:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGzBn-0001zw-Tj
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 17:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758015AbYAUQHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 11:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757324AbYAUQHR
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 11:07:17 -0500
Received: from relais.videotron.ca ([24.201.245.36]:54684 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756991AbYAUQHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 11:07:16 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JV000JMC4S3M930@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 21 Jan 2008 11:07:15 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <1200926145-14625-1-git-send-email-vsu@altlinux.ru>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71288>

On Mon, 21 Jan 2008, Sergey Vlasov wrote:

> When partitioning the work amongst threads, dividing the number of
> objects by the number of threads may return 0 when there are less
> objects than threads; this will cause the subsequent code to segfault
> when accessing list[sub_size-1].  Fix this by ensuring that sub_size
> is not zero if there is at least one object to process.

No.  Forcing one object in a thread is counter productive since it won't 
have anything to delta against.  Instead, the thread should be allowed 
to have zero objects and let the other threads have more.

This patch would be a proper fix:

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index ec10238..d3efeff 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1672,7 +1672,8 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 		p[i].data_ready = 0;
 
 		/* try to split chunks on "path" boundaries */
-		while (sub_size < list_size && list[sub_size]->hash &&
+		while (sub_size && sub_size < list_size &&
+		       list[sub_size]->hash &&
 		       list[sub_size]->hash == list[sub_size-1]->hash)
 			sub_size++;
 
