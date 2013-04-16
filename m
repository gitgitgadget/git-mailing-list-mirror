From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 02/13] pretty: get the correct encoding for --pretty:format=%e
Date: Tue, 16 Apr 2013 18:24:51 +1000
Message-ID: <1366100702-31745-3-git-send-email-pclouds@gmail.com>
References: <1364636112-15065-1-git-send-email-pclouds@gmail.com>
 <1366100702-31745-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 16 10:25:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US1D4-0005DH-Fp
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 10:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935638Ab3DPIZp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Apr 2013 04:25:45 -0400
Received: from mail-da0-f42.google.com ([209.85.210.42]:56724 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932147Ab3DPIZo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 04:25:44 -0400
Received: by mail-da0-f42.google.com with SMTP id n15so143317dad.29
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 01:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=KdqIehFTSm+38dgIfEFDFoWgIljYPn170wPjfviq1HA=;
        b=gQNwelTVE4EFhf/68yCmy3GXt8aSv5N1chZc5WijmqqMCF0AiHaq0/JxjGEdVj3pZx
         ZRoDotYGrwchRXDN6TuElEHHIVSdig9GXsNrh2abJjzcjumW1vWKhDqFiIHFvNnO5APp
         Nzjet2ihNdRdbQ0RVE32bMnQ2sViA08UFfycrIKFxY/7MTrqs29Lo+3sZoiA8eSAvjI6
         CUXv4Oz+1VF9OJQOft9EmvCPiYZL3AN8yCWZRDCyI5OgkR8D4A5RoHUfm73UTzZIklHA
         W83glSXKKWNP4KHCPgoZis4/JXcd1uXJ97Zl8+li3cGEFKhiCREebcvtS1+7qgY/sC5Q
         WOTA==
X-Received: by 10.66.149.73 with SMTP id ty9mr2368158pab.66.1366100743451;
        Tue, 16 Apr 2013 01:25:43 -0700 (PDT)
Received: from pclouds@gmail.com (xinyep.lnk.telstra.net. [110.143.18.114])
        by mx.google.com with ESMTPS id jk11sm1232442pbb.0.2013.04.16.01.25.40
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 16 Apr 2013 01:25:42 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Apr 2013 18:25:29 +1000
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1366100702-31745-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221381>

parse_commit_header() provides the commit encoding for '%e' and it
reads it from the re-encoded message, which contains the new encoding,
not the original one in the commit object. This never happens because
--pretty=3Dformat:xxx never respects i18n.logoutputencoding. But that's
a different story.

Get the commit encoding from logmsg_reencode() instead.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pretty.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/pretty.c b/pretty.c
index c361b9b..e59688b 100644
--- a/pretty.c
+++ b/pretty.c
@@ -776,12 +776,12 @@ struct format_commit_context {
 	unsigned commit_message_parsed:1;
 	struct signature_check signature_check;
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
@@ -828,9 +828,6 @@ static void parse_commit_header(struct format_commi=
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
@@ -1185,7 +1182,8 @@ static size_t format_commit_one(struct strbuf *sb=
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
@@ -1296,11 +1294,14 @@ void format_commit_message(const struct commit =
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
 	free(context.signature_check.gpg_output);
 	free(context.signature_check.signer);
--=20
1.8.2.82.gc24b958
