From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/45] parse_pathspec: support stripping/checking submodule paths
Date: Sun,  9 Jun 2013 13:25:44 +0700
Message-ID: <1370759178-1709-12-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:26:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ4s-000078-Ii
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909Ab3FIG0F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:26:05 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:43660 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007Ab3FIG0E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:26:04 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa11so3538073pad.5
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lCS4AXCpN5icmZSaMza+HpkG/5n4zZTooTrGWh9+Ois=;
        b=K5ah4rb77HirBlZaQIbOC0sTboj5BiHuVKIDp8AV2Lz9297ETqDFl6lSFjTbi9CaLz
         UuHvBE2lkmjMfgIiYt3EXHsfreIGSN54CRs1wzr41MLdzVMxpaiVYMfPPj6Ix96QpIbA
         gdwV7qHXaTKOCYqXeyFuMQ51Awr2JHHAmyfjwCLHpqYcBE0Nprn9nNQIxlqk0uOL7KpT
         bLrDb6la9TcUl+pIM/xQtQmdVdoIyvQg9ixTChiPywgPOFIQbbh9daDHgYR0f7l3b4Mf
         o7baLqj1Ko3m/yNkH6E/BvDYEPHCZuvRdHRPxtiYu7Nk4OmsmlLPastj9ru4XY8Mav1A
         gqeg==
X-Received: by 10.66.13.169 with SMTP id i9mr9039589pac.212.1370759163489;
        Sat, 08 Jun 2013 23:26:03 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id tb7sm5539807pbc.14.2013.06.08.23.26.00
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:26:02 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:27:34 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226903>

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
index e3c8339..9aaec36 100644
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
1.8.2.83.gc99314b
