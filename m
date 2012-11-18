From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/4] pathspec: apply "*.c" optimization from exclude
Date: Sun, 18 Nov 2012 16:13:08 +0700
Message-ID: <1353229989-13075-4-git-send-email-pclouds@gmail.com>
References: <1353229989-13075-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 10:13:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta0wY-0005us-DW
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 10:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649Ab2KRJNU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Nov 2012 04:13:20 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:32812 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617Ab2KRJNT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 04:13:19 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so313271dak.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 01:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Nx61Sw6RPJI5ITNKoN8J3w17dBXxBkH+M0lbFHKEx+Q=;
        b=DYV/x4lw18pnNCVh+Y97X/TodFWYgfoCczIbsUk86SSiVQDvaX5d5MohOvYzvqj9zx
         0DU84dZ4StEkamP5wmfPWW6AVLD1+jrzd0htQmxetcv33ES8498xbR4SZWPjmUyjkCWt
         gkFYnvJX5vm+GqRtV3smpfV7+zLhM1k2Ig86XaZfqaeuF5OGLWRyIdQZq2MEmV1UyBli
         5doX0BvevmAS3rQjZVp5Bp+D44rDeRi2M/L44TuZlzqGBamFe39KkXrfjRGlI5kZLf65
         wVKcj8mBq31Jy5OI25s0RHqUNoQjZ4Yfy3H/mr3RBDzZfr0Jf3VtuaWQwasB+hdoKmNT
         7JNQ==
Received: by 10.66.85.134 with SMTP id h6mr27100776paz.36.1353229999247;
        Sun, 18 Nov 2012 01:13:19 -0800 (PST)
Received: from lanh ([115.74.37.170])
        by mx.google.com with ESMTPS id ni3sm4243181pbc.2.2012.11.18.01.13.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Nov 2012 01:13:18 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 18 Nov 2012 16:13:26 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1353229989-13075-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209998>

-O2 build on linux-2.6, without the patch:

$ time git rev-list --quiet HEAD -- '*.c'

real    0m40.770s
user    0m40.290s
sys     0m0.256s

With the patch

$ time ~/w/git/git rev-list --quiet HEAD -- '*.c'

real    0m34.288s
user    0m33.997s
sys     0m0.205s

The above command is not supposed to be widely popular. It's chosen
because it exercises pathspec matching a lot. The point is it cuts
down matching time for popular patterns like *.c, which could be used
as pathspec in other places.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h     |  3 +++
 dir.c       | 17 +++++++++++++++--
 dir.h       |  1 +
 tree-walk.c |  6 ++++--
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index bf031f1..d18f584 100644
--- a/cache.h
+++ b/cache.h
@@ -473,6 +473,8 @@ extern int index_name_is_other(const struct index_s=
tate *, const char *, int);
 extern int ie_match_stat(const struct index_state *, struct cache_entr=
y *, struct stat *, unsigned int);
 extern int ie_modified(const struct index_state *, struct cache_entry =
*, struct stat *, unsigned int);
=20
+#define PSF_ONESTAR 1
+
 struct pathspec {
 	const char **raw; /* get_pathspec() result, not freed by free_pathspe=
c() */
 	int nr;
@@ -483,6 +485,7 @@ struct pathspec {
 		const char *match;
 		int len;
 		int nowildcard_len;
+		int flags;
 	} *items;
 };
=20
diff --git a/dir.c b/dir.c
index e4e6ca1..d00f240 100644
--- a/dir.c
+++ b/dir.c
@@ -46,6 +46,12 @@ inline int git_fnmatch(const char *pattern, const ch=
ar *string,
 		pattern +=3D prefix;
 		string +=3D prefix;
 	}
+	if (flags & GF_ONESTAR) {
+		int pattern_len =3D strlen(++pattern);
+		int string_len =3D strlen(string);
+		return strcmp(pattern,
+			      string + string_len - pattern_len);
+	}
 	return fnmatch(pattern, string, fnm_flags);
 }
=20
@@ -246,7 +252,9 @@ static int match_pathspec_item(const struct pathspe=
c_item *item, int prefix,
 	}
=20
 	if (item->nowildcard_len < item->len &&
-	    !git_fnmatch(match, name, 0, item->nowildcard_len - prefix))
+	    !git_fnmatch(match, name,
+			 item->flags & PSF_ONESTAR ? GF_ONESTAR : 0,
+			 item->nowildcard_len - prefix))
 		return MATCHED_FNMATCH;
=20
 	return 0;
@@ -1446,8 +1454,13 @@ int init_pathspec(struct pathspec *pathspec, con=
st char **paths)
 		item->match =3D path;
 		item->len =3D strlen(path);
 		item->nowildcard_len =3D simple_length(path);
-		if (item->nowildcard_len < item->len)
+		item->flags =3D 0;
+		if (item->nowildcard_len < item->len) {
 			pathspec->has_wildcard =3D 1;
+			if (path[item->nowildcard_len] =3D=3D '*' &&
+			    no_wildcard(path + item->nowildcard_len + 1))
+				item->flags |=3D PSF_ONESTAR;
+		}
 	}
=20
 	qsort(pathspec->items, pathspec->nr,
diff --git a/dir.h b/dir.h
index 4cd5074..590532b 100644
--- a/dir.h
+++ b/dir.h
@@ -143,6 +143,7 @@ extern int fnmatch_icase(const char *pattern, const=
 char *string, int flags);
  * The prefix part of pattern must not contains wildcards.
  */
 #define GF_PATHNAME 1
+#define GF_ONESTAR  2
=20
 extern int git_fnmatch(const char *pattern, const char *string,
 		       int flags, int prefix);
diff --git a/tree-walk.c b/tree-walk.c
index 2fcf3c0..42fe610 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -628,7 +628,8 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
=20
 			if (item->nowildcard_len < item->len) {
 				if (!git_fnmatch(match + baselen, entry->path,
-						 0, item->nowildcard_len - baselen))
+						 item->flags & PSF_ONESTAR ? GF_ONESTAR : 0,
+						 item->nowildcard_len - baselen))
 					return entry_interesting;
=20
 				/*
@@ -654,7 +655,8 @@ match_wildcards:
 		strbuf_add(base, entry->path, pathlen);
=20
 		if (!git_fnmatch(match, base->buf + base_offset,
-				 0, item->nowildcard_len)) {
+				 item->flags & PSF_ONESTAR ? GF_ONESTAR : 0,
+				 item->nowildcard_len)) {
 			strbuf_setlen(base, base_offset + baselen);
 			return entry_interesting;
 		}
--=20
1.8.0.rc2.23.g1fb49df
