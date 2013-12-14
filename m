From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 11/21] setup.c: reduce cleanup sites in setup_explicit_git_dir()
Date: Sat, 14 Dec 2013 17:54:57 +0700
Message-ID: <1387018507-21999-12-git-send-email-pclouds@gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
 <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 14 11:52:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vrmpa-000175-Rf
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 11:52:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526Ab3LNKwS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Dec 2013 05:52:18 -0500
Received: from mail-pd0-f182.google.com ([209.85.192.182]:59949 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab3LNKwR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 05:52:17 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so3508244pde.13
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 02:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=63jYZNjP7lovR3X4SWV/30fa1DZ1fwRfoyeIJ8GjhZk=;
        b=aQlBRXaMotJAXgNzDyL4RYv7SNuMsE5NDzCE9k1gMf0sKd/4M3k7X50eAGSKmgNQms
         3LAcRbA0ZVX00Vj8c2nolW0+WamkZkwf5YvH7nU1/g52EQzbC3dp4fIzppkOmxp6jp/m
         ao0esoH1cAxKlO3OGWek71Bn4vLACpY+tSq5NayzimZO1fhdt9TS5MwxJC+ZmIfY/9RR
         yKQqaEyFLjaOr1WOBBihIjUE8B6rUJZLc6rEA53so6wENzNXiTbimcCGM02su0Cmwck6
         mxWc4SgSQjkrb/gRRpwn8f4NhXs3ysS5IzLBYMOJ4xNCqgr9PfqvHNejB75+kJY5+dsp
         5VWg==
X-Received: by 10.68.99.99 with SMTP id ep3mr8781406pbb.107.1387018337270;
        Sat, 14 Dec 2013 02:52:17 -0800 (PST)
Received: from lanh ([115.73.245.131])
        by mx.google.com with ESMTPSA id at4sm11412235pbc.30.2013.12.14.02.52.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 14 Dec 2013 02:52:16 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 14 Dec 2013 17:57:10 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239293>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/setup.c b/setup.c
index 01fe89a..397eecc 100644
--- a/setup.c
+++ b/setup.c
@@ -406,16 +406,13 @@ static const char *setup_explicit_git_dir(const c=
har *gitdirenv,
 	if (!is_git_directory(gitdirenv)) {
 		if (nongit_ok) {
 			*nongit_ok =3D 1;
-			free(gitfile);
-			return NULL;
+			goto done_null;
 		}
 		die("Not a git repository: '%s'", gitdirenv);
 	}
=20
-	if (check_repository_format_gently(gitdirenv, nongit_ok)) {
-		free(gitfile);
-		return NULL;
-	}
+	if (check_repository_format_gently(gitdirenv, nongit_ok))
+		goto done_null;
=20
 	/* #3, #7, #11, #15, #19, #23, #27, #31 (see t1510) */
 	if (work_tree_env)
@@ -426,8 +423,7 @@ static const char *setup_explicit_git_dir(const cha=
r *gitdirenv,
=20
 		/* #18, #26 */
 		set_git_dir(gitdirenv);
-		free(gitfile);
-		return NULL;
+		goto done_null;
 	}
 	else if (git_work_tree_cfg) { /* #6, #14 */
 		if (is_absolute_path(git_work_tree_cfg))
@@ -448,8 +444,7 @@ static const char *setup_explicit_git_dir(const cha=
r *gitdirenv,
 	else if (!git_env_bool(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, 1)) {
 		/* #16d */
 		set_git_dir(gitdirenv);
-		free(gitfile);
-		return NULL;
+		goto done_null;
 	}
 	else /* #2, #10 */
 		set_git_work_tree(".");
@@ -460,8 +455,7 @@ static const char *setup_explicit_git_dir(const cha=
r *gitdirenv,
 	/* both get_git_work_tree() and cwd are already normalized */
 	if (!strcmp(cwd, worktree)) { /* cwd =3D=3D worktree */
 		set_git_dir(gitdirenv);
-		free(gitfile);
-		return NULL;
+		goto done_null;
 	}
=20
 	offset =3D dir_inside_of(cwd, worktree);
@@ -477,6 +471,8 @@ static const char *setup_explicit_git_dir(const cha=
r *gitdirenv,
=20
 	/* cwd outside worktree */
 	set_git_dir(gitdirenv);
+
+done_null:
 	free(gitfile);
 	return NULL;
 }
--=20
1.8.5.1.77.g42c48fa
