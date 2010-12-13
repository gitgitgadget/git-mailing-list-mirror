From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 19/19] grep: drop pathspec_matches() in favor of tree_entry_interesting()
Date: Mon, 13 Dec 2010 16:46:56 +0700
Message-ID: <1292233616-27692-20-git-send-email-pclouds@gmail.com>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 13 10:50:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS531-0005R9-P1
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 10:50:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874Ab0LMJuQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 04:50:16 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35818 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab0LMJuO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 04:50:14 -0500
Received: by mail-pz0-f46.google.com with SMTP id 6so479719pzk.19
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 01:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=QYk84yzKFD25U0rmFnuGW3lX//6TYt4mzX0uS88zRVo=;
        b=F8VzMd3NW+6bdwcsa0KrPkbFc2ZP/kGiYTQ1fiRc0GW6j9Zg2qwTTMIXheAJghAWYB
         DaY2dlrdlej3WDSFKQFboPbNigAeiFa4UhDC8MrYKFr/fM4+0ZM60h+tCppyubEaoJ0v
         FJSRIZagoMQ6XzVgcX3BhVNiWwxooDhutthgA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=OFbvrIIRJUHX4y6VYyxXvM5U6NhC8GfJp5pp5fVXrXud8q6ndNshXU1B9FBsvoTiWo
         qmOsh74Oqy4U4iWX2NZpERMxwxi4iDJrpIss+BC0a590pKwD3usekeuqVWrRHDtXS7Ht
         xRz/NfXqwsYFUFTVoAsnRu5xpvwRNgz5UsicY=
Received: by 10.142.128.11 with SMTP id a11mr3028156wfd.295.1292233814728;
        Mon, 13 Dec 2010 01:50:14 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id q13sm8679739wfc.5.2010.12.13.01.50.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 01:50:13 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 13 Dec 2010 16:49:22 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163546>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/grep.c |  130 ++++++------------------------------------------=
-------
 1 files changed, 15 insertions(+), 115 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 6bd5728..a56cdd6 100644
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
@@ -632,39 +532,37 @@ static int grep_tree(struct grep_opt *opt, const =
struct pathspec *pathspec,
 		     struct tree_desc *tree, char *base,
 		     int baselen, int tree_name_len)
 {
-	int hit =3D 0;
+	int hit =3D 0, matched =3D 0;
 	struct name_entry entry;
=20
 	while (tree_entry(tree, &entry)) {
 		int te_len =3D tree_entry_len(entry.path, entry.sha1);
-		int len =3D baselen;
-		memcpy(base + baselen, entry.path, te_len+1);
=20
-		len +=3D te_len;
-		if (S_ISDIR(entry.mode)) {
-			/* Match "abc/" against pathspec to
-			 * decide if we want to descend into "abc"
-			 * directory.
-			 */
-			base[len++] =3D '/';
-			base[len] =3D 0;
+		if (matched !=3D 2) {
+			matched =3D tree_entry_interesting(&entry, base, baselen, pathspec)=
;
+			if (matched =3D=3D -1)
+				break; /* no more matches */
+			if (!matched)
+				continue;
 		}
=20
-		if (!pathspec_matches(pathspec->raw, base, opt->max_depth))
-			;
-		else if (S_ISREG(entry.mode)) {
+		memcpy(base + baselen, entry.path, te_len+1);
+		if (S_ISREG(entry.mode))
 			hit |=3D grep_sha1(opt, entry.sha1, base-tree_name_len, tree_name_l=
en);
-		}
 		else if (S_ISDIR(entry.mode)) {
 			enum object_type type;
 			struct tree_desc sub;
 			void *data;
 			unsigned long size;
+			int len =3D baselen + te_len;
=20
 			data =3D lock_and_read_sha1_file(entry.sha1, &type, &size);
 			if (!data)
 				die("unable to read tree (%s)",
 				    sha1_to_hex(entry.sha1));
+
+			base[len++] =3D '/';
+			base[len] =3D 0;
 			init_tree_desc(&sub, data, size);
 			hit |=3D grep_tree(opt, pathspec, &sub, base, len, tree_name_len);
 			free(data);
@@ -1069,6 +967,8 @@ int cmd_grep(int argc, const char **argv, const ch=
ar *prefix)
 		paths[1] =3D NULL;
 	}
 	init_pathspec(&pathspec, paths);
+	pathspec.max_depth =3D opt.max_depth;
+	pathspec.recursive =3D 1;
=20
 	if (show_in_pager && (cached || list.nr))
 		die("--open-files-in-pager only works on the worktree");
--=20
1.7.3.3.476.g10a82
