From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/2] git.c: make sure we do not leak GIT_* to alias scripts
Date: Sat,  5 Dec 2015 16:32:18 +0100
Message-ID: <1449329538-18623-1-git-send-email-pclouds@gmail.com>
References: <1449166676-30845-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
	asottile@umich.edu,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 05 16:32:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5EpM-0002nZ-2I
	for gcvg-git-2@plane.gmane.org; Sat, 05 Dec 2015 16:32:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472AbbLEPcn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Dec 2015 10:32:43 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33978 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235AbbLEPcm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2015 10:32:42 -0500
Received: by wmvv187 with SMTP id v187so112467389wmv.1
        for <git@vger.kernel.org>; Sat, 05 Dec 2015 07:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xzx361j0ZLTHCXoORxx3G7l51bbXDCBF+W7adWcY4Gg=;
        b=c+jAv+lGt1pBnsgLnqBTioMXoNxZt6cq/BLC30JTnDqj2Ji/hIK5j1176TTVfzIhB6
         9n/ul4Xlux+WAVmV0u3/l4h5NyfQ3OezEtPpFXwxvaV6orytPNysB12YTpqs1XVRSCVX
         tfbX0adHG+PmKF4bqbAqt1xmoxnwcyjvi7GL8QWmgCoMygClkhpwcg6aJMOxMzcEn4KS
         sf1ot12tO4dettWVWBjgu6N160QUpxmcaXs8IGXE8DmZLx3DdTqQaAKEDJL/7D6I5Bni
         o80a3T5NrzxG4Uu4+0IVv79/CQ4vBi7mwcmZmeAp1IUbobLvpfNPTwhrzdj7IpiwPh1M
         rKwA==
X-Received: by 10.194.200.5 with SMTP id jo5mr23364378wjc.79.1449329561353;
        Sat, 05 Dec 2015 07:32:41 -0800 (PST)
Received: from duynguyen-vnpc.dek-tpc.homenet.telecomitalia.it (host171-164-static.60-79-b.business.telecomitalia.it. [79.60.164.171])
        by smtp.gmail.com with ESMTPSA id vu4sm16833276wjc.2.2015.12.05.07.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 05 Dec 2015 07:32:39 -0800 (PST)
X-Mailer: git-send-email 2.2.0.513.g477eb31
In-Reply-To: <1449166676-30845-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282036>

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
 Let's hope there will be no third report about this commit..

 git.c           | 10 +++++++---
 t/t0001-init.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index e2f187d..83b6c56 100644
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
@@ -244,6 +247,7 @@ static int handle_alias(int *argcp, const char ***a=
rgv)
 			int argc =3D *argcp, i;
=20
 			commit_pager_choice();
+			restore_env(1);
=20
 			/* build alias_argv */
 			alias_argv =3D xmalloc(sizeof(*alias_argv) * (argc + 1));
@@ -531,7 +535,7 @@ static void handle_builtin(int argc, const char **a=
rgv)
 	builtin =3D get_builtin(cmd);
 	if (builtin) {
 		if (saved_env_before_alias)
-			restore_env();
+			restore_env(0);
 		else
 			exit(run_builtin(builtin, argc, argv));
 	}
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index f91bbcf..19539fc 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -87,6 +87,33 @@ test_expect_success 'plain nested in bare through al=
iased command' '
 	check_config bare-ancestor-aliased.git/plain-nested/.git false unset
 '
=20
+test_expect_success 'No extra GIT_* on alias scripts' '
+	cat <<-\EOF >expected &&
+	GIT_ATTR_NOSYSTEM
+	GIT_AUTHOR_EMAIL
+	GIT_AUTHOR_NAME
+	GIT_COMMITTER_EMAIL
+	GIT_COMMITTER_NAME
+	GIT_CONFIG_NOSYSTEM
+	GIT_EXEC_PATH
+	GIT_MERGE_AUTOEDIT
+	GIT_MERGE_VERBOSITY
+	GIT_PREFIX
+	GIT_TEMPLATE_DIR
+	GIT_TEXTDOMAINDIR
+	GIT_TRACE_BARE
+	EOF
+	cat <<-\EOF >script &&
+	#!/bin/sh
+	env | grep GIT_ | sed "s/=3D.*//" | sort >actual
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
2.2.0.513.g477eb31
