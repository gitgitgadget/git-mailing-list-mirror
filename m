From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/19] tree_entry_interesting(): remove dependency on struct diff_options
Date: Mon, 13 Dec 2010 16:46:42 +0700
Message-ID: <1292233616-27692-6-git-send-email-pclouds@gmail.com>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 13 10:48:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS51S-0004j6-UE
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 10:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016Ab0LMJsb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 04:48:31 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54065 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab0LMJsa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 04:48:30 -0500
Received: by pzk6 with SMTP id 6so479538pzk.19
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 01:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=psWIe7M5Y+1gbbvcUxKSWAqWxNZ+pbAEke22x7Rb70Q=;
        b=cdU1ERwsq+l5ayNwlPjXLhMKwcP1CGnzxjHZjfIBmA00GCovNqyv0XSsU+hMFoRMI2
         szaU3Tdg1GPvzvO14flPCALr6ZN+XYIzQrN4GDA5GrJ2qsYnBN7kErGozHjg010Q1PZ4
         xkQiLMzvcOZC4MVUShpOFIsB6sFazt0dC+KfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ak0tJaMiwDOFTou0ffCTuZYBLp/FQEjDC+KRsuTous336YJUz7jKQv3Hnn7nwqmJY6
         3NeQJHV9juqld2WIQCXZOzRFb9pKyDHZs7Sz7yTzNN5phVUClDkKs50njIUfEBhdIxWs
         WUpYLvUQ9iAaO912oTuAzs8r8ZWN1NoQAc/W4=
Received: by 10.142.174.18 with SMTP id w18mr3002692wfe.268.1292233707564;
        Mon, 13 Dec 2010 01:48:27 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id e14sm8676643wfg.8.2010.12.13.01.48.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 01:48:26 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 13 Dec 2010 16:47:34 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163536>

This function can be potentially used in more places than just
tree-diff.c. "struct diff_options" does not make much sense outside
diff_tree_sha1().

While removing the use of diff_options, it also removes
tree_entry_extract() call, which means S_ISDIR() uses the entry->mode
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
1.7.3.3.476.g10a82
