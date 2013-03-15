From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 12/45] parse_pathspec: support stripping/checking submodule paths
Date: Fri, 15 Mar 2013 13:06:27 +0700
Message-ID: <1363327620-29017-13-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:25:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO5U-0004ri-GE
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714Ab3COGZZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:25:25 -0400
Received: from mail-ia0-f179.google.com ([209.85.210.179]:45618 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069Ab3COGZY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:25:24 -0400
Received: by mail-ia0-f179.google.com with SMTP id x24so2861368iak.38
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=jjoe+Eb0safnFriJndupDxE0D1TTqJHAUMcsJPHJ1IA=;
        b=hQkoFiusO7QeIg0gEpX1zhFCUPuyj4TRBra9fmE+oZwgZGQRlMBZU+GCVUBTm5QOlg
         R36CfpzHA7Zlm74TKhYcuK7U3+yxFyJcYURyDIOsGHnrKpTuU+OSE4jGGs5ip4QGafcS
         xL6hAFKyGpXbCJDd2uRnhgDu73c70c9smLekl9ZI0IRepQ3DRUQtHkWEnPibX8Qz5BjF
         xXQbjlfsJ1IME+4n/ydlK1I6IxQujO9gJJ6K7eC7c9QyDUsLwZw35+EWSahoo4pbYCvs
         tU5CPqRQz0SwoRXkZGbVmoLWbXkyku/uh1w5Q/Imhx5Q8VjMwqDVCn7vSP6RXlued+vs
         1xLg==
X-Received: by 10.43.8.200 with SMTP id ot8mr3953659icb.11.1363328723797;
        Thu, 14 Mar 2013 23:25:23 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id qn10sm616364igc.6.2013.03.14.23.25.20
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:25:23 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:08:26 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218199>

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
 pathspec.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/pathspec.c b/pathspec.c
index 2da8bc9..834db80 100644
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
@@ -327,6 +347,12 @@ void parse_pathspec(struct pathspec *pathspec,
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
index f24b07b..6ffd09d 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -32,6 +32,8 @@ struct pathspec {
 #define PATHSPEC_PREFER_FULL (1<<1) /* No args means match everything =
*/
 #define PATHSPEC_MAXDEPTH_VALID (1<<2) /* max_depth field is valid */
 #define PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP (1<<3)
+#define PATHSPEC_SYMLINK_LEADING_PATH (1<<4)
+#define PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE (1<<5)
=20
 extern int init_pathspec(struct pathspec *, const char **);
 extern void parse_pathspec(struct pathspec *pathspec,
--=20
1.8.0.rc0.19.g7bbb31d
