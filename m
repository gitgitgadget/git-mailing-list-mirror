From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/21] tree_entry_interesting(): refactor into separate smaller functions
Date: Wed, 15 Dec 2010 22:02:43 +0700
Message-ID: <1292425376-14550-9-git-send-email-pclouds@gmail.com>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 16:05:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSsvJ-00013J-Ej
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 16:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754779Ab0LOPE5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 10:04:57 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53691 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754751Ab0LOPE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 10:04:56 -0500
Received: by mail-yw0-f46.google.com with SMTP id 5so1082697ywl.19
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 07:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=w2lkUci74k11yG9hJNf63dd8U2zPTmT/GgJO1hRUA+o=;
        b=fEEe9fE4DnyMWtgl4xExA/DMaFf4gvmCdtX+P0cpm1h6WMZvAzHl33n3DvXYX8rCyL
         Zr3wzvzPdD9EHJwKrm5mECPouUOy0bclbr2Mm1+Me+mmYTQmx7AAuZvqKzAKSURH2em0
         8tE9KlpIUHpq7YAEM0+JaUOCLUc7tDaTEdTmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=TDKkkuszDVaPXvjN2WlOqaqwNlLm4jj7O0JLrvYUkWALDJqa/+Xyk7klKHd6+Lo6mN
         9RFPiSHfPaiK3fit4G5d5zn4AnkotJANL+hLlgmymaTaezLPMi6n+Yu3FdZV4Iuoy+CC
         BOu7OQgG3oke/YiSaScL3xbHbrDWxoJ8eCXks=
Received: by 10.42.167.131 with SMTP id s3mr5974874icy.288.1292425495740;
        Wed, 15 Dec 2010 07:04:55 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.209.213])
        by mx.google.com with ESMTPS id l26sm849407icl.4.2010.12.15.07.04.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 07:04:54 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 15 Dec 2010 22:04:02 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163762>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 tree-walk.c |  170 ++++++++++++++++++++++++++++++++-------------------=
--------
 1 files changed, 93 insertions(+), 77 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 0830676..5012705 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -456,6 +456,90 @@ int get_tree_entry(const unsigned char *tree_sha1,=
 const char *name, unsigned ch
 	return retval;
 }
=20
+static int match_entry(const struct name_entry *entry, int pathlen,
+		       const char *match, int matchlen,
+		       int *never_interesting)
+{
+	int m =3D -1; /* signals that we haven't called strncmp() */
+
+	if (*never_interesting) {
+		/*
+		 * We have not seen any match that sorts later
+		 * than the current path.
+		 */
+
+		/*
+		 * Does match sort strictly earlier than path
+		 * with their common parts?
+		 */
+		m =3D strncmp(match, entry->path,
+			    (matchlen < pathlen) ? matchlen : pathlen);
+		if (m < 0)
+			return 0;
+
+		/*
+		 * If we come here even once, that means there is at
+		 * least one pathspec that would sort equal to or
+		 * later than the path we are currently looking at.
+		 * In other words, if we have never reached this point
+		 * after iterating all pathspecs, it means all
+		 * pathspecs are either outside of base, or inside the
+		 * base but sorts strictly earlier than the current
+		 * one.  In either case, they will never match the
+		 * subsequent entries.  In such a case, we initialized
+		 * the variable to -1 and that is what will be
+		 * returned, allowing the caller to terminate early.
+		 */
+		*never_interesting =3D 0;
+	}
+
+	if (pathlen > matchlen)
+		return 0;
+
+	if (matchlen > pathlen) {
+		if (match[pathlen] !=3D '/')
+			return 0;
+		if (!S_ISDIR(entry->mode))
+			return 0;
+	}
+
+	if (m =3D=3D -1)
+		/*
+		 * we cheated and did not do strncmp(), so we do
+		 * that here.
+		 */
+		m =3D strncmp(match, entry->path, pathlen);
+
+	/*
+	 * If common part matched earlier then it is a hit,
+	 * because we rejected the case where path is not a
+	 * leading directory and is shorter than match.
+	 */
+	if (!m)
+		return 1;
+
+	return 0;
+}
+
+static int match_dir_prefix(const char *base, int baselen,
+			    const char *match, int matchlen)
+{
+	if (strncmp(base, match, matchlen))
+		return 0;
+
+	/*
+	 * If the base is a subdirectory of a path which
+	 * was specified, all of them are interesting.
+	 */
+	if (!matchlen ||
+	    base[matchlen] =3D=3D '/' ||
+	    match[matchlen - 1] =3D=3D '/')
+		return 1;
+
+	/* Just a random prefix match */
+	return 0;
+}
+
 /*
  * Is a tree entry interesting given the pathspec we have?
  *
@@ -466,13 +550,12 @@ int get_tree_entry(const unsigned char *tree_sha1=
, const char *name, unsigned ch
  *  - negative for "no, and no subsequent entries will be either"
  */
 int tree_entry_interesting(const struct name_entry *entry,
-			   const struct strbuf *base_buf,
+			   const struct strbuf *base,
 			   const struct pathspec *ps)
 {
 	int i;
-	int pathlen, baselen =3D base_buf->len;
+	int pathlen, baselen =3D base->len;
 	int never_interesting =3D -1;
-	const char *base =3D base_buf->buf;
=20
 	if (!ps || !ps->nr)
 		return 1;
@@ -483,88 +566,21 @@ int tree_entry_interesting(const struct name_entr=
y *entry,
 		const struct pathspec_item *item =3D ps->items+i;
 		const char *match =3D item->match;
 		int matchlen =3D item->len;
-		int m =3D -1; /* signals that we haven't called strncmp() */
=20
 		if (baselen >=3D matchlen) {
 			/* If it doesn't match, move along... */
-			if (strncmp(base, match, matchlen))
+			if (!match_dir_prefix(base->buf, baselen, match, matchlen))
 				continue;
-
-			/*
-			 * If the base is a subdirectory of a path which
-			 * was specified, all of them are interesting.
-			 */
-			if (!matchlen ||
-			    base[matchlen] =3D=3D '/' ||
-			    match[matchlen - 1] =3D=3D '/')
-				return 2;
-
-			/* Just a random prefix match */
-			continue;
+			return 2;
 		}
=20
 		/* Does the base match? */
-		if (strncmp(base, match, baselen))
-			continue;
-
-		match +=3D baselen;
-		matchlen -=3D baselen;
-
-		if (never_interesting) {
-			/*
-			 * We have not seen any match that sorts later
-			 * than the current path.
-			 */
-
-			/*
-			 * Does match sort strictly earlier than path
-			 * with their common parts?
-			 */
-			m =3D strncmp(match, entry->path,
-				    (matchlen < pathlen) ? matchlen : pathlen);
-			if (m < 0)
-				continue;
-
-			/*
-			 * If we come here even once, that means there is at
-			 * least one pathspec that would sort equal to or
-			 * later than the path we are currently looking at.
-			 * In other words, if we have never reached this point
-			 * after iterating all pathspecs, it means all
-			 * pathspecs are either outside of base, or inside the
-			 * base but sorts strictly earlier than the current
-			 * one.  In either case, they will never match the
-			 * subsequent entries.  In such a case, we initialized
-			 * the variable to -1 and that is what will be
-			 * returned, allowing the caller to terminate early.
-			 */
-			never_interesting =3D 0;
+		if (!strncmp(base->buf, match, baselen)) {
+			if (match_entry(entry, pathlen,
+					match + baselen, matchlen - baselen,
+					&never_interesting))
+				return 1;
 		}
-
-		if (pathlen > matchlen)
-			continue;
-
-		if (matchlen > pathlen) {
-			if (match[pathlen] !=3D '/')
-				continue;
-			if (!S_ISDIR(entry->mode))
-				continue;
-		}
-
-		if (m =3D=3D -1)
-			/*
-			 * we cheated and did not do strncmp(), so we do
-			 * that here.
-			 */
-			m =3D strncmp(match, entry->path, pathlen);
-
-		/*
-		 * If common part matched earlier then it is a hit,
-		 * because we rejected the case where path is not a
-		 * leading directory and is shorter than match.
-		 */
-		if (!m)
-			return 1;
 	}
 	return never_interesting; /* No matches */
 }
--=20
1.7.3.3.476.g10a82
