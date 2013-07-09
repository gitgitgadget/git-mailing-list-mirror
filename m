From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 07/15] pretty: allow passing NULL commit to format_commit_message()
Date: Tue,  9 Jul 2013 16:02:18 +0530
Message-ID: <1373365946-9230-8-git-send-email-artagnon@gmail.com>
References: <1373365946-9230-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 09 12:36:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwVHi-00072T-6F
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 12:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565Ab3GIKgd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jul 2013 06:36:33 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:63997 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539Ab3GIKg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 06:36:29 -0400
Received: by mail-pb0-f53.google.com with SMTP id xb12so5371275pbc.26
        for <git@vger.kernel.org>; Tue, 09 Jul 2013 03:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YbI02jos17TkacihYSkWVsNUDzjHtSfAVq3Gv15crLE=;
        b=AH4ZGzxQkMw2F9dCs60ArRkWN0ZdCZvZM/ETriZo6VHHb9FORAe28WaR+yGPIc/1r4
         glUUBv41wN06g7/J7ozM8k+NxbV5vdhzvE2kR8xbst4GOlsMKABitbik6Yz6V+Gem7BO
         5gmB3pe49UN9DGzbybTjzn1E1QnGJvIRnv1MtCYc3eePkNiI9uCfRdWQRRRGvXWBlO8d
         XbrwO9RH5vnMnHcgS77mZDm8tmmT1F2RaHU0hY2aABVut38m7iLgFrOMslGln2VS/21D
         pUHNJ2DJQUDVoKyHuzTU7A3g0MSy7vLPkghsioeZDsV7PtAIozbeScohmbO6JsBXSCMW
         +b/Q==
X-Received: by 10.68.143.73 with SMTP id sc9mr26017495pbb.2.1373366189402;
        Tue, 09 Jul 2013 03:36:29 -0700 (PDT)
Received: from localhost.localdomain ([122.174.59.189])
        by mx.google.com with ESMTPSA id fr1sm27553398pbb.26.2013.07.09.03.36.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Jul 2013 03:36:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.736.g869de25
In-Reply-To: <1373365946-9230-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229935>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

The new formatter, for-each-ref, may use non-commit placeholders only.
While it could audit the format line and warn/exclude commit
placeholders, that's a lot more work than simply ignore them.
Unrecognized placeholders are displayed as-is, pretty obvious that they
are not handled.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 pretty.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/pretty.c b/pretty.c
index 0063f2d..816aa32 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1156,6 +1156,9 @@ static size_t format_commit_one(struct strbuf *sb=
, /* in UTF-8 */
 	}
=20
 	/* these depend on the commit */
+	if (!commit)
+		return 0;
+
 	if (!commit->object.parsed)
 		parse_object(commit->object.sha1);
=20
@@ -1276,6 +1279,9 @@ static size_t format_commit_one(struct strbuf *sb=
, /* in UTF-8 */
 	}
=20
=20
+	if (!c->message)
+		return 0;
+
 	/* For the rest we have to parse the commit header. */
 	if (!c->commit_header_parsed)
 		parse_commit_header(c);
@@ -1510,9 +1516,10 @@ void format_commit_message(const struct commit *=
commit,
 	context.commit =3D commit;
 	context.pretty_ctx =3D pretty_ctx;
 	context.wrap_start =3D sb->len;
-	context.message =3D logmsg_reencode(commit,
-					  &context.commit_encoding,
-					  output_enc);
+	if (commit)
+		context.message =3D logmsg_reencode(commit,
+						  &context.commit_encoding,
+						  output_enc);
=20
 	strbuf_expand(sb, format, format_commit_item, &context);
 	rewrap_message_tail(sb, &context, 0, 0, 0);
@@ -1535,7 +1542,8 @@ void format_commit_message(const struct commit *c=
ommit,
 	}
=20
 	free(context.commit_encoding);
-	logmsg_free(context.message, commit);
+	if (commit)
+		logmsg_free(context.message, commit);
 	free(context.signature_check.gpg_output);
 	free(context.signature_check.signer);
 }
--=20
1.8.3.2.736.g869de25
