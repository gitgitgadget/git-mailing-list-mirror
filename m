From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 1/3] Preparation to call determine_author_info from prepare_to_commit
Date: Wed, 30 Apr 2008 10:47:14 +0200
Message-ID: <1209545236-4266-2-git-send-email-sbejar@gmail.com>
References: <1209545236-4266-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 10:48:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr7zJ-0002bc-O5
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 10:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757366AbYD3Irg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Apr 2008 04:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757303AbYD3Irf
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 04:47:35 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:59837 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757344AbYD3Ire (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 04:47:34 -0400
Received: by fg-out-1718.google.com with SMTP id 19so75288fgg.17
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 01:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        bh=FnFvbiAYL7LE0dpH4hwS7S5ohxqGezKzkz9WvExPYDk=;
        b=FxWE1YKjMDeXhaWVHJeNEMn9VxfTSDowE5JNuxLLNduTImsxVOL0WBN8NiwAa6tIVIRtJ7d3hPeC3Fs9zEOxYATSBofDZhGiAwhnch4ka2xikB5N1sChMKNlEl2DvpcX7hv76QHb5cExT4HxC2j0deHux8x44uMSxtgGac/cR10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=QvNLctgJjl6dq53uWC02irRcqFySNiVeWqlkMHiliI2kPPo4VABX6IfpBI1dbylQgRVmy+1/9wTk+sZr7TH2if+yCW3BR8rFSxwbMY7sz1jhmb4qZOTWHUiLbmfUokWDmEs0fkaeENutUkH5XS0a5tZ74w1W6bTVWFLLDrh83FU=
Received: by 10.86.73.17 with SMTP id v17mr631458fga.46.1209545250972;
        Wed, 30 Apr 2008 01:47:30 -0700 (PDT)
Received: from localhost ( [91.13.102.119])
        by mx.google.com with ESMTPS id s10sm777937muh.10.2008.04.30.01.47.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Apr 2008 01:47:29 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.148.g37726
In-Reply-To: <1209545236-4266-1-git-send-email-sbejar@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80813>

Reorder functions definitions such that determine_author_info is
defined before prepare_to_commit. No code changes.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 builtin-commit.c |   78 +++++++++++++++++++++++++++-------------------=
--------
 1 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 256181a..a37d8c3 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -395,6 +395,45 @@ static int is_a_merge(const unsigned char *sha1)
=20
 static const char sign_off_header[] =3D "Signed-off-by: ";
=20
+static void determine_author_info(struct strbuf *sb)
+{
+	char *name, *email, *date;
+
+	name =3D getenv("GIT_AUTHOR_NAME");
+	email =3D getenv("GIT_AUTHOR_EMAIL");
+	date =3D getenv("GIT_AUTHOR_DATE");
+
+	if (use_message) {
+		const char *a, *lb, *rb, *eol;
+
+		a =3D strstr(use_message_buffer, "\nauthor ");
+		if (!a)
+			die("invalid commit: %s", use_message);
+
+		lb =3D strstr(a + 8, " <");
+		rb =3D strstr(a + 8, "> ");
+		eol =3D strchr(a + 8, '\n');
+		if (!lb || !rb || !eol)
+			die("invalid commit: %s", use_message);
+
+		name =3D xstrndup(a + 8, lb - (a + 8));
+		email =3D xstrndup(lb + 2, rb - (lb + 2));
+		date =3D xstrndup(rb + 2, eol - (rb + 2));
+	}
+
+	if (force_author) {
+		const char *lb =3D strstr(force_author, " <");
+		const char *rb =3D strchr(force_author, '>');
+
+		if (!lb || !rb)
+			die("malformed --author parameter");
+		name =3D xstrndup(force_author, lb - force_author);
+		email =3D xstrndup(lb + 2, rb - (lb + 2));
+	}
+
+	strbuf_addf(sb, "author %s\n", fmt_ident(name, email, date, IDENT_ERR=
OR_ON_NO_NAME));
+}
+
 static int prepare_to_commit(const char *index_file, const char *prefi=
x)
 {
 	struct stat statbuf;
@@ -622,45 +661,6 @@ static int message_is_empty(struct strbuf *sb, int=
 start)
 	return 1;
 }
=20
-static void determine_author_info(struct strbuf *sb)
-{
-	char *name, *email, *date;
-
-	name =3D getenv("GIT_AUTHOR_NAME");
-	email =3D getenv("GIT_AUTHOR_EMAIL");
-	date =3D getenv("GIT_AUTHOR_DATE");
-
-	if (use_message) {
-		const char *a, *lb, *rb, *eol;
-
-		a =3D strstr(use_message_buffer, "\nauthor ");
-		if (!a)
-			die("invalid commit: %s", use_message);
-
-		lb =3D strstr(a + 8, " <");
-		rb =3D strstr(a + 8, "> ");
-		eol =3D strchr(a + 8, '\n');
-		if (!lb || !rb || !eol)
-			die("invalid commit: %s", use_message);
-
-		name =3D xstrndup(a + 8, lb - (a + 8));
-		email =3D xstrndup(lb + 2, rb - (lb + 2));
-		date =3D xstrndup(rb + 2, eol - (rb + 2));
-	}
-
-	if (force_author) {
-		const char *lb =3D strstr(force_author, " <");
-		const char *rb =3D strchr(force_author, '>');
-
-		if (!lb || !rb)
-			die("malformed --author parameter");
-		name =3D xstrndup(force_author, lb - force_author);
-		email =3D xstrndup(lb + 2, rb - (lb + 2));
-	}
-
-	strbuf_addf(sb, "author %s\n", fmt_ident(name, email, date, IDENT_ERR=
OR_ON_NO_NAME));
-}
-
 static int parse_and_validate_options(int argc, const char *argv[],
 				      const char * const usage[])
 {
--=20
1.5.5.1.148.g37726
