From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] versionsort: support reorder prerelease suffixes
Date: Thu, 26 Feb 2015 17:44:01 +0700
Message-ID: <1424947441-19134-1-git-send-email-pclouds@gmail.com>
References: <CAPc5daVJJcC--mwq0PfAczge3zG44ToDKP853FkyZ3x1KUfsig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 11:43:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQvvC-0000ap-0y
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 11:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611AbbBZKnx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Feb 2015 05:43:53 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:45137 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753596AbbBZKnw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 05:43:52 -0500
Received: by pablf10 with SMTP id lf10so12992906pab.12
        for <git@vger.kernel.org>; Thu, 26 Feb 2015 02:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0USVlY+aZ+GqRDHabykCXLGzSysadRgR4EK95z4e9ak=;
        b=txSi0qOr3FPMeF/nKdGeKkyFbVcgrV9wV8p9uCspNV298eRIR0cCa4TUYqonu92NHk
         bdvkt0GEZgnlGIM4pfrC0FHmrRM1neFxv2MZ5VXnhz5AsBylSfN/+FUWlZVdndPL3AlN
         bzfEB3VGveh5XhhTmSHJR4mX8GUz/HUAzONfmA+Cdoh4HdYi7LNAHtFKWOu0S0vZOkJ1
         t1+bZ8qU67hqjOQxPgk9J9jN/Bj+caPEFDyKNSI8i4kaffgytkyIyKKwytSEQFNASEJP
         kV896jzx+2C2vVhs4JRou8qPviyWwCJy1VWu9M1lqf4OOxvvQDq546PIAu5XpAPMha2n
         e1Lg==
X-Received: by 10.66.219.233 with SMTP id pr9mr14049522pac.8.1424947431990;
        Thu, 26 Feb 2015 02:43:51 -0800 (PST)
Received: from lanh ([115.73.213.171])
        by mx.google.com with ESMTPSA id gi3sm542736pbc.83.2015.02.26.02.43.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Feb 2015 02:43:51 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 26 Feb 2015 17:44:14 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <CAPc5daVJJcC--mwq0PfAczge3zG44ToDKP853FkyZ3x1KUfsig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264428>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Second round. Looking better. We can do
 "1.0-pre12 < 1.0-rc0 < 1.0 < 1.0-post1" too but it relies on
 config key's loading order, a bit iffy.

 Documentation/config.txt |  7 +++++++
 t/t7004-tag.sh           | 28 +++++++++++++++++++++++++++
 versioncmp.c             | 50 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 85 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 04e2a71..8e078df 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2539,6 +2539,13 @@ user.signingkey::
 	This option is passed unchanged to gpg's --local-user parameter,
 	so you may specify a key using any method that gpg supports.
=20
+versionsort.prereleaseSuffix::
+	When version sort is used in linkgit:git-tag[1], prerelease
+	tags (e.g. "1.0-rc1") may appear after the main release
+	"1.0". By specifying the suffix "-rc" in this variable,
+	"1.0-rc1" will appear before "1.0". One variable assignment
+	per suffix.
+
 web.browser::
 	Specify a web browser that may be used by some commands.
 	Currently only linkgit:git-instaweb[1] and linkgit:git-help[1]
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 35c805a..8bfeef9 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1459,6 +1459,34 @@ test_expect_success 'invalid sort parameter in c=
onfiguratoin' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'version sort with prerelease reordering' '
+	git config --unset tag.sort &&
+	git config versionsort.prereleaseSuffix -rc &&
+	git tag foo1.6-rc1 &&
+	git tag foo1.6-rc2 &&
+	git tag -l --sort=3Dversion:refname "foo*" >actual &&
+	cat >expect <<-\EOF &&
+	foo1.3
+	foo1.6-rc1
+	foo1.6-rc2
+	foo1.6
+	foo1.10
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'reverse version sort with prerelease reordering' =
'
+	git tag -l --sort=3D-version:refname "foo*" >actual &&
+	cat >expect <<-\EOF &&
+	foo1.10
+	foo1.6
+	foo1.6-rc2
+	foo1.6-rc1
+	foo1.3
+	EOF
+	test_cmp expect actual
+'
+
 run_with_limited_stack () {
 	(ulimit -s 128 && "$@")
 }
diff --git a/versioncmp.c b/versioncmp.c
index 7511e08..80bfd10 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "string-list.h"
=20
 /*
  * versioncmp(): copied from string/strverscmp.c in glibc commit
@@ -20,6 +21,48 @@
 #define  CMP    2
 #define  LEN    3
=20
+static const struct string_list *prereleases;
+static int initialized;
+
+/*
+ * p1 and p2 point to the first different character in two strings. If
+ * either p1 or p2 starts with a prerelease suffix, it will be forced
+ * to be on top.
+ *
+ * If both p1 and p2 start with (different) suffix, the order is
+ * determined by config file.
+ *
+ * Note that we don't have to deal with the situation when both p1 and
+ * p2 start with the same suffix because the common part is already
+ * consumed by the caller.
+ *
+ * Return non-zero if *diff contains the return value for versioncmp()
+ */
+static int swap_prereleases(const void *p1_,
+			    const void *p2_,
+			    int *diff)
+{
+	const char *p1 =3D p1_;
+	const char *p2 =3D p2_;
+	int i, i1 =3D -1, i2 =3D -1;
+
+	for (i =3D 0; i < prereleases->nr; i++) {
+		const char *suffix =3D prereleases->items[i].string;
+		if (i1 =3D=3D -1 && starts_with(p1, suffix))
+			i1 =3D i;
+		if (i2 =3D=3D -1 && starts_with(p2, suffix))
+			i2 =3D i;
+	}
+	if (i1 =3D=3D -1 && i2 =3D=3D -1)
+		return 0;
+	if (i1 >=3D 0 && i2 >=3D 0)
+		*diff =3D i1 - i2;
+	else if (i1 >=3D 0)
+		*diff =3D -1;
+	else /* if (i2 >=3D 0) */
+		*diff =3D 1;
+	return 1;
+}
=20
 /*
  * Compare S1 and S2 as strings holding indices/version numbers,
@@ -74,6 +117,13 @@ int versioncmp(const char *s1, const char *s2)
 		state +=3D (c1 =3D=3D '0') + (isdigit (c1) !=3D 0);
 	}
=20
+	if (!initialized) {
+		initialized =3D 1;
+		prereleases =3D git_config_get_value_multi("versionsort.prereleasesu=
ffix");
+	}
+	if (prereleases && swap_prereleases(p1 - 1, p2 - 1, &diff))
+		return diff;
+
 	state =3D result_type[state * 3 + (((c2 =3D=3D '0') + (isdigit (c2) !=
=3D 0)))];
=20
 	switch (state) {
--=20
2.3.0.rc1.137.g477eb31
