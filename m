From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/21] tree_entry_interesting(): remove dependency on struct diff_options
Date: Wed, 15 Dec 2010 22:02:39 +0700
Message-ID: <1292425376-14550-5-git-send-email-pclouds@gmail.com>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 16:09:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSszG-0003Ou-OU
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 16:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754880Ab0LOPJk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 10:09:40 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63241 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab0LOPJj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 10:09:39 -0500
Received: by yxt3 with SMTP id 3so1089047yxt.19
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 07:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=U5kQu3MiKqq+f+TlaQ6CRO3tq2/dxO/PQP20Zscqevg=;
        b=Xgbjnbx28LpmRacObufE61dXMw5wAafsT5B0BkHjQFXvIw8Vtw9MlFKcpcq+jcD8Cl
         vw+wGKLz2F5MMqB57CVz0lWVnDp0BuP0lTvqUaGMBRP/sPg8golSJ5Ox54t7cOxozz4k
         jE1HegNWGsM06WhhINg2BsV2sY/0NrpCcv+Vg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rB9zSvH9dzsD3LW0PVJLzUYzxgCdGwngfDOYSdfmene8PTFgji7xrOyuXSVc0VVXHI
         74sIxuW1ioMhA/0bmIjmz/OBvjfJxoludQ2uVeXkh8cSHYZI1CLqYEUsX6nd391WuvVO
         pvHE5ZYtjoMJZIbjY1F6KTAECXUShuXJ7/dVM=
Received: by 10.42.224.129 with SMTP id io1mr5905614icb.433.1292425463238;
        Wed, 15 Dec 2010 07:04:23 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.209.213])
        by mx.google.com with ESMTPS id 8sm1044222iba.4.2010.12.15.07.04.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 07:04:22 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 15 Dec 2010 22:03:30 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163776>

This function can be potentially used in more places than just
tree-diff.c. "struct diff_options" does not make much sense outside
diff_tree_sha1().

While removing the use of diff_options, it also removes
tree_entry_extract() call, which means S_ISDIR() uses the entry->mode
directly, without being filtered by canon_mode() (called internally
inside tree_entry_extract).

The only use of the mode information in this function is to check the
type of the entry by giving it to S_ISDIR() macro, and the result does
not change with or without canon_mode(), so it is ok to bypass
tree_entry_extract().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 tree-diff.c |   26 ++++++++++----------------
 1 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 7a4cc4b..57e8909 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -91,24 +91,19 @@ static int compare_tree_entry(struct tree_desc *t1,=
 struct tree_desc *t2, const
  *  - zero for no
  *  - negative for "no, and no subsequent entries will be either"
  */
-static int tree_entry_interesting(struct tree_desc *desc, const char *=
base, int baselen, struct diff_options *opt)
+static int tree_entry_interesting(const struct name_entry *entry, cons=
t char *base, int baselen, const struct pathspec *ps)
 {
-	const char *path;
-	const unsigned char *sha1;
-	unsigned mode;
 	int i;
 	int pathlen;
 	int never_interesting =3D -1;
=20
-	if (!opt->pathspec.nr)
+	if (!ps || !ps->nr)
 		return 1;
=20
-	sha1 =3D tree_entry_extract(desc, &path, &mode);
-
-	pathlen =3D tree_entry_len(path, sha1);
+	pathlen =3D tree_entry_len(entry->path, entry->sha1);
=20
-	for (i =3D 0; i < opt->pathspec.nr; i++) {
-		const struct pathspec_item *item =3D opt->pathspec.items+i;
+	for (i =3D 0; i < ps->nr; i++) {
+		const struct pathspec_item *item =3D ps->items+i;
 		const char *match =3D item->match;
 		int matchlen =3D item->len;
 		int m =3D -1; /* signals that we haven't called strncmp() */
@@ -148,7 +143,7 @@ static int tree_entry_interesting(struct tree_desc =
*desc, const char *base, int
 			 * Does match sort strictly earlier than path
 			 * with their common parts?
 			 */
-			m =3D strncmp(match, path,
+			m =3D strncmp(match, entry->path,
 				    (matchlen < pathlen) ? matchlen : pathlen);
 			if (m < 0)
 				continue;
@@ -175,7 +170,7 @@ static int tree_entry_interesting(struct tree_desc =
*desc, const char *base, int
 		if (matchlen > pathlen) {
 			if (match[pathlen] !=3D '/')
 				continue;
-			if (!S_ISDIR(mode))
+			if (!S_ISDIR(entry->mode))
 				continue;
 		}
=20
@@ -184,7 +179,7 @@ static int tree_entry_interesting(struct tree_desc =
*desc, const char *base, int
 			 * we cheated and did not do strncmp(), so we do
 			 * that here.
 			 */
-			m =3D strncmp(match, path, pathlen);
+			m =3D strncmp(match, entry->path, pathlen);
=20
 		/*
 		 * If common part matched earlier then it is a hit,
@@ -207,8 +202,7 @@ static void show_tree(struct diff_options *opt, con=
st char *prefix, struct tree_
 		if (all_interesting)
 			show =3D 1;
 		else {
-			show =3D tree_entry_interesting(desc, base, baselen,
-						      opt);
+			show =3D tree_entry_interesting(&desc->entry, base, baselen, &opt->=
pathspec);
 			if (show =3D=3D 2)
 				all_interesting =3D 1;
 		}
@@ -267,7 +261,7 @@ static void skip_uninteresting(struct tree_desc *t,=
 const char *base, int basele
 		if (all_interesting)
 			show =3D 1;
 		else {
-			show =3D tree_entry_interesting(t, base, baselen, opt);
+			show =3D tree_entry_interesting(&t->entry, base, baselen, &opt->pat=
hspec);
 			if (show =3D=3D 2)
 				all_interesting =3D 1;
 		}
--=20
1.7.3.3.476.g10a82
