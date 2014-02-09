From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/2] dir: ignore trailing spaces in exclude patterns
Date: Sun,  9 Feb 2014 07:26:38 +0700
Message-ID: <1391905598-19198-3-git-send-email-pclouds@gmail.com>
References: <1391847004-22810-1-git-send-email-pclouds@gmail.com>
 <1391905598-19198-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 09 01:27:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCIEf-0001zn-1k
	for gcvg-git-2@plane.gmane.org; Sun, 09 Feb 2014 01:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbaBIA0z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Feb 2014 19:26:55 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:65441 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbaBIA0s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 19:26:48 -0500
Received: by mail-pa0-f53.google.com with SMTP id lj1so4695325pab.12
        for <git@vger.kernel.org>; Sat, 08 Feb 2014 16:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rfh+ZFQegs/s71i/0FYVha2IJxIRSsvvuJdlbefog8s=;
        b=PLT9ms4A7MooBsPgRF9fU0TVOUNqcMa8RVXh9ojlET5lNp2ZvW0V5tryavVz2aBFrP
         NHw5u9zS1y5Faz6otBNbmCmcdRhycoBqdSKz85fQdwcof2BywnG0hGIXafuoGJKEwaIB
         ui1B3OCKHZSAHaoxiUtltkH6T4GcufDaMp+xnmaZ9/i4XWFtHJJtH4+P6O23Qzgk7c+b
         8J+8OoZloEJEFzmqXZnQJ94fxAvAGEFR3EZue9S6G9zfNk+/Cuzh4QWSOA0Q5W7RmFJb
         QqNRtkiqlJ40+JCmVd/eFPb9RPsu6v47PkDyOK84fy4ENXjncx+IKUqVd27m0CHuyoAJ
         Avqg==
X-Received: by 10.68.129.5 with SMTP id ns5mr80049pbb.147.1391905608193;
        Sat, 08 Feb 2014 16:26:48 -0800 (PST)
Received: from lanh ([115.73.239.36])
        by mx.google.com with ESMTPSA id e3sm27483391pbc.17.2014.02.08.16.26.45
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Feb 2014 16:26:47 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Feb 2014 07:26:51 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391905598-19198-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241868>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/gitignore.txt |  3 +++
 dir.c                       | 21 ++++++++++++---------
 t/t0008-ignores.sh          |  8 ++++----
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index b08d34d..8734c15 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -77,6 +77,9 @@ PATTERN FORMAT
    Put a backslash ("`\`") in front of the first hash for patterns
    that begin with a hash.
=20
+ - Trailing spaces are ignored unless they are quoted with backlash
+   ("`\`").
+
  - An optional prefix "`!`" which negates the pattern; any
    matching file excluded by a previous pattern will become
    included again. It is not possible to re-include a file if a parent
diff --git a/dir.c b/dir.c
index 6162209..70076b5 100644
--- a/dir.c
+++ b/dir.c
@@ -491,20 +491,23 @@ void clear_exclude_list(struct exclude_list *el)
 	el->filebuf =3D NULL;
 }
=20
-static void check_trailing_spaces(const char *fname, char *buf)
+static void trim_trailing_spaces(char *buf)
 {
-	int i, last_space =3D -1, len =3D strlen(buf);
+	int i, last_space =3D -1, nr_spaces, len =3D strlen(buf);
 	for (i =3D 0; i < len; i++)
 		if (buf[i] =3D=3D '\\')
 			i++;
-		else if (buf[i] =3D=3D ' ')
-			last_space =3D i;
-		else
+		else if (buf[i] =3D=3D ' ') {
+			if (last_space =3D=3D -1) {
+				last_space =3D i;
+				nr_spaces =3D 1;
+			} else
+				nr_spaces++;
+		} else
 			last_space =3D -1;
=20
-	if (last_space =3D=3D len - 1)
-		warning(_("%s: trailing spaces in '%s'. Please quote or remove them.=
"),
-			fname, buf);
+	if (last_space !=3D -1 && last_space + nr_spaces =3D=3D len)
+		buf[last_space] =3D '\0';
 }
=20
 int add_excludes_from_file_to_list(const char *fname,
@@ -558,7 +561,7 @@ int add_excludes_from_file_to_list(const char *fnam=
e,
 		if (buf[i] =3D=3D '\n') {
 			if (entry !=3D buf + i && entry[0] !=3D '#') {
 				buf[i - (i && buf[i-1] =3D=3D '\r')] =3D 0;
-				check_trailing_spaces(fname, entry);
+				trim_trailing_spaces(entry);
 				add_exclude(entry, base, baselen, el, lineno);
 			}
 			lineno++;
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 9e1d64c..bbaf6b5 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -779,18 +779,18 @@ test_expect_success PIPE 'streaming support for -=
-stdin' '
 #
 # test whitespace handling
=20
-test_expect_success 'trailing whitespace is warned' '
+test_expect_success 'trailing whitespace is ignored' '
 	mkdir whitespace &&
 	>whitespace/trailing &&
 	>whitespace/untracked &&
 	echo "whitespace/trailing   " >ignore &&
 	cat >expect <<EOF &&
-whitespace/trailing
 whitespace/untracked
 EOF
+	: >err.expect &&
 	git ls-files -o -X ignore whitespace >actual 2>err &&
-	grep "ignore:.*'\''whitespace/trailing   '\''" err &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	test_cmp err.expect err
 '
=20
 test_expect_success 'quoting allows trailing whitespace' '
--=20
1.8.5.2.240.g8478abd
