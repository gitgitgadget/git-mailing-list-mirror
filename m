From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] list-objects: mark fewer commits as edges for non-shallow clones
Date: Thu, 11 Dec 2014 03:46:55 +0000
Message-ID: <1418269615-139571-1-git-send-email-sandals@crustytoothpaste.net>
References: <20141211030948.GA137226@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 11 04:47:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xyuif-0004AB-NF
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 04:47:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933615AbaLKDrJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Dec 2014 22:47:09 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55243 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933460AbaLKDrI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2014 22:47:08 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9AD772808F;
	Thu, 11 Dec 2014 03:47:02 +0000 (UTC)
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
In-Reply-To: <20141211030948.GA137226@vauxhall.crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261270>

In commit fbd4a70 (list-objects: mark more commits as edges in
mark_edges_uninteresting - 2013-08-16), we made --thin much more
aggressive by reading lots more trees.  This produces much smaller pack=
s
for shallow clones; however, it causes a significant performance
regression for non-shallow clones with lots of refs (23.322 seconds vs.
4.785 seconds with 22400 refs).  Limit this extra edge-marking to
shallow clones to avoid poor performance.

Suggested-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 list-objects.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/list-objects.c b/list-objects.c
index 2910bec..274ebb4 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -151,13 +151,14 @@ void mark_edges_uninteresting(struct rev_info *re=
vs, show_edge_fn show_edge)
 {
 	struct commit_list *list;
 	int i;
+	int shallow =3D is_repository_shallow();
=20
 	for (list =3D revs->commits; list; list =3D list->next) {
 		struct commit *commit =3D list->item;
=20
 		if (commit->object.flags & UNINTERESTING) {
 			mark_tree_uninteresting(commit->tree);
-			if (revs->edge_hint && !(commit->object.flags & SHOWN)) {
+			if (shallow && revs->edge_hint && !(commit->object.flags & SHOWN)) =
{
 				commit->object.flags |=3D SHOWN;
 				show_edge(commit);
 			}
@@ -165,6 +166,8 @@ void mark_edges_uninteresting(struct rev_info *revs=
, show_edge_fn show_edge)
 		}
 		mark_edge_parents_uninteresting(commit, revs, show_edge);
 	}
+	if (!shallow)
+		return;
 	if (revs->edge_hint) {
 		for (i =3D 0; i < revs->cmdline.nr; i++) {
 			struct object *obj =3D revs->cmdline.rev[i].item;
--=20
2.2.0.rc0.207.ga3a616c
