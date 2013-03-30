From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 06/12] pretty: get the correct encoding for --pretty:format=%e
Date: Sat, 30 Mar 2013 16:35:06 +0700
Message-ID: <1364636112-15065-7-git-send-email-pclouds@gmail.com>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
 <1364636112-15065-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 30 10:36:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULsCs-00038U-6I
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 10:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756330Ab3C3Jfq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Mar 2013 05:35:46 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:49179 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756030Ab3C3Jfp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Mar 2013 05:35:45 -0400
Received: by mail-pd0-f174.google.com with SMTP id p12so562257pdj.19
        for <git@vger.kernel.org>; Sat, 30 Mar 2013 02:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=iobwJEHRm69cDGCPeZa8kBXOjVEGzU3pFgR2BJfMNJQ=;
        b=hQyz8YmIZh7p4dri+QgfjMLgoPTGloeGq/u6dbHUX7pxoJGu+3PlvL9fX6HDphYRwf
         R7QQxlb3FhCrKOSsQKYwMi5hVcM0ksNCBjoEVN3taGolek2oHgJz82P1fuA6HV15hHgy
         UHGxN1qk6x8DjQp9SnVPUo4BQg0tQTsRfzO8dH+dJUNcc+CtqsUZ9ieeNi/jN3HH9hYi
         4v9P9ERucd2zXADLWisMMmKqmsIW2asQbx/x8n98j2n2EKTFsumopc+L1bEZCqTDYLMU
         LhlqTCGoHEsJDi7be27wn6v2o62ogjyZhHJoPLCRlEO67COKK21OyO0E0NumdsfjoSJX
         SxHw==
X-Received: by 10.66.116.208 with SMTP id jy16mr8867369pab.70.1364636145122;
        Sat, 30 Mar 2013 02:35:45 -0700 (PDT)
Received: from lanh ([115.74.55.89])
        by mx.google.com with ESMTPS id jk1sm5995728pbb.14.2013.03.30.02.35.42
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 30 Mar 2013 02:35:44 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Mar 2013 16:35:49 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1364636112-15065-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219575>

parse_commit_header() provides the commit encoding for '%e' and it
reads it from the re-encoded message, which contains the new encoding,
not the original one in the commit object.

Get the commit encoding from logmsg_reencode() instead.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pretty.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/pretty.c b/pretty.c
index ab5d70f..e2241e5 100644
--- a/pretty.c
+++ b/pretty.c
@@ -771,12 +771,12 @@ struct format_commit_context {
 		char *signer;
 	} signature;
 	char *message;
+	char *commit_encoding;
 	size_t width, indent1, indent2;
=20
 	/* These offsets are relative to the start of the commit message. */
 	struct chunk author;
 	struct chunk committer;
-	struct chunk encoding;
 	size_t message_off;
 	size_t subject_off;
 	size_t body_off;
@@ -823,9 +823,6 @@ static void parse_commit_header(struct format_commi=
t_context *context)
 		} else if (!prefixcmp(msg + i, "committer ")) {
 			context->committer.off =3D i + 10;
 			context->committer.len =3D eol - i - 10;
-		} else if (!prefixcmp(msg + i, "encoding ")) {
-			context->encoding.off =3D i + 9;
-			context->encoding.len =3D eol - i - 9;
 		}
 		i =3D eol;
 	}
@@ -1210,7 +1207,8 @@ static size_t format_commit_one(struct strbuf *sb=
, const char *placeholder,
 				   msg + c->committer.off, c->committer.len,
 				   c->pretty_ctx->date_mode);
 	case 'e':	/* encoding */
-		strbuf_add(sb, msg + c->encoding.off, c->encoding.len);
+		if (c->commit_encoding)
+			strbuf_addstr(sb, c->commit_encoding);
 		return 1;
 	case 'B':	/* raw body */
 		/* message_off is always left at the initial newline */
@@ -1321,11 +1319,14 @@ void format_commit_message(const struct commit =
*commit,
 	context.commit =3D commit;
 	context.pretty_ctx =3D pretty_ctx;
 	context.wrap_start =3D sb->len;
-	context.message =3D logmsg_reencode(commit, NULL, output_enc);
+	context.message =3D logmsg_reencode(commit,
+					  &context.commit_encoding,
+					  output_enc);
=20
 	strbuf_expand(sb, format, format_commit_item, &context);
 	rewrap_message_tail(sb, &context, 0, 0, 0);
=20
+	free(context.commit_encoding);
 	logmsg_free(context.message, commit);
 	free(context.signature.gpg_output);
 	free(context.signature.signer);
--=20
1.8.2.83.gc99314b
