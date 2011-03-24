From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] Reimplement read_tree_recursive() using tree_entry_interesting()
Date: Thu, 24 Mar 2011 21:41:14 +0700
Message-ID: <1300977675-6243-1-git-send-email-pclouds@gmail.com>
References: <AANLkTinYB=ZUTe29Y9ibLVL5z3KhiYmnCpCGcHx=18RJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 24 15:41:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2ljC-0001WO-Oq
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 15:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227Ab1CXOl3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2011 10:41:29 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44161 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907Ab1CXOl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 10:41:28 -0400
Received: by iwn34 with SMTP id 34so6680iwn.19
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 07:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=M1HjUsoZ821XJg9Ayxo9/PopzVbc/YQSDDD6Hqk5wZw=;
        b=fxm82SO/3O8HlqwYS4XzcCBtt8TgHVfX/kDI7pkKAHoTqSsFCfds9UBp3CXvLw8QPz
         ZkVvSGQjQHVFTUVook+yN2LeJl8ooa8ifPU4Ul6h/TJIWg+ZCNvKlwpgtE4DfNjOcNkk
         shZR/PqKmb4cx8ZVDV8XoSLmoPQZdeFCx+1qU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HEtiDYSIvqghG+jo8qRnGuDSslMtCECAqpk9vDaYUyE7LJoVMiHoWYtzwzCQvT95pP
         EgqDnVllx7hrZItb1DBX5uOMHDDBcXMrLR//q6fL3jMfyLZqWUz/Ijr5qhwx7sXe3joZ
         dSTrPv7I6DEh7tK76Q7sJcy4JnmybyosXTVg4=
Received: by 10.231.39.130 with SMTP id g2mr8054068ibe.118.1300977688032;
        Thu, 24 Mar 2011 07:41:28 -0700 (PDT)
Received: from tre ([115.73.209.201])
        by mx.google.com with ESMTPS id d10sm5857175ibb.34.2011.03.24.07.41.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Mar 2011 07:41:27 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Thu, 24 Mar 2011 21:41:16 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <AANLkTinYB=ZUTe29Y9ibLVL5z3KhiYmnCpCGcHx=18RJ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169917>

read_tree_recursive() uses a very similar function, match_tree_entry, t=
o
tree_entry_interesting() to do its path matching. This patch kills
match_tree_entry() in favor of tree_entry_interesting().

match_tree_entry(), like older version of tree_entry_interesting(), doe=
s
not support wildcard matching. New read_tree_recursive() retains this
behavior by forcing all pathspecs literal.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 tree.c |  156 +++++++++++++++++++++++++-------------------------------=
-------
 1 files changed, 62 insertions(+), 94 deletions(-)

diff --git a/tree.c b/tree.c
index 5ab90af..2b23381 100644
--- a/tree.c
+++ b/tree.c
@@ -45,62 +45,14 @@ static int read_one_entry_quick(const unsigned char=
 *sha1, const char *base, int
 				  ADD_CACHE_JUST_APPEND);
 }
=20
-static int match_tree_entry(const char *base, int baselen, const char =
*path, unsigned int mode, const char **paths)
-{
-	const char *match;
-	int pathlen;
-
-	if (!paths)
-		return 1;
-	pathlen =3D strlen(path);
-	while ((match =3D *paths++) !=3D NULL) {
-		int matchlen =3D strlen(match);
-
-		if (baselen >=3D matchlen) {
-			/* If it doesn't match, move along... */
-			if (strncmp(base, match, matchlen))
-				continue;
-			/* pathspecs match only at the directory boundaries */
-			if (!matchlen ||
-			    baselen =3D=3D matchlen ||
-			    base[matchlen] =3D=3D '/' ||
-			    match[matchlen - 1] =3D=3D '/')
-				return 1;
-			continue;
-		}
-
-		/* Does the base match? */
-		if (strncmp(base, match, baselen))
-			continue;
-
-		match +=3D baselen;
-		matchlen -=3D baselen;
-
-		if (pathlen > matchlen)
-			continue;
-
-		if (matchlen > pathlen) {
-			if (match[pathlen] !=3D '/')
-				continue;
-			if (!S_ISDIR(mode))
-				continue;
-		}
-
-		if (strncmp(path, match, pathlen))
-			continue;
-
-		return 1;
-	}
-	return 0;
-}
-
-int read_tree_recursive(struct tree *tree,
-			const char *base, int baselen,
-			int stage, const char **match,
-			read_tree_fn_t fn, void *context)
+static int read_tree_1(struct tree *tree, struct strbuf *base,
+		       int stage, struct pathspec *pathspecs,
+		       read_tree_fn_t fn, void *context)
 {
 	struct tree_desc desc;
 	struct name_entry entry;
+	unsigned char sha1[20];
+	int len, retval, all_interesting =3D 0, oldlen =3D base->len;
=20
 	if (parse_tree(tree))
 		return -1;
@@ -108,10 +60,22 @@ int read_tree_recursive(struct tree *tree,
 	init_tree_desc(&desc, tree->buffer, tree->size);
=20
 	while (tree_entry(&desc, &entry)) {
-		if (!match_tree_entry(base, baselen, entry.path, entry.mode, match))
+		if (all_interesting)
+			retval =3D all_interesting > 0;
+		else {
+			retval =3D tree_entry_interesting(&entry, base, 0, pathspecs);
+			if (retval =3D=3D 2)
+				all_interesting =3D 1;
+			else if (retval =3D=3D -1) {
+				all_interesting =3D -1;
+				retval =3D 0;
+			}
+		}
+		if (!retval)
 			continue;
=20
-		switch (fn(entry.sha1, base, baselen, entry.path, entry.mode, stage,=
 context)) {
+		switch (fn(entry.sha1, base->buf, base->len,
+			   entry.path, entry.mode, stage, context)) {
 		case 0:
 			continue;
 		case READ_TREE_RECURSIVE:
@@ -119,56 +83,60 @@ int read_tree_recursive(struct tree *tree,
 		default:
 			return -1;
 		}
-		if (S_ISDIR(entry.mode)) {
-			int retval;
-			char *newbase;
-			unsigned int pathlen =3D tree_entry_len(entry.path, entry.sha1);
-
-			newbase =3D xmalloc(baselen + 1 + pathlen);
-			memcpy(newbase, base, baselen);
-			memcpy(newbase + baselen, entry.path, pathlen);
-			newbase[baselen + pathlen] =3D '/';
-			retval =3D read_tree_recursive(lookup_tree(entry.sha1),
-						     newbase,
-						     baselen + pathlen + 1,
-						     stage, match, fn, context);
-			free(newbase);
-			if (retval)
-				return -1;
-			continue;
-		} else if (S_ISGITLINK(entry.mode)) {
-			int retval;
-			struct strbuf path;
-			unsigned int entrylen;
-			struct commit *commit;
=20
-			entrylen =3D tree_entry_len(entry.path, entry.sha1);
-			strbuf_init(&path, baselen + entrylen + 1);
-			strbuf_add(&path, base, baselen);
-			strbuf_add(&path, entry.path, entrylen);
-			strbuf_addch(&path, '/');
+		if (S_ISDIR(entry.mode))
+			hashcpy(sha1, entry.sha1);
+		else if (S_ISGITLINK(entry.mode)) {
+			struct commit *commit;
=20
 			commit =3D lookup_commit(entry.sha1);
 			if (!commit)
-				die("Commit %s in submodule path %s not found",
-				    sha1_to_hex(entry.sha1), path.buf);
+				die("Commit %s in submodule path %s%s not found",
+				    sha1_to_hex(entry.sha1),
+				    base->buf, entry.path);
=20
 			if (parse_commit(commit))
-				die("Invalid commit %s in submodule path %s",
-				    sha1_to_hex(entry.sha1), path.buf);
-
-			retval =3D read_tree_recursive(commit->tree,
-						     path.buf, path.len,
-						     stage, match, fn, context);
-			strbuf_release(&path);
-			if (retval)
-				return -1;
-			continue;
+				die("Invalid commit %s in submodule path %s%s",
+				    sha1_to_hex(entry.sha1),
+				    base->buf, entry.path);
+
+			hashcpy(sha1, commit->tree->object.sha1);
 		}
+		else
+			continue;
+
+		len =3D tree_entry_len(entry.path, entry.sha1);
+		strbuf_add(base, entry.path, len);
+		strbuf_addch(base, '/');
+		retval =3D read_tree_1(lookup_tree(sha1),
+				     base, stage, pathspecs,
+				     fn, context);
+		strbuf_setlen(base, oldlen);
+		if (retval)
+			return -1;
 	}
 	return 0;
 }
=20
+int read_tree_recursive(struct tree *tree,
+			const char *base, int baselen,
+			int stage, const char **match,
+			read_tree_fn_t fn, void *context)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	struct pathspec pathspecs;
+	int i, ret;
+
+	init_pathspec(&pathspecs, match);
+	for (i =3D 0; i < pathspecs.nr; i++)
+		pathspecs.items[i].has_wildcard =3D 0;
+	strbuf_add(&sb, base, baselen);
+	ret =3D read_tree_1(tree, &sb, stage, &pathspecs, fn, context);
+	strbuf_release(&sb);
+	free_pathspec(&pathspecs);
+	return ret;
+}
+
 static int cmp_cache_name_compare(const void *a_, const void *b_)
 {
 	const struct cache_entry *ce1, *ce2;
--=20
1.7.4.74.g639db
