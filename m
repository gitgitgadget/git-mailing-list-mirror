From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/19] grep: use preallocated buffer for grep_tree()
Date: Mon, 13 Dec 2010 16:46:55 +0700
Message-ID: <1292233616-27692-19-git-send-email-pclouds@gmail.com>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 13 10:50:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS531-0005R9-8P
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 10:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853Ab0LMJuJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 04:50:09 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35818 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab0LMJuI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 04:50:08 -0500
Received: by mail-pz0-f46.google.com with SMTP id 6so479719pzk.19
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 01:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=c/UtZ4G5FKfWwwG6VkCi4sNxb4obYyaHVLXq+kFn1jc=;
        b=Tx65OpUuCTfsJ+jPdQcEw5iZUsWXVZCoeLT3RhUYgMZgMHM4uk3K4tJ87SkhWV2qhK
         DckiP+0QiU4Gb9ucKsAxAYEGjc369TBsEsFaUH7yycNjISjMZTpwhrjiKVKh+Y3YRsse
         Dzy0tpVFsaj/IUIwCmeq6urS3GvnlFtT0zqnA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Zmmoz4H6vYN+YH3k14JKspVEkpm6dPeuR8M5N8hnOFJ0SYJlKGEzWx8lU/VStsSsNP
         pGFKxj2Lb9QfI5Zu+nN6H+ne7O4JCJMlW7FRx/1moJ1Pas17FAEhbRrItj8BPkKcrHD6
         g/992Kh8HedQqfIci4TGqmt3J1FKxI4yYAynQ=
Received: by 10.142.204.15 with SMTP id b15mr3033636wfg.424.1292233807828;
        Mon, 13 Dec 2010 01:50:07 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id w22sm8679054wfd.7.2010.12.13.01.50.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 01:50:06 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 13 Dec 2010 16:49:14 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163545>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 because tree_entry_interesting() will need writable "base".

 builtin/grep.c |   59 +++++++++++++++++++++++++++++-------------------=
-------
 1 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 1646e15..6bd5728 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -623,44 +623,38 @@ static int grep_cache(struct grep_opt *opt, const=
 struct pathspec *pathspec, int
 	return hit;
 }
=20
+/*
+ * "base" is a writable buffer where
+ * - base[-tree_name_len..-1] contains tree_name
+ * - base[0..baselen-1] contains tree base
+ */
 static int grep_tree(struct grep_opt *opt, const struct pathspec *path=
spec,
-		     struct tree_desc *tree,
-		     const char *tree_name, const char *base)
+		     struct tree_desc *tree, char *base,
+		     int baselen, int tree_name_len)
 {
-	int len;
 	int hit =3D 0;
 	struct name_entry entry;
-	char *down;
-	int tn_len =3D strlen(tree_name);
-	struct strbuf pathbuf;
-
-	strbuf_init(&pathbuf, PATH_MAX + tn_len);
-
-	if (tn_len) {
-		strbuf_add(&pathbuf, tree_name, tn_len);
-		strbuf_addch(&pathbuf, ':');
-		tn_len =3D pathbuf.len;
-	}
-	strbuf_addstr(&pathbuf, base);
-	len =3D pathbuf.len;
=20
 	while (tree_entry(tree, &entry)) {
 		int te_len =3D tree_entry_len(entry.path, entry.sha1);
-		pathbuf.len =3D len;
-		strbuf_add(&pathbuf, entry.path, te_len);
+		int len =3D baselen;
+		memcpy(base + baselen, entry.path, te_len+1);
=20
-		if (S_ISDIR(entry.mode))
+		len +=3D te_len;
+		if (S_ISDIR(entry.mode)) {
 			/* Match "abc/" against pathspec to
 			 * decide if we want to descend into "abc"
 			 * directory.
 			 */
-			strbuf_addch(&pathbuf, '/');
+			base[len++] =3D '/';
+			base[len] =3D 0;
+		}
=20
-		down =3D pathbuf.buf + tn_len;
-		if (!pathspec_matches(pathspec->raw, down, opt->max_depth))
+		if (!pathspec_matches(pathspec->raw, base, opt->max_depth))
 			;
-		else if (S_ISREG(entry.mode))
-			hit |=3D grep_sha1(opt, entry.sha1, pathbuf.buf, tn_len);
+		else if (S_ISREG(entry.mode)) {
+			hit |=3D grep_sha1(opt, entry.sha1, base-tree_name_len, tree_name_l=
en);
+		}
 		else if (S_ISDIR(entry.mode)) {
 			enum object_type type;
 			struct tree_desc sub;
@@ -672,13 +666,12 @@ static int grep_tree(struct grep_opt *opt, const =
struct pathspec *pathspec,
 				die("unable to read tree (%s)",
 				    sha1_to_hex(entry.sha1));
 			init_tree_desc(&sub, data, size);
-			hit |=3D grep_tree(opt, pathspec, &sub, tree_name, down);
+			hit |=3D grep_tree(opt, pathspec, &sub, base, len, tree_name_len);
 			free(data);
 		}
 		if (hit && opt->status_only)
 			break;
 	}
-	strbuf_release(&pathbuf);
 	return hit;
 }
=20
@@ -691,13 +684,23 @@ static int grep_object(struct grep_opt *opt, cons=
t struct pathspec *pathspec,
 		struct tree_desc tree;
 		void *data;
 		unsigned long size;
-		int hit;
+		int hit, len;
+		char *base;
+
 		data =3D read_object_with_reference(obj->sha1, tree_type,
 						  &size, NULL);
 		if (!data)
 			die("unable to read tree (%s)", sha1_to_hex(obj->sha1));
 		init_tree_desc(&tree, data, size);
-		hit =3D grep_tree(opt, pathspec, &tree, name, "");
+		len =3D name ? strlen(name) : 0;
+		base =3D xmalloc(PATH_MAX + len + 1);
+		if (len) {
+			memcpy(base, name, len);
+			base[len++] =3D ':';
+		}
+		base[len] =3D 0;
+		hit =3D grep_tree(opt, pathspec, &tree, base+len, 0, len);
+		free(base);
 		free(data);
 		return hit;
 	}
--=20
1.7.3.3.476.g10a82
