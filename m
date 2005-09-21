From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 5/8] fetch.c: Remove some duplicated code in process()
Date: Wed, 21 Sep 2005 20:19:03 +0400 (MSD)
Message-ID: <20050921161903.AC3D2E2FFC8@center4.mivlgu.local>
References: <20050921161829.GA20944@master.mivlgu.local>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 18:22:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI7JN-0006Bd-Si
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 18:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbVIUQTG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 12:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVIUQTG
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 12:19:06 -0400
Received: from mivlgu.ru ([81.18.140.87]:2694 "EHLO center4.mivlgu.local")
	by vger.kernel.org with ESMTP id S1751123AbVIUQTE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 12:19:04 -0400
Received: by center4.mivlgu.local (Postfix, from userid 500)
	id AC3D2E2FFC8; Wed, 21 Sep 2005 20:19:03 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20050921161829.GA20944@master.mivlgu.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9055>

It does not matter if we call prefetch() or set the TO_SCAN flag before
or after adding the object to process_queue.  However, doing it before
object_list_insert() allows us to kill 3 lines of duplicated code.

---

 fetch.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

dc255341f62596b0808c383ef8f3eff044be5515
diff --git a/fetch.c b/fetch.c
--- a/fetch.c
+++ b/fetch.c
@@ -138,18 +138,15 @@ static int process(struct object *obj)
 		/* We already have it, so we should scan it now. */
 		if (obj->flags & TO_SCAN)
 			return 0;
-		object_list_insert(obj, process_queue_end);
-		process_queue_end = &(*process_queue_end)->next;
 		obj->flags |= TO_SCAN;
-		return 0;
+	} else {
+		if (obj->flags & COMPLETE)
+			return 0;
+		prefetch(obj->sha1);
 	}
-	if (obj->flags & COMPLETE)
-		return 0;
+		
 	object_list_insert(obj, process_queue_end);
 	process_queue_end = &(*process_queue_end)->next;
-
-	prefetch(obj->sha1);
-		
 	return 0;
 }
 
