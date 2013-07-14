From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 13/46] Guard against new pathspec magic in pathspec matching code
Date: Sun, 14 Jul 2013 15:35:36 +0700
Message-ID: <1373790969-13000-14-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:37:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHoM-0001qo-Mr
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:37:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976Ab3GNIhj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:37:39 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:37949 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab3GNIhg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:37:36 -0400
Received: by mail-pd0-f171.google.com with SMTP id y14so9796329pdi.2
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+aobb+/xRAjhdqJWSz2wLAkh0IrAvkdpd8JqAeiVVjQ=;
        b=Nhif9naP4AWsyl+DwTN/YC6oyM4CTokDB8G0/45OMpMgh320BiU24kcqF1uyZ3B3uJ
         IaxeyUr+cWlzcH7zIj/6kEIH5/Bfav08GbuAGWZB3zqan49YeaUjaUUZR8QAAcuwy96d
         nv/60386HygPfwsbStidyaujoJtzYPz0XO52fE06YP49h8VrMn/J10yttOaOfkinKwyl
         nkJsG+qN+f21tgio/rmhPl3e+wMpMPx5yTHOKuHld6o0DwDF5t6Ju9N30Z2P6RZM0e6D
         jz0nASvsrIX+GnWeID4WANARl2vZi04+7psemz9s2jjq23OHDVzZCLtDxyTBJam51XIp
         zIhQ==
X-Received: by 10.68.1.9 with SMTP id 9mr47471778pbi.128.1373791055657;
        Sun, 14 Jul 2013 01:37:35 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id py6sm54539449pbb.33.2013.07.14.01.37.32
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:37:35 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:37:47 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230325>

GUARD_PATHSPEC() marks pathspec-sensitive code, basically all those
that touch anything in 'struct pathspec' except fields "nr" and
"original". GUARD_PATHSPEC() is not supposed to fail. It's mainly to
help the designers catch unsupported codepaths.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/api-setup.txt | 19 +++++++++++++++++++
 builtin/diff.c                        |  2 ++
 dir.c                                 |  2 ++
 pathspec.h                            |  7 +++++++
 tree-diff.c                           | 19 +++++++++++++++++++
 tree-walk.c                           |  2 ++
 6 files changed, 51 insertions(+)

diff --git a/Documentation/technical/api-setup.txt b/Documentation/tech=
nical/api-setup.txt
index 90d1aff..540e455 100644
--- a/Documentation/technical/api-setup.txt
+++ b/Documentation/technical/api-setup.txt
@@ -28,3 +28,22 @@ parse_pathspec(). This function takes several argume=
nts:
 - prefix and args come from cmd_* functions
=20
 get_pathspec() is obsolete and should never be used in new code.
+
+parse_pathspec() helps catch unsupported features and reject them
+politely. At a lower level, different pathspec-related functions may
+not support the same set of features. Such pathspec-sensitive
+functions are guarded with GUARD_PATHSPEC(), which will die in an
+unfriendly way when an unsupported feature is requested.
+
+The command designers are supposed to make sure that GUARD_PATHSPEC()
+never dies. They have to make sure all unsupported features are caught
+by parse_pathspec(), not by GUARD_PATHSPEC. grepping GUARD_PATHSPEC()
+should give the designers all pathspec-sensitive codepaths and what
+features they support.
+
+A similar process is applied when a new pathspec magic is added. The
+designer lifts the GUARD_PATHSPEC restriction in the functions that
+support the new magic. At the same time (s)he has to make sure this
+new feature will be caught at parse_pathspec() in commands that cannot
+handle the new magic in some cases. grepping parse_pathspec() should
+help.
diff --git a/builtin/diff.c b/builtin/diff.c
index 9fc273d..6bb41af 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -367,6 +367,8 @@ int cmd_diff(int argc, const char **argv, const cha=
r *prefix)
 		}
 	}
 	if (rev.prune_data.nr) {
+		/* builtin_diff_b_f() */
+		GUARD_PATHSPEC(&rev.prune_data, PATHSPEC_FROMTOP);
 		if (!path)
 			path =3D rev.prune_data.items[0].match;
 		paths +=3D rev.prune_data.nr;
diff --git a/dir.c b/dir.c
index e28bc0d..19978d3 100644
--- a/dir.c
+++ b/dir.c
@@ -340,6 +340,8 @@ int match_pathspec_depth(const struct pathspec *ps,
 {
 	int i, retval =3D 0;
=20
+	GUARD_PATHSPEC(ps, PATHSPEC_FROMTOP | PATHSPEC_MAXDEPTH);
+
 	if (!ps->nr) {
 		if (!ps->recursive ||
 		    !(ps->magic & PATHSPEC_MAXDEPTH) ||
diff --git a/pathspec.h b/pathspec.h
index 2e427d7..6baf205 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -27,6 +27,13 @@ struct pathspec {
 	} *items;
 };
=20
+#define GUARD_PATHSPEC(ps, mask) \
+	do { \
+		if ((ps)->magic & ~(mask))	       \
+			die("BUG:%s:%d: unsupported magic %x",	\
+			    __FILE__, __LINE__, (ps)->magic & ~(mask)); \
+	} while (0)
+
 /* parse_pathspec flags */
 #define PATHSPEC_PREFER_CWD (1<<0) /* No args means match cwd */
 #define PATHSPEC_PREFER_FULL (1<<1) /* No args means match everything =
*/
diff --git a/tree-diff.c b/tree-diff.c
index 826512e..5a87614 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -198,6 +198,25 @@ static void try_to_follow_renames(struct tree_desc=
 *t1, struct tree_desc *t2, co
 	const char *paths[1];
 	int i;
=20
+	/*
+	 * follow-rename code is very specific, we need exactly one
+	 * path. Magic that matches more than one path is not
+	 * supported.
+	 */
+	GUARD_PATHSPEC(&opt->pathspec, PATHSPEC_FROMTOP);
+#if 0
+	/*
+	 * We should reject wildcards as well. Unfortunately we
+	 * haven't got a reliable way to detect that 'foo\*bar' in
+	 * fact has no wildcards. nowildcard_len is merely a hint for
+	 * optimization. Let it slip for now until wildmatch is taught
+	 * about dry-run mode and returns wildcard info.
+	 */
+	if (opt->pathspec.has_wildcard)
+		die("BUG:%s:%d: wildcards are not supported",
+		    __FILE__, __LINE__);
+#endif
+
 	/* Remove the file creation entry from the diff queue, and remember i=
t */
 	choice =3D q->queue[0];
 	q->nr =3D 0;
diff --git a/tree-walk.c b/tree-walk.c
index d399ca9..37b157e 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -636,6 +636,8 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
 	enum interesting never_interesting =3D ps->has_wildcard ?
 		entry_not_interesting : all_entries_not_interesting;
=20
+	GUARD_PATHSPEC(ps, PATHSPEC_FROMTOP | PATHSPEC_MAXDEPTH);
+
 	if (!ps->nr) {
 		if (!ps->recursive ||
 		    !(ps->magic & PATHSPEC_MAXDEPTH) ||
--=20
1.8.2.83.gc99314b
