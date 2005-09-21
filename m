From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 3/8] fetch.c: Remove redundant SCANNED flag
Date: Wed, 21 Sep 2005 20:18:59 +0400 (MSD)
Message-ID: <20050921161859.A29A0E2FFC7@center4.mivlgu.local>
References: <20050921161829.GA20944@master.mivlgu.local>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 18:23:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI7JL-0006Bd-Jx
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 18:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbVIUQTD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 12:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbVIUQTC
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 12:19:02 -0400
Received: from mivlgu.ru ([81.18.140.87]:1670 "EHLO center4.mivlgu.local")
	by vger.kernel.org with ESMTP id S1751128AbVIUQTA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 12:19:00 -0400
Received: by center4.mivlgu.local (Postfix, from userid 500)
	id A29A0E2FFC7; Wed, 21 Sep 2005 20:18:59 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20050921161829.GA20944@master.mivlgu.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9058>

After adding the SEEN flag, the SCANNED flag became obviously
redundant - each object can get into process_queue through process()
only once, and therefore multiple calls to process_object() for the
same object are not possible.

---

 fetch.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

320120295a258c4b66c43ee3b4ff6af962333950
diff --git a/fetch.c b/fetch.c
--- a/fetch.c
+++ b/fetch.c
@@ -57,7 +57,6 @@ static int process_tree(struct tree *tre
 #define COMPLETE	1U
 #define TO_FETCH	2U
 #define TO_SCAN		4U
-#define SCANNED		8U
 #define SEEN		16U
 
 static struct commit_list *complete = NULL;
@@ -106,10 +105,6 @@ static struct object_list **process_queu
 
 static int process_object(struct object *obj)
 {
-	if (obj->flags & SCANNED)
-		return 0;
-	obj->flags |= SCANNED;
-
 	if (obj->type == commit_type) {
 		if (process_commit((struct commit *)obj))
 			return -1;
@@ -142,7 +137,7 @@ static int process(struct object *obj)
 	if (has_sha1_file(obj->sha1)) {
 		parse_object(obj->sha1);
 		/* We already have it, so we should scan it now. */
-		if (obj->flags & (SCANNED | TO_SCAN))
+		if (obj->flags & TO_SCAN)
 			return 0;
 		object_list_insert(obj, process_queue_end);
 		process_queue_end = &(*process_queue_end)->next;
