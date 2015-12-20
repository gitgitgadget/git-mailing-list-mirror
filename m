From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/3] git.c: make sure we do not leak GIT_* to alias scripts
Date: Sun, 20 Dec 2015 14:50:19 +0700
Message-ID: <1450597819-26278-4-git-send-email-pclouds@gmail.com>
References: <1449166676-30845-1-git-send-email-pclouds@gmail.com>
 <1450597819-26278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
	asottile@umich.edu,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 20 08:51:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAYlm-0002aP-6G
	for gcvg-git-2@plane.gmane.org; Sun, 20 Dec 2015 08:51:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205AbbLTHu4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Dec 2015 02:50:56 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36379 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbbLTHuz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2015 02:50:55 -0500
Received: by mail-pf0-f171.google.com with SMTP id o64so71853463pfb.3
        for <git@vger.kernel.org>; Sat, 19 Dec 2015 23:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=U+0UerjKLH4RNr8YYlYSe885MpoB0s8YVOi2KKTmXRI=;
        b=Nk8lF6cUpMWIyrDkNu0yKpalI8+nxmNPm6ZuUzZSgrgAmsOtrvIzqh4hTkro/DIgc8
         8l3DsORizJEz6y4VsdNVDQ/8FFGT0THk6XnU4Grg1Ll8phq2nwotOpB4SXqi1nh0c5Gk
         PN4ghlIXJ0U+1sm6Qmo8eF74E2R+UC4OqP7FsHfDYVq7mM1/lzLj9WaeQB9EqdhngV7+
         e/k0C2ze3uEQ+EXWrJ0ZGZ+qkbnUzHO3uLx9Ht6EOknhZsDlzYO+PAXoZoz72Ywr5Qv+
         Nn5VVu9d4ikN9D6sE96TvUZF6NDYXKk2Ij4w9MgwKAeye+dZdvDgiVcVrsdlHDYarkBj
         3t8Q==
X-Received: by 10.98.15.150 with SMTP id 22mr18002485pfp.57.1450597854318;
        Sat, 19 Dec 2015 23:50:54 -0800 (PST)
Received: from lanh ([171.233.236.127])
        by smtp.gmail.com with ESMTPSA id ix2sm31819893pac.15.2015.12.19.23.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Dec 2015 23:50:52 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 20 Dec 2015 14:50:53 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1450597819-26278-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282767>

The unfortunate commit d95138e (setup: set env $GIT_WORK_TREE when
work tree is set, like $GIT_DIR - 2015-06-26) exposes another problem,
besides git-clone that's described in the previous commit. If
GIT_WORK_TREE (or even GIT_DIR) is exported to an alias script, it may
mislead git commands in the script where the repo is. Granted, most
scripts work on the repo where the alias is summoned from. But nowhere
do we forbid the script to visit another repository.

The revert of d95138e in the previous commit is sufficient as a
fix. However, to protect us from accidentally leaking GIT_*
environment variables again, we restore certain sensitive env before
calling the external script.

GIT_PREFIX is let through because there's another setup side effect
that we simply accepted so far: current working directory is
moved. Maybe in future we can introduce a new alias format that
guarantees no cwd move, then we can unexport GIT_PREFIX.

Reported-by: Gabriel Ganne <gabriel.ganne@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git.c           | 10 +++++++---
 t/t0001-init.sh | 17 +++++++++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index 1a7d399..da278c3 100644
--- a/git.c
+++ b/git.c
@@ -41,13 +41,16 @@ static void save_env_before_alias(void)
 	}
 }
=20
-static void restore_env(void)
+static void restore_env(int external_alias)
 {
 	int i;
-	if (orig_cwd && chdir(orig_cwd))
+	if (!external_alias && orig_cwd && chdir(orig_cwd))
 		die_errno("could not move to %s", orig_cwd);
 	free(orig_cwd);
 	for (i =3D 0; i < ARRAY_SIZE(env_names); i++) {
+		if (external_alias &&
+		    !strcmp(env_names[i], GIT_PREFIX_ENVIRONMENT))
+			continue;
 		if (orig_env[i])
 			setenv(env_names[i], orig_env[i], 1);
 		else
@@ -243,6 +246,7 @@ static int handle_alias(int *argcp, const char ***a=
rgv)
 			int argc =3D *argcp, i;
=20
 			commit_pager_choice();
+			restore_env(1);
=20
 			/* build alias_argv */
 			alias_argv =3D xmalloc(sizeof(*alias_argv) * (argc + 1));
@@ -291,7 +295,7 @@ static int handle_alias(int *argcp, const char ***a=
rgv)
 		ret =3D 1;
 	}
=20
-	restore_env();
+	restore_env(0);
=20
 	errno =3D saved_errno;
=20
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index f91bbcf..295aa59 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -87,6 +87,23 @@ test_expect_success 'plain nested in bare through al=
iased command' '
 	check_config bare-ancestor-aliased.git/plain-nested/.git false unset
 '
=20
+test_expect_success 'No extra GIT_* on alias scripts' '
+	(
+		env | sed -ne "/^GIT_/s/=3D.*//p" &&
+		echo GIT_PREFIX &&        # setup.c
+		echo GIT_TEXTDOMAINDIR    # wrapper-for-bin.sh
+	) | sort | uniq >expected &&
+	cat <<-\EOF >script &&
+	#!/bin/sh
+	env | sed -ne "/^GIT_/s/=3D.*//p" | sort >actual
+	exit 0
+	EOF
+	chmod 755 script &&
+	git config alias.script \!./script &&
+	( mkdir sub && cd sub && git script ) &&
+	test_cmp expected actual
+'
+
 test_expect_success 'plain with GIT_WORK_TREE' '
 	mkdir plain-wt &&
 	test_must_fail env GIT_WORK_TREE=3D"$(pwd)/plain-wt" git init plain-w=
t
--=20
2.3.0.rc1.137.g477eb31
