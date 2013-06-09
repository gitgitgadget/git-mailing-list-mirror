From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/45] Guard against new pathspec magic in pathspec matching code
Date: Sun,  9 Jun 2013 13:25:46 +0700
Message-ID: <1370759178-1709-14-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:26:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ53-0000DF-R1
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049Ab3FIG0R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:26:17 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35737 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007Ab3FIG0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:26:16 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so1860940pde.23
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ZpllCiYzMzXcL1eLTbzBmS8Twd8K+POeRIpY5B7Zc98=;
        b=yZZyZkCQXru4jWihbHrqfcuxCjNU4JDGTrPmwGkZadPcnijhS2qKFyM/TjYwQbR97a
         /Df1LjqUz4m+V7ybNJHCk+bHoklI72ixcAIE68wdglgsmuheBlR4euFiat0FnTnMNqae
         yorGHKgfC+J6dY3F9upAlZo2OY5Sw2ms2txf4sz3wr/1LoQ5FebOVoMqlhIgfWo0fuql
         epZtrD08Hvn2ECpG2tbf/PDa7RxyBthoot6b3KNN9L27cjwt4YaTi333KAenQjjZMxvd
         beUax0/mdbKBS7b1jcZB/pZigZgtxesppNQAqRVt1z1QcqOg1aRvFmjpemHRfAM5L9bx
         Hmrg==
X-Received: by 10.66.228.34 with SMTP id sf2mr9346917pac.134.1370759175841;
        Sat, 08 Jun 2013 23:26:15 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id v7sm5503557pbq.32.2013.06.08.23.26.12
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:26:15 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:27:47 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226905>

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
index cfcdda5..fcc0b97 100644
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
1.8.2.83.gc99314b
