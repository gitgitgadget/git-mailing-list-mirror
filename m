From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/6] pretty: trim trailing spaces due to padding
Date: Sat, 22 Sep 2012 11:26:40 +0700
Message-ID: <1348288000-12485-1-git-send-email-pclouds@gmail.com>
References: <1348287739-12128-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 22 06:26:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFHIk-00066P-T3
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 06:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112Ab2IVE0i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Sep 2012 00:26:38 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52110 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754Ab2IVE0h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 00:26:37 -0400
Received: by pbbrr4 with SMTP id rr4so3909763pbb.19
        for <git@vger.kernel.org>; Fri, 21 Sep 2012 21:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=egVmkjXSMIhSjZXSiK3Btv4VlNUGKhXY9BFetcD5AXU=;
        b=WNOyo4Lmvx3M6dwoWYBye+B/rNTVsTrS9q+iqrcwxJrButt1XtLGPBvYjkPzriUTKY
         qUPPyFU4kwX+kZWPcFZTRyMinaITgxkIPfzrlEmnJURsB4JQFsPNBQniRSMzCSKrz2Wg
         CpowZP0jJ708MmeK+gzZ5DJHSjaSKIU07KsNyVGfUyheK8KbdiYzM5ujQ0rkZFWE2MD9
         z55VedUb+TriUj0KdXP6S39bAT5cAxq7hcB49J/ozdlMhj9gsMpQ7+89OLV9/tGjneMB
         VKaZnQqGIeeUeUjlmstij09LBQ4Fj1PMVR5TH2FpSoHaIxsw6F0T0F1JYqCofPMjjhka
         v/1A==
Received: by 10.68.189.161 with SMTP id gj1mr20505985pbc.21.1348287996774;
        Fri, 21 Sep 2012 21:26:36 -0700 (PDT)
Received: from lanh ([115.74.43.144])
        by mx.google.com with ESMTPS id uh7sm6104089pbc.35.2012.09.21.21.26.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Sep 2012 21:26:36 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Sep 2012 11:26:47 +0700
X-Mailer: git-send-email 1.7.12.1.384.g7b808e7
In-Reply-To: <1348287739-12128-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206188>

TODO: should only be enabled explicitly to avoid unexpected trimming

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 And I did not remember I was in interactive rebase mode when I made
 the series. This patch is for discussion only. My screen seems to
 flash (I think) printing trailing spaces.

 pretty.c          |  1 +
 strbuf.c          | 29 +++++++++++++++++++++++++++++
 strbuf.h          |  1 +
 t/t9010-svn-fe.sh |  2 +-
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/pretty.c b/pretty.c
index 6662f52..70f776b 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1327,6 +1327,7 @@ void format_commit_message(const struct commit *c=
ommit,
=20
 	strbuf_expand(sb, format, format_commit_item, &context);
 	rewrap_message_tail(sb, &context, 0, 0, 0);
+	delete_trailing_whitespace(sb);
=20
 	if (context.message !=3D commit->buffer)
 		free(context.message);
diff --git a/strbuf.c b/strbuf.c
index 0510f76..e001175 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -488,3 +488,32 @@ int fprintf_ln(FILE *fp, const char *fmt, ...)
 		return -1;
 	return ret + 1;
 }
+
+void delete_trailing_whitespace(struct strbuf *sb)
+{
+	char *src =3D sb->buf, *dst =3D sb->buf;
+	char *end =3D src + sb->len, *anchor =3D NULL;
+	while (src < end) {
+		if (*src =3D=3D ' ') {
+			if (anchor)
+				src++;
+			else
+				anchor =3D src++;
+		} else if (*src =3D=3D '\n') {
+			if (anchor) {
+				*dst++ =3D *src++;
+				anchor =3D NULL;
+			} else
+				*dst++ =3D *src++;
+		} else {
+			if (anchor) {
+				memcpy(dst, anchor, src - anchor);
+				dst +=3D src - anchor;
+				anchor =3D NULL;
+			}
+			*dst++ =3D *src++;
+		}
+	}
+	sb->len =3D dst - sb->buf;
+	sb->buf[sb->len] =3D '\0';
+}
diff --git a/strbuf.h b/strbuf.h
index be941ee..75a8908 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -42,6 +42,7 @@ static inline void strbuf_setlen(struct strbuf *sb, s=
ize_t len) {
 extern void strbuf_trim(struct strbuf *);
 extern void strbuf_rtrim(struct strbuf *);
 extern void strbuf_ltrim(struct strbuf *);
+extern void delete_trailing_whitespace(struct strbuf *);
 extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
=20
 extern struct strbuf **strbuf_split_buf(const char *, size_t,
diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index b7eed24..b603e70 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -96,7 +96,7 @@ test_expect_failure PIPE 'empty revision' '
=20
 test_expect_success PIPE 'empty properties' '
 	reinit_git &&
-	printf "rev <nobody, nobody@local>: %s\n" "" "" >expect &&
+	printf "rev <nobody, nobody@local>: %s\n" "" "" | sed "s/ *$//" >expe=
ct &&
 	cat >emptyprop.dump <<-\EOF &&
 	SVN-fs-dump-format-version: 3
=20
--=20
1.7.12.1.384.g7b808e7
