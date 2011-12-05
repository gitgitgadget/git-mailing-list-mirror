From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Bug: git bus error (stack blowout)
Date: Mon, 5 Dec 2011 11:58:17 +0700
Message-ID: <20111205045816.GA31766@do>
References: <CAAcG=3NfvYSjhHDNb8aZ=_O4661bV7jkZBpmc77ZVCFDQQdHJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: vsrinivas@ops101.org
X-From: git-owner@vger.kernel.org Mon Dec 05 05:58:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXQdQ-0005xV-5i
	for gcvg-git-2@lo.gmane.org; Mon, 05 Dec 2011 05:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173Ab1LEE6b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Dec 2011 23:58:31 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52577 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755042Ab1LEE6a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Dec 2011 23:58:30 -0500
Received: by iakc1 with SMTP id c1so1504237iak.19
        for <git@vger.kernel.org>; Sun, 04 Dec 2011 20:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GTPGZ7HeylZV9GHosCo9qTYNMRSLuNFOdTF1q28cLAs=;
        b=HHVj4/2RiqMY55U10kWudrBlQXN2iPDehyTBFm0BscfQmIZww3J5M5YMwazs2l38zl
         jYpnuhTS+rpdyhN5CdIaZPlMEmoXZ3vb2GQ17z5qDUNK7/DVb7gFbGSc13PNlwN08fVo
         gnNGEFXaa7dm6jDNHmM4/RMKOa3cVAbc0D4Yw=
Received: by 10.50.149.165 with SMTP id ub5mr8530459igb.23.1323061109809;
        Sun, 04 Dec 2011 20:58:29 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.41.182])
        by mx.google.com with ESMTPS id g16sm71926531ibs.8.2011.12.04.20.58.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Dec 2011 20:58:28 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 05 Dec 2011 11:58:17 +0700
Content-Disposition: inline
In-Reply-To: <CAAcG=3NfvYSjhHDNb8aZ=_O4661bV7jkZBpmc77ZVCFDQQdHJw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186277>

On Sun, Dec 04, 2011 at 05:50:19PM -0500, Venkatesh Srinivas wrote:
> Hi,
>=20
> When using git 1.7.6.3 from NetBSD's pkgsrc, on this git tree:
> http://gitweb.dragonflybsd.org/pkgsrcv2.git, I got a bus error when
> switching from the pkgsrc-2011q3 branch to the master branch. I have =
a
> core file and the git binary if it'd be helpful; it looks like
> mark_parents_uninteresting() was called recursively entirely too many
> times (>60,000), originally from prepare_revision_walk(), from
> stat_tracking_info(), from format_tracking_info(),
> update_revs_for_switch(), from cmd_checkout().

This patch may fix it for you, although it'd be interesting to
understand how you get into this (I'm still cloning pkgsrcv2.git).

-- 8< --
Subject: [PATCH] Eliminate recursion in setting/clearing marks in commi=
t list

Recursion in a DAG is generally a bad idea because it could be very
deep. Be defensive and avoid recursion in mark_parents_uninteresting()
and clear_commit_marks().

mark_parents_uninteresting() learns a trick from clear_commit_marks()
to avoid malloc() in (dorminant) single-parent case.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 commit.c   |   31 ++++++++++++++++++++-----------
 revision.c |   45 +++++++++++++++++++++++++++++----------------
 2 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/commit.c b/commit.c
index 0775eec..cd19a69 100644
--- a/commit.c
+++ b/commit.c
@@ -423,22 +423,31 @@ struct commit *pop_most_recent_commit(struct comm=
it_list **list,
=20
 void clear_commit_marks(struct commit *commit, unsigned int mark)
 {
-	while (commit) {
-		struct commit_list *parents;
+	struct commit_list *list =3D NULL, *l;
+	commit_list_insert(commit, &list);
+	while (list) {
+		commit =3D list->item;
+		l =3D list;
+		list =3D list->next;
+		free(l);
=20
-		if (!(mark & commit->object.flags))
-			return;
+		while (commit) {
+			struct commit_list *parents;
=20
-		commit->object.flags &=3D ~mark;
+			if (!(mark & commit->object.flags))
+				break;
=20
-		parents =3D commit->parents;
-		if (!parents)
-			return;
+			commit->object.flags &=3D ~mark;
+
+			parents =3D commit->parents;
+			if (!parents)
+				break;
=20
-		while ((parents =3D parents->next))
-			clear_commit_marks(parents->item, mark);
+			while ((parents =3D parents->next))
+				commit_list_insert(parents->item, &list);
=20
-		commit =3D commit->parents->item;
+			commit =3D commit->parents->item;
+		}
 	}
 }
=20
diff --git a/revision.c b/revision.c
index 0aa3638..8d4069e 100644
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
1.7.8.36.g69ee2
-- 8< --
--=20
Duy
