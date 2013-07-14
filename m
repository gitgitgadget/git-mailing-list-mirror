From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 11/46] parse_pathspec: support stripping/checking submodule paths
Date: Sun, 14 Jul 2013 15:35:34 +0700
Message-ID: <1373790969-13000-12-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:37:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHoD-0001iM-My
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963Ab3GNIh2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:37:28 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:58131 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab3GNIh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:37:26 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so10268233pbc.2
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=AiGKfrsTSKK77JsvhJrpEqLDH72iNygNmcalgWz5wo4=;
        b=Xxfcwfj5Y0iMOGnjhPk/5kRV9iKjKXOzVWcuWZNSgGMhIGSCuNOCnt2eIJA3C1U1Uo
         bcvZHUx50jPGhi0A++lWee9uYUwApWHxpxkIJPK8mBvI++wGuex1qx+JF2jOoiPD8JmH
         yLkkTnMYLBUm1ie/0QD5bGvMrgHwmXvTOZiV4b1rJ22hWWyFkSzrY+vbOAj0B2tyeBRO
         2a1LqLurr3rGa4dkJ9Vkj32TLeZQrSNodJXqXwoD2SjkT+mIAk5UI5sgORDMiqp/Bf0t
         jlr/LOE4hY2bG+DwrfiH8mjXA6IdNdw8UqZ4FiwB79CXZ6Q8JwXcmKjM70sYLelCep+3
         QXrg==
X-Received: by 10.66.118.163 with SMTP id kn3mr51011615pab.165.1373791044058;
        Sun, 14 Jul 2013 01:37:24 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id y9sm54518590pbb.46.2013.07.14.01.37.21
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:37:23 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:37:35 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230323>

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
index 1c07c23..e2a4f91 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -214,6 +214,26 @@ static unsigned prefix_pathspec(struct pathspec_it=
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
@@ -329,6 +349,12 @@ void parse_pathspec(struct pathspec *pathspec,
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
index 5144851..450fc03 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -33,6 +33,16 @@ struct pathspec {
 #define PATHSPEC_MAXDEPTH_VALID (1<<2) /* max_depth field is valid */
 /* strip the trailing slash if the given path is a gitlink */
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
1.8.2.83.gc99314b
