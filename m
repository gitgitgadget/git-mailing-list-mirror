From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] speedup allocation in pack-redundant.c
Date: Tue, 22 Nov 2005 15:56:35 +0100
Message-ID: <81b0412b0511220656l528436b1xea80ee18965e4dda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4862_32952149.1132671395430"
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Nov 22 15:59:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeZZa-00008F-8S
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 15:56:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbVKVO4h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 09:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbVKVO4h
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 09:56:37 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:54548 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964941AbVKVO4g (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 09:56:36 -0500
Received: by nproxy.gmail.com with SMTP id x4so155445nfb
        for <git@vger.kernel.org>; Tue, 22 Nov 2005 06:56:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=MjBs4ZfsWpdf/HhkpCGWoXNlYqnc8BUSVNhPm8mFbz2rQHJdDSfv/Kq+RKNKARypUfoqOR/afXu1tu+d6Xg343sKB9hDrMJTDylRePiECJFFKYcRJyyvZ4If6K4Qp+SEDVr2P0gLivGIOdtpctg46Ubjz5tOXFfTqfRNhxPMrBo=
Received: by 10.48.239.10 with SMTP id m10mr387205nfh;
        Tue, 22 Nov 2005 06:56:35 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Tue, 22 Nov 2005 06:56:34 -0800 (PST)
To: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12550>

------=_Part_4862_32952149.1132671395430
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Reuse discarded nodes of llists

------=_Part_4862_32952149.1132671395430
Content-Type: text/plain; 
	name=0001-speedup-allocation-in-pack-redundant.c.txt; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="0001-speedup-allocation-in-pack-redundant.c.txt"

Subject: [PATCH] speedup allocation in pack-redundant.c

Signed-off-by: Alex Riesen <ariesen@harmanbecker.com>


---

 pack-redundant.c |   32 ++++++++++++++++++++++++++------
 1 files changed, 26 insertions(+), 6 deletions(-)

applies-to: 0a8441bc998f995dd35380472314802f53c6e1f3
738ce6cef594ae09b89372859d28f37b1bef9aa1
diff --git a/pack-redundant.c b/pack-redundant.c
index 1519385..3681170 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -36,11 +36,31 @@ struct pll {
 	size_t pl_size;
 };
 
-static inline void llist_free(struct llist *list)
+static struct llist_item *free_nodes = NULL;
+
+static inline struct llist_item *llist_item_get()
+{
+	struct llist_item *new;
+	if ( free_nodes ) {
+		new = free_nodes;
+		free_nodes = free_nodes->next;
+	} else
+		new = xmalloc(sizeof(struct llist_item));
+
+	return new;
+}
+
+static inline void llist_item_put(struct llist_item *item)
+{
+	item->next = free_nodes;
+	free_nodes = item;
+}
+
+static void llist_free(struct llist *list)
 {
 	while((list->back = list->front)) {
 		list->front = list->front->next;
-		free(list->back);
+		llist_item_put(list->back);
 	}
 	free(list);
 }
@@ -62,13 +82,13 @@ static struct llist * llist_copy(struct 
 	if ((ret->size = list->size) == 0)
 		return ret;
 
-	new = ret->front = xmalloc(sizeof(struct llist_item));
+	new = ret->front = llist_item_get();
 	new->sha1 = list->front->sha1;
 
 	old = list->front->next;
 	while (old) {
 		prev = new;
-		new = xmalloc(sizeof(struct llist_item));
+		new = llist_item_get();
 		prev->next = new;
 		new->sha1 = old->sha1;
 		old = old->next;
@@ -82,7 +102,7 @@ static struct llist * llist_copy(struct 
 static inline struct llist_item * llist_insert(struct llist *list,
 					struct llist_item *after, char *sha1)
 {
-	struct llist_item *new = xmalloc(sizeof(struct llist_item));
+	struct llist_item *new = llist_item_get();
 	new->sha1 = sha1;
 	new->next = NULL;
 
@@ -153,7 +173,7 @@ redo_from_start:
 				prev->next = l->next;
 			if (l == list->back)
 				list->back = prev;
-			free(l);
+			llist_item_put(l);
 			list->size--;
 			return prev;
 		}
---
0.99.9.GIT

------=_Part_4862_32952149.1132671395430--
