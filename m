From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/21] grep: drop pathspec_matches() in favor of tree_entry_interesting()
Date: Fri, 17 Dec 2010 19:45:33 +0700
Message-ID: <1292589933-9706-1-git-send-email-pclouds@gmail.com>
References: <1292425376-14550-21-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 13:47:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTZiF-0003LR-Nl
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 13:47:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534Ab0LQMqs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Dec 2010 07:46:48 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45399 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754361Ab0LQMqf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Dec 2010 07:46:35 -0500
Received: by iyi12 with SMTP id 12so403870iyi.19
        for <git@vger.kernel.org>; Fri, 17 Dec 2010 04:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=dLW6FeNRh19RriDeghF+Ofxo1LwjUBCmtoej310wsps=;
        b=xdiPpaJdcgnBTqL01g2qPCUhSAUxKjng7R91s9+OMo+mzzXMxP+SI2x/2WQo080JLk
         jh4QsHlj0jJdRSZJtslhge0K7d8A+enRyjVxsPSucjxUPzZkFTJxtIvlqORM+ghOgK5h
         QJQPd4QjUzgK3fqGHwDJXKsIdoGN6FLIYh7yo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rNw8Lx5xfteR/cudooBEipziCD2n3qZZpGEQNFyWHmhgqWnN3i/XtmeHZHF9kNlw5/
         RJF2wZUsfp7EJWV73bedTbsh0MVJeZ5FIaLg4KAEFp4QDWvcu+/Rso18X0wB5g9Kbpcz
         Kiuztg11P0bvlXT98zrMqLOac7fIw1SIzq7Lo=
Received: by 10.42.167.66 with SMTP id r2mr802318icy.286.1292589994012;
        Fri, 17 Dec 2010 04:46:34 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.209.213])
        by mx.google.com with ESMTPS id i2sm956678icv.15.2010.12.17.04.46.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Dec 2010 04:46:32 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 17 Dec 2010 19:45:34 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292425376-14550-21-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163877>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 tree_entry_interesting now takes base_offset. The real base is
 base->buf+base_offset

 builtin/grep.c |  125 ++++++------------------------------------------=
-------
 tree-diff.c    |    4 +-
 tree-walk.c    |   19 ++++----
 tree-walk.h    |    2 +-
 4 files changed, 27 insertions(+), 123 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index fa1ad28..7256002 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -333,106 +333,6 @@ static int grep_config(const char *var, const cha=
r *value, void *cb)
 	return 0;
 }
=20
-/*
- * Return non-zero if max_depth is negative or path has no more then m=
ax_depth
- * slashes.
- */
-static int accept_subdir(const char *path, int max_depth)
-{
-	if (max_depth < 0)
-		return 1;
-
-	while ((path =3D strchr(path, '/')) !=3D NULL) {
-		max_depth--;
-		if (max_depth < 0)
-			return 0;
-		path++;
-	}
-	return 1;
-}
-
-/*
- * Return non-zero if name is a subdirectory of match and is not too d=
eep.
- */
-static int is_subdir(const char *name, int namelen,
-		const char *match, int matchlen, int max_depth)
-{
-	if (matchlen > namelen || strncmp(name, match, matchlen))
-		return 0;
-
-	if (name[matchlen] =3D=3D '\0') /* exact match */
-		return 1;
-
-	if (!matchlen || match[matchlen-1] =3D=3D '/' || name[matchlen] =3D=3D=
 '/')
-		return accept_subdir(name + matchlen + 1, max_depth);
-
-	return 0;
-}
-
-/*
- * git grep pathspecs are somewhat different from diff-tree pathspecs;
- * pathname wildcards are allowed.
- */
-static int pathspec_matches(const char **paths, const char *name, int =
max_depth)
-{
-	int namelen, i;
-	if (!paths || !*paths)
-		return accept_subdir(name, max_depth);
-	namelen =3D strlen(name);
-	for (i =3D 0; paths[i]; i++) {
-		const char *match =3D paths[i];
-		int matchlen =3D strlen(match);
-		const char *cp, *meta;
-
-		if (is_subdir(name, namelen, match, matchlen, max_depth))
-			return 1;
-		if (!fnmatch(match, name, 0))
-			return 1;
-		if (name[namelen-1] !=3D '/')
-			continue;
-
-		/* We are being asked if the directory ("name") is worth
-		 * descending into.
-		 *
-		 * Find the longest leading directory name that does
-		 * not have metacharacter in the pathspec; the name
-		 * we are looking at must overlap with that directory.
-		 */
-		for (cp =3D match, meta =3D NULL; cp - match < matchlen; cp++) {
-			char ch =3D *cp;
-			if (ch =3D=3D '*' || ch =3D=3D '[' || ch =3D=3D '?') {
-				meta =3D cp;
-				break;
-			}
-		}
-		if (!meta)
-			meta =3D cp; /* fully literal */
-
-		if (namelen <=3D meta - match) {
-			/* Looking at "Documentation/" and
-			 * the pattern says "Documentation/howto/", or
-			 * "Documentation/diff*.txt".  The name we
-			 * have should match prefix.
-			 */
-			if (!memcmp(match, name, namelen))
-				return 1;
-			continue;
-		}
-
-		if (meta - match < namelen) {
-			/* Looking at "Documentation/howto/" and
-			 * the pattern says "Documentation/h*";
-			 * match up to "Do.../h"; this avoids descending
-			 * into "Documentation/technical/".
-			 */
-			if (!memcmp(match, name, meta - match))
-				return 1;
-			continue;
-		}
-	}
-	return 0;
-}
-
 static void *lock_and_read_sha1_file(const unsigned char *sha1, enum o=
bject_type *type, unsigned long *size)
 {
 	void *data;
@@ -625,25 +525,24 @@ static int grep_cache(struct grep_opt *opt, const=
 struct pathspec *pathspec, int
 static int grep_tree(struct grep_opt *opt, const struct pathspec *path=
spec,
 		     struct tree_desc *tree, struct strbuf *base, int tn_len)
 {
-	int hit =3D 0;
+	int hit =3D 0, matched =3D 0;
 	struct name_entry entry;
 	int old_baselen =3D base->len;
=20
 	while (tree_entry(tree, &entry)) {
 		int te_len =3D tree_entry_len(entry.path, entry.sha1);
=20
-		strbuf_add(base, entry.path, te_len);
+		if (matched !=3D 2) {
+			matched =3D tree_entry_interesting(&entry, base, tn_len, pathspec);
+			if (matched =3D=3D -1)
+				break; /* no more matches */
+			if (!matched)
+				continue;
+		}
=20
-		if (S_ISDIR(entry.mode))
-			/* Match "abc/" against pathspec to
-			 * decide if we want to descend into "abc"
-			 * directory.
-			 */
-			strbuf_addch(base, '/');
+		strbuf_add(base, entry.path, te_len);
=20
-		if (!pathspec_matches(pathspec->raw, base->buf + tn_len, opt->max_de=
pth))
-			;
-		else if (S_ISREG(entry.mode)) {
+		if (S_ISREG(entry.mode)) {
 			hit |=3D grep_sha1(opt, entry.sha1, base->buf, tn_len);
 		}
 		else if (S_ISDIR(entry.mode)) {
@@ -656,6 +555,8 @@ static int grep_tree(struct grep_opt *opt, const st=
ruct pathspec *pathspec,
 			if (!data)
 				die("unable to read tree (%s)",
 				    sha1_to_hex(entry.sha1));
+
+			strbuf_addch(base, '/');
 			init_tree_desc(&sub, data, size);
 			hit |=3D grep_tree(opt, pathspec, &sub, base, tn_len);
 			free(data);
@@ -1062,6 +963,8 @@ int cmd_grep(int argc, const char **argv, const ch=
ar *prefix)
 		paths[1] =3D NULL;
 	}
 	init_pathspec(&pathspec, paths);
+	pathspec.max_depth =3D opt.max_depth;
+	pathspec.recursive =3D 1;
=20
 	if (show_in_pager && (cached || list.nr))
 		die("--open-files-in-pager only works on the worktree");
diff --git a/tree-diff.c b/tree-diff.c
index bde2c52..064233a 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -72,7 +72,7 @@ static void show_tree(struct diff_options *opt, const=
 char *prefix,
 		if (all_interesting)
 			show =3D 1;
 		else {
-			show =3D tree_entry_interesting(&desc->entry, base,
+			show =3D tree_entry_interesting(&desc->entry, base, 0,
 						      &opt->pathspec);
 			if (show =3D=3D 2)
 				all_interesting =3D 1;
@@ -130,7 +130,7 @@ static void skip_uninteresting(struct tree_desc *t,=
 struct strbuf *base,
 		if (all_interesting)
 			show =3D 1;
 		else {
-			show =3D tree_entry_interesting(&t->entry, base,
+			show =3D tree_entry_interesting(&t->entry, base, 0,
 						      &opt->pathspec);
 			if (show =3D=3D 2)
 				all_interesting =3D 1;
diff --git a/tree-walk.c b/tree-walk.c
index 99413b3..9b43ad5 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -551,17 +551,17 @@ static int match_dir_prefix(const char *base, int=
 baselen,
  *  - negative for "no, and no subsequent entries will be either"
  */
 int tree_entry_interesting(const struct name_entry *entry,
-			   struct strbuf *base,
+			   struct strbuf *base, int base_offset,
 			   const struct pathspec *ps)
 {
 	int i;
-	int pathlen, baselen =3D base->len;
+	int pathlen, baselen =3D base->len - base_offset;
 	int never_interesting =3D ps->has_wildcard ? 0 : -1;
=20
 	if (!ps->nr) {
 		if (!ps->recursive || ps->max_depth =3D=3D -1)
 			return 1;
-		return !!within_depth(base->buf, baselen,
+		return !!within_depth(base->buf + base_offset, baselen,
 				      !!S_ISDIR(entry->mode),
 				      ps->max_depth);
 	}
@@ -571,24 +571,25 @@ int tree_entry_interesting(const struct name_entr=
y *entry,
 	for (i =3D ps->nr-1; i >=3D 0; i--) {
 		const struct pathspec_item *item =3D ps->items+i;
 		const char *match =3D item->match;
+		const char *base_str =3D base->buf + base_offset;
 		int matchlen =3D item->len;
=20
 		if (baselen >=3D matchlen) {
 			/* If it doesn't match, move along... */
-			if (!match_dir_prefix(base->buf, baselen, match, matchlen))
+			if (!match_dir_prefix(base_str, baselen, match, matchlen))
 				goto match_wildcards;
=20
 			if (!ps->recursive || ps->max_depth =3D=3D -1)
 				return 2;
=20
-			return !!within_depth(base->buf + matchlen + 1,
+			return !!within_depth(base_str + matchlen + 1,
 					      baselen - matchlen - 1,
 					      !!S_ISDIR(entry->mode),
 					      ps->max_depth);
 		}
=20
 		/* Does the base match? */
-		if (!strncmp(base->buf, match, baselen)) {
+		if (!strncmp(base_str, match, baselen)) {
 			if (match_entry(entry, pathlen,
 					match + baselen, matchlen - baselen,
 					&never_interesting))
@@ -620,11 +621,11 @@ match_wildcards:
=20
 		strbuf_add(base, entry->path, pathlen);
=20
-		if (!fnmatch(match, base->buf, 0)) {
-			strbuf_setlen(base, baselen);
+		if (!fnmatch(match, base->buf + base_offset, 0)) {
+			strbuf_setlen(base, base_offset + baselen);
 			return 1;
 		}
-		strbuf_setlen(base, baselen);
+		strbuf_setlen(base, base_offset + baselen);
=20
 		/*
 		 * Match all directories. We'll try to match files
diff --git a/tree-walk.h b/tree-walk.h
index 6589ee2..39524b7 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -60,6 +60,6 @@ static inline int traverse_path_len(const struct trav=
erse_info *info, const stru
 	return info->pathlen + tree_entry_len(n->path, n->sha1);
 }
=20
-extern int tree_entry_interesting(const struct name_entry *, struct st=
rbuf *, const struct pathspec *ps);
+extern int tree_entry_interesting(const struct name_entry *, struct st=
rbuf *, int, const struct pathspec *ps);
=20
 #endif
--=20
1.7.3.3.476.g10a82
