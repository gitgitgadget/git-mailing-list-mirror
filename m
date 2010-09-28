From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/6] tree_entry_interesting(): remove dependency on struct diff_options
Date: Tue, 28 Sep 2010 22:00:28 +1000
Message-ID: <1285675229-28019-6-git-send-email-pclouds@gmail.com>
References: <1285675229-28019-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 00:33:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0ijr-0003Bs-HH
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 00:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755189Ab0I1WdV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 18:33:21 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61631 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274Ab0I1WdU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 18:33:20 -0400
Received: by mail-pz0-f46.google.com with SMTP id 34so35451pzk.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 15:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=G+c8mTAenzNVu3oh+515sMgMEDH63xsKERahi3UhUBI=;
        b=mD2JQ4vrkx6G9cl4rh6ib1oH0H+1VE4o8S9xwOpUMU7mxYlBetpTR1MinIxA3i1qKZ
         UrWvkfvx8Q7DqiUM13kmu3hr5j9FfatKQfNH1ImKqlMPBVmzKSF82iLzJrBLyDvmdkgy
         GJbT1eCAITMvMUE3GtBEnghZkDPlLCrr960BI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HKi18StrqSpDNuXL9y26w4dNml0SNBmV0F/VMJnWfwIScBF0W+IvTNu96s6OIuabyL
         4R9QK5c7D2RHtxOKKPDwLCVL3QGQ7D1vNr46S5S3b71gbi8j0HL1ltgJNtmRMBxmp/Sg
         SfkJlsrkdyTq1hDxj0XBuZeCImHde/TbMgqow=
Received: by 10.114.111.12 with SMTP id j12mr848605wac.95.1285713200644;
        Tue, 28 Sep 2010 15:33:20 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id d38sm13307243wam.20.2010.09.28.15.33.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Sep 2010 15:33:19 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Tue, 28 Sep 2010 22:01:03 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g788ca
In-Reply-To: <1285675229-28019-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157491>

This function can be potentially used in more places than just
tree-diff.c. "struct diff_options" does not make much sense outside
diff_tree_sha1().

While removing the use of diff_options, it also removes
tree_entry_extract() call. This means S_ISDIR() uses the entry->mode
directly, without being filtered by canon_mode() (called internally
inside tree_entry_extract)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 tree-diff.c |   28 +++++++++++-----------------
 1 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 986c0f4..822d45e 100644
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
-		const char *match =3D opt->pathspec.raw[i];
-		int matchlen =3D opt->pathspec.items[i].len;
+	for (i =3D 0; i < ps->nr; i++) {
+		const char *match =3D ps->raw[i];
+		int matchlen =3D ps->items[i].len;
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
1.7.1.rc1.70.g788ca
