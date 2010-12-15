From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/21] tree_entry_interesting(): support wildcard matching
Date: Wed, 15 Dec 2010 22:02:46 +0700
Message-ID: <1292425376-14550-12-git-send-email-pclouds@gmail.com>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 16:05:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSsvK-00013J-Tb
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 16:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754789Ab0LOPFU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 10:05:20 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65439 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754450Ab0LOPFS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 10:05:18 -0500
Received: by iyi12 with SMTP id 12so937470iyi.19
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 07:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=HbMdBi0G8lb2zMgmOhylYZICJn6mnOH3jdHhLdSwuNA=;
        b=kfV4bT4Q77CBom0GjcnyTPCBZ6Hj9pqPTvG3+gik7Kg8NPGvAJ33bXJkX5IJ2pkDwn
         RAB0NRCfWe4IN9jsi4Bq1Jvq262eDNkUaO8QQW+nIple5Dd2hewg5jeKqp98fvDKN/pX
         yXRu1YhKuSptH6PNPY+bBBZ2Jf0Q0QCPG7C+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=mKpbRTC6t2YPV9Jmr8egY8mf/9MSqu7IKNMoDxznFiHAmTOmzDCIluDEB7Hw5y14XT
         ROFd2r8WbycTNYBAHZuysTt3fU7KJedsoJLBw5UnbTFTGKccroD6FiA6V/0/idj4alN/
         bIIQCKgXqWcrdsCJVuZBIZRrpGUdoZGT+v/3c=
Received: by 10.231.13.137 with SMTP id c9mr4862279iba.37.1292425518427;
        Wed, 15 Dec 2010 07:05:18 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.209.213])
        by mx.google.com with ESMTPS id d21sm1037219ibg.21.2010.12.15.07.05.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 07:05:17 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 15 Dec 2010 22:04:25 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163768>

never_interesting optimization is disabled if there is any wildcard
pathspec, even if it only matches exactly on trees.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h                  |    2 ++
 dir.c                    |    3 +++
 t/t4010-diff-pathspec.sh |   14 ++++++++++++++
 tree-walk.c              |   30 +++++++++++++++++++++++++++---
 tree-walk.h              |    2 +-
 5 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index b110775..dc0bfb4 100644
--- a/cache.h
+++ b/cache.h
@@ -496,11 +496,13 @@ extern int ie_modified(const struct index_state *=
, struct cache_entry *, struct
 struct pathspec {
 	const char **raw; /* get_pathspec() result, not freed by free_pathspe=
c() */
 	int nr;
+	int has_wildcard:1;
 	int recursive:1;
 	int max_depth;
 	struct pathspec_item {
 		const char *match;
 		int len;
+		int has_wildcard:1;
 	} *items;
 };
=20
diff --git a/dir.c b/dir.c
index aa0522d..66c163f 100644
--- a/dir.c
+++ b/dir.c
@@ -1117,6 +1117,9 @@ int init_pathspec(struct pathspec *pathspec, cons=
t char **paths)
=20
 		item->match =3D path;
 		item->len =3D strlen(path);
+		item->has_wildcard =3D !no_wildcard(path);
+		if (item->has_wildcard)
+			pathspec->has_wildcard =3D 1;
 	}
=20
 	qsort(pathspec->items, pathspec->nr,
diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index 94df7ae..4b120f8 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -70,4 +70,18 @@ test_expect_success 'diff-tree pathspec' '
 	test_cmp expected current
 '
=20
+EMPTY_TREE=3D4b825dc642cb6eb9a060e54bf8d69288fbee4904
+
+test_expect_success 'diff-tree with wildcard shows dir also matches' '
+	git diff-tree --name-only $EMPTY_TREE $tree -- "f*" >result &&
+	echo file0 >expected &&
+	test_cmp expected result
+'
+
+test_expect_success 'diff-tree -r with wildcard' '
+	git diff-tree -r --name-only $EMPTY_TREE $tree -- "*file1" >result &&
+	echo path1/file1 >expected &&
+	test_cmp expected result
+'
+
 test_done
diff --git a/tree-walk.c b/tree-walk.c
index 93b05a7..cc5a4e1 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -551,12 +551,12 @@ static int match_dir_prefix(const char *base, int=
 baselen,
  *  - negative for "no, and no subsequent entries will be either"
  */
 int tree_entry_interesting(const struct name_entry *entry,
-			   const struct strbuf *base,
+			   struct strbuf *base,
 			   const struct pathspec *ps)
 {
 	int i;
 	int pathlen, baselen =3D base->len;
-	int never_interesting =3D -1;
+	int never_interesting =3D ps->has_wildcard ? 0 : -1;
=20
 	if (!ps->nr) {
 		if (!ps->recursive || ps->max_depth =3D=3D -1)
@@ -576,7 +576,7 @@ int tree_entry_interesting(const struct name_entry =
*entry,
 		if (baselen >=3D matchlen) {
 			/* If it doesn't match, move along... */
 			if (!match_dir_prefix(base->buf, baselen, match, matchlen))
-				continue;
+				goto match_wildcards;
=20
 			if (!ps->recursive || ps->max_depth =3D=3D -1)
 				return 2;
@@ -594,6 +594,30 @@ int tree_entry_interesting(const struct name_entry=
 *entry,
 					&never_interesting))
 				return 1;
 		}
+
+match_wildcards:
+		if (!ps->items[i].has_wildcard)
+			continue;
+
+		/*
+		 * Concatenate base and entry->path into one and do
+		 * fnmatch() on it.
+		 */
+
+		strbuf_add(base, entry->path, pathlen);
+
+		if (!fnmatch(match, base->buf, 0)) {
+			strbuf_setlen(base, baselen);
+			return 1;
+		}
+		strbuf_setlen(base, baselen);
+
+		/*
+		 * Match all directories. We'll try to match files
+		 * later on.
+		 */
+		if (ps->recursive && S_ISDIR(entry->mode))
+			return 1;
 	}
 	return never_interesting; /* No matches */
 }
diff --git a/tree-walk.h b/tree-walk.h
index f81c232..6589ee2 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -60,6 +60,6 @@ static inline int traverse_path_len(const struct trav=
erse_info *info, const stru
 	return info->pathlen + tree_entry_len(n->path, n->sha1);
 }
=20
-extern int tree_entry_interesting(const struct name_entry *, const str=
uct strbuf *, const struct pathspec *ps);
+extern int tree_entry_interesting(const struct name_entry *, struct st=
rbuf *, const struct pathspec *ps);
=20
 #endif
--=20
1.7.3.3.476.g10a82
