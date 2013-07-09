From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 06/15] pretty: limit recursion in format_commit_one()
Date: Tue,  9 Jul 2013 16:02:17 +0530
Message-ID: <1373365946-9230-7-git-send-email-artagnon@gmail.com>
References: <1373365946-9230-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 09 12:36:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwVHd-0006vn-D0
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 12:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557Ab3GIKga convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jul 2013 06:36:30 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:53511 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359Ab3GIKg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 06:36:27 -0400
Received: by mail-pd0-f174.google.com with SMTP id 10so5101757pdc.19
        for <git@vger.kernel.org>; Tue, 09 Jul 2013 03:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=39NqumBV+8wFx6YJy8CAVngE7FXWdfyBl3/54+XWjXA=;
        b=vhdoQUOfBwFoPsPyRXhr1IG1AyRFQrU2XvitbQEHOiiGPUlWTYIVC0ZtY5S7uT2giD
         8tbNRy5BiMzkAYd9SZ+GRjgUkC95Q0mj1Zjn5D1Z6QCd9tJEDPoH4WooIRYWyBHHe1bO
         mEZG/5xLKpeHR5ZDZn3E17akvR4eMhIRnpAQo+fqxlvagg0fljHmY6TLlzqTPnaz0Zt5
         IGae7hNHSWKsiLZj3C0L68Oc3eWxlPoByM6OVB02V1sU6woSCLbwPNUcNNx9YtoHRbuF
         hy0Mr9s3ypbpMA0pjaP1rPei9+eeGFiYbyyDp0QqOxKwQ4EQ9BfK5fM6BKrZzzyauWb6
         FHwA==
X-Received: by 10.66.162.102 with SMTP id xz6mr27857747pab.0.1373366186830;
        Tue, 09 Jul 2013 03:36:26 -0700 (PDT)
Received: from localhost.localdomain ([122.174.59.189])
        by mx.google.com with ESMTPSA id fr1sm27553398pbb.26.2013.07.09.03.36.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Jul 2013 03:36:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.736.g869de25
In-Reply-To: <1373365946-9230-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229934>

To make sure that a pretty_ctx->format substitution doesn't result in a=
n
infinite recursion, change the prototype of format_commit_one() to
accept one last argument: no_recurse.  So, a single substitution by
format() must yield a result that can be parsed by format_commit_one()
without the help of format().

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pretty.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/pretty.c b/pretty.c
index 095e5ba..0063f2d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1061,7 +1061,8 @@ static size_t parse_padding_placeholder(struct st=
rbuf *sb,
=20
 static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 				const char *placeholder,
-				void *context)
+				void *context,
+				int no_recurse)
 {
 	struct format_commit_context *c =3D context;
 	const struct commit *commit =3D c->commit;
@@ -1069,7 +1070,7 @@ static size_t format_commit_one(struct strbuf *sb=
, /* in UTF-8 */
 	struct commit_list *p;
 	int h1, h2;
=20
-	if (c->pretty_ctx->format) {
+	if (!no_recurse && c->pretty_ctx->format) {
 		struct strbuf subst =3D STRBUF_INIT;
 		int ret =3D c->pretty_ctx->format(sb, placeholder, context,
 						c->pretty_ctx->user_data,
@@ -1083,7 +1084,7 @@ static size_t format_commit_one(struct strbuf *sb=
, /* in UTF-8 */
 			 * ret: the length of the original string
 			 * before substitution.
 			 */
-			ret =3D format_commit_one(sb, subst.buf, context) ? ret : 0;
+			ret =3D format_commit_one(sb, subst.buf, context, 1) ? ret : 0;
 			strbuf_release(&subst);
 			return ret;
 		} else if (ret)
@@ -1332,7 +1333,7 @@ static size_t format_and_pad_commit(struct strbuf=
 *sb, /* in UTF-8 */
 	}
 	while (1) {
 		int modifier =3D *placeholder =3D=3D 'C';
-		int consumed =3D format_commit_one(&local_sb, placeholder, c);
+		int consumed =3D format_commit_one(&local_sb, placeholder, c, 0);
 		total_consumed +=3D consumed;
=20
 		if (!modifier)
@@ -1452,7 +1453,7 @@ static size_t format_commit_item(struct strbuf *s=
b, /* in UTF-8 */
 	if (((struct format_commit_context *)context)->flush_type !=3D no_flu=
sh)
 		consumed =3D format_and_pad_commit(sb, placeholder, context);
 	else
-		consumed =3D format_commit_one(sb, placeholder, context);
+		consumed =3D format_commit_one(sb, placeholder, context, 0);
 	if (magic =3D=3D NO_MAGIC)
 		return consumed;
=20
--=20
1.8.3.2.736.g869de25
