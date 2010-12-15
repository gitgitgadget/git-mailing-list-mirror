From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/21] tree_entry_interesting(): support depth limit
Date: Wed, 15 Dec 2010 22:02:44 +0700
Message-ID: <1292425376-14550-10-git-send-email-pclouds@gmail.com>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 16:05:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSsvK-00013J-0G
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 16:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764Ab0LOPFF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 10:05:05 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53691 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366Ab0LOPFD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 10:05:03 -0500
Received: by mail-yw0-f46.google.com with SMTP id 5so1082697ywl.19
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 07:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=lQ2sGkkx+BJQqjJLvZ50H0KjYZWMiWk5WZeVvWpVqjU=;
        b=lPXzUXoCpj5k+X8umlDNeoB3iVr8/abSHncDtXsQP2qrgrCZa98OgV2OA+iyWGj930
         woUaLB+I7vHGSyXbcMLudX9g6mxxFy0h/cIvS9jP4x9LQ217eq87zhQeFwSBYK9DYh1/
         IKvAVf5nLCDf4lAlyVS3oPWjA4639yKilXU2A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=svYiwnVIHO9EFEIwvchJbYrzrERxbCWGaVsm9+998To+AX+nJz4vOQ5Deitu4JpCrE
         SBQQq0mj4ccv/iplXVbU2NpeVvlzMAthal4pOvbltLsmzaoDLRwP3RaEU+lBfASlk2kt
         FwQIFYoNAcFME2QKKvS8T0YEhaNs3VXV6/s/0=
Received: by 10.42.171.194 with SMTP id k2mr1581489icz.32.1292425503117;
        Wed, 15 Dec 2010 07:05:03 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.209.213])
        by mx.google.com with ESMTPS id k38sm840609ick.9.2010.12.15.07.04.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 07:05:02 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 15 Dec 2010 22:04:10 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163766>

This is needed to replace pathspec_matches() in builtin/grep.c.

max_depth =3D=3D -1 means infinite depth. Depth limit is only effective
when pathspec.recursive =3D=3D 1. When pathspec.recursive =3D=3D 0, the
behavior depends on match functions: non-recursive for
tree_entry_interesting() and recursive for match_pathspec{,_depth}

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h     |    2 ++
 dir.c       |   15 +++++++++++++++
 dir.h       |    1 +
 tree-diff.c |    4 ++++
 tree-walk.c |   19 ++++++++++++++++---
 5 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 9eeecc2..b110775 100644
--- a/cache.h
+++ b/cache.h
@@ -496,6 +496,8 @@ extern int ie_modified(const struct index_state *, =
struct cache_entry *, struct
 struct pathspec {
 	const char **raw; /* get_pathspec() result, not freed by free_pathspe=
c() */
 	int nr;
+	int recursive:1;
+	int max_depth;
 	struct pathspec_item {
 		const char *match;
 		int len;
diff --git a/dir.c b/dir.c
index a88f2ef..79e88f6 100644
--- a/dir.c
+++ b/dir.c
@@ -71,6 +71,21 @@ int fill_directory(struct dir_struct *dir, const cha=
r **pathspec)
 	return len;
 }
=20
+int within_depth(const char *name, int namelen,
+			int depth, int max_depth)
+{
+	const char *cp =3D name, *cpe =3D name + namelen;
+
+	while (cp < cpe) {
+		if (*cp++ !=3D '/')
+			continue;
+		depth++;
+		if (depth > max_depth)
+			return 0;
+	}
+	return 1;
+}
+
 /*
  * Does 'match' match the given name?
  * A match is found if
diff --git a/dir.h b/dir.h
index 278d84c..c71de08 100644
--- a/dir.h
+++ b/dir.h
@@ -65,6 +65,7 @@ struct dir_struct {
 #define MATCHED_FNMATCH 2
 #define MATCHED_EXACTLY 3
 extern int match_pathspec(const char **pathspec, const char *name, int=
 namelen, int prefix, char *seen);
+extern int within_depth(const char *name, int namelen, int depth, int =
max_depth);
=20
 extern int fill_directory(struct dir_struct *dir, const char **pathspe=
c);
 extern int read_directory(struct dir_struct *, const char *path, int l=
en, const char **pathspec);
diff --git a/tree-diff.c b/tree-diff.c
index 67fa6c4..bde2c52 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -152,6 +152,10 @@ int diff_tree(struct tree_desc *t1, struct tree_de=
sc *t2,
 	struct strbuf base;
 	int baselen =3D strlen(base_str);
=20
+	/* Enable recursion indefinitely */
+	opt->pathspec.recursive =3D DIFF_OPT_TST(opt, RECURSIVE);
+	opt->pathspec.max_depth =3D -1;
+
 	strbuf_init(&base, PATH_MAX);
 	strbuf_add(&base, base_str, baselen);
=20
diff --git a/tree-walk.c b/tree-walk.c
index 5012705..91d7b36 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "tree-walk.h"
 #include "unpack-trees.h"
+#include "dir.h"
 #include "tree.h"
=20
 static const char *get_mode(const char *str, unsigned int *modep)
@@ -557,8 +558,13 @@ int tree_entry_interesting(const struct name_entry=
 *entry,
 	int pathlen, baselen =3D base->len;
 	int never_interesting =3D -1;
=20
-	if (!ps || !ps->nr)
-		return 1;
+	if (!ps->nr) {
+		if (!ps->recursive || ps->max_depth =3D=3D -1)
+			return 1;
+		return !!within_depth(base->buf, baselen,
+				      !!S_ISDIR(entry->mode),
+				      ps->max_depth);
+	}
=20
 	pathlen =3D tree_entry_len(entry->path, entry->sha1);
=20
@@ -571,7 +577,14 @@ int tree_entry_interesting(const struct name_entry=
 *entry,
 			/* If it doesn't match, move along... */
 			if (!match_dir_prefix(base->buf, baselen, match, matchlen))
 				continue;
-			return 2;
+
+			if (!ps->recursive || ps->max_depth =3D=3D -1)
+				return 2;
+
+			return !!within_depth(base->buf + matchlen + 1,
+					      baselen - matchlen - 1,
+					      !!S_ISDIR(entry->mode),
+					      ps->max_depth);
 		}
=20
 		/* Does the base match? */
--=20
1.7.3.3.476.g10a82
