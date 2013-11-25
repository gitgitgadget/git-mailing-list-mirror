From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 24/28] receive-pack: support pushing to a shallow clone via http
Date: Mon, 25 Nov 2013 10:55:50 +0700
Message-ID: <1385351754-9954-25-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 04:54:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VknFg-0002Uq-95
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 04:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779Ab3KYDyL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 22:54:11 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:47813 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707Ab3KYDxv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 22:53:51 -0500
Received: by mail-pb0-f48.google.com with SMTP id md12so4783174pbc.21
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 19:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=QF5+4+WImvOiAvPS+ptLie9HS37KzJ9U8tHM1WnbEX4=;
        b=JAs3W0i7hFW0DozdMJrpfTnIYFfd3Y40f2p0MgbKD/8BVwkWeHZCejcDfydTZMA4xk
         gi0C6BhEuMQIkLt5gw55YJ4+aZ/2QUAoIBE8TB2pIoDZZSYFkXQndNp35qZQOmCxqWuC
         1Gri3U/4ZPz2e7IkzTdGethl4vfVkCdgMvMGA/6WxnQ3R3f7xQ5wJEvxyrvxGPwYEO+v
         38Qg4VQaFlHab7rsOCx8z524l3yMTcO9LbWHtNfEg+0QX8xjGJeX0LFmdgRV/6LeW6n1
         iOR5EPzxNhwiv83kPbxPXQJoIpCktjFuX0dNtsKug/BIyO21pkxAayGTbq/fJxKgYQcg
         YEvw==
X-Received: by 10.66.231.42 with SMTP id td10mr558792pac.144.1385351630429;
        Sun, 24 Nov 2013 19:53:50 -0800 (PST)
Received: from lanh ([115.73.213.240])
        by mx.google.com with ESMTPSA id xs1sm79029718pac.7.2013.11.24.19.53.47
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 19:53:49 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 25 Nov 2013 10:58:22 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238300>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/receive-pack.c  |  3 ---
 t/t5537-push-shallow.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 366ecde..ec681ba 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1157,9 +1157,6 @@ int cmd_receive_pack(int argc, const char **argv,=
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
index ccb41b6..d252a78 100755
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
@@ -121,4 +122,38 @@ EOF
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
