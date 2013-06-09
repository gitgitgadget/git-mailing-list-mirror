From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 07/15] pretty: allow passing NULL commit to format_commit_message()
Date: Sun,  9 Jun 2013 23:24:26 +0530
Message-ID: <1370800474-8940-8-git-send-email-artagnon@gmail.com>
References: <1370800474-8940-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:57:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljrQ-0006Xv-JL
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920Ab3FIR4z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 13:56:55 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:47392 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905Ab3FIR4x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:56:53 -0400
Received: by mail-pb0-f50.google.com with SMTP id wz7so883652pbc.37
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hZRhfAV2ovFyKrFa1zP40zmrb78INbaL7S19hjJG6vU=;
        b=j3+uhQcJ3swCmnx7Ay5gV++zJyFgX1XLlTiQtE1AwWa+OsqYw2MeBU+TT9rESes4jV
         ku3E4sFcvWqqZPGLlkhGVX60p/KvmsR4BSpqOWVXoOkqu5n7eezzEu6RdSJWNKvMDKqO
         +XlMcm/A4jovjL74+WrDwfpgDIarbUxhqcz48Ux5BqLqQUqcUGKAnKdJlIhOfRofHDv/
         ux5hIieLW+HeZVgNn9M9Mcsq4VL+rIDiEeD8eqMR0ZbE8tMcK+RJKMPN7RLpvNa/tlWt
         Do3lprJtOc/GPY+lQ0eZYk/djz20Grs3wUC0hwzRoFG1dolvsvRFkk1k+AWgouxoJC4B
         Dv9Q==
X-Received: by 10.68.90.197 with SMTP id by5mr6698364pbb.196.1370800612364;
        Sun, 09 Jun 2013 10:56:52 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id qp4sm7275815pbc.41.2013.06.09.10.56.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 10:56:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.247.g485169c
In-Reply-To: <1370800474-8940-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227063>

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
1.8.3.247.g485169c
