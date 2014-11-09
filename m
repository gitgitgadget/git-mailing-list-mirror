From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/3] ls-tree: remove path filtering logic in show_tree
Date: Sun,  9 Nov 2014 15:58:39 +0700
Message-ID: <1415523519-28789-3-git-send-email-pclouds@gmail.com>
References: <1415444432-18596-1-git-send-email-pclouds@gmail.com>
 <1415523519-28789-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 09 09:58:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnOKY-0004FE-Fk
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 09:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbaKII6i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Nov 2014 03:58:38 -0500
Received: from mail-pd0-f180.google.com ([209.85.192.180]:49061 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbaKII6h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 03:58:37 -0500
Received: by mail-pd0-f180.google.com with SMTP id ft15so5871636pdb.25
        for <git@vger.kernel.org>; Sun, 09 Nov 2014 00:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MAPtmP9QC77QAgUNAa10beInuUusHVuG4bZ/ZiLdDG0=;
        b=z3GjaCV9s0og8BiTiOWLccJ4s+IswRa/LjHZ/PUcsBXXz1Bd85b/pm8BovcTtvPbOn
         n6G5b2xf6KJpnCj2NN6M5MjnYtBM4bCn9Vz9s5W40UuibviC9az9MBUcu9Z1agnG7t22
         XjL4yzBB8G9/DzaTN6aj6fdLiWuy+aKOnnzK4EzTGJvLP1ZYIoNyBXGQZaB5e2Ra+JpH
         kGu9VKzaE9e4KuCzemvSCF1Lfdhi8/UG7DILoqNCzsySef5N8tUmWhxPlXf4pKEunuE/
         XCDwwlu6l1H4LgllZK1HZ+xjTyS4o3CwLQ7TmGBtLE7si+7m2pnDzsYm+kdho0QMx/Am
         b2fA==
X-Received: by 10.70.33.195 with SMTP id t3mr274340pdi.135.1415523516874;
        Sun, 09 Nov 2014 00:58:36 -0800 (PST)
Received: from lanh ([115.73.197.54])
        by mx.google.com with ESMTPSA id 3sm13330729pdv.47.2014.11.09.00.58.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Nov 2014 00:58:36 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Nov 2014 15:58:51 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1415523519-28789-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ls-tree uses read_tree_recursive() which already does path filtering
using pathspec. No need to filter one more time based on prefix
only. "ls-tree ../somewhere" does not work because of
this. write_name_quotedpfx() can now be retired because nobody else
uses it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-tree.c            | 14 +++++++-------
 quote.c                      | 21 ---------------------
 quote.h                      |  2 --
 t/t3102-ls-tree-wildcards.sh |  8 ++++++++
 4 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index d226344..3b04a0f 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -65,6 +65,7 @@ static int show_tree(const unsigned char *sha1, struc=
t strbuf *base,
 		const char *pathname, unsigned mode, int stage, void *context)
 {
 	int retval =3D 0;
+	int baselen;
 	const char *type =3D blob_type;
=20
 	if (S_ISGITLINK(mode)) {
@@ -89,11 +90,6 @@ static int show_tree(const unsigned char *sha1, stru=
ct strbuf *base,
 	else if (ls_options & LS_TREE_ONLY)
 		return 0;
=20
-	if (chomp_prefix &&
-	    (base->len < chomp_prefix ||
-	     memcmp(ls_tree_prefix, base->buf, chomp_prefix)))
-		return 0;
-
 	if (!(ls_options & LS_NAME_ONLY)) {
 		if (ls_options & LS_SHOW_SIZE) {
 			char size_text[24];
@@ -113,8 +109,12 @@ static int show_tree(const unsigned char *sha1, st=
ruct strbuf *base,
 			printf("%06o %s %s\t", mode, type,
 			       find_unique_abbrev(sha1, abbrev));
 	}
-	write_name_quotedpfx(base->buf + chomp_prefix, base->len - chomp_pref=
ix,
-			  pathname, stdout, line_termination);
+	baselen =3D base->len;
+	strbuf_addstr(base, pathname);
+	write_name_quoted_relative(base->buf,
+				   chomp_prefix ? ls_tree_prefix : NULL,
+				   stdout, line_termination);
+	strbuf_setlen(base, baselen);
 	return retval;
 }
=20
diff --git a/quote.c b/quote.c
index 45e3db1..7920e18 100644
--- a/quote.c
+++ b/quote.c
@@ -274,27 +274,6 @@ void write_name_quoted(const char *name, FILE *fp,=
 int terminator)
 	fputc(terminator, fp);
 }
=20
-void write_name_quotedpfx(const char *pfx, size_t pfxlen,
-			  const char *name, FILE *fp, int terminator)
-{
-	int needquote =3D 0;
-
-	if (terminator) {
-		needquote =3D next_quote_pos(pfx, pfxlen) < pfxlen
-			|| name[next_quote_pos(name, -1)];
-	}
-	if (needquote) {
-		fputc('"', fp);
-		quote_c_style_counted(pfx, pfxlen, NULL, fp, 1);
-		quote_c_style(name, NULL, fp, 1);
-		fputc('"', fp);
-	} else {
-		fwrite(pfx, pfxlen, 1, fp);
-		fputs(name, fp);
-	}
-	fputc(terminator, fp);
-}
-
 void write_name_quoted_relative(const char *name, const char *prefix,
 				FILE *fp, int terminator)
 {
diff --git a/quote.h b/quote.h
index 71dcc3a..99e04d3 100644
--- a/quote.h
+++ b/quote.h
@@ -56,8 +56,6 @@ extern size_t quote_c_style(const char *name, struct =
strbuf *, FILE *, int no_dq
 extern void quote_two_c_style(struct strbuf *, const char *, const cha=
r *, int);
=20
 extern void write_name_quoted(const char *name, FILE *, int terminator=
);
-extern void write_name_quotedpfx(const char *pfx, size_t pfxlen,
-                                 const char *name, FILE *, int termina=
tor);
 extern void write_name_quoted_relative(const char *name, const char *p=
refix,
 		FILE *fp, int terminator);
=20
diff --git a/t/t3102-ls-tree-wildcards.sh b/t/t3102-ls-tree-wildcards.s=
h
index c286854..83fca8d 100755
--- a/t/t3102-ls-tree-wildcards.sh
+++ b/t/t3102-ls-tree-wildcards.sh
@@ -19,4 +19,12 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'ls-tree outside prefix' '
+	cat >expected <<EOF &&
+100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	../a[a]/three
+EOF
+	( cd aa && git ls-tree -r HEAD "../a[a]"; ) >actual &&
+	test_cmp expected actual
+'
+
 test_done
--=20
2.1.0.rc0.78.gc0d8480
