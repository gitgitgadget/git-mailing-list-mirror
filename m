From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 24/28] receive-pack: support pushing to a shallow clone via http
Date: Thu,  5 Dec 2013 20:02:51 +0700
Message-ID: <1386248575-10206-25-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 14:00:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoYY5-0002yG-UU
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 14:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237Ab3LENAy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 08:00:54 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:63991 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932215Ab3LENAw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 08:00:52 -0500
Received: by mail-pd0-f177.google.com with SMTP id q10so24244201pdj.8
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 05:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=AhlYZfaBI6vJZWqx0ppoHMadntrAyDpiOpX7jC7Pt2Y=;
        b=wzN15PNKZie7nV8ZUbF9EXz3MKCcu/M0aDvyLsGkam0fwiFKVFqDOqp6FxjSZpJF6J
         ghCKMIoPQHhcLwXZv8/VfzGNED5g1kUP/6Mw98Og6pGEDxoE+S/UDEWRmUYK5uqGfgX1
         SRXT5XdV0kX5bq505a9A1c9PfYHOdeXfhgDXzkC2iSkez6hM0EJyoX6WPoyNOAz7/cE+
         GqXnc0Z8eVtBxbC4eD+xOIftJ+ioaWC/Duqrs1frR9NcM832nh+O/22v2aIeKtM2kwt0
         4VEMZrjMAfPxm/8BMXNMX6971MT2xvUIYW24JRP7Fcyr48y8MGehFzCv/CF5GDY6i8/G
         /3uA==
X-Received: by 10.68.112.161 with SMTP id ir1mr52971227pbb.9.1386248452235;
        Thu, 05 Dec 2013 05:00:52 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id ye1sm30028148pab.19.2013.12.05.05.00.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 05:00:51 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 20:05:35 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238880>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/receive-pack.c  |  3 ---
 t/t5537-push-shallow.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 5c85bb4..78fe8ee 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1179,9 +1179,6 @@ int cmd_receive_pack(int argc, const char **argv,=
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
index f5c74e6..866621a 100755
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
@@ -120,4 +121,38 @@ EOF
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
1.8.5.1.25.g8667982
