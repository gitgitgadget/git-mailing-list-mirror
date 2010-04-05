From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 30/43] git_config(): do not read .git/config if there is no repository
Date: Mon,  5 Apr 2010 20:41:15 +0200
Message-ID: <1270492888-26589-31-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:44:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrHA-0000ps-8J
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756115Ab0DESn0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:43:26 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:44752 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756108Ab0DESnX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:43:23 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1251549fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=wlsN+fFh8D4tF3bAZIcjGXte6Rdm7QApSpswAKyWq/g=;
        b=qkZKqHUbbrI2KvefoKIumnz3ltM5t/4aV6mbg110j+polzTHZfj359A2uVlmvQUEWG
         vWFUWSkDtOmFJ6P0LLlNmLY3BYrFFhan1KRx8G1kJelZKrcPYnEzFLVmozR5u3tp+BuP
         UPhMcko8pwwB/z9zgiUqbvQKoN0r5CRKiALEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=arFWMPF5fKjx+t4HumG2FLe5usOQyLEOZiMog+bAbDOQQRKhJ18a6ookODqAz3KOy9
         JNRuVyHb4D1xs/tqDDSdpNoEkz7qyp8x21xLfk/mEuQA6dv78bwUhh1C+pjn0KeFMI49
         BklCA0dx1IpT4iu3gFLLPtnnbaAMCRLfeDhM0=
Received: by 10.223.64.205 with SMTP id f13mr6089887fai.98.1270493001614;
        Mon, 05 Apr 2010 11:43:21 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id g28sm26929533fkg.28.2010.04.05.11.43.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:43:20 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:43:18 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144025>

If no repository is found, do not bother calling git_pathdup(). If a
command forgets to call setup_git_directory*() or enter_repo(),
$GIT_DIR/config will be missed, though.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.c               |    3 ++-
 t/t1300-repo-config.sh |   13 +++++++++++++
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/config.c b/config.c
index 2d38096..07d854a 100644
--- a/config.c
+++ b/config.c
@@ -737,7 +737,8 @@ int git_config(config_fn_t fn, void *data)
 	char *repo_config =3D NULL;
 	int ret;
=20
-	repo_config =3D git_pathdup("config");
+	if (!startup_info || startup_info->have_repository)
+		repo_config =3D git_pathdup("config");
 	ret =3D git_config_early(fn, data, repo_config);
 	if (repo_config)
 		free(repo_config);
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index f11f98c..cfb70e2 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -824,4 +824,17 @@ test_expect_success 'check split_cmdline return' "
 	test_must_fail git merge master
 	"
=20
+test_expect_success 'skip .git/config if there is no repository' '
+	(
+		mkdir -p a/b/.git &&
+		cd a &&
+		GIT_CEILING_DIRECTORIES=3D"`pwd`" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd b &&
+		echo "[core]" > .git/config &&
+		echo "wrong =3D true" >> .git/config &&
+		test -z "$(git var -l | grep core.wrong)"
+	)
+'
+
 test_done
--=20
1.7.0.rc1.541.g2da82.dirty
