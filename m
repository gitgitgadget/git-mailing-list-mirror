From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/POC 5/7] setup.c: reduce cleanup sites in setup_explicit_git_dir()
Date: Wed, 11 Dec 2013 21:15:31 +0700
Message-ID: <1386771333-32574-6-git-send-email-pclouds@gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 11 15:11:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqkVW-0007lE-55
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 15:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986Ab3LKOLR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Dec 2013 09:11:17 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:34332 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab3LKOLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 09:11:16 -0500
Received: by mail-pb0-f44.google.com with SMTP id rq2so10084810pbb.3
        for <git@vger.kernel.org>; Wed, 11 Dec 2013 06:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ubyeaXrIhtb/+cy9TB2tMWeJ2D5ovNH5Xm9cyBGfevU=;
        b=Ijde21iqvAt3gZLYEg7oCyvrjTMww816IFmmvnDCQ3QSZ5+BsNlwhQys8QA281W3ZW
         r32nhzAQDxBO3YzFiYgec4dht0enrExC4ZGNqFD0ZJvkb9Ei5KiZK6i7T9vzCdeGmMSj
         3KGN4CUfgRw+2ZOYBmwbtHZ46Ed+ZpaBENrGhlLY7lgPD4ZZ+RrCJCG+aifyDbzSfZVy
         0FHU512cPL/EyKNjcdPkKNWXwb5d7CvQl+9v4Sdlou3E/WVwZmWy/ccCRZbW96JvuTYq
         jNvf3qM8NmBjxOCnmZ9F8C5cC3aJhBb/r8wya+v3efY/3D64+KTzA7TLwJa45JCof6lz
         lMmg==
X-Received: by 10.66.152.102 with SMTP id ux6mr1814455pab.79.1386771075835;
        Wed, 11 Dec 2013 06:11:15 -0800 (PST)
Received: from lanh ([115.73.201.231])
        by mx.google.com with ESMTPSA id sd3sm32925465pbb.42.2013.12.11.06.11.12
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Dec 2013 06:11:15 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 11 Dec 2013 21:16:05 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239199>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/setup.c b/setup.c
index 43f56fb..dfe9d08 100644
--- a/setup.c
+++ b/setup.c
@@ -388,16 +388,13 @@ static const char *setup_explicit_git_dir(const c=
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
@@ -408,8 +405,7 @@ static const char *setup_explicit_git_dir(const cha=
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
@@ -430,8 +426,7 @@ static const char *setup_explicit_git_dir(const cha=
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
@@ -442,8 +437,7 @@ static const char *setup_explicit_git_dir(const cha=
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
@@ -459,6 +453,8 @@ static const char *setup_explicit_git_dir(const cha=
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
