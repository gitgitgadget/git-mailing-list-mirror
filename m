From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/3] Eliminate recursion in setting/clearing marks in commit list
Date: Mon,  9 Jan 2012 10:59:04 +0700
Message-ID: <1326081546-29320-2-git-send-email-pclouds@gmail.com>
References: <1324901080-23215-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 04:59:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rk6On-0002Mz-HD
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 04:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755379Ab2AID7h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jan 2012 22:59:37 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35276 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755361Ab2AID70 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 22:59:26 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so6123831iae.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 19:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zBBOs1KhCOb5vQ35tbnNgLhzyHInwEWUMtAG+6SQ8m8=;
        b=tulFkVRB1Ahg9mpsL/+d4jpDdlkmctczrUBLiqVqsmSW75hjBchbJPjAXCQ+5XRbBD
         NS9xVE7NvSY+fap0vamuGEG/4HSrKGHNDYO2YZyySfLlI2DzsCABPoggWoE6n3t3yKDk
         J/sYyXoOOJswtxUgX+dMlmIBCNbmdTs7xuYNY=
Received: by 10.42.176.66 with SMTP id bd2mr16198788icb.32.1326081565874;
        Sun, 08 Jan 2012 19:59:25 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id 5sm68752940ibe.8.2012.01.08.19.59.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 19:59:24 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 09 Jan 2012 10:59:16 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1324901080-23215-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188157>

Recursion in a DAG is generally a bad idea because it could be very
deep. Be defensive and avoid recursion in mark_parents_uninteresting()
and clear_commit_marks().

mark_parents_uninteresting() learns a trick from clear_commit_marks()
to avoid malloc() in (dorminant) single-parent case.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 commit.c   |   13 +++++++++++--
 revision.c |   45 +++++++++++++++++++++++++++++----------------
 2 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/commit.c b/commit.c
index 44bc96d..c7aefbf 100644
--- a/commit.c
+++ b/commit.c
@@ -421,7 +421,8 @@ struct commit *pop_most_recent_commit(struct commit=
_list **list,
 	return ret;
 }
=20
-void clear_commit_marks(struct commit *commit, unsigned int mark)
+static void clear_commit_marks_1(struct commit_list **plist,
+				 struct commit *commit, unsigned int mark)
 {
 	while (commit) {
 		struct commit_list *parents;
@@ -436,12 +437,20 @@ void clear_commit_marks(struct commit *commit, un=
signed int mark)
 			return;
=20
 		while ((parents =3D parents->next))
-			clear_commit_marks(parents->item, mark);
+			commit_list_insert(parents->item, plist);
=20
 		commit =3D commit->parents->item;
 	}
 }
=20
+void clear_commit_marks(struct commit *commit, unsigned int mark)
+{
+	struct commit_list *list =3D NULL;
+	commit_list_insert(commit, &list);
+	while (list)
+		clear_commit_marks_1(&list, pop_commit(&list), mark);
+}
+
 void clear_commit_marks_for_object_array(struct object_array *a, unsig=
ned mark)
 {
 	struct object *object;
diff --git a/revision.c b/revision.c
index 8764dde..7cc72fc 100644
--- a/revision.c
+++ b/revision.c
@@ -139,11 +139,32 @@ void mark_tree_uninteresting(struct tree *tree)
=20
 void mark_parents_uninteresting(struct commit *commit)
 {
-	struct commit_list *parents =3D commit->parents;
+	struct commit_list *parents =3D NULL, *l;
+
+	for (l =3D commit->parents; l; l =3D l->next)
+		commit_list_insert(l->item, &parents);
=20
 	while (parents) {
 		struct commit *commit =3D parents->item;
-		if (!(commit->object.flags & UNINTERESTING)) {
+		l =3D parents;
+		parents =3D parents->next;
+		free(l);
+
+		while (commit) {
+			/*
+			 * A missing commit is ok iff its parent is marked
+			 * uninteresting.
+			 *
+			 * We just mark such a thing parsed, so that when
+			 * it is popped next time around, we won't be trying
+			 * to parse it and get an error.
+			 */
+			if (!has_sha1_file(commit->object.sha1))
+				commit->object.parsed =3D 1;
+
+			if (commit->object.flags & UNINTERESTING)
+				break;
+
 			commit->object.flags |=3D UNINTERESTING;
=20
 			/*
@@ -154,21 +175,13 @@ void mark_parents_uninteresting(struct commit *co=
mmit)
 			 * wasn't uninteresting), in which case we need
 			 * to mark its parents recursively too..
 			 */
-			if (commit->parents)
-				mark_parents_uninteresting(commit);
-		}
+			if (!commit->parents)
+				break;
=20
-		/*
-		 * A missing commit is ok iff its parent is marked
-		 * uninteresting.
-		 *
-		 * We just mark such a thing parsed, so that when
-		 * it is popped next time around, we won't be trying
-		 * to parse it and get an error.
-		 */
-		if (!has_sha1_file(commit->object.sha1))
-			commit->object.parsed =3D 1;
-		parents =3D parents->next;
+			for (l =3D commit->parents->next; l; l =3D l->next)
+				commit_list_insert(l->item, &parents);
+			commit =3D commit->parents->item;
+		}
 	}
 }
=20
--=20
1.7.3.1.256.g2539c.dirty
