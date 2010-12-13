From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/19] Move tree_entry_interesting() to tree-walk.c and export it
Date: Mon, 13 Dec 2010 16:46:43 +0700
Message-ID: <1292233616-27692-7-git-send-email-pclouds@gmail.com>
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
	id 1PS51T-0004j6-EZ
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 10:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063Ab0LMJsl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 04:48:41 -0500
Received: from mail-px0-f179.google.com ([209.85.212.179]:54923 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab0LMJsk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 04:48:40 -0500
Received: by pxi20 with SMTP id 20so1600318pxi.10
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 01:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=LEPtH7ZePLuZAGE6iEOuG7WBjaXrxOOmzgqgL2jVFwA=;
        b=DP44P5cVqFG5JTlaMxJjR17e6FCZSFbT/nGAuh7ev1y2YUFUKKjUE9vKdS1bqag6fV
         VY7MKwPXrfSUd7ItCg2tiMbH+q5YzoCBrLXAptNmROmyMmCMpVkmEt//EzrcQsGdPaC2
         iNyF1IV9WARUYajutcvPcNZrBIfpdseXT1N/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=sFEXQi0h/qpeK5NpJxQk89AfHQFlL8XdOeB4o92RPYNMRyR19qonns1w/DaI6DinKE
         QIvm01wXJn/ZLV/RDHvI6YXA89LQxR4YascSBJ5vVasQzgW168M+DRt+NMKS14enTTh4
         RrKskcoA/wIqrq3y6AlMQ93W0ruXq6MJbieYE=
Received: by 10.142.204.4 with SMTP id b4mr3072357wfg.308.1292233720353;
        Mon, 13 Dec 2010 01:48:40 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id q13sm8674944wfc.17.2010.12.13.01.48.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 01:48:39 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 13 Dec 2010 16:47:41 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163535>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 tree-diff.c |  109 ---------------------------------------------------=
------
 tree-walk.c |  111 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 tree-walk.h |    2 +
 3 files changed, 113 insertions(+), 109 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 822d45e..50d7e6d 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -82,115 +82,6 @@ static int compare_tree_entry(struct tree_desc *t1,=
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
-		const char *match =3D ps->raw[i];
-		int matchlen =3D ps->items[i].len;
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
index a9bbf4e..01168ea 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -455,3 +455,114 @@ int get_tree_entry(const unsigned char *tree_sha1=
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
+		const char *match =3D ps->raw[i];
+		int matchlen =3D ps->items[i].len;
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
