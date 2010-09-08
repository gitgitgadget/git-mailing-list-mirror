From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/8] tree_entry_interesting(): remove dependency on struct diff_options
Date: Thu,  9 Sep 2010 01:50:18 +1000
Message-ID: <1283961023-4491-4-git-send-email-pclouds@gmail.com>
References: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 09 05:23:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtXiz-0000En-NH
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 05:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753123Ab0IIDWw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 23:22:52 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47382 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047Ab0IIDWv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 23:22:51 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so339297pwi.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 20:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=IiWjGNgPG5TO5ea4HuKPR2guKAl9WRSCTHVdfK7vYTY=;
        b=nmlHY+tr7gEUds27koF3ZQirYxDIXF5Oa1s8yjYTWlzNk1HFoETWiVCn7uNuvdFAIw
         Eh2Y86nnPEcE+xLU50y5jH2uYcH7oOlfFUTdBV+5CIax8U4cd2Yn93CyKXn9hM0C5YVG
         cSgH1+W38hOTtxJMh0cVFQFZWQfLmnCR8zRLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rhJ8rcCbDP46j4jW1FJ1qzFOyNyUJzeIZGmMvVuouX+cVJN8ab2E1W7u7AoZfnvQFR
         EOXgreOGYT9KtY9SD/OdwygCj2mF5bdk5NzcqnCiVrDn2xSxfdBGYwIQuy85ygxUwhEQ
         cd4pJMYxCVCK04PYBTbvJFg90riNuN8dUB7mA=
Received: by 10.143.16.17 with SMTP id t17mr279980wfi.208.1284002570549;
        Wed, 08 Sep 2010 20:22:50 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id t11sm818566wfc.22.2010.09.08.20.22.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Sep 2010 20:22:49 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu,  9 Sep 2010 01:50:54 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g13aff
In-Reply-To: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155832>

This function can be potentially used in more places than just
tree-diff.c. "struct diff_options" does not make much sense outside
diff_tree_sha1().

Moreover people seem to be agree that diff machinery should learn
proper pathspecs too (i.e. globbing, negative pathspecs...), not just
treating pathspecs as tree prefix.

So tree_entry_interesting() now uses struct tree_pathspec_list, which
can be easily extended later on.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 tree-diff.c |   28 +++++++++++-----------------
 1 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 270dea0..b0aa3a0 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -91,25 +91,20 @@ static int compare_tree_entry(struct tree_desc *t1,=
 struct tree_desc *t2, const
  *  - zero for no
  *  - negative for "no, and no subsequent entries will be either"
  */
-static int tree_entry_interesting(struct tree_desc *desc, const char *=
base, int baselen, struct diff_options *opt)
+static int tree_entry_interesting(const struct name_entry *entry, cons=
t char *base, int baselen, const struct tree_pathspec_list *ps)
 {
-	const char *path;
-	const unsigned char *sha1;
-	unsigned mode;
 	int i;
 	int pathlen;
 	int never_interesting =3D -1;
=20
-	if (!opt->pathspec.nr)
+	if (!ps->nr)
 		return 1;
=20
-	sha1 =3D tree_entry_extract(desc, &path, &mode);
-
-	pathlen =3D tree_entry_len(path, sha1);
+	pathlen =3D tree_entry_len(entry->path, entry->sha1);
=20
-	for (i =3D 0; i < opt->pathspec.nr; i++) {
-		const char *match =3D opt->pathspec.paths[i];
-		int matchlen =3D opt->pathspec.info[i].pathlen;
+	for (i =3D 0; i < ps->nr; i++) {
+		const char *match =3D ps->info[i].path;
+		int matchlen =3D ps->info[i].pathlen;
 		int m =3D -1; /* signals that we haven't called strncmp() */
=20
 		if (baselen >=3D matchlen) {
@@ -147,7 +142,7 @@ static int tree_entry_interesting(struct tree_desc =
*desc, const char *base, int
 			 * Does match sort strictly earlier than path
 			 * with their common parts?
 			 */
-			m =3D strncmp(match, path,
+			m =3D strncmp(match, entry->path,
 				    (matchlen < pathlen) ? matchlen : pathlen);
 			if (m < 0)
 				continue;
@@ -174,7 +169,7 @@ static int tree_entry_interesting(struct tree_desc =
*desc, const char *base, int
 		if (matchlen > pathlen) {
 			if (match[pathlen] !=3D '/')
 				continue;
-			if (!S_ISDIR(mode))
+			if (!S_ISDIR(entry->mode))
 				continue;
 		}
=20
@@ -183,7 +178,7 @@ static int tree_entry_interesting(struct tree_desc =
*desc, const char *base, int
 			 * we cheated and did not do strncmp(), so we do
 			 * that here.
 			 */
-			m =3D strncmp(match, path, pathlen);
+			m =3D strncmp(match, entry->path, pathlen);
=20
 		/*
 		 * If common part matched earlier then it is a hit,
@@ -206,8 +201,7 @@ static void show_tree(struct diff_options *opt, con=
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
@@ -266,7 +260,7 @@ static void skip_uninteresting(struct tree_desc *t,=
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
1.7.1.rc1.70.g13aff
