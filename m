From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/3] nd/clear-gitenv-upon-use-of-alias
Date: Sun, 20 Dec 2015 14:50:16 +0700
Message-ID: <1450597819-26278-1-git-send-email-pclouds@gmail.com>
References: <1449166676-30845-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
	asottile@umich.edu,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 20 08:50:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAYlO-0001zE-J1
	for gcvg-git-2@plane.gmane.org; Sun, 20 Dec 2015 08:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbbLTHuj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Dec 2015 02:50:39 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35386 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbbLTHuh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2015 02:50:37 -0500
Received: by mail-pa0-f54.google.com with SMTP id jx14so54314187pad.2
        for <git@vger.kernel.org>; Sat, 19 Dec 2015 23:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Q/S/qd0CuxUNnXaI1ooRCy5hj1qz1FO+M0m7HQyQsA4=;
        b=ZvT5A0DCaLhFkgFp4nDRiV6MAhA7bTb7ZJ1JPk5YRfUV+cX8fySXpU3/sLyksJKmwl
         jZu/rgFDtXcPL3BtCXKplj900iP591LsEMHDps8guuQyEWxxvV7Tzz0v/eXYv6nKmB7y
         kIYhG4Qkouup2V8t3yecqhyfDpoi64luDwJ3yAcNZa6+9Iab2phUL4XggHOIYTiFRa/G
         At1osE/JkDZ+ndwW0FYXCz2n6hyqAIj9TE4rDKx7j6/v/OCXDBa1MaTSlgKMwQ1N32gl
         un46vejzBea1WFXUunzBhcGZTEADeOJKHkul+LvhSYfvllY0bfW5lx80OFy1/jC7k1wr
         odMQ==
X-Received: by 10.66.150.228 with SMTP id ul4mr18229603pab.15.1450597834873;
        Sat, 19 Dec 2015 23:50:34 -0800 (PST)
Received: from lanh ([171.233.236.127])
        by smtp.gmail.com with ESMTPSA id u67sm27354615pfa.84.2015.12.19.23.50.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Dec 2015 23:50:33 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 20 Dec 2015 14:50:34 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1449166676-30845-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282765>

Changes since v1:

 - make sure we save/restore env for external commands in 2/3
 - fix t0001 test in 3/3

Interdiff:

diff --git b/git.c a/git.c
index 83b6c56..da278c3 100644
--- b/git.c
+++ a/git.c
@@ -229,7 +229,6 @@ static int handle_options(const char ***argv, int *=
argc, int *envchanged)
 static int handle_alias(int *argcp, const char ***argv)
 {
 	int envchanged =3D 0, ret =3D 0, saved_errno =3D errno;
-	const char *subdir;
 	int count, option_count;
 	const char **new_argv;
 	const char *alias_command;
@@ -237,7 +236,7 @@ static int handle_alias(int *argcp, const char ***a=
rgv)
 	int unused_nongit;
=20
 	save_env_before_alias();
-	subdir =3D setup_git_directory_gently(&unused_nongit);
+	setup_git_directory_gently(&unused_nongit);
=20
 	alias_command =3D (*argv)[0];
 	alias_string =3D alias_lookup(alias_command);
@@ -296,8 +295,7 @@ static int handle_alias(int *argcp, const char ***a=
rgv)
 		ret =3D 1;
 	}
=20
-	if (subdir && chdir(subdir))
-		die_errno("Cannot change to '%s'", subdir);
+	restore_env(0);
=20
 	errno =3D saved_errno;
=20
@@ -534,9 +532,13 @@ static void handle_builtin(int argc, const char **=
argv)
=20
 	builtin =3D get_builtin(cmd);
 	if (builtin) {
-		if (saved_env_before_alias)
-			restore_env(0);
-		else
+		/*
+		 * XXX: if we can figure out cases where it is _safe_
+		 * to do, we can avoid spawning a new process when
+		 * saved_env_before_alias is true
+		 * (i.e. setup_git_dir* has been run once)
+		 */
+		if (!saved_env_before_alias)
 			exit(run_builtin(builtin, argc, argv));
 	}
 }
diff --git b/t/t0001-init.sh a/t/t0001-init.sh
index 19539fc..295aa59 100755
--- b/t/t0001-init.sh
+++ a/t/t0001-init.sh
@@ -88,24 +88,14 @@ test_expect_success 'plain nested in bare through a=
liased command' '
 '
=20
 test_expect_success 'No extra GIT_* on alias scripts' '
-	cat <<-\EOF >expected &&
-	GIT_ATTR_NOSYSTEM
-	GIT_AUTHOR_EMAIL
-	GIT_AUTHOR_NAME
-	GIT_COMMITTER_EMAIL
-	GIT_COMMITTER_NAME
-	GIT_CONFIG_NOSYSTEM
-	GIT_EXEC_PATH
-	GIT_MERGE_AUTOEDIT
-	GIT_MERGE_VERBOSITY
-	GIT_PREFIX
-	GIT_TEMPLATE_DIR
-	GIT_TEXTDOMAINDIR
-	GIT_TRACE_BARE
-	EOF
+	(
+		env | sed -ne "/^GIT_/s/=3D.*//p" &&
+		echo GIT_PREFIX &&        # setup.c
+		echo GIT_TEXTDOMAINDIR    # wrapper-for-bin.sh
+	) | sort | uniq >expected &&
 	cat <<-\EOF >script &&
 	#!/bin/sh
-	env | grep GIT_ | sed "s/=3D.*//" | sort >actual
+	env | sed -ne "/^GIT_/s/=3D.*//p" | sort >actual
 	exit 0
 	EOF
 	chmod 755 script &&

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  git.c: make it clear save_env() is for alias handling only
  setup.c: re-fix d95138e (setup: set env $GIT_WORK_TREE when ..
  git.c: make sure we do not leak GIT_* to alias scripts

 environment.c    |  2 --
 git.c            | 41 +++++++++++++++++++++++------------------
 t/t0001-init.sh  | 17 +++++++++++++++++
 t/t5601-clone.sh | 23 +++++++++++++++++++++++
 4 files changed, 63 insertions(+), 20 deletions(-)

--=20
2.3.0.rc1.137.g477eb31
