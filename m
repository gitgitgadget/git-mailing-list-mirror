From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 1/8 v6] make lineno_width() from blame reusable for others
Date: Mon, 20 Feb 2012 22:57:07 +0100
Message-ID: <1329775034-21551-2-git-send-email-zbyszek@in.waw.pl>
References: <1329775034-21551-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, pclouds@gmail.com,
	j.sixt@viscovery.net,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 20 22:58:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzbFA-0004JM-Sh
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 22:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089Ab2BTV54 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Feb 2012 16:57:56 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52833 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753944Ab2BTV5z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 16:57:55 -0500
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RzbF4-0007o6-Tp; Mon, 20 Feb 2012 22:57:55 +0100
X-Mailer: git-send-email 1.7.9.1.353.g684b4
In-Reply-To: <1329775034-21551-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191109>

builtin/blame.c has a helper function to compute how many columns we
need to show a line-number, whose implementation is reusable as a more
generic helper function to count the number of columns necessary to
show any cardinal number.

Rename it to decimal_width(), move it to pager.c and export it for use
by future callers.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 builtin/blame.c | 18 +++---------------
 cache.h         |  1 +
 pager.c         | 13 +++++++++++++
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git builtin/blame.c builtin/blame.c
index 01956c8..b35bd62 100644
--- builtin/blame.c
+++ builtin/blame.c
@@ -1829,18 +1829,6 @@ static int read_ancestry(const char *graft_file)
 }
=20
 /*
- * How many columns do we need to show line numbers in decimal?
- */
-static int lineno_width(int lines)
-{
-	int i, width;
-
-	for (width =3D 1, i =3D 10; i <=3D lines; width++)
-		i *=3D 10;
-	return width;
-}
-
-/*
  * How many columns do we need to show line numbers, authors,
  * and filenames?
  */
@@ -1880,9 +1868,9 @@ static void find_alignment(struct scoreboard *sb,=
 int *option)
 		if (largest_score < ent_score(sb, e))
 			largest_score =3D ent_score(sb, e);
 	}
-	max_orig_digits =3D lineno_width(longest_src_lines);
-	max_digits =3D lineno_width(longest_dst_lines);
-	max_score_digits =3D lineno_width(largest_score);
+	max_orig_digits =3D decimal_width(longest_src_lines);
+	max_digits =3D decimal_width(longest_dst_lines);
+	max_score_digits =3D decimal_width(largest_score);
 }
=20
 /*
diff --git cache.h cache.h
index 9ecdf76..980d95d 100644
--- cache.h
+++ cache.h
@@ -1198,6 +1198,7 @@ extern const char *pager_program;
 extern int pager_in_use(void);
 extern int pager_use_color;
 extern int term_columns(void);
+extern int decimal_width(uintmax_t number);
=20
 extern const char *editor_program;
 extern const char *askpass_program;
diff --git pager.c pager.c
index b790967..60be7bb 100644
--- pager.c
+++ pager.c
@@ -147,3 +147,16 @@ int term_columns(void)
=20
 	return term_columns_at_startup;
 }
+
+/*
+ * How many columns do we need to show this number in decimal?
+ */
+int decimal_width(uintmax_t number)
+{
+	int width;
+	uintmax_t i;
+
+	for (width =3D 1, i =3D 10; i <=3D number; width++)
+		i *=3D 10;
+	return width;
+}
--=20
1.7.9.1.353.g684b4
