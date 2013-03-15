From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 14/45] Guard against new pathspec magic in pathspec matching code
Date: Fri, 15 Mar 2013 13:06:29 +0700
Message-ID: <1363327620-29017-15-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:26:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO5e-00053K-U2
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074Ab3COGZi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:25:38 -0400
Received: from mail-ia0-f173.google.com ([209.85.210.173]:65225 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223Ab3COGZh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:25:37 -0400
Received: by mail-ia0-f173.google.com with SMTP id h37so2897008iak.32
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=0/+q1hf1E5PtWxF2cdk8yMZ1bpQUcLo3LQ5gTKnlq30=;
        b=o9qEOCadTTZoGSqtm3XpH9Ccm02Il53axGKjVVwS3CI/qcPKbbX7S7GZ8SUnXvAVry
         1tDTmvoaT/u0sN7dF6Q9R4F5KopBkjF/ydX4MZoiqjTaWHPQBa9eSDsBikZpIz3uEr9m
         Q+SmE2UmVAknfQ2862+xrQsXU5hu8AJP6tAjZBfK1lnTbh/hSWzzJ8dgd2t+H29+6ALG
         XhzqRA8a9boJqmYb4FUaqUcIzB1EyFPVTcdYDVaYT071Al4WewKYUZLV3p8IN7sAIj/C
         NFikfCaaGIw4WJtJfbpcwFIaTyaspmOdguxOYMdHHCML18nFTug0hbQcIg5dzzo3ZC+E
         mfog==
X-Received: by 10.50.36.199 with SMTP id s7mr417463igj.56.1363328737046;
        Thu, 14 Mar 2013 23:25:37 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id s8sm762289igs.0.2013.03.14.23.25.34
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:25:36 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:08:39 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218201>

GUARD_PATHSPEC() marks pathspec-sensitive code (basically anything in
'struct pathspec' except fields "nr" and "original"). GUARD_PATHSPEC()
is not supposed to fail. The steps for a new pathspec magic or
optimization would be:

 - update parse_pathspec, add extra information to struct pathspec

 - grep GUARD_PATHSPEC() and update all relevant code (or note those
   that won't work with your new stuff). Update GUARD_PATHSPEC mask
   accordingly.

 - update parse_pathspec calls to disable new magic early at command
   parsing level. Make sure parse_pathspec() catches unsupported
   syntax, not until GUARD_PATHSPEC catches it.

 - add tests to verify supported/unsupported commands both work as
   expected.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/diff.c |  2 ++
 dir.c          |  2 ++
 pathspec.h     |  7 +++++++
 tree-diff.c    | 19 +++++++++++++++++++
 tree-walk.c    |  2 ++
 5 files changed, 32 insertions(+)

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
index 1cef9c6..ed5d3a6 100644
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
