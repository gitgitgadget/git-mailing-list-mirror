From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/25] list-files: show paths relative to cwd
Date: Mon,  6 Apr 2015 20:52:15 +0700
Message-ID: <1428328354-14897-7-git-send-email-pclouds@gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 1425896314-10941-1-git-send-email-pclouds@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:53:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf7Sq-00052W-FS
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 15:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbbDFNxQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 09:53:16 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35204 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086AbbDFNxP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 09:53:15 -0400
Received: by patj18 with SMTP id j18so45109574pat.2
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 06:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jOkO28HCxKc2u4GcrkZ1zHcLF8faG0fz7h/YMmCrHrs=;
        b=nycoFB3zzJXGDqxihWZY/9KlBxoGsk2Zmmxe7plSesn3IyRLQeu0tAacda8hbcAbwv
         g4ND33q5NByMYDW3Xprmj6XI794zpW1+c5dvm8B+oUcQN1HYbW/vFoObjGcGFfnM3YnV
         EqTUsacxvOsxmJ4PA3UKAaohFWQe9DcqyI0ngCgj8i82/2dllfiJZnUGr+gafnmsdv9N
         f4yQ8AawP4qAdvxeAs9wQf/+W/gXKM2CZBPtVuddVErWCHn5dup9T1Le16rRdTSGR66Y
         nk0A/Ddtpsn5as5pkgkiqE4s6A20extJyCEWIWxtamXIwj4quY0aHgLpieOXd6PtBAWP
         SvMA==
X-Received: by 10.66.124.164 with SMTP id mj4mr27949085pab.83.1428328394692;
        Mon, 06 Apr 2015 06:53:14 -0700 (PDT)
Received: from lanh ([115.73.245.217])
        by mx.google.com with ESMTPSA id pf3sm4806791pdb.3.2015.04.06.06.53.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 06:53:14 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 06 Apr 2015 20:53:26 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266852>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c  |  9 ++++++++-
 t/t7013-list-files.sh | 24 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index 8b74d79..51ff19d 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -3,6 +3,7 @@
 #include "parse-options.h"
 #include "pathspec.h"
 #include "dir.h"
+#include "quote.h"
=20
 enum item_type {
 	FROM_INDEX
@@ -57,13 +58,19 @@ static void populate_cached_entries(struct item_lis=
t *result,
=20
 static void display(const struct item_list *result)
 {
+	struct strbuf quoted =3D STRBUF_INIT;
 	int i;
=20
+	if (!prefix_length)
+		prefix =3D NULL;
+
 	for (i =3D 0; i < result->nr; i++) {
 		const struct item *item =3D result->items + i;
=20
-		printf("%s\n", item->path);
+		quote_path_relative(item->path, prefix, &quoted);
+		printf("%s\n", quoted.buf);
 	}
+	strbuf_release(&quoted);
 }
=20
 static int ls_config(const char *var, const char *value, void *cb)
diff --git a/t/t7013-list-files.sh b/t/t7013-list-files.sh
index f43776e..a5e555d 100755
--- a/t/t7013-list-files.sh
+++ b/t/t7013-list-files.sh
@@ -32,4 +32,28 @@ test_expect_success 'list-files selectively from ind=
ex' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'list-files from subdir ' '
+	(
+	cd sa &&
+	git list-files >actual &&
+	cat >expect <<-\EOF &&
+	a
+	sb/b
+	EOF
+	test_cmp expect actual
+	)
+'
+
+test_expect_success 'list-files from subdir (2)' '
+	(
+	cd sa &&
+	git list-files ../a sb >actual &&
+	cat >expect <<-\EOF &&
+	../a
+	sb/b
+	EOF
+	test_cmp expect actual
+	)
+'
+
 test_done
--=20
2.3.0.rc1.137.g477eb31
