From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] pack-objects: fix delta cache size accounting
Date: Fri, 07 Dec 2007 20:27:52 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712072016590.555@xanadu.home>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
 <alpine.LFD.0.9999.0712071632490.12046@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 02:28:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0oUL-0007VZ-3d
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 02:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667AbXLHB1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 20:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752652AbXLHB1y
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 20:27:54 -0500
Received: from relais.videotron.ca ([24.201.245.36]:21604 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506AbXLHB1y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 20:27:54 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSP00ECSIQHBUL0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 07 Dec 2007 20:27:53 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.0.9999.0712071632490.12046@woody.linux-foundation.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67491>

The wrong value was substracted from delta_cache_size when replacing
a cached delta, as trg_entry->delta_size was used after the old size
had been replaced by the new size.

Noticed by Linus.

Signed-off-by: Nicolas Pitre <nico@cam.org> 
---

On Fri, 7 Dec 2007, Linus Torvalds wrote:

> The code in try_delta() that replaces a delta cache entry with another one 
> seems very buggy wrt that whole "delta_cache_size" update. It does
> 
> 	delta_cache_size -= trg_entry->delta_size;
> 
> to account for the old delta going away, but it does this *after* having 
> already replaced trg_entry->delta_size with the new delta entry.

Doh!  Mea culpa.

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 4f44658..350ece4 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1422,10 +1422,6 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		}
 	}
 
-	trg_entry->delta = src_entry;
-	trg_entry->delta_size = delta_size;
-	trg->depth = src->depth + 1;
-
 	/*
 	 * Handle memory allocation outside of the cache
 	 * accounting lock.  Compiler will optimize the strangeness
@@ -1439,7 +1435,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		trg_entry->delta_data = NULL;
 	}
 	if (delta_cacheable(src_size, trg_size, delta_size)) {
-		delta_cache_size += trg_entry->delta_size;
+		delta_cache_size += delta_size;
 		cache_unlock();
 		trg_entry->delta_data = xrealloc(delta_buf, delta_size);
 	} else {
@@ -1447,6 +1443,10 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		free(delta_buf);
 	}
 
+	trg_entry->delta = src_entry;
+	trg_entry->delta_size = delta_size;
+	trg->depth = src->depth + 1;
+
 	return 1;
 }
 
