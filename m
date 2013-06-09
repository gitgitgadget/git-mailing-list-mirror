From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 06/15] pretty: limit recursion in format_commit_one()
Date: Sun,  9 Jun 2013 23:24:25 +0530
Message-ID: <1370800474-8940-7-git-send-email-artagnon@gmail.com>
References: <1370800474-8940-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:57:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljrQ-0006Xv-2Q
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912Ab3FIR4w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 13:56:52 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:48891 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864Ab3FIR4u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:56:50 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp12so2182091pab.35
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6e9KmF+xrdl//r9FD8hbSzlliPDp9EzWU0CjQCWalaU=;
        b=rnaH44eA+uBEJR9pShmjjFnUtDICjHEhpkNYWalmH/40pH3++0xwMOFDTdLPotqW8p
         412YjDfPPTfe3LO458xVuEwgIm7LREODiDW6mCs/nwfc6NG78l3weT1yknzH5nqPYsWl
         Sj7LGe1it5dfxA6dcBYJ8TYnBjE5UqoydncY5dPWAdCpEr23s/mEAZI2TFBpkFmQIKDj
         5rKNi276in67tKFOM2ckDCmoERU7Moh3Q6xdbemBvfOzp8P/GZtJTU/swKahiHwR6Uzo
         Fhjl9oieG+Y6dHFd1cnRTxQ2oqYk3BMb1jI/BDWF+TlFB0M3Ivcc4HFTxtmEdIPd9V5z
         uP2w==
X-Received: by 10.68.129.10 with SMTP id ns10mr6955466pbb.13.1370800610079;
        Sun, 09 Jun 2013 10:56:50 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id qp4sm7275815pbc.41.2013.06.09.10.56.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 10:56:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.247.g485169c
In-Reply-To: <1370800474-8940-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227061>

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
1.8.3.247.g485169c
