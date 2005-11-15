From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH] Fix llist_sorted_difference_inplace in git-pack-redundant
Date: Tue, 15 Nov 2005 22:24:02 +0100
Message-ID: <437A51F2.4000106@etek.chalmers.se>
References: <81b0412b0511150749g5672158v7b39c02ffdf13e08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	=?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Tue Nov 15 22:26:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec8HQ-0000kR-0s
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 22:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbVKOVXt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 Nov 2005 16:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbVKOVXs
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 16:23:48 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:38886 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1750776AbVKOVXs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 16:23:48 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout1-sn2.hy.skanova.net (7.2.060.1)
        id 4378E9530006C2FA; Tue, 15 Nov 2005 22:23:34 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: junkio@cox.net
In-Reply-To: <81b0412b0511150749g5672158v7b39c02ffdf13e08@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11940>

Simplify and actually make llist_sorted_difference_inplace work
by using llist_sorted_remove instead of duplicating parts of the
code.

Signed-off-by: Lukas Sandstr=C3=83=C2=B6m <lukass@etek.chalmers.se>

---
Looking at the code; I must have been tired when I wrote llist_sorted_d=
ifference_inplace.
This should hopefully fix things up nicely. Note that I think the old v=
ersion got the
case "remove last element from list" wrong too.

I think the Signed-off line is in utf8 this time. Tell me if it works b=
etter, of if I=20
just should change my name ;)

 pack-redundant.c |   47 +++++++++++++++-------------------------------=
-
 1 files changed, 15 insertions(+), 32 deletions(-)

applies-to: 4b6dbe856a3e63699b299c76f4f1fc5cb34cbe26
560aa97889ef028fed0678389d4bb05ebf3ead62
diff --git a/pack-redundant.c b/pack-redundant.c
index 28b82ee..fcb36ff 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -127,38 +127,6 @@ inline struct llist_item * llist_insert_
 	return llist_insert_back(list, sha1);
 }
=20
-/* computes A\B */
-void llist_sorted_difference_inplace(struct llist *A,
-				     struct llist *B)
-{
-	struct llist_item *prev, *a, *b, *x;
-
-	prev =3D a =3D A->front;
-	b =3D B->front;
-
-	while (a !=3D NULL && b !=3D NULL) {
-		int cmp =3D memcmp(a->sha1, b->sha1, 20);
-		if (!cmp) {
-			x =3D a;
-			if (a =3D=3D A->front)
-				A->front =3D a->next;
-			a =3D prev->next =3D a->next;
-
-			if (a =3D=3D NULL) /* end of list */
-				A->back =3D prev;
-			A->size--;
-			free(x);
-			b =3D b->next;
-		} else
-			if (cmp > 0)
-				b =3D b->next;
-			else {
-				prev =3D a;
-				a =3D a->next;
-			}
-	}
-}
-
 /* returns a pointer to an item in front of sha1 */
 inline struct llist_item * llist_sorted_remove(struct llist *list, cha=
r *sha1,
 					       struct llist_item *hint)
@@ -194,6 +162,21 @@ redo_from_start:
 	return prev;
 }
=20
+/* computes A\B */
+void llist_sorted_difference_inplace(struct llist *A,
+				     struct llist *B)
+{
+	struct llist_item *hint, *b;
+
+	hint =3D NULL;
+	b =3D B->front;
+
+	while (b) {
+		hint =3D llist_sorted_remove(A, b->sha1, hint);
+		b =3D b->next;
+	}
+}
+
 inline struct pack_list * pack_list_insert(struct pack_list **pl,
 					   struct pack_list *entry)
 {
---
0.99.9.GIT
