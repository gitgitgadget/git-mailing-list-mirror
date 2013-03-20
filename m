From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 12/45] parse_pathspec: support stripping/checking submodule paths
Date: Wed, 20 Mar 2013 19:16:16 +0700
Message-ID: <1363781779-14947-4-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363781779-14947-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 20 13:17:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIHxD-0003Pm-1z
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 13:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933623Ab3CTMQq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Mar 2013 08:16:46 -0400
Received: from mail-da0-f43.google.com ([209.85.210.43]:40590 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932391Ab3CTMQp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 08:16:45 -0400
Received: by mail-da0-f43.google.com with SMTP id u36so958464dak.2
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 05:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=xn/BAT5trFPGjD4O5fsTPTQ8CqjdEmzH3WwW1wi+EaY=;
        b=M6o+Fa6FEPLWTTsR2TdNkR9kTknrai7wlebRyYqdaFNmb4aI5pnhVSD4GqyWYEL5TF
         HGHxhG2abMAXZdvzJq7legqI7U7FxRQGb6T77LzzaGCnuesdCpzQo8UoY2QtNV9B5u/B
         USLH89GFNXv5yRz+NRbOBboN/bDk6hu9td/c1vfj2Wk+gt3ENyOTK31RzZyx6D0JZ738
         VgoN3IVK2OM9eubHhXTKhzvZdEDdYBBFMuPE5tmlp2k9sx8fYTKZ6yiGRi2Dv65Xs+9O
         g1munb1s4cX2ogNLNGmE2/fE9hGMbdJT7XDaZLRyJ9dz8PH3sU4C7UrdMNr1sCIa3zxs
         hFuA==
X-Received: by 10.68.221.36 with SMTP id qb4mr3291203pbc.66.1363781804772;
        Wed, 20 Mar 2013 05:16:44 -0700 (PDT)
Received: from lanh ([115.74.40.216])
        by mx.google.com with ESMTPS id y13sm1956797pbv.0.2013.03.20.05.16.41
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 05:16:43 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 20 Mar 2013 19:16:40 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1363781779-14947-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218591>

PATHSPEC_SYMLINK_LEADING_PATH and _STRIP_SUBMODULE_SLASH_EXPENSIVE are
respectively the alternate implementation of
pathspec.c:die_if_path_beyond_symlink() and
pathspec.c:check_path_for_gitlink(). They are intended to replace
those functions when builtin/add.c and builtin/check-ignore.c are
converted to use parse_pathspec.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pathspec.c | 26 ++++++++++++++++++++++++++
 pathspec.h | 10 ++++++++++
 2 files changed, 36 insertions(+)

diff --git a/pathspec.c b/pathspec.c
index 57ad9ba..40bf178 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -213,6 +213,26 @@ static unsigned prefix_pathspec(struct pathspec_it=
em *item,
 		match[item->len] =3D '\0';
 	}
=20
+	if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE)
+		for (i =3D 0; i < active_nr; i++) {
+			struct cache_entry *ce =3D active_cache[i];
+			int ce_len =3D ce_namelen(ce);
+
+			if (!S_ISGITLINK(ce->ce_mode))
+				continue;
+
+			if (item->len <=3D ce_len || match[ce_len] !=3D '/' ||
+			    memcmp(ce->name, match, ce_len))
+				continue;
+			if (item->len =3D=3D ce_len + 1) {
+				/* strip trailing slash */
+				item->len--;
+				match[item->len] =3D '\0';
+			} else
+				die (_("Pathspec '%s' is in submodule '%.*s'"),
+				     elt, ce_len, ce->name);
+		}
+
 	if (limit_pathspec_to_literal())
 		item->nowildcard_len =3D item->len;
 	else
@@ -328,6 +348,12 @@ void parse_pathspec(struct pathspec *pathspec,
 			unsupported_magic(entry,
 					  item[i].magic & magic_mask,
 					  short_magic);
+
+		if ((flags & PATHSPEC_SYMLINK_LEADING_PATH) &&
+		    has_symlink_leading_path(item[i].match, item[i].len)) {
+			die(_("pathspec '%s' is beyond a symbolic link"), entry);
+		}
+
 		if (item[i].nowildcard_len < item[i].len)
 			pathspec->has_wildcard =3D 1;
 		pathspec->magic |=3D item[i].magic;
diff --git a/pathspec.h b/pathspec.h
index 7935b26..b631514 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -33,6 +33,16 @@ struct pathspec {
 #define PATHSPEC_MAXDEPTH_VALID (1<<2) /* max_depth field is valid */
 /* stripping the trailing slash if the given path is a gitlink */
 #define PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP (1<<3)
+/* die if a symlink is part of the given path's directory */
+#define PATHSPEC_SYMLINK_LEADING_PATH (1<<4)
+/*
+ * This is like a combination of ..LEADING_PATH and .._SLASH_CHEAP
+ * (but not the same): it strips the trailing slash if the given path
+ * is a gitlink but also checks and dies if gitlink is part of the
+ * leading path (i.e. the given path goes beyond a submodule). It's
+ * safer than _SLASH_CHEAP and also more expensive.
+ */
+#define PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE (1<<5)
=20
 extern int init_pathspec(struct pathspec *, const char **);
 extern void parse_pathspec(struct pathspec *pathspec,
--=20
1.8.0.rc0.19.g7bbb31d
