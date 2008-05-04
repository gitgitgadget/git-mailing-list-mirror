From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCHv4 1/4] Preparation to call determine_author_info from prepare_to_commit
Date: Sun,  4 May 2008 18:04:49 +0200
Message-ID: <1209917092-12146-2-git-send-email-sbejar@gmail.com>
References: <1209917092-12146-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbjear@gmail.com>,
	=?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 18:06:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsgj1-00077p-Gj
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 18:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbYEDQFM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 May 2008 12:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbYEDQFL
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 12:05:11 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:56874 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbYEDQFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 12:05:09 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1618419fgg.17
        for <git@vger.kernel.org>; Sun, 04 May 2008 09:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        bh=auEWElmSTZvtMaGv13SWJFmQMbwr9ptsGTxL8nAm1lY=;
        b=pnK5N7XXz9rSJK47RYsZ9tpJnXW4o+Bhs2/C0h1SaGJMa792C6EpSwMYg3ySjeLvmon8Sddx/b1w5vGDOcTvXuOYydcmIimi0PmUnqsULjTtD9YE3FXr454uimJlNAW+0IYkpthuTkvnsk8xeCOaj0TGOqwOZZBTLatNKdcBT/w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=vpSvE6jh0UZGwAF+PQ31qCamAx+Sy/dVkVz3NB7PKhc8a+Xboqc814jVSA20ADZR9qBvFyCNOSMrEeEMlrPff5HVKS7ZXQcN4OzylG+ITt5DFW5wr1yvNuK9UEOz/l1zd0FEsiajouAvYyTd5doOI+QMLVOqya1mU0CDeG0SbG4=
Received: by 10.86.70.11 with SMTP id s11mr7871960fga.71.1209917107811;
        Sun, 04 May 2008 09:05:07 -0700 (PDT)
Received: from localhost ( [91.13.106.248])
        by mx.google.com with ESMTPS id d4sm4003734fga.4.2008.05.04.09.05.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 May 2008 09:05:06 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.224.gadb29
In-Reply-To: <1209917092-12146-1-git-send-email-sbejar@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81179>

=46rom: Santi B=C3=A9jar <sbjear@gmail.com>

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
1.5.5.1.224.gadb29
