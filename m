From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/6] Move tree_entry_interesting() to tree-walk.c and export it
Date: Mon, 20 Sep 2010 09:21:54 +1000
Message-ID: <1284938514-16663-7-git-send-email-pclouds@gmail.com>
References: <1284938514-16663-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 01:22:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxTDn-0007qb-4z
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 01:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297Ab0ISXWm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 19:22:42 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36504 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754884Ab0ISXWl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 19:22:41 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so1084991pwi.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 16:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=aWp3ssWPNf9EWF88TngqC0Hkt9XXm/3AncFnA8OeL3o=;
        b=kggcXDjW7de6R7Fj/CHjbYrjzCeGja8KLkTkyhbDWnwP3CyZVz8yF5ETM/VQAkosMT
         RdjvwrcGWsO1IS5tQ5bsw3M95hmj5XerOrmoGZ0KFLO94FLVsqZ4CxR5apWObV+jdZzl
         SADS26TUtR9+rgPgVNdUV/uyQdYo2d0TbRQfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=h7loApM5VHJNy5MeLPnJHFXCTcmVzgdzX29C8mHZvZh7nMitkfbysPqf23xZgv3BU3
         LOZ03UQRX3+JhGlzxmfNlx/nkQrm+e6TbxWpjZjfffbnXXSWiXStQJ1XuUZZ7uyVTD9o
         t8+H2xvyJE696u8vZ/L1tPurCBAqUqkvy74Bk=
Received: by 10.114.109.18 with SMTP id h18mr9137095wac.66.1284938561554;
        Sun, 19 Sep 2010 16:22:41 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id d38sm12265518wam.8.2010.09.19.16.22.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 16:22:40 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon, 20 Sep 2010 09:22:35 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g788ca
In-Reply-To: <1284938514-16663-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156527>

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
index 88ea7e9..c3d0684 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -57,4 +57,6 @@ static inline int traverse_path_len(const struct trav=
erse_info *info, const stru
 	return info->pathlen + tree_entry_len(n->path, n->sha1);
 }
=20
+extern int tree_entry_interesting(const struct name_entry *, const cha=
r *, int, const struct pathspec *ps);
+
 #endif
--=20
1.7.1.rc1.70.g788ca
