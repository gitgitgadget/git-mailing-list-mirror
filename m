From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/19] tree_entry_interesting: support depth limit
Date: Mon, 13 Dec 2010 16:46:48 +0700
Message-ID: <1292233616-27692-12-git-send-email-pclouds@gmail.com>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 13 10:56:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS58j-0007TP-4z
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 10:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227Ab0LMJ4K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 04:56:10 -0500
Received: from mail-iw0-f170.google.com ([209.85.214.170]:33275 "EHLO
	mail-iw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104Ab0LMJ4J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 04:56:09 -0500
Received: by iwn6 with SMTP id 6so8892637iwn.1
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 01:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=vyJIz06O7SZR5duOiTUKjbhtw0zcuOI2Sih5bTM9Pa0=;
        b=re+qgIIb6RKnCoQ1rnpLCDYMcKHStClKj3QvlFUFNEZfltjD8Vpmk4DM4DrQ+T0qCI
         flCjjDEtGXfoJLotFnT5Kes6gg9r/zj1aYf+XyZSQyPFmrk5CWSolHKM4mmNcWJtnacd
         ir6+YS4bowBhghqax8gfj/OJgLjAhT+QLWI4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ZGOCEP7D5I1+JvN2GpXohh0G/+u6ADSQh0+Rxc2CGjsXNFpyInah3Lf2xTH1yveFTd
         r+sTOjn1t9FXmSoZiTuU1kmQ4llIWPOJrt4NkM8oMXrz3kd8pj4YnsAPlnqgjM7LFm7J
         VCKT4zihKAB3kAh9WEkFqj7UgK58cL7A3Ag2s=
Received: by 10.231.35.205 with SMTP id q13mr559471ibd.175.1292233757352;
        Mon, 13 Dec 2010 01:49:17 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id 8sm6048592iba.10.2010.12.13.01.49.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 01:49:16 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 13 Dec 2010 16:48:24 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163549>

This is needed to replace pathspec_matches() in builtin/grep.c. Depth
limit is only effective when pathspec.recursive =3D=3D 1

max_depth =3D=3D -1 means unlimited depth.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pathspec.recursive is also needed for wildcard matching later on.

 cache.h     |    2 ++
 dir.c       |   15 +++++++++++++++
 dir.h       |    1 +
 tree-diff.c |    2 ++
 tree-walk.c |   19 +++++++++++++++++--
 5 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 3a1acf1..56da281 100644
--- a/cache.h
+++ b/cache.h
@@ -497,6 +497,8 @@ struct pathspec {
 	const char **raw; /* get_pathspec() result, not freed by free_pathspe=
c() */
 	int nr;
 	int has_wildcard:1;
+	int recursive:1;
+	int max_depth;
 	struct pathspec_item {
 		int len, prefix_len;
 		int has_wildcard:1;
diff --git a/dir.c b/dir.c
index 0987d0c..bb5076c 100644
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
index a870f6c..7c3b770 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -165,6 +165,8 @@ int diff_tree(struct tree_desc *t1, struct tree_des=
c *t2,
 	int baselen =3D strlen(base_);
=20
 	memcpy(base, base_, baselen+1);
+	opt->pathspec.recursive =3D DIFF_OPT_TST(opt, RECURSIVE);
+	opt->pathspec.max_depth =3D -1;
 	for (;;) {
 		if (DIFF_OPT_TST(opt, QUICK) &&
 		    DIFF_OPT_TST(opt, HAS_CHANGES))
diff --git a/tree-walk.c b/tree-walk.c
index 40a4657..d28de30 100644
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
@@ -558,9 +559,17 @@ int tree_entry_interesting(const struct name_entry=
 *entry,
 	int pathlen;
 	int never_interesting =3D -1;
=20
-	if (!ps || !ps->nr)
+	if (!ps)
 		return 1;
=20
+	if (!ps->nr) {
+		if (!ps->recursive || ps->max_depth =3D=3D -1)
+			return 1;
+		return !!within_depth(base, baselen,
+				      !!S_ISDIR(entry->mode),
+				      ps->max_depth);
+	}
+
 	pathlen =3D tree_entry_len(entry->path, entry->sha1);
=20
 	for (i =3D 0; i < ps->nr; i++) {
@@ -571,7 +580,13 @@ int tree_entry_interesting(const struct name_entry=
 *entry,
 			if (!match_dir_prefix(base, baselen, match, matchlen))
 				/* Just a random prefix match */
 				continue;
-			return 2;
+
+			if (!ps->recursive || ps->max_depth =3D=3D -1)
+				return 2;
+
+			return !!within_depth(base+matchlen+1, baselen-matchlen-1,
+					      !!S_ISDIR(entry->mode),
+					      ps->max_depth);
 		}
=20
 		/* Does the base match? */
--=20
1.7.3.3.476.g10a82
