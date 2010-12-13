From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/19] tree_entry_interesting(): factor out most matching logic
Date: Mon, 13 Dec 2010 16:46:47 +0700
Message-ID: <1292233616-27692-11-git-send-email-pclouds@gmail.com>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 13 10:49:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS52N-0005A4-Ci
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 10:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724Ab0LMJtN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 04:49:13 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64097 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164Ab0LMJtK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 04:49:10 -0500
Received: by pwj3 with SMTP id 3so1096243pwj.19
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 01:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=xjpqMVKx3u/UZhva2BzCwKEzHjJworq2iZXiyEP4jaE=;
        b=aUBwgt8e5aMsPxVaE6yvbxu6wUv6/2MLUMhn7wpds2SzPohUH6MYUaF1dgHKJNLC6B
         byxq20E9XGIDpzE5rrfnPL9mUIJoJJOHSW515ZqRovZQWrvZ1j15XYn1DJiUcpMh4pbU
         CnOHr4ieQfa2imXmtrAXEpuf89MngoS3DQPew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=VgbwwPT8Npt/IJEigyCpYafXxRXI7b3/mYSsD8TIj6arD0xjRp6DlWKmK0b03PJ2Bw
         C3C6K1yAu1GtCDCLOqrHUJ0+GtaWqlQdWyGU9cHO0q+AvtP6JMaygxsTE4oS/gmvMxQX
         4EuHfODsnZnSQrkxobce9Omlxe2ALvveUPv2o=
Received: by 10.142.162.3 with SMTP id k3mr2058235wfe.170.1292233750241;
        Mon, 13 Dec 2010 01:49:10 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id x18sm8684242wfa.23.2010.12.13.01.49.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 01:49:09 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 13 Dec 2010 16:48:16 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163541>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 tree-walk.c |  168 ++++++++++++++++++++++++++++++++-------------------=
-------
 1 files changed, 93 insertions(+), 75 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 01168ea..40a4657 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -456,6 +456,91 @@ int get_tree_entry(const unsigned char *tree_sha1,=
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
+	/* If it doesn't match, move along... */
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
@@ -481,88 +566,21 @@ int tree_entry_interesting(const struct name_entr=
y *entry,
 	for (i =3D 0; i < ps->nr; i++) {
 		const char *match =3D ps->raw[i];
 		int matchlen =3D ps->items[i].len;
-		int m =3D -1; /* signals that we haven't called strncmp() */
=20
 		if (baselen >=3D matchlen) {
-			/* If it doesn't match, move along... */
-			if (strncmp(base, match, matchlen))
+			if (!match_dir_prefix(base, baselen, match, matchlen))
+				/* Just a random prefix match */
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
+		if (!strncmp(base, match, baselen)) {
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
