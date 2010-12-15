From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/21] grep: drop pathspec_matches() in favor of tree_entry_interesting()
Date: Wed, 15 Dec 2010 22:02:55 +0700
Message-ID: <1292425376-14550-21-git-send-email-pclouds@gmail.com>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 16:06:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSsw8-0001Yr-8u
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 16:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815Ab0LOPG1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 10:06:27 -0500
Received: from mail-gx0-f180.google.com ([209.85.161.180]:35764 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753826Ab0LOPG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 10:06:27 -0500
Received: by gxk19 with SMTP id 19so1329326gxk.11
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 07:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=lfkkEM9ztAPQRFTpWb73R6IWT4L/taaEP3tY2wBgyGM=;
        b=LBuLsTJzQSeu7kD44FYB5fCJNLayE3ULrKxd1ZsXlrfljrmRGGt9Z5D9NhXM8KOAkI
         GYYPVCPKa8vmBBXzAS+qdFVP4exxiIuLTSHNATFHV/QMegAX53TsW9jwbuOfDH7tWZY1
         2qs7A1AqqpnrfklQ2OFbRV5egOn1IhV+HiOHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=uoAoem2MleZZqS99O0x+hpgPiha+gUbViGJeaCmoWqyHE/Kss95Mk9ctAT7cVgqCYE
         SKOVedNBpj3GuayprhaFtTiLB6Ou33K3Lb4tmZGWw0TVdZgG4huckT3ztxwdQ0nYoryX
         MsXtDyPOIOo+YqT8ZIzEiz95qBw3y+SkRj92A=
Received: by 10.42.222.6 with SMTP id ie6mr5759432icb.217.1292425586087;
        Wed, 15 Dec 2010 07:06:26 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.209.213])
        by mx.google.com with ESMTPS id l26sm848169icl.16.2010.12.15.07.06.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 07:06:25 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 15 Dec 2010 22:05:33 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163774>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/grep.c |  125 ++++++------------------------------------------=
-------
 1 files changed, 14 insertions(+), 111 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 5ecbbf8..3cd66b1 100644
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
+			matched =3D tree_entry_interesting(&entry, base, pathspec);
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
-		if (!pathspec_matches(pathspec->raw, base->buf, opt->max_depth))
-			;
-		else if (S_ISREG(entry.mode)) {
+		if (S_ISREG(entry.mode)) {
 			hit |=3D grep_sha1(opt, entry.sha1, base->buf - tn_len, tn_len);
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
@@ -1063,6 +964,8 @@ int cmd_grep(int argc, const char **argv, const ch=
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
