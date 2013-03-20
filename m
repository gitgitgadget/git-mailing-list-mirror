From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 14/45] Guard against new pathspec magic in pathspec matching code
Date: Wed, 20 Mar 2013 19:16:17 +0700
Message-ID: <1363781779-14947-5-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363781779-14947-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 20 13:17:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIHxH-0003Sm-Ux
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 13:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933698Ab3CTMQw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Mar 2013 08:16:52 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:38421 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932159Ab3CTMQv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 08:16:51 -0400
Received: by mail-pd0-f174.google.com with SMTP id 10so591192pdi.19
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 05:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=3jTuTu7VN6X5s7hXaXRwE8Keb7M+Njvrk0wGo+9FjOQ=;
        b=TqdVl0NogsAQiKfAPhK0RG7d+ir4uAwFrPyuo+M+XSBwrp4L/fFDDhW+YD7YqXbmJ1
         J543yTENAfB/+Kr5M7nMjnXhz4F8IdDU/X7oV0zsJ9/t4u5PZNDyORB5V1IxSsjJy0Tu
         ZEsA6vabHWRMku7H1fLhQSOubJtQj+zB+LcQKmqNka9RPXPEo6O0GK35wEmn62GqdOa+
         5CYH2PmdXdaffgTniwJqOPbrIBRSev78W1Q5+u2HHoc4Vxk3fmO/hD7bJq7ueFRBY/kE
         jIrgJaf4AUd2/8z8wULS7vNQ+487MjUcgUpVjqxfGLyyRT8PxhTRWjzXJsSpjvEc0FoB
         Ikpg==
X-Received: by 10.68.237.100 with SMTP id vb4mr8639763pbc.202.1363781810845;
        Wed, 20 Mar 2013 05:16:50 -0700 (PDT)
Received: from lanh ([115.74.40.216])
        by mx.google.com with ESMTPS id pv7sm1933768pbb.33.2013.03.20.05.16.47
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 05:16:50 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 20 Mar 2013 19:16:46 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1363781779-14947-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218592>

GUARD_PATHSPEC() marks pathspec-sensitive code, basically all those
that touch anything in 'struct pathspec' except fields "nr" and
"original". GUARD_PATHSPEC() is not supposed to fail. It's mainly to
help the designers to catch unsupported codepaths.

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
index 59a947e..f62528e 100644
--- a/Documentation/technical/api-setup.txt
+++ b/Documentation/technical/api-setup.txt
@@ -28,3 +28,22 @@ parse_pathspec(). This function takes several argume=
nts:
 - prefix and args come from cmd_* functions
=20
 get_pathspec() is obsolete and should never be used in new code.
+
+parse_pathspec() helps catch unsupported features and reject it
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
index 8c2af6c..d237e0a 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -371,6 +371,8 @@ int cmd_diff(int argc, const char **argv, const cha=
r *prefix)
 		die(_("unhandled object '%s' given."), name);
 	}
 	if (rev.prune_data.nr) {
+		/* builtin_diff_b_f() */
+		GUARD_PATHSPEC(&rev.prune_data, PATHSPEC_FROMTOP);
 		if (!path)
 			path =3D rev.prune_data.items[0].match;
 		paths +=3D rev.prune_data.nr;
diff --git a/dir.c b/dir.c
index 1e9db41..6094ba8 100644
--- a/dir.c
+++ b/dir.c
@@ -297,6 +297,8 @@ int match_pathspec_depth(const struct pathspec *ps,
 {
 	int i, retval =3D 0;
=20
+	GUARD_PATHSPEC(ps, PATHSPEC_FROMTOP | PATHSPEC_MAXDEPTH);
+
 	if (!ps->nr) {
 		if (!ps->recursive ||
 		    !(ps->magic & PATHSPEC_MAXDEPTH) ||
diff --git a/pathspec.h b/pathspec.h
index 3ca6636..7068f7d 100644
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
1.8.0.rc0.19.g7bbb31d
