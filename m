From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/12] pretty: get the correct encoding for --pretty:format=%e
Date: Sat, 16 Mar 2013 09:24:37 +0700
Message-ID: <1363400683-14813-7-git-send-email-pclouds@gmail.com>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 16 03:25:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGgom-0002bu-HL
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 03:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755500Ab3CPCZ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 22:25:29 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:43795 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754081Ab3CPCZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 22:25:29 -0400
Received: by mail-pb0-f50.google.com with SMTP id up1so4558640pbc.37
        for <git@vger.kernel.org>; Fri, 15 Mar 2013 19:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=iobwJEHRm69cDGCPeZa8kBXOjVEGzU3pFgR2BJfMNJQ=;
        b=XUqe5IDWA617VDZTCoCV0y4RidSbzxhLk3nO7dL6qPE882f9qaXFxO8JL3qChse5R4
         Hl96gJoLbQh5KxjuYi/Gk4rdJz5W4KpltViSegvI8YlbOVS53+ORloyuEsO0sdjxDgbz
         fhHUkw12p1LW4YnJzUKEVADPvTYklnVBgMp9OztCBH9QYmtXfGeoZw4Q0qqEhnyiAQxv
         5NV+HmhZoisNQPmgqX+M2FQrP1j3vuOccOn7Lm+siM9belGpJh6/UQ3YqVHqk17wp7Vp
         F3OagOK8nw9w3zmCi2gRSP/cYT7xlsoEhhptgcQy471enzUy8oHOHNqi47amO9nPZYyC
         mhsA==
X-Received: by 10.68.25.42 with SMTP id z10mr21433463pbf.113.1363400728566;
        Fri, 15 Mar 2013 19:25:28 -0700 (PDT)
Received: from lanh ([115.74.58.84])
        by mx.google.com with ESMTPS id vd4sm11497785pbc.35.2013.03.15.19.25.25
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 15 Mar 2013 19:25:27 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 16 Mar 2013 09:25:22 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218277>

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
