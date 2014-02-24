From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 12/19] tree-diff: remove special-case diff-emitting code for empty-tree cases
Date: Mon, 24 Feb 2014 20:21:44 +0400
Message-ID: <dad40b2cf785e5951c105cac936d86a7bc6db8a3.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 17:21:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHyHh-0003kQ-Bp
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 17:21:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775AbaBXQVc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Feb 2014 11:21:32 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:34235 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752498AbaBXQVc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 11:21:32 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WHyHa-00040c-KC; Mon, 24 Feb 2014 20:21:30 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WHyJF-0007A0-LP; Mon, 24 Feb 2014 20:23:13 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242601>

via teaching tree_entry_pathcmp() how to compare empty tree descriptors=
:

While walking trees, we iterate their entries from lowest to highest in
sort order, so empty tree means all entries were already went over.

If we artificially assign +infinity value to such tree "entry", it will
go after all usual entries, and through the usual driver loop we will b=
e
taking the same actions, which were hand-coded for special cases, i.e.

    t1 empty, t2 non-empty
        pathcmp(+=E2=88=9E, t2) -> +1
        show_path(/*t1=3D*/NULL, t2);     /* =3D t1 > t2 case in main l=
oop */

    t1 non-empty, t2-empty
        pathcmp(t1, +=E2=88=9E) -> -1
        show_path(t1, /*t2=3D*/NULL);     /* =3D t1 < t2 case in main l=
oop */

Right now we never go to when compared tree descriptors are infinity, a=
s
this condition is checked in the loop beginning as finishing criteria,
but will do in the future, when there will be several parents iterated
simultaneously, and some pair of them would run to the end.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

( re-posting without change )

 tree-diff.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index cf96ad7..2fd6d0e 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -12,12 +12,19 @@
  *
  * NOTE files and directories *always* compare differently, even when =
having
  *      the same name - thanks to base_name_compare().
+ *
+ * NOTE empty (=3Dinvalid) descriptor(s) take part in comparison as +i=
nfty.
  */
 static int tree_entry_pathcmp(struct tree_desc *t1, struct tree_desc *=
t2)
 {
 	struct name_entry *e1, *e2;
 	int cmp;
=20
+	if (!t1->size)
+		return t2->size ? +1 /* +=E2=88=9E > c */  : 0 /* +=E2=88=9E =3D +=E2=
=88=9E */;
+	else if (!t2->size)
+		return -1;	/* c < +=E2=88=9E */
+
 	e1 =3D &t1->entry;
 	e2 =3D &t2->entry;
 	cmp =3D base_name_compare(e1->path, tree_entry_len(e1), e1->mode,
@@ -151,18 +158,8 @@ int diff_tree(struct tree_desc *t1, struct tree_de=
sc *t2,
 			skip_uninteresting(t1, &base, opt);
 			skip_uninteresting(t2, &base, opt);
 		}
-		if (!t1->size) {
-			if (!t2->size)
-				break;
-			show_path(&base, opt, /*t1=3D*/NULL, t2);
-			update_tree_entry(t2);
-			continue;
-		}
-		if (!t2->size) {
-			show_path(&base, opt, t1, /*t2=3D*/NULL);
-			update_tree_entry(t1);
-			continue;
-		}
+		if (!t1->size && !t2->size)
+			break;
=20
 		cmp =3D tree_entry_pathcmp(t1, t2);
=20
--=20
1.9.rc1.181.g641f458
