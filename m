From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 19/21] grep: use writable strbuf from caller for grep_tree()
Date: Fri, 17 Dec 2010 19:44:25 +0700
Message-ID: <1292589865-9617-1-git-send-email-pclouds@gmail.com>
References: <AANLkTi=hXQqtYmhtHh+D67d9puRrDA+iScpafaYYMsAk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 13:45:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTZgi-0002a9-T8
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 13:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843Ab0LQMp2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Dec 2010 07:45:28 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47421 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553Ab0LQMp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Dec 2010 07:45:27 -0500
Received: by pwj3 with SMTP id 3so116243pwj.19
        for <git@vger.kernel.org>; Fri, 17 Dec 2010 04:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=nTIqSdtpHxAWx/NBGa8TKhhYWz1+TMp7iZ51Ym1w09o=;
        b=r+rM8KZR/siIV1nPGI54u44KmsH4OB8Qe0cLnNAGkEqlv0egaMe5vZMmDdKLlmW3xH
         MySM6VdVDr9YL7duli9YatiOh3QSuSZlaD3EZRbkRtWqQxLIhMAfb0GuyzynQ4cV6dVI
         egIKBjvLQwf0p401vXl0rPLrTHTnfUx/wuMN0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=IJbk5Rof1SVn2bqab+T4UDKqTaXSKzp+Weoh2UW371Ddl/lWz6fuaHQ9i2MB1Wn/aY
         MaD+FiIn4ae+iEb4XdmbgeH3D9VV86vLnX5jMNClIZ0gUumTsmYdsDHTizWLInW2N0/R
         wpWYwFXIqeOlwCf5Xn61MqYU7aKqZSXhA66yI=
Received: by 10.142.218.6 with SMTP id q6mr627840wfg.220.1292589927469;
        Fri, 17 Dec 2010 04:45:27 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.209.213])
        by mx.google.com with ESMTPS id b11sm325870wff.21.2010.12.17.04.45.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Dec 2010 04:45:26 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 17 Dec 2010 19:44:27 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <AANLkTi=hXQqtYmhtHh+D67d9puRrDA+iScpafaYYMsAk@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163876>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 strbuf_offset and its patch are dropped.

 builtin/grep.c |   51 ++++++++++++++++++++++++------------------------=
---
 1 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index fbc7d02..fa1ad28 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -623,43 +623,29 @@ static int grep_cache(struct grep_opt *opt, const=
 struct pathspec *pathspec, int
 }
=20
 static int grep_tree(struct grep_opt *opt, const struct pathspec *path=
spec,
-		     struct tree_desc *tree,
-		     const char *tree_name, const char *base)
+		     struct tree_desc *tree, struct strbuf *base, int tn_len)
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
+	int old_baselen =3D base->len;
=20
 	while (tree_entry(tree, &entry)) {
 		int te_len =3D tree_entry_len(entry.path, entry.sha1);
-		pathbuf.len =3D len;
-		strbuf_add(&pathbuf, entry.path, te_len);
+
+		strbuf_add(base, entry.path, te_len);
=20
 		if (S_ISDIR(entry.mode))
 			/* Match "abc/" against pathspec to
 			 * decide if we want to descend into "abc"
 			 * directory.
 			 */
-			strbuf_addch(&pathbuf, '/');
+			strbuf_addch(base, '/');
=20
-		down =3D pathbuf.buf + tn_len;
-		if (!pathspec_matches(pathspec->raw, down, opt->max_depth))
+		if (!pathspec_matches(pathspec->raw, base->buf + tn_len, opt->max_de=
pth))
 			;
-		else if (S_ISREG(entry.mode))
-			hit |=3D grep_sha1(opt, entry.sha1, pathbuf.buf, tn_len);
+		else if (S_ISREG(entry.mode)) {
+			hit |=3D grep_sha1(opt, entry.sha1, base->buf, tn_len);
+		}
 		else if (S_ISDIR(entry.mode)) {
 			enum object_type type;
 			struct tree_desc sub;
@@ -671,13 +657,14 @@ static int grep_tree(struct grep_opt *opt, const =
struct pathspec *pathspec,
 				die("unable to read tree (%s)",
 				    sha1_to_hex(entry.sha1));
 			init_tree_desc(&sub, data, size);
-			hit |=3D grep_tree(opt, pathspec, &sub, tree_name, down);
+			hit |=3D grep_tree(opt, pathspec, &sub, base, tn_len);
 			free(data);
 		}
+		strbuf_setlen(base, old_baselen);
+
 		if (hit && opt->status_only)
 			break;
 	}
-	strbuf_release(&pathbuf);
 	return hit;
 }
=20
@@ -690,13 +677,23 @@ static int grep_object(struct grep_opt *opt, cons=
t struct pathspec *pathspec,
 		struct tree_desc tree;
 		void *data;
 		unsigned long size;
-		int hit;
+		struct strbuf base;
+		int hit, len;
+
 		data =3D read_object_with_reference(obj->sha1, tree_type,
 						  &size, NULL);
 		if (!data)
 			die("unable to read tree (%s)", sha1_to_hex(obj->sha1));
+
+		len =3D name ? strlen(name) : 0;
+		strbuf_init(&base, PATH_MAX + len + 1);
+		if (len) {
+			strbuf_add(&base, name, len);
+			strbuf_addch(&base, ':');
+		}
 		init_tree_desc(&tree, data, size);
-		hit =3D grep_tree(opt, pathspec, &tree, name, "");
+		hit =3D grep_tree(opt, pathspec, &tree, &base, base.len);
+		strbuf_release(&base);
 		free(data);
 		return hit;
 	}
--=20
1.7.3.3.476.g10a82
