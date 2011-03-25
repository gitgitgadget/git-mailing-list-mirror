From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] Reimplement read_tree_recursive() using tree_entry_interesting()
Date: Fri, 25 Mar 2011 16:34:18 +0700
Message-ID: <1301045660-25053-1-git-send-email-pclouds@gmail.com>
References: <7vlj048f97.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 25 10:34:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q33Pl-00049T-4w
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 10:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934010Ab1CYJef convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2011 05:34:35 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61121 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756062Ab1CYJee (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 05:34:34 -0400
Received: by pwi15 with SMTP id 15so136918pwi.19
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 02:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=V0ctuYg3V7nefPnVqfjh/WdT9WiSVbaQbIy5W9EvuGE=;
        b=SzFx+ReVEJLQKBsu1wRT/rkASIX1lly0+8ol+ABNtoOMuWRoNTiyjezbnNM+kOvThp
         Z87QQFs965gJB18HLVLDv4NfKaIXPwYpprTm/pBIRBXkg7riazrjCrqGXDgzCrXz3w8T
         OL92VX5/EiRs6oKuSdMMGEerb6h1eXzxjptNU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=fP9BP9aRO5HL9bzDIUSbFuoQUQetNDNb0k3R5P4a7V/6SSwBWY1dcKCdRxs+Q4FL6g
         SmcTqxaSOP0NZlXN2wKAsrox/UVYRiZ16c1fHFazZagrcYQvVZzU4J7OtPjgCZNjmFiO
         kxJaBqVvrOPLBhTeWfAgkICQl5gtenBWIFR7k=
Received: by 10.142.237.17 with SMTP id k17mr495559wfh.41.1301045673344;
        Fri, 25 Mar 2011 02:34:33 -0700 (PDT)
Received: from tre ([115.73.209.201])
        by mx.google.com with ESMTPS id w11sm1082971wfh.18.2011.03.25.02.34.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Mar 2011 02:34:31 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 25 Mar 2011 16:34:21 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <7vlj048f97.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169970>

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
 2011/3/25 Junio C Hamano <gitster@pobox.com>:
 > Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
 >
 >> +static int read_tree_1(struct tree *tree, struct strbuf *base,
 >> +                    int stage, struct pathspec *pathspecs,
 >> +                    read_tree_fn_t fn, void *context)
 >
 > Micronit: call the variable pathspec, not pathspecs.

 Fixed (also in the second patch)

 > This "if all-interesting then avoid calling into an expensive matche=
r"
 > logic looks familiar but is not something that came from the parts d=
eleted
 > by this patch.  Where did I see it? Is that something we can share i=
n a
 > common helper function? Is such a sharing worth pursuing, considerin=
g that
 > the above is a reasonably trivial logic in a tight loop?
 >
 > "That's how the return value of tree-entry-interesting is designed t=
o be
 > used, and it is unsurprising that all the callers will fall into tha=
t
 > pattern" is a perfectly acceptable answer, I guess.

 Actually the surrounding code could be improved so that helper functio=
n
 is not needed. I also update other t_e_i() callsites in the third patc=
h.

 tree.c |  152 ++++++++++++++++++++++++--------------------------------=
--------
 1 files changed, 57 insertions(+), 95 deletions(-)

diff --git a/tree.c b/tree.c
index 5ab90af..db3a5c3 100644
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
+		       int stage, struct pathspec *pathspec,
+		       read_tree_fn_t fn, void *context)
 {
 	struct tree_desc desc;
 	struct name_entry entry;
+	unsigned char sha1[20];
+	int len, retval =3D 0, oldlen =3D base->len;
=20
 	if (parse_tree(tree))
 		return -1;
@@ -108,10 +60,16 @@ int read_tree_recursive(struct tree *tree,
 	init_tree_desc(&desc, tree->buffer, tree->size);
=20
 	while (tree_entry(&desc, &entry)) {
-		if (!match_tree_entry(base, baselen, entry.path, entry.mode, match))
-			continue;
+		if (retval !=3D 2) {
+			retval =3D tree_entry_interesting(&entry, base, 0, pathspec);
+			if (retval < 0)
+				break;
+			if (retval =3D=3D 0)
+				continue;
+		}
=20
-		switch (fn(entry.sha1, base, baselen, entry.path, entry.mode, stage,=
 context)) {
+		switch (fn(entry.sha1, base->buf, base->len,
+			   entry.path, entry.mode, stage, context)) {
 		case 0:
 			continue;
 		case READ_TREE_RECURSIVE:
@@ -119,56 +77,60 @@ int read_tree_recursive(struct tree *tree,
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
+				     base, stage, pathspec,
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
+	struct pathspec pathspec;
+	int i, ret;
+
+	init_pathspec(&pathspec, match);
+	for (i =3D 0; i < pathspec.nr; i++)
+		pathspec.items[i].has_wildcard =3D 0;
+	strbuf_add(&sb, base, baselen);
+	ret =3D read_tree_1(tree, &sb, stage, &pathspec, fn, context);
+	strbuf_release(&sb);
+	free_pathspec(&pathspec);
+	return ret;
+}
+
 static int cmp_cache_name_compare(const void *a_, const void *b_)
 {
 	const struct cache_entry *ce1, *ce2;
--=20
1.7.4.74.g639db
