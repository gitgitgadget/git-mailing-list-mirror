From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 12/16] receive-pack: support pushing to a shallow clone via http
Date: Sat, 20 Jul 2013 16:58:06 +0700
Message-ID: <1374314290-5976-13-git-send-email-pclouds@gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
 <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 20 11:59:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0Twd-0001ej-BA
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 11:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625Ab3GTJ7O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Jul 2013 05:59:14 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:64253 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753588Ab3GTJ7N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 05:59:13 -0400
Received: by mail-ie0-f169.google.com with SMTP id at20so400167iec.0
        for <git@vger.kernel.org>; Sat, 20 Jul 2013 02:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=N6EhODAAJ3Q/Yy1U9CsWIpd/CZ3oH/DiwLEMUqeHEME=;
        b=IPvDkJgwQo7DWYhGPZRKpj1QQrrOoK8ZeTmpYIzjTkUiuVLJwBb1BXpZK5+dGeTzvc
         wvnKcEo5y+490Y5+INdWVisTO8EedPGBcIQkoPu3Sq0ToquW5RsGkJDuBMRI84KQSVb2
         UlKR0FHr91kV2I+EOJ0nm0mWfcD8CuDQrGtisP/tZy89IQ8/dYaIDEgnMoI3bm/3lJkU
         5SbY1xArkuD4robqthaSmo2BQT4GaM1PlBf9EhhnOydYRZv9BJgyXNKOpkZPsH3XGhCZ
         cyDfEXWrvrYPoZ7InuCBY5EtRp/y/LlAYMkl5caPp/HsMIIkkl6/HOylHiDYZCBh/gVG
         YjOw==
X-Received: by 10.42.132.3 with SMTP id b3mr13510194ict.98.1374314352685;
        Sat, 20 Jul 2013 02:59:12 -0700 (PDT)
Received: from lanh ([115.73.248.127])
        by mx.google.com with ESMTPSA id w5sm44187235igz.10.2013.07.20.02.59.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Jul 2013 02:59:12 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 20 Jul 2013 16:59:31 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230890>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/receive-pack.c  |  3 ---
 t/t5537-push-shallow.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index cbb2025..54bf6b2 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1038,9 +1038,6 @@ int cmd_receive_pack(int argc, const char **argv,=
 const char *prefix)
 	if (!enter_repo(dir, 0))
 		die("'%s' does not appear to be a git repository", dir);
=20
-	if (is_repository_shallow() && stateless_rpc)
-		die("attempt to push into a shallow repository");
-
 	git_config(receive_pack_config, NULL);
=20
 	if (0 <=3D transfer_unpack_limit)
diff --git a/t/t5537-push-shallow.sh b/t/t5537-push-shallow.sh
index beb85ce..02d9198 100755
--- a/t/t5537-push-shallow.sh
+++ b/t/t5537-push-shallow.sh
@@ -16,6 +16,7 @@ test_expect_success 'setup' '
 	commit 2 &&
 	commit 3 &&
 	commit 4 &&
+	git clone . full &&
 	(
 	git init full-abc &&
 	cd full-abc &&
@@ -107,4 +108,38 @@ EOF
 	)
 '
=20
+if test -n "$NO_CURL" -o -z "$GIT_TEST_HTTPD"; then
+	say 'skipping remaining tests, git built without http support'
+	test_done
+fi
+
+LIB_HTTPD_PORT=3D${LIB_HTTPD_PORT-'5537'}
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'push to shallow repo via http' '
+	git clone --bare --no-local shallow "$HTTPD_DOCUMENT_ROOT_PATH/repo.g=
it" &&
+	(
+	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git config http.receivepack true
+	) &&
+	(
+	cd full &&
+	commit 9 &&
+	git push $HTTPD_URL/smart/repo.git +master:refs/remotes/top/master
+	) &&
+	(
+	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git fsck &&
+	git log --format=3D%s top/master >actual &&
+	cat <<EOF >expect &&
+9
+4
+3
+EOF
+	test_cmp expect actual
+	)
+'
+
+stop_httpd
 test_done
--=20
1.8.2.83.gc99314b
