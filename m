From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 10/45] parse_pathspec: a special flag for max_depth feature
Date: Fri, 15 Mar 2013 13:06:25 +0700
Message-ID: <1363327620-29017-11-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:25:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO5J-0004fQ-Io
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858Ab3COGZN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:25:13 -0400
Received: from mail-ia0-f173.google.com ([209.85.210.173]:54745 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab3COGZL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:25:11 -0400
Received: by mail-ia0-f173.google.com with SMTP id h37so2906194iak.18
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=4HS9AamaQsU4+IPMLbHF4At1fvN71ZS2ewIZlJy2evk=;
        b=HgWUAQUwMSQozn4yr6PfwLHjtQsspt9j3Rj6jy4aSOoEfR9PEa33tvS8sZG8e/dWQn
         tD2NUYvo4yu6PCFWIwJnZzugeYqoi9oxItdvFAszACuG3C72TsqrdcjGrM5Uqh23mwXG
         tidbSYxDTVTJeZxrosb4xkFVpt2/nVjhkSfRllH8NoiN/UPgBHiwQgwdORThhnXeQ61f
         2VpaV1pLmGUcSHY2QnTXis7QK6XAZyp0CT10OJiXlWR97V2XKhhyFtHKHRYiyGMjH6uN
         LVPCijNkGyS5HUCgXAvwGIuoKwFWNxVmrtmI29+5/dFon1a5q4GpjYnQ2uMZr5aWDSLo
         dTqA==
X-Received: by 10.43.18.3 with SMTP id qe3mr3896345icb.12.1363328711203;
        Thu, 14 Mar 2013 23:25:11 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id vb15sm732954igb.9.2013.03.14.23.25.07
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:25:10 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:08:13 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218197>

match_pathspec_depth() and tree_entry_interesting() check max_depth
field in order to support "git grep --max-depth". The feature
activation is tied to "recursive" field, which led to some unwated
activation, e.g. 5c8eeb8 (diff-index: enable recursive pathspec
matching in unpack_trees - 2012-01-15).

This patch decouples the activation from "recursive" field, puts it in
"magic" field instead. This makes sure that only "git grep" can
activate this feature. And because parse_pathspec knows when the
feature is not used, it does not need to sort pathspec (required for
max_depth to work correctly). A small win for non-grep cases.

Even though a new magic flag is introduced, no magic syntax is. The
magic can be only enabled by parse_pathspec() caller. We might someday
want to support ":(maxdepth:10)src." It all depends on actual use
cases.

max_depth feature cannot be enabled via init_pathspec() anymore. But
that's ok because init_pathspec() is on its way to /dev/null.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/grep.c | 3 ++-
 diff-lib.c     | 1 -
 dir.c          | 8 ++++++--
 pathspec.c     | 8 ++++++--
 pathspec.h     | 6 +++++-
 tree-diff.c    | 1 -
 tree-walk.c    | 8 ++++++--
 7 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 54b089e..1c7397a 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -860,7 +860,8 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 	}
=20
 	parse_pathspec(&pathspec, 0,
-		       PATHSPEC_PREFER_CWD,
+		       PATHSPEC_PREFER_CWD |
+		       (opt.max_depth !=3D -1 ? PATHSPEC_MAXDEPTH_VALID : 0),
 		       prefix, argv + i);
 	pathspec.max_depth =3D opt.max_depth;
 	pathspec.recursive =3D 1;
diff --git a/diff-lib.c b/diff-lib.c
index f35de0f..4729157 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -474,7 +474,6 @@ static int diff_cache(struct rev_info *revs,
 	opts.dst_index =3D NULL;
 	opts.pathspec =3D &revs->diffopt.pathspec;
 	opts.pathspec->recursive =3D 1;
-	opts.pathspec->max_depth =3D -1;
=20
 	init_tree_desc(&t, tree->buffer, tree->size);
 	return unpack_trees(1, &t, &opts);
diff --git a/dir.c b/dir.c
index 8541ea7..1e9db41 100644
--- a/dir.c
+++ b/dir.c
@@ -298,7 +298,9 @@ int match_pathspec_depth(const struct pathspec *ps,
 	int i, retval =3D 0;
=20
 	if (!ps->nr) {
-		if (!ps->recursive || ps->max_depth =3D=3D -1)
+		if (!ps->recursive ||
+		    !(ps->magic & PATHSPEC_MAXDEPTH) ||
+		    ps->max_depth =3D=3D -1)
 			return MATCHED_RECURSIVELY;
=20
 		if (within_depth(name, namelen, 0, ps->max_depth))
@@ -315,7 +317,9 @@ int match_pathspec_depth(const struct pathspec *ps,
 		if (seen && seen[i] =3D=3D MATCHED_EXACTLY)
 			continue;
 		how =3D match_pathspec_item(ps->items+i, prefix, name, namelen);
-		if (ps->recursive && ps->max_depth !=3D -1 &&
+		if (ps->recursive &&
+		    (ps->magic & PATHSPEC_MAXDEPTH) &&
+		    ps->max_depth !=3D -1 &&
 		    how && how !=3D MATCHED_FNMATCH) {
 			int len =3D ps->items[i].len;
 			if (name[len] =3D=3D '/')
diff --git a/pathspec.c b/pathspec.c
index 6dd944a..b2446c3 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -266,6 +266,9 @@ void parse_pathspec(struct pathspec *pathspec,
=20
 	memset(pathspec, 0, sizeof(*pathspec));
=20
+	if (flags & PATHSPEC_MAXDEPTH_VALID)
+		pathspec->magic |=3D PATHSPEC_MAXDEPTH;
+
 	/* No arguments, no prefix -> no pathspec */
 	if (!entry && !prefix)
 		return;
@@ -320,8 +323,9 @@ void parse_pathspec(struct pathspec *pathspec,
 		pathspec->magic |=3D item[i].magic;
 	}
=20
-	qsort(pathspec->items, pathspec->nr,
-	      sizeof(struct pathspec_item), pathspec_item_cmp);
+	if (pathspec->magic & PATHSPEC_MAXDEPTH)
+		qsort(pathspec->items, pathspec->nr,
+		      sizeof(struct pathspec_item), pathspec_item_cmp);
 }
=20
 /*
diff --git a/pathspec.h b/pathspec.h
index d630e8b..aa98597 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -3,7 +3,10 @@
=20
 /* Pathspec magic */
 #define PATHSPEC_FROMTOP	(1<<0)
-#define PATHSPEC_ALL_MAGIC PATHSPEC_FROMTOP
+#define PATHSPEC_MAXDEPTH	(1<<1)
+#define PATHSPEC_ALL_MAGIC	  \
+	(PATHSPEC_FROMTOP	| \
+	 PATHSPEC_MAXDEPTH)
=20
 #define PATHSPEC_ONESTAR 1	/* the pathspec pattern sastisfies GFNM_ONE=
STAR */
=20
@@ -27,6 +30,7 @@ struct pathspec {
 /* parse_pathspec flags */
 #define PATHSPEC_PREFER_CWD (1<<0) /* No args means match cwd */
 #define PATHSPEC_PREFER_FULL (1<<1) /* No args means match everything =
*/
+#define PATHSPEC_MAXDEPTH_VALID (1<<2) /* max_depth field is valid */
=20
 extern int init_pathspec(struct pathspec *, const char **);
 extern void parse_pathspec(struct pathspec *pathspec,
diff --git a/tree-diff.c b/tree-diff.c
index ba01563..826512e 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -138,7 +138,6 @@ int diff_tree(struct tree_desc *t1, struct tree_des=
c *t2,
=20
 	/* Enable recursion indefinitely */
 	opt->pathspec.recursive =3D DIFF_OPT_TST(opt, RECURSIVE);
-	opt->pathspec.max_depth =3D -1;
=20
 	strbuf_init(&base, PATH_MAX);
 	strbuf_add(&base, base_str, baselen);
diff --git a/tree-walk.c b/tree-walk.c
index 72a9613..d399ca9 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -637,7 +637,9 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
 		entry_not_interesting : all_entries_not_interesting;
=20
 	if (!ps->nr) {
-		if (!ps->recursive || ps->max_depth =3D=3D -1)
+		if (!ps->recursive ||
+		    !(ps->magic & PATHSPEC_MAXDEPTH) ||
+		    ps->max_depth =3D=3D -1)
 			return all_entries_interesting;
 		return within_depth(base->buf + base_offset, baselen,
 				    !!S_ISDIR(entry->mode),
@@ -658,7 +660,9 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
 			if (!match_dir_prefix(base_str, match, matchlen))
 				goto match_wildcards;
=20
-			if (!ps->recursive || ps->max_depth =3D=3D -1)
+			if (!ps->recursive ||
+			    !(ps->magic & PATHSPEC_MAXDEPTH) ||
+			    ps->max_depth =3D=3D -1)
 				return all_entries_interesting;
=20
 			return within_depth(base_str + matchlen + 1,
--=20
1.8.0.rc0.19.g7bbb31d
