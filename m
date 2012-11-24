From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/4] pathspec: apply "*.c" optimization from exclude
Date: Sat, 24 Nov 2012 11:33:50 +0700
Message-ID: <1353731631-20593-4-git-send-email-pclouds@gmail.com>
References: <1353731631-20593-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 05:34:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc7Rv-0005nv-Lg
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 05:34:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932748Ab2KXEeY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Nov 2012 23:34:24 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44365 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932693Ab2KXEeX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 23:34:23 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so6867625pbc.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 20:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3UNWazn3S4K9pQMgvu55w8o7bSYJK2NRFNBBsWOfvQw=;
        b=pjtIRsdRGQ8g0ontSvea30SE3UlvgmldQLJXvfhYtevymrcwVPHS/x1SFpKBDB1hMz
         tzlX+5GE5odZcZOrfs1Ez30kE3AUgKs5Al6QVQz4ECguEDnAqRQSRxbYrGfbQSYk1GOi
         pzS/LupBIdy7G+npfW9chTa87lmuhQhdNjjFQr8HlPvIdDbMQqTRddlon7ONhRZ+u6YN
         zAxblG1yeRzjZGs6GEyX7EEsGycD/3FITpwJ8SXmICTHjN3AZXnKFhzxOFLm563oXWT2
         TNNl6MFO8x7BScmg1/88jLNrP9vTw+cxcCBjaxsYc8RH7mT8wF08PnE0QscUdTcclSv+
         GP7Q==
Received: by 10.68.193.167 with SMTP id hp7mr19586908pbc.124.1353731662736;
        Fri, 23 Nov 2012 20:34:22 -0800 (PST)
Received: from lanh ([115.74.35.242])
        by mx.google.com with ESMTPS id l5sm4763258paz.14.2012.11.23.20.34.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 20:34:22 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 24 Nov 2012 11:34:15 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1353731631-20593-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210314>

When a pattern contains only a single asterisk as wildcard,
e.g. "foo*bar", after literally comparing the leading part "foo" with
the string, we can compare the tail of the string and make sure it
matches "bar", instead of running fnmatch() on "*bar" against the
remainder of the string.

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
 The optimization's condition could be loosen to "only one asterisk"
 (iow, fixed-length wildcards are OK, e.g. "abc[de]gh*.[ch]") when we
 have a custom fnmatch implementation that supports dry-run, so it can
 parse the pattern and determine the actual string length of
 "abc[de]gh" and ".[ch]". We would have something similar to regcomp in
 addition to git_fnmatch().

 cache.h     |  3 +++
 dir.c       | 18 ++++++++++++++++--
 dir.h       |  1 +
 tree-walk.c |  6 ++++--
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index bf031f1..babf9e5 100644
--- a/cache.h
+++ b/cache.h
@@ -473,6 +473,8 @@ extern int index_name_is_other(const struct index_s=
tate *, const char *, int);
 extern int ie_match_stat(const struct index_state *, struct cache_entr=
y *, struct stat *, unsigned int);
 extern int ie_modified(const struct index_state *, struct cache_entry =
*, struct stat *, unsigned int);
=20
+#define PATHSPEC_ONESTAR 1	/* the pathspec pattern sastisfies GFNM_ONE=
STAR */
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
index f81e1d2..9afd388 100644
--- a/dir.c
+++ b/dir.c
@@ -46,6 +46,13 @@ inline int git_fnmatch(const char *pattern, const ch=
ar *string,
 		pattern +=3D prefix;
 		string +=3D prefix;
 	}
+	if (flags & GFNM_ONESTAR) {
+		int pattern_len =3D strlen(++pattern);
+		int string_len =3D strlen(string);
+		return string_len < pattern_len ||
+		       strcmp(pattern,
+			      string + string_len - pattern_len);
+	}
 	return fnmatch(pattern, string, fnm_flags);
 }
=20
@@ -246,7 +253,9 @@ static int match_pathspec_item(const struct pathspe=
c_item *item, int prefix,
 	}
=20
 	if (item->nowildcard_len < item->len &&
-	    !git_fnmatch(match, name, 0, item->nowildcard_len - prefix))
+	    !git_fnmatch(match, name,
+			 item->flags & PATHSPEC_ONESTAR ? GFNM_ONESTAR : 0,
+			 item->nowildcard_len - prefix))
 		return MATCHED_FNMATCH;
=20
 	return 0;
@@ -1446,8 +1455,13 @@ int init_pathspec(struct pathspec *pathspec, con=
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
+				item->flags |=3D PATHSPEC_ONESTAR;
+		}
 	}
=20
 	qsort(pathspec->items, pathspec->nr,
diff --git a/dir.h b/dir.h
index 0e8ae84..ab5af42 100644
--- a/dir.h
+++ b/dir.h
@@ -143,6 +143,7 @@ extern int fnmatch_icase(const char *pattern, const=
 char *string, int flags);
  * The prefix part of pattern must not contains wildcards.
  */
 #define GFNM_PATHNAME 1		/* similar to FNM_PATHNAME */
+#define GFNM_ONESTAR  2		/* there is only _one_ wildcard, a star */
=20
 extern int git_fnmatch(const char *pattern, const char *string,
 		       int flags, int prefix);
diff --git a/tree-walk.c b/tree-walk.c
index 2fcf3c0..585899e 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -628,7 +628,8 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
=20
 			if (item->nowildcard_len < item->len) {
 				if (!git_fnmatch(match + baselen, entry->path,
-						 0, item->nowildcard_len - baselen))
+						 item->flags & PATHSPEC_ONESTAR ? GFNM_ONESTAR : 0,
+						 item->nowildcard_len - baselen))
 					return entry_interesting;
=20
 				/*
@@ -654,7 +655,8 @@ match_wildcards:
 		strbuf_add(base, entry->path, pathlen);
=20
 		if (!git_fnmatch(match, base->buf + base_offset,
-				 0, item->nowildcard_len)) {
+				 item->flags & PATHSPEC_ONESTAR ? GFNM_ONESTAR : 0,
+				 item->nowildcard_len)) {
 			strbuf_setlen(base, base_offset + baselen);
 			return entry_interesting;
 		}
--=20
1.8.0.rc2.23.g1fb49df
