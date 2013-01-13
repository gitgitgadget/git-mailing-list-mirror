From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 01/10] pathspec: allow to use alternate char for quoting long magic mnemonic
Date: Sun, 13 Jan 2013 19:49:30 +0700
Message-ID: <1358081379-17752-2-git-send-email-pclouds@gmail.com>
References: <1358081379-17752-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:49:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuN0h-0000jJ-87
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846Ab3AMMte convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:49:34 -0500
Received: from mail-da0-f48.google.com ([209.85.210.48]:33464 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754761Ab3AMMtd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:49:33 -0500
Received: by mail-da0-f48.google.com with SMTP id k18so1419460dae.35
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=F7L7lLM//1PNYg+wYUz+UjR+2wKUqvrFWJ6+LNrW6Y4=;
        b=bqkOGTs/H0etJl6/uhGaXazwGJ+aRouHRN2CqkiSEjo9BdlJ2JWTCDMyzf5uyoSlyY
         +h315BQJT9dYIHKWOwb4JuTF1Ku7h289xOAbbT9EbPplEEOULi5+wJF8D9Uat+rRLzf9
         vrQKXeKv2KFRJM3Trhx/WZJlLorBZAV1fUdkPdm5nXCsNraV+l9o8QMst5NvDzWIOwT/
         fztpE3M1ZHylWXs+7HrttwK7mHDqM93d1HbTRmJiEAZwsxrcZYR+jEPlWw0RrVFgLKpi
         1/hYwnmdPRyfEFPgfBY7SfkKcMppr7VOypFXoFG6wRNucYt98W+S6HfEHKC+5ksEiV2f
         NjCw==
X-Received: by 10.68.212.200 with SMTP id nm8mr249449779pbc.4.1358081373464;
        Sun, 13 Jan 2013 04:49:33 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id x2sm6777885paw.8.2013.01.13.04.49.30
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:49:32 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:49:47 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358081379-17752-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213372>

Currently use parentheses, e.g. ":(icase,literal)path", but they do
not play well with unix shells because they have special meaning and
we need to quote them. Allow an alternate syntax ":q/icase,literal/path=
".

Similar to ed's s/// syntax, '/' can be replaced with anything. If the
opening quote has a closing counterpart, e.g. () [] <> {}, then it'll
be quoted as such.

It may even be a good thing to kill ':(...)' syntax, which can easily
be replaced with ':q(...)'. It's unlikely that anybody is used to it
yet.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/setup.c b/setup.c
index 69ca047..9db6093 100644
--- a/setup.c
+++ b/setup.c
@@ -196,14 +196,32 @@ static unsigned prefix_pathspec(struct pathspec_i=
tem *item,
=20
 	if (elt[0] !=3D ':') {
 		; /* nothing to do */
-	} else if (elt[1] =3D=3D '(') {
+	} else if (elt[1] =3D=3D '(' || elt[1] =3D=3D 'q') {
 		/* longhand */
 		const char *nextat;
-		for (copyfrom =3D elt + 2;
-		     *copyfrom && *copyfrom !=3D ')';
+		char close =3D ')';
+		char sep[3] =3D ",)";
+		if (elt[1] =3D=3D '(')
+			copyfrom =3D elt + 2;
+		else {
+			copyfrom =3D elt + 3;
+			switch (elt[2]) {
+			case '(': close =3D ')'; break;
+			case '[': close =3D ']'; break;
+			case '{': close =3D '}'; break;
+			case '<': close =3D '>'; break;
+			case '\0':
+				die("Invalid pathspec '%s'", elt);
+			default:
+				close =3D elt[2];
+			}
+			sep[1] =3D close;
+		}
+		for (;
+		     *copyfrom && *copyfrom !=3D close;
 		     copyfrom =3D nextat) {
-			size_t len =3D strcspn(copyfrom, ",)");
-			if (copyfrom[len] =3D=3D ')')
+			size_t len =3D strcspn(copyfrom, sep);
+			if (copyfrom[len] =3D=3D close)
 				nextat =3D copyfrom + len;
 			else
 				nextat =3D copyfrom + len + 1;
@@ -219,7 +237,7 @@ static unsigned prefix_pathspec(struct pathspec_ite=
m *item,
 				die("Invalid pathspec magic '%.*s' in '%s'",
 				    (int) len, copyfrom, elt);
 		}
-		if (*copyfrom =3D=3D ')')
+		if (*copyfrom =3D=3D close)
 			copyfrom++;
 	} else {
 		/* shorthand */
--=20
1.8.0.rc2.23.g1fb49df
