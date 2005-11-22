From: =?ISO-8859-15?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: Re: [PATCH] speedup allocation in pack-redundant.c
Date: Wed, 23 Nov 2005 00:55:07 +0100
Organization: Chalmers
Message-ID: <4383AFDB.90907@etek.chalmers.se>
References: <81b0412b0511220656l528436b1xea80ee18965e4dda@mail.gmail.com> <7vek58ct4b.fsf@assigned-by-dhcp.cox.net> <20051122230011.GA2916@steel.home> <4383A66D.2030201@etek.chalmers.se> <20051122233845.GC2916@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Nov 23 00:55:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EehyA-0002jo-NE
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 00:54:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbVKVXyf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 22 Nov 2005 18:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbVKVXyf
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 18:54:35 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:4587 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1030260AbVKVXyf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 18:54:35 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout1-sn2.hy.skanova.net (7.2.060.1)
        id 438335A2000210B5; Wed, 23 Nov 2005 00:54:32 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20051122233845.GC2916@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12589>

Alex Riesen wrote:
> Lukas Sandstr=F6m, Wed, Nov 23, 2005 00:14:53 +0100:
>=20
>>>>I think making allocation/deallocation to the central place is a
>>>>good cleanup, but I am not sure about the free-nodes reusing.
>>>>Does this make difference in real life?
>>>
>>>It definitely does, though nor very much. I have no real numbers at
>>>hand (being home now), but I remember it was 1 min with against 3 mi=
n
>>>without the patch on cygwin+fat32, which is already bad enough all b=
y
>>>itself. Very big repository with no redundant packs in it.
>>
>>Would you mind sharing the .idx files?
>=20
>=20
> this time I probably would (they're not here)... But for a perfomance
> testing any big repository will do, linux kernel, for example.
>=20
The problem is that the large repository I have contains lots of
redundant packs, which makes quite fast to find a complete set
and end the search. If you don't have any redundant packs, the
complete set search really is 2**n (n =3D the number of packs).

I did some quick experiments with slab allocation and got a 4.4%
improvement on the redundant repo, so that might be worth persuing.=20
(Concept patch below)

diff --git a/pack-redundant.c b/pack-redundant.c
index b38baa9..05294f8 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -8,6 +8,8 @@
=20
 #include "cache.h"
=20
+#define BLKSIZE 1024
+
 static const char pack_redundant_usage[] =3D
 "git-pack-redundant [ --verbose ] [ --alt-odb ] < --all | <.pack filen=
ame> ...>";
=20
@@ -38,24 +40,28 @@ struct pll {
=20
 static struct llist_item *free_nodes =3D NULL;
=20
+static inline void llist_item_put(struct llist_item *item)
+{
+	item->next =3D free_nodes;
+	free_nodes =3D item;
+}
+
 static inline struct llist_item *llist_item_get()
 {
 	struct llist_item *new;
 	if ( free_nodes ) {
 		new =3D free_nodes;
 		free_nodes =3D free_nodes->next;
-	} else
-		new =3D xmalloc(sizeof(struct llist_item));
-
+	} else {
+		int i =3D 1;
+		new =3D xmalloc(sizeof(struct llist_item) * BLKSIZE);
+		for(;i < BLKSIZE; i++) {
+			llist_item_put(&new[i]);
+		}
+	}
 	return new;
 }
=20
-static inline void llist_item_put(struct llist_item *item)
-{
-	item->next =3D free_nodes;
-	free_nodes =3D item;
-}
-
 static void llist_free(struct llist *list)
 {
 	while((list->back =3D list->front)) {
