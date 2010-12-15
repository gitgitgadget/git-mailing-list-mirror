From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 19/21] grep: use writable strbuf from caller in grep_tree()
Date: Wed, 15 Dec 2010 22:02:54 +0700
Message-ID: <1292425376-14550-20-git-send-email-pclouds@gmail.com>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 16:06:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSsw7-0001Yr-OY
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 16:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752Ab0LOPGU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 10:06:20 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50981 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753826Ab0LOPGT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 10:06:19 -0500
Received: by iyi12 with SMTP id 12so937916iyi.19
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 07:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=lxKuw6gT/NG0YhxdAyd/F4W1CXQBsClrBdUlfrQrKz4=;
        b=RZ9QbFNt0ZZcItGDdgVMyXYw7nXCSIlD5q0VG8eYO/pRZjAFbFqx9ehJIC5z9Hf7hv
         o1sh4wy6x/MnDEnp8fcLhunr0Dw9k4ZZAEvaeXdx4V0IpYBP33VG5Yyi2br7ysC6Upzr
         DR05MAPbzWftkFlO39GlgS0uRTvOO/ikU4ofA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=IbwUeUjr12+mst020x/OLPLBUnutaztT3i2oYR7cIR8t9YzjgP01SZz6l/IDWzDSSa
         6MdJwlB5pGTwO4Vt76N3L/gbgn+lDPrfI0dITNnO7fmO2YTsL16wdFdEz9x5eetFzqBX
         P8IA01fRdcWh+wBG3gz8acdY9bNfGOEXYLGg4=
Received: by 10.231.36.69 with SMTP id s5mr4768541ibd.167.1292425578773;
        Wed, 15 Dec 2010 07:06:18 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.209.213])
        by mx.google.com with ESMTPS id i16sm1044985ibl.6.2010.12.15.07.06.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 07:06:18 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 15 Dec 2010 22:05:26 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163775>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/grep.c |   52 +++++++++++++++++++++++++-----------------------=
----
 1 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index fbc7d02..5ecbbf8 100644
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
+		if (!pathspec_matches(pathspec->raw, base->buf, opt->max_depth))
 			;
-		else if (S_ISREG(entry.mode))
-			hit |=3D grep_sha1(opt, entry.sha1, pathbuf.buf, tn_len);
+		else if (S_ISREG(entry.mode)) {
+			hit |=3D grep_sha1(opt, entry.sha1, base->buf - tn_len, tn_len);
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
@@ -690,13 +677,24 @@ static int grep_object(struct grep_opt *opt, cons=
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
+			strbuf_offset(&base, base.len);
+		}
 		init_tree_desc(&tree, data, size);
-		hit =3D grep_tree(opt, pathspec, &tree, name, "");
+		hit =3D grep_tree(opt, pathspec, &tree, &base, base.neglen);
+		strbuf_release(&base);
 		free(data);
 		return hit;
 	}
--=20
1.7.3.3.476.g10a82
