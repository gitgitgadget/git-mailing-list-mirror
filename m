From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/8] tree-walk: move tree_entry_interesting() from tree-diff.c
Date: Thu,  9 Sep 2010 01:50:19 +1000
Message-ID: <1283961023-4491-5-git-send-email-pclouds@gmail.com>
References: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 09 05:23:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtXjE-0000Kq-AO
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 05:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170Ab0IIDW7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 23:22:59 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42783 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047Ab0IIDW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 23:22:58 -0400
Received: by pvg2 with SMTP id 2so315428pvg.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 20:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=OReGZRv2HJfVmc1p+F1MewITep5uIzzziNog58XLDGE=;
        b=iF4AV+rswXVQ65cGUtVtSWlkazTSJ4NM8a8DsZcm9Qc7ISTmCfCHAY2hYkQvq9XFdT
         lKYvLymN674PdCT/Dsmdil8W5hapeLh/XFx8rhSFMcu9wnc8EHBy3XYAFNTO/tR6Mwu0
         /nTL9IU8+gsDxhNESJCnTXKmtq2/WOtr61YeM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=VtOoMzynfRJdVAeSUIdntP3vwd1rlyC1ixP7EXloNHluWQdF8XIraNdmYnhl5uR1ow
         7V6HI7pJ/1pfSgRhfCqcNsKvLLaoSQYKUvLMxwGi3TuwOTBx+DtQEX1g51DLaBE/vBKE
         ms4GKN+j4NNJjdOfpWmjCy+RfxARMUNptegcM=
Received: by 10.142.131.16 with SMTP id e16mr273389wfd.338.1284002577536;
        Wed, 08 Sep 2010 20:22:57 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id n36sm826729wfa.4.2010.09.08.20.22.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Sep 2010 20:22:56 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu,  9 Sep 2010 01:51:01 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g13aff
In-Reply-To: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155833>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 tree-diff.c |  109 ---------------------------------------------------=
--------
 tree-walk.c |  109 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 tree-walk.h |    2 +
 3 files changed, 111 insertions(+), 109 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index b0aa3a0..4b9d551 100644
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
t char *base, int baselen, const struct tree_pathspec_list *ps)
-{
-	int i;
-	int pathlen;
-	int never_interesting =3D -1;
-
-	if (!ps->nr)
-		return 1;
-
-	pathlen =3D tree_entry_len(entry->path, entry->sha1);
-
-	for (i =3D 0; i < ps->nr; i++) {
-		const char *match =3D ps->info[i].path;
-		int matchlen =3D ps->info[i].pathlen;
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
index 30c2aa1..e7041d7 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -483,3 +483,112 @@ int setup_tree_pathspec(const char **paths, struc=
t tree_pathspec_list *ps)
 	}
 	return 0;
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
+int tree_entry_interesting(const struct name_entry *entry, const char =
*base, int baselen, const struct tree_pathspec_list *ps)
+{
+	int i;
+	int pathlen;
+	int never_interesting =3D -1;
+
+	if (!ps->nr)
+		return 1;
+
+	pathlen =3D tree_entry_len(entry->path, entry->sha1);
+
+	for (i =3D 0; i < ps->nr; i++) {
+		const char *match =3D ps->info[i].path;
+		int matchlen =3D ps->info[i].pathlen;
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
index 2d09b7c..bb55656 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -67,5 +67,7 @@ static inline int traverse_path_len(const struct trav=
erse_info *info, const stru
 }
=20
 extern int setup_tree_pathspec(const char **paths, struct tree_pathspe=
c_list *ps);
+extern int tree_entry_interesting(const struct name_entry *entry, cons=
t char *base, int baselen,
+				  const struct tree_pathspec_list *ps);
=20
 #endif
--=20
1.7.1.rc1.70.g13aff
