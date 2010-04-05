From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 34/43] config: do not read .git/config if there is no repository
Date: Mon,  5 Apr 2010 20:41:19 +0200
Message-ID: <1270492888-26589-35-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:44:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrHB-0000ps-CC
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756122Ab0DESnp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:43:45 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:44752 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756108Ab0DESnm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:43:42 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1251549fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=yk9RS/NH8MXRQ4AAARKSO1rhvnTDVo0WhXYwCDWtbWc=;
        b=LBJCSKWfhGRpADNXC7iyElziRFlkdUoXGh0X05VqaPjVyKsLnG3KVp8sJ6sMmPJqu/
         2uCBI+NoGLwpTGSu9eKhWKKefALGt9dz+zAGv6RdX1wZaUz/8n4rk/vlw5J3oJ8LY38t
         XxEwk1RjtbMKtbOh6+2/IOdDrRYj14bcbBK+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=WsBN5H/JF/oI47CU77M0KnjIABckN//hg4f2SWlJjc0mfArFIIW2Of7zKM8mDusQfn
         r+8Re9vb/3YApv5rensBNPjLbcVgUh2Y7Mz5afxBjcADeu0xqMdjL2rj7hvK4a0BDUb8
         3wPd3kjQIMuj6gskDuD08VUdDBgj8/vd/okHE=
Received: by 10.223.35.12 with SMTP id n12mr5771959fad.35.1270493021893;
        Mon, 05 Apr 2010 11:43:41 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id 18sm142890fkq.4.2010.04.05.11.43.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:43:41 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:43:39 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144027>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/config.c        |    9 ++++++---
 t/t1300-repo-config.sh  |    3 ++-
 t/t1302-repo-version.sh |    2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index ecc8f87..3fca3b4 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -159,7 +159,8 @@ static int get_value(const char *key_, const char *=
regex_)
 	local =3D config_exclusive_filename;
 	if (!local) {
 		const char *home =3D getenv("HOME");
-		local =3D repo_config =3D git_pathdup("config");
+		if (startup_info->have_repository)
+			local =3D repo_config =3D git_pathdup("config");
 		if (git_config_global() && home)
 			global =3D xstrdup(mkpath("%s/.gitconfig", home));
 		if (git_config_system())
@@ -197,7 +198,8 @@ static int get_value(const char *key_, const char *=
regex_)
 		git_config_from_file(show_config, system_wide, NULL);
 	if (do_all && global)
 		git_config_from_file(show_config, global, NULL);
-	git_config_from_file(show_config, local, NULL);
+	if (local)
+		git_config_from_file(show_config, local, NULL);
 	if (!do_all && !seen && global)
 		git_config_from_file(show_config, global, NULL);
 	if (!do_all && !seen && system_wide)
@@ -215,7 +217,8 @@ static int get_value(const char *key_, const char *=
regex_)
 		ret =3D (seen =3D=3D 1) ? 0 : seen > 1 ? 2 : 1;
=20
 free_strings:
-	free(repo_config);
+	if (repo_config)
+		free(repo_config);
 	free(global);
 	return ret;
 }
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index cfb70e2..b040f72 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -833,7 +833,8 @@ test_expect_success 'skip .git/config if there is n=
o repository' '
 		cd b &&
 		echo "[core]" > .git/config &&
 		echo "wrong =3D true" >> .git/config &&
-		test -z "$(git var -l | grep core.wrong)"
+		test -z "$(git var -l | grep core.wrong)" &&
+		test -z "$(git config --bool core.wrong)"
 	)
 '
=20
diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index 8d305b4..74bf51f 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -29,7 +29,7 @@ test_expect_success 'gitdir selection on normal repos=
' '
 # Make sure it would stop at test2, not trash
 test_expect_success 'gitdir selection on unsupported repo' '
 	(cd test2 &&
-	test "$(git config core.repositoryformatversion)" =3D 99)'
+	test "$(git config --file=3D.git/config core.repositoryformatversion)=
" =3D 99)'
=20
 test_expect_success 'gitdir not required mode' '
 	(git apply --stat test.patch &&
--=20
1.7.0.rc1.541.g2da82.dirty
