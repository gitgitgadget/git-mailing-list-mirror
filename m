From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH v2] make lineno_width() from blame reusable for others
Date: Tue, 14 Feb 2012 13:24:11 +0100
Message-ID: <1329222251-28188-1-git-send-email-zbyszek@in.waw.pl>
References: <7vhayub9d3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Feb 14 13:24:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxHQw-0002Bg-Oy
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 13:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755007Ab2BNMYa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 07:24:30 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52584 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754193Ab2BNMY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 07:24:29 -0500
Received: from [193.0.104.42] (helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RxHQn-0008RQ-2M; Tue, 14 Feb 2012 13:24:25 +0100
X-Mailer: git-send-email 1.7.9.3.g2429d.dirty
In-Reply-To: <7vhayub9d3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190719>

builtin/blame.c has a helper function to compute how many columns we
need to show a line-number, whose implementation is reusable as a more
generic helper function to count the number of columns necessary to
show any cardinal number.

Rename it to decimal_width(), move it to pager.c and export it for use
by future callers. The argument type is changed to unsigned to underlin=
e
the fact that the function supports only non-negative numbers.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
I'll be using this in the 'diff --stat: use the full terminal width'
patch.

v2: - change arg type to unsigned
    - corrected commit message

 builtin/blame.c | 18 +++---------------
 cache.h         |  1 +
 pager.c         | 12 ++++++++++++
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 5a67c20..f028e8a 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
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
diff --git a/cache.h b/cache.h
index 2f30b3a..3504bcc 100644
--- a/cache.h
+++ b/cache.h
@@ -1176,6 +1176,7 @@ extern const char *pager_program;
 extern int pager_in_use(void);
 extern int pager_use_color;
 extern int term_columns(void);
+extern int decimal_width(unsigned number);
=20
 extern const char *editor_program;
 extern const char *askpass_program;
diff --git a/pager.c b/pager.c
index e06cfa0..2e16a9c 100644
--- a/pager.c
+++ b/pager.c
@@ -153,3 +153,15 @@ int term_columns(void)
 #endif
 	return term_columns_at_startup;
 }
+
+/*
+ * How many columns do we need to show this number in decimal?
+ */
+int decimal_width(unsigned number)
+{
+	int i, width;
+
+	for (width =3D 1, i =3D 10; i <=3D number; width++)
+		i *=3D 10;
+	return width;
+}
--=20
1.7.9.3.g2429d.dirty
