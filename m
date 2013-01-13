From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 06/31] Guard against new pathspec magic in pathspec matching code
Date: Sun, 13 Jan 2013 19:35:14 +0700
Message-ID: <1358080539-17436-7-git-send-email-pclouds@gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:36:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMnj-00066K-Lv
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755020Ab3AMMgP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:36:15 -0500
Received: from mail-da0-f47.google.com ([209.85.210.47]:35148 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754979Ab3AMMgP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:36:15 -0500
Received: by mail-da0-f47.google.com with SMTP id s35so1417397dak.34
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=thY+vS8qB02vas9TONbpAFVZ7/5K3x0e5+PpF9cOH+8=;
        b=rU7SSXMEB5kwuCeiaj+yC5t5R3gnpCmAR2T4ziZ8Mv5lCN5BIg4lHfFIJVwX/1TDuo
         MiAHXUd/71O8/nHq9YkDgGSS9nUAGxu4HBETrNrREM7QqaG9EJxTQY3krhfgQdQC8Ral
         5Rwh5Q+idnt5Ygew1UBdwMIl5TLwO5Pg35JLh9EVQmBchaWahiz5yBi5baEKPGZdag+8
         Nxyiq00cK7RxbEBHOjixMMWjCH6zZ1pMvIouR2kAAXSexAOYvC/IgraV0YPSlG21G+4t
         BAsgHjbx8Vunh0juetnrihbd4mw7sDw9umMEz+9rebfBvXRtwypxII29MIGrLr3Qp1T6
         zfLQ==
X-Received: by 10.66.79.97 with SMTP id i1mr41929668pax.47.1358080574407;
        Sun, 13 Jan 2013 04:36:14 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id d8sm6753763pax.23.2013.01.13.04.36.11
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:36:13 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:36:23 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213346>

GUARD_PATHSPEC() marks pathspec-sensitive code (basically anything in
'struct pathspec' except fields "nr" and "original"). GUARD_PATHSPEC()
is not supposed to fail. The steps for a new pathspec magic or
optimization would be:

 - update parse_pathspec, add extra information to struct pathspec

 - grep GUARD_PATHSPEC() and update all relevant code (or note those
   that won't work with your new stuff). Update GUARD_PATHSPEC mask
   accordingly.

 - update parse_pathspec calls to allow new magic. Make sure
   parse_pathspec() catches unsupported syntax early, not until
   GUARD_PATHSPEC catches it.

 - add tests to verify supported/unsupported commands both work as
   expected.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/diff.c |  2 ++
 cache.h        |  7 +++++++
 dir.c          |  2 ++
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
diff --git a/cache.h b/cache.h
index 858c7e4..1f51423 100644
--- a/cache.h
+++ b/cache.h
@@ -496,6 +496,13 @@ struct pathspec {
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
 extern int init_pathspec(struct pathspec *, const char **);
 extern void parse_pathspec(struct pathspec *pathspec, unsigned magic_m=
ask,
 			   unsigned flags, const char *prefix,
diff --git a/dir.c b/dir.c
index beb7532..37280c8 100644
--- a/dir.c
+++ b/dir.c
@@ -282,6 +282,8 @@ int match_pathspec_depth(const struct pathspec *ps,
 {
 	int i, retval =3D 0;
=20
+	GUARD_PATHSPEC(ps, PATHSPEC_FROMTOP);
+
 	if (!ps->nr) {
 		if (!ps->recursive || ps->max_depth =3D=3D -1)
 			return MATCHED_RECURSIVELY;
diff --git a/tree-diff.c b/tree-diff.c
index ba01563..68a9e7c 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -199,6 +199,25 @@ static void try_to_follow_renames(struct tree_desc=
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
index 6e30ef9..dd03750 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -635,6 +635,8 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
 	enum interesting never_interesting =3D ps->has_wildcard ?
 		entry_not_interesting : all_entries_not_interesting;
=20
+	GUARD_PATHSPEC(ps, PATHSPEC_FROMTOP);
+
 	if (!ps->nr) {
 		if (!ps->recursive || ps->max_depth =3D=3D -1)
 			return all_entries_interesting;
--=20
1.8.0.rc2.23.g1fb49df
