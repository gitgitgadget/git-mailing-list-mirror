From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] fix diff-delta bad memory access
Date: Wed, 10 May 2006 12:26:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605101216360.24505@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 10 18:26:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdrVt-0000fT-Uc
	for gcvg-git@gmane.org; Wed, 10 May 2006 18:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbWEJQ0K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 12:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbWEJQ0K
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 12:26:10 -0400
Received: from relais.videotron.ca ([24.201.245.36]:63418 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965012AbWEJQ0J
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 May 2006 12:26:09 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IZ200AL45NKPOJ0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 10 May 2006 12:26:08 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19887>

It cannot be assumed that the given buffer will never be moved when 
shrinking the allocated memory size with realloc().  So let's ignore 
that optimization for now.

This patch makes Electric Fence happy on Linux.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

I can't tell if that fixes it on BSD and Cygwin though.


diff --git a/Makefile b/Makefile
diff --git a/diff-delta.c b/diff-delta.c
index c618875..25a798d 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -199,7 +199,6 @@ struct delta_index * create_delta_index(
 			entry->next = hash[i];
 			hash[i] = entry++;
 			hash_count[i]++;
-			entries--;
 		}
 	}
 
@@ -230,10 +229,6 @@ struct delta_index * create_delta_index(
 	}
 	free(hash_count);
 
-	/* If we didn't use all hash entries, free the unused memory. */
-	if (entries)
-		index = realloc(index, memsize - entries * sizeof(*entry));
-
 	return index;
 }
 
