From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 07/15] pretty: allow passing NULL commit to format_commit_message()
Date: Tue,  4 Jun 2013 18:05:29 +0530
Message-ID: <1370349337-20938-8-git-send-email-artagnon@gmail.com>
References: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 04 14:34:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjqRf-00078F-OP
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 14:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754029Ab3FDMeR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jun 2013 08:34:17 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:43825 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772Ab3FDMeK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 08:34:10 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa11so310119pad.33
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 05:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=sKoiH0SysdLaeP/N5QprDQ4BSfa8hJ+vtmWdlUkqW98=;
        b=jqR+7Qwjc4DgOVulk3fm5NYU2sZPq6ZVzPj+SnyfegIVHffIGUOmPJGxHKKDQ+2/bJ
         y9oZxSERM+n+2LLyDWFDPrtOOZrApHxPC2M2w6OQksbz/MBTkdYKmE3qxlHhTVYGUrpK
         IrCGW1Laz0QDeF+HXKA3E6D1x7Kjc5kOe3cr9DlROEdXfZOlKwfBmvZyqoUL+VA+3sc9
         Yx83PjA0FQuQLXs5EmanNAXM/Z8aTcF4bPdviOvKR3pWMv/0lmPqwQwbpW6EhknkH7xF
         gmcPULb/6IbUhM2cncHnjOoEbOms7aRMR9A/H5nwivQEjkuXLv1n9xvPdWQmpYfBpGbS
         zUNw==
X-Received: by 10.68.8.68 with SMTP id p4mr28644159pba.168.1370349250090;
        Tue, 04 Jun 2013 05:34:10 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id vz8sm67423587pac.20.2013.06.04.05.34.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 05:34:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226350>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

The new formatter, for-each-ref, may use non-commit placeholders only.
While it could audit the format line and warn/exclude commit
placeholders, that's a lot more work than simply ignore them.
Unrecognized placeholders are displayed as-is, pretty obvious that they
are not handled.

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
1.8.3.GIT
