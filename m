From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 01/21] pathspec: save the non-wildcard length part
Date: Fri, 11 Jan 2013 18:20:55 +0700
Message-ID: <1357903275-16804-2-git-send-email-pclouds@gmail.com>
References: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 12:21:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttcg2-0006NZ-N0
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 12:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192Ab3AKLVL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2013 06:21:11 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:64857 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab3AKLVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 06:21:09 -0500
Received: by mail-pa0-f43.google.com with SMTP id fb10so968551pad.16
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 03:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=z0zCVWMvlXjiMwZaD+bSGICK1DJmzpvl55KXPFtL3tQ=;
        b=rM5XY/lOkNp+b4mESsrQgfuRuMUFyu2HUlqOOVICRnK1p0w5kFIkG2Uo4zfDz3PVOz
         M1EGOY1Wu6dKfdLmK/Vv7z/lgoXMPDpTM/rKQLRAzPOB4fB7R0YowOAd8SVjx5/nGY3+
         J5R2SjqP54KWVOmKPj9cZw2UD5UKOerAQD1LlBdkPBL1cSZ/TjTYevG0tujjMRIq49Ck
         jCa0qUc1AqI7HfBu9mxUO3r8Af9dAkTAD4VLJIywiT6ArRUR2UpNMIW9nbHuKqcGowSK
         C0jxyhE8Qrffcj8i+ZGfQDb4vJqfbEIJ0oprKt9KHM5q9NzrIuUQPJZnuvE/Dl/r42md
         7FxQ==
X-Received: by 10.68.229.169 with SMTP id sr9mr19233371pbc.120.1357903268721;
        Fri, 11 Jan 2013 03:21:08 -0800 (PST)
Received: from lanh ([115.74.46.148])
        by mx.google.com with ESMTPS id qh4sm2641017pbb.9.2013.01.11.03.21.05
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 03:21:07 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 11 Jan 2013 18:21:23 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213194>

We mark pathspec with wildcards with the field use_wildcard. We
could do better by saving the length of the non-wildcard part, which
can be used for optimizations such as f9f6e2c (exclude: do strcmp as
much as possible before fnmatch - 2012-06-07).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/ls-files.c | 2 +-
 builtin/ls-tree.c  | 2 +-
 cache.h            | 2 +-
 dir.c              | 6 +++---
 tree-walk.c        | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b5434af..4a9ee69 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -337,7 +337,7 @@ void overlay_tree_on_cache(const char *tree_name, c=
onst char *prefix)
 		matchbuf[0] =3D prefix;
 		matchbuf[1] =3D NULL;
 		init_pathspec(&pathspec, matchbuf);
-		pathspec.items[0].use_wildcard =3D 0;
+		pathspec.items[0].nowildcard_len =3D pathspec.items[0].len;
 	} else
 		init_pathspec(&pathspec, NULL);
 	if (read_tree(tree, 1, &pathspec))
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 235c17c..fb76e38 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -168,7 +168,7 @@ int cmd_ls_tree(int argc, const char **argv, const =
char *prefix)
=20
 	init_pathspec(&pathspec, get_pathspec(prefix, argv + 1));
 	for (i =3D 0; i < pathspec.nr; i++)
-		pathspec.items[i].use_wildcard =3D 0;
+		pathspec.items[i].nowildcard_len =3D pathspec.items[i].len;
 	pathspec.has_wildcard =3D 0;
 	tree =3D parse_tree_indirect(sha1);
 	if (!tree)
diff --git a/cache.h b/cache.h
index 2b192d2..9304d91 100644
--- a/cache.h
+++ b/cache.h
@@ -482,7 +482,7 @@ struct pathspec {
 	struct pathspec_item {
 		const char *match;
 		int len;
-		unsigned int use_wildcard:1;
+		int nowildcard_len;
 	} *items;
 };
=20
diff --git a/dir.c b/dir.c
index 5a83aa7..c391d46 100644
--- a/dir.c
+++ b/dir.c
@@ -230,7 +230,7 @@ static int match_pathspec_item(const struct pathspe=
c_item *item, int prefix,
 			return MATCHED_RECURSIVELY;
 	}
=20
-	if (item->use_wildcard && !fnmatch(match, name, 0))
+	if (item->nowildcard_len < item->len && !fnmatch(match, name, 0))
 		return MATCHED_FNMATCH;
=20
 	return 0;
@@ -1429,8 +1429,8 @@ int init_pathspec(struct pathspec *pathspec, cons=
t char **paths)
=20
 		item->match =3D path;
 		item->len =3D strlen(path);
-		item->use_wildcard =3D !no_wildcard(path);
-		if (item->use_wildcard)
+		item->nowildcard_len =3D simple_length(path);
+		if (item->nowildcard_len < item->len)
 			pathspec->has_wildcard =3D 1;
 	}
=20
diff --git a/tree-walk.c b/tree-walk.c
index 3f54c02..af871c5 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -626,7 +626,7 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
 					&never_interesting))
 				return entry_interesting;
=20
-			if (item->use_wildcard) {
+			if (item->nowildcard_len < item->len) {
 				if (!fnmatch(match + baselen, entry->path, 0))
 					return entry_interesting;
=20
@@ -642,7 +642,7 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
 		}
=20
 match_wildcards:
-		if (!item->use_wildcard)
+		if (item->nowildcard_len =3D=3D item->len)
 			continue;
=20
 		/*
--=20
1.8.0.rc2.23.g1fb49df
