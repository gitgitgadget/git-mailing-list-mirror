From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/5] tree-walk: move tree_entry_interesting() from tree-diff.c
Date: Wed,  8 Sep 2010 01:48:01 +1000
Message-ID: <1283874483-32017-4-git-send-email-pclouds@gmail.com>
References: <1283874483-32017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 03:38:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot9cc-00056Y-Qd
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 03:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755648Ab0IHBie convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 21:38:34 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:40605 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905Ab0IHBid (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 21:38:33 -0400
Received: by pxi10 with SMTP id 10so1560311pxi.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 18:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=1PT3BNwMpn+Xg1n0m0d+6vqfAqq1e2I6idFqmPS4FNs=;
        b=jd9A+rQKVbDj8ED145X6V8h2fwUrgpp4o8HHLhF5dXByRTeWKTEPTjab8KitMMd1dm
         zrzcftIUtT8kMkr0qe+cEAGbxBtNABW9DenTlrXezt1jOsd1wckHLqTuDfg58l+MkSSL
         wyShpPsWs3uBH89kJ/3mnXin0NpDEXvldAXog=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=A8sg4E4UJpS9PqrZXSaQsOEFUqod4riiYAXOElNsj8cW6mLuedo3ywtYYpCWNNEgfV
         PZ9jKbqw9E4V6b+gpqlKAWH1Fvf4bykNbUG90XS3cmZ9TPwW8b4u94ch//geCAR30RHV
         AyeYzlEV6WeKoggXlIy04bO5al8C5vCabif/A=
Received: by 10.114.88.15 with SMTP id l15mr603865wab.191.1283909912740;
        Tue, 07 Sep 2010 18:38:32 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id s5sm14567149wak.12.2010.09.07.18.38.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 18:38:31 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed,  8 Sep 2010 11:38:26 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1283874483-32017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155755>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 tree-diff.c |  114 ---------------------------------------------------=
-------
 tree-walk.c |  115 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 tree-walk.h |    3 ++
 3 files changed, 118 insertions(+), 114 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index cd659c6..c74d0b5 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -82,120 +82,6 @@ static int compare_tree_entry(struct tree_desc *t1,=
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
-static int tree_entry_interesting(struct tree_desc *desc, const char *=
base, int baselen, struct diff_options *opt)
-{
-	const char *path;
-	const unsigned char *sha1;
-	unsigned mode;
-	int i;
-	int pathlen;
-	int never_interesting =3D -1;
-
-	if (!opt->nr_paths)
-		return 1;
-
-	sha1 =3D tree_entry_extract(desc, &path, &mode);
-
-	pathlen =3D tree_entry_len(path, sha1);
-
-	for (i =3D 0; i < opt->nr_paths; i++) {
-		const char *match =3D opt->paths[i];
-		int matchlen =3D opt->pathlens[i];
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
-			m =3D strncmp(match, path,
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
-			if (!S_ISDIR(mode))
-				continue;
-		}
-
-		if (m =3D=3D -1)
-			/*
-			 * we cheated and did not do strncmp(), so we do
-			 * that here.
-			 */
-			m =3D strncmp(match, path, pathlen);
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
index a9bbf4e..bc83fa3 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -2,6 +2,7 @@
 #include "tree-walk.h"
 #include "unpack-trees.h"
 #include "tree.h"
+#include "diff.h"
=20
 static const char *get_mode(const char *str, unsigned int *modep)
 {
@@ -455,3 +456,117 @@ int get_tree_entry(const unsigned char *tree_sha1=
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
+static int tree_entry_interesting(struct tree_desc *desc, const char *=
base, int baselen, struct diff_options *opt)
+{
+	const char *path;
+	const unsigned char *sha1;
+	unsigned mode;
+	int i;
+	int pathlen;
+	int never_interesting =3D -1;
+
+	if (!opt->nr_paths)
+		return 1;
+
+	sha1 =3D tree_entry_extract(desc, &path, &mode);
+
+	pathlen =3D tree_entry_len(path, sha1);
+
+	for (i =3D 0; i < opt->nr_paths; i++) {
+		const char *match =3D opt->paths[i];
+		int matchlen =3D opt->pathlens[i];
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
+			m =3D strncmp(match, path,
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
+			if (!S_ISDIR(mode))
+				continue;
+		}
+
+		if (m =3D=3D -1)
+			/*
+			 * we cheated and did not do strncmp(), so we do
+			 * that here.
+			 */
+			m =3D strncmp(match, path, pathlen);
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
index 88ea7e9..0572721 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -57,4 +57,7 @@ static inline int traverse_path_len(const struct trav=
erse_info *info, const stru
 	return info->pathlen + tree_entry_len(n->path, n->sha1);
 }
=20
+struct diff_options;
+extern int tree_entry_interesting(struct tree_desc *desc, const char *=
base, int baselen, struct diff_options *opt);
+
 #endif
--=20
1.7.1.rc1.69.g24c2f7
