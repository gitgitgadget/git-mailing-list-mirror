From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/7] Move estimate_bisect_steps to libgit.a
Date: Fri, 26 Oct 2012 22:53:50 +0700
Message-ID: <1351266835-22610-3-git-send-email-pclouds@gmail.com>
References: <20121026120253.GA1455@sigill.intra.peff.net>
 <1351266835-22610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 26 17:54:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRmEw-00006w-EY
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 17:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900Ab2JZPyR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Oct 2012 11:54:17 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:49515 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964824Ab2JZPyN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 11:54:13 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1361868dak.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 08:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Ix4Gt0Iho58/7sP5klenQ4YQiOmuhKXUojjxArgF3P8=;
        b=LXI0sQCgxJ4WmjSeJ2WuNhM99bs5+dftvlPYxxf2WgOd3dtPeA/3JuXKZMZsUs8IFS
         hiP5DMpTEWRdyZUosQCjFxUdbXEHF1rDNNlxxwabPYDVE8DNViEX/rFgeLUa1TWaS0rO
         EOoWjhHBEYOREQWL6gx+wJRdg9FZtuURugAI5low1Gm682aa6pzS/Tq8TMt4eERe9PC8
         ddqDfI+bailVGXnoXyaHmjFd9QQ6v4e1lYlIMzOB171cqHsB96nk2SXofKXzzhH1yV7+
         8DjtIedZt5iq++rJc6oAMm71j8hUDpRnvMEwOh/RSl6MC+3CAHdqLOwcXaS9xg+gun73
         Iflw==
Received: by 10.68.189.102 with SMTP id gh6mr70551242pbc.37.1351266853430;
        Fri, 26 Oct 2012 08:54:13 -0700 (PDT)
Received: from lanh ([115.74.33.44])
        by mx.google.com with ESMTPS id a4sm845226pax.12.2012.10.26.08.54.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 26 Oct 2012 08:54:12 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 26 Oct 2012 22:54:14 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1351266835-22610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208458>

This function is used by bisect.c, part of libgit.a while
estimate_bisect_steps stays in builtin/rev-list.c. Move it to bisect.a
so we won't have undefine reference if a standalone program that uses
libgit.a happens to pull it in.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 bisect.c           | 38 ++++++++++++++++++++++++++++++++++++++
 builtin/rev-list.c | 39 ---------------------------------------
 2 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/bisect.c b/bisect.c
index 1aad49b..bd1b7b5 100644
--- a/bisect.c
+++ b/bisect.c
@@ -956,3 +956,41 @@ int bisect_next_all(const char *prefix, int no_che=
ckout)
 	return bisect_checkout(bisect_rev_hex, no_checkout);
 }
=20
+static inline int log2i(int n)
+{
+	int log2 =3D 0;
+
+	for (; n > 1; n >>=3D 1)
+		log2++;
+
+	return log2;
+}
+
+static inline int exp2i(int n)
+{
+	return 1 << n;
+}
+
+/*
+ * Estimate the number of bisect steps left (after the current step)
+ *
+ * For any x between 0 included and 2^n excluded, the probability for
+ * n - 1 steps left looks like:
+ *
+ * P(2^n + x) =3D=3D (2^n - x) / (2^n + x)
+ *
+ * and P(2^n + x) < 0.5 means 2^n < 3x
+ */
+int estimate_bisect_steps(int all)
+{
+	int n, x, e;
+
+	if (all < 3)
+		return 0;
+
+	n =3D log2i(all);
+	e =3D exp2i(n);
+	x =3D all - e;
+
+	return (e < 3 * x) ? n : n - 1;
+}
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ff5a383..a0ec84e 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -201,45 +201,6 @@ static void show_edge(struct commit *commit)
 	printf("-%s\n", sha1_to_hex(commit->object.sha1));
 }
=20
-static inline int log2i(int n)
-{
-	int log2 =3D 0;
-
-	for (; n > 1; n >>=3D 1)
-		log2++;
-
-	return log2;
-}
-
-static inline int exp2i(int n)
-{
-	return 1 << n;
-}
-
-/*
- * Estimate the number of bisect steps left (after the current step)
- *
- * For any x between 0 included and 2^n excluded, the probability for
- * n - 1 steps left looks like:
- *
- * P(2^n + x) =3D=3D (2^n - x) / (2^n + x)
- *
- * and P(2^n + x) < 0.5 means 2^n < 3x
- */
-int estimate_bisect_steps(int all)
-{
-	int n, x, e;
-
-	if (all < 3)
-		return 0;
-
-	n =3D log2i(all);
-	e =3D exp2i(n);
-	x =3D all - e;
-
-	return (e < 3 * x) ? n : n - 1;
-}
-
 void print_commit_list(struct commit_list *list,
 		       const char *format_cur,
 		       const char *format_last)
--=20
1.8.0.rc2.23.g1fb49df
