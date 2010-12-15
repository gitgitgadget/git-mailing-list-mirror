From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/21] Move tree_entry_interesting() to tree-walk.c and export it
Date: Wed, 15 Dec 2010 22:02:40 +0700
Message-ID: <1292425376-14550-6-git-send-email-pclouds@gmail.com>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 16:04:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSsuO-0000YW-IZ
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 16:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766Ab0LOPEk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 10:04:40 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53691 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754736Ab0LOPEc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 10:04:32 -0500
Received: by ywl5 with SMTP id 5so1082697ywl.19
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 07:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=NFEw2D5EDoLf80ZNgIl00Jw9PKfT+S7vduOrabbmFYU=;
        b=uxVnFPwnyahLN8QF85Xy6iwx3uo8aEWMcGEO/O1wXuLeCJT0RzZIAqYtXOCGHxr7bQ
         5UDWoqQMDmsQ3PmbDKzlUdUZYceKLyZLcakfpx4MbhgsrvQv1ui9X/9Af0x1rjB6Y/bm
         8Ig4OcAS24+Avr3VEqlCjeWmPnHZrMOIBlpaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=SA9ZCWURIzoGFfHL0LY3esLkA/exu9iH2I7blhHtKpt80ucKNph1iGtMQOhWO1E1cb
         zk+zDGcDnHQbaxU3OVC/yk4ateYAzQWzV+4PDjlGt3OncjbKGuv46fJhPADf/tU1agiO
         otMaM93iA4KstgC9H5qB8b218Kndp+O0quxt8=
Received: by 10.236.110.12 with SMTP id t12mr14729574yhg.6.1292425471625;
        Wed, 15 Dec 2010 07:04:31 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.209.213])
        by mx.google.com with ESMTPS id j28sm751010yha.44.2010.12.15.07.04.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 07:04:30 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 15 Dec 2010 22:03:38 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163760>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 tree-diff.c |  110 ---------------------------------------------------=
------
 tree-walk.c |  112 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 tree-walk.h |    2 +
 3 files changed, 114 insertions(+), 110 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 57e8909..28a69dc 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -82,116 +82,6 @@ static int compare_tree_entry(struct tree_desc *t1,=
 struct tree_desc *t2, const
 	return 0;
 }
=20
-/*
- * Is a tree entry interesting given the pathspec we have?
- *
- * Return:
- *  - 2 for "yes, and all subsequent entries will be"
- *  - 1 for yes
- *  - zero for no
- *  - negative for "no, and no subsequent entries will be either"
- */
-static int tree_entry_interesting(const struct name_entry *entry, cons=
t char *base, int baselen, const struct pathspec *ps)
-{
-	int i;
-	int pathlen;
-	int never_interesting =3D -1;
-
-	if (!ps || !ps->nr)
-		return 1;
-
-	pathlen =3D tree_entry_len(entry->path, entry->sha1);
-
-	for (i =3D 0; i < ps->nr; i++) {
-		const struct pathspec_item *item =3D ps->items+i;
-		const char *match =3D item->match;
-		int matchlen =3D item->len;
-		int m =3D -1; /* signals that we haven't called strncmp() */
-
-		if (baselen >=3D matchlen) {
-			/* If it doesn't match, move along... */
-			if (strncmp(base, match, matchlen))
-				continue;
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
-		}
-
-		/* Does the base match? */
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
-		}
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
-	}
-	return never_interesting; /* No matches */
-}
-
 /* A whole sub-tree went away or appeared */
 static void show_tree(struct diff_options *opt, const char *prefix, st=
ruct tree_desc *desc, const char *base, int baselen)
 {
diff --git a/tree-walk.c b/tree-walk.c
index a9bbf4e..a2e2a99 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -455,3 +455,115 @@ int get_tree_entry(const unsigned char *tree_sha1=
, const char *name, unsigned ch
 	free(tree);
 	return retval;
 }
+
+/*
+ * Is a tree entry interesting given the pathspec we have?
+ *
+ * Return:
+ *  - 2 for "yes, and all subsequent entries will be"
+ *  - 1 for yes
+ *  - zero for no
+ *  - negative for "no, and no subsequent entries will be either"
+ */
+int tree_entry_interesting(const struct name_entry *entry,
+			   const char *base, int baselen,
+			   const struct pathspec *ps)
+{
+	int i;
+	int pathlen;
+	int never_interesting =3D -1;
+
+	if (!ps || !ps->nr)
+		return 1;
+
+	pathlen =3D tree_entry_len(entry->path, entry->sha1);
+
+	for (i =3D 0; i < ps->nr; i++) {
+		const struct pathspec_item *item =3D ps->items+i;
+		const char *match =3D item->match;
+		int matchlen =3D item->len;
+		int m =3D -1; /* signals that we haven't called strncmp() */
+
+		if (baselen >=3D matchlen) {
+			/* If it doesn't match, move along... */
+			if (strncmp(base, match, matchlen))
+				continue;
+
+			/*
+			 * If the base is a subdirectory of a path which
+			 * was specified, all of them are interesting.
+			 */
+			if (!matchlen ||
+			    base[matchlen] =3D=3D '/' ||
+			    match[matchlen - 1] =3D=3D '/')
+				return 2;
+
+			/* Just a random prefix match */
+			continue;
+		}
+
+		/* Does the base match? */
+		if (strncmp(base, match, baselen))
+			continue;
+
+		match +=3D baselen;
+		matchlen -=3D baselen;
+
+		if (never_interesting) {
+			/*
+			 * We have not seen any match that sorts later
+			 * than the current path.
+			 */
+
+			/*
+			 * Does match sort strictly earlier than path
+			 * with their common parts?
+			 */
+			m =3D strncmp(match, entry->path,
+				    (matchlen < pathlen) ? matchlen : pathlen);
+			if (m < 0)
+				continue;
+
+			/*
+			 * If we come here even once, that means there is at
+			 * least one pathspec that would sort equal to or
+			 * later than the path we are currently looking at.
+			 * In other words, if we have never reached this point
+			 * after iterating all pathspecs, it means all
+			 * pathspecs are either outside of base, or inside the
+			 * base but sorts strictly earlier than the current
+			 * one.  In either case, they will never match the
+			 * subsequent entries.  In such a case, we initialized
+			 * the variable to -1 and that is what will be
+			 * returned, allowing the caller to terminate early.
+			 */
+			never_interesting =3D 0;
+		}
+
+		if (pathlen > matchlen)
+			continue;
+
+		if (matchlen > pathlen) {
+			if (match[pathlen] !=3D '/')
+				continue;
+			if (!S_ISDIR(entry->mode))
+				continue;
+		}
+
+		if (m =3D=3D -1)
+			/*
+			 * we cheated and did not do strncmp(), so we do
+			 * that here.
+			 */
+			m =3D strncmp(match, entry->path, pathlen);
+
+		/*
+		 * If common part matched earlier then it is a hit,
+		 * because we rejected the case where path is not a
+		 * leading directory and is shorter than match.
+		 */
+		if (!m)
+			return 1;
+	}
+	return never_interesting; /* No matches */
+}
diff --git a/tree-walk.h b/tree-walk.h
index 7e3e0b5..c12f0a2 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -60,4 +60,6 @@ static inline int traverse_path_len(const struct trav=
erse_info *info, const stru
 	return info->pathlen + tree_entry_len(n->path, n->sha1);
 }
=20
+extern int tree_entry_interesting(const struct name_entry *, const cha=
r *, int, const struct pathspec *ps);
+
 #endif
--=20
1.7.3.3.476.g10a82
