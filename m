From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Remove .git auto detection from setup_git_env()
Date: Fri,  5 Feb 2010 18:47:48 +0700
Message-ID: <1265370468-6147-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 12:50:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdMhm-0003aw-Gz
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 12:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709Ab0BELu3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2010 06:50:29 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:59403 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824Ab0BELu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 06:50:27 -0500
Received: by pxi12 with SMTP id 12so4089358pxi.33
        for <git@vger.kernel.org>; Fri, 05 Feb 2010 03:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=3glPn2oGhmE+FAlJXjZPYldi2az9Qu653H2U8MePtNU=;
        b=vCF3K3qxNZ8M4EvLZI71SQFts1G2FkTQPKm+PUx9DYaMDTq6thHqripzyrg/YPV+Z1
         e4FOXjveAwKK9Mjg0gmRpGyVBU1shqoyrOpk6FVUCGeMOVTBat09hg4IQhmOBaUHdCIl
         6uzYyrm3f+1m4XwH/Zaisnk3lXwV1qb4EpYfw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=CyO/ZbAzI5o83/2Bx00/AJlyXUps/9tixAMWrQIHhuXzqpvdXLgV38KcdBbPn8LY6T
         6hd+0brwYBnEXmHCXJWElEEC8BoiSmpljdrqtAjy6m1as8V06kC40CQng2hK5kyL7YXG
         qyXnWsH6mlJCqKpA/7erG0LcA3o7uvOr/ac1s=
Received: by 10.143.26.10 with SMTP id d10mr654133wfj.136.1265370627139;
        Fri, 05 Feb 2010 03:50:27 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.235.86])
        by mx.google.com with ESMTPS id 20sm1335721pzk.5.2010.02.05.03.50.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Feb 2010 03:50:26 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri,  5 Feb 2010 18:47:50 +0700
X-Mailer: git-send-email 1.7.0.rc0.54.gd33ef
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139043>

When GIT_DIR environment variable is not specified, .git will be
searched if a repository is needed. Currently this can be done in two
places: setup_git_directory_gently() and setup_git_env().

The one in setup_git_env() is no longer correct and should IMHO have
been removed since the introduction of setup_git_directory_gently() in
d288a70. Having two ways of auto detection may lead to obscure errors
because .git may be misdetected by setup_git_env(),
automatically called via git_path(), which is all over the place.

This patch makes setup_git_env() die if GIT_DIR is not explictly
set. That's setup_git_directory_gently()'s job. If you ever want to
touch things inside $GIT_DIR, you should have already called
setup_git_directory_gently().

This patch breaks commands (in a good way) and obviously not for
mainline. I still have to go through "make test" to see how many are
impacted. But I think this is a good change. Am I missing something?

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 environment.c |    4 +---
 setup.c       |    4 +++-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/environment.c b/environment.c
index 739ec27..b609569 100644
--- a/environment.c
+++ b/environment.c
@@ -67,9 +67,7 @@ static void setup_git_env(void)
 {
 	git_dir =3D getenv(GIT_DIR_ENVIRONMENT);
 	if (!git_dir)
-		git_dir =3D read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
-	if (!git_dir)
-		git_dir =3D DEFAULT_GIT_DIR_ENVIRONMENT;
+		die("GIT_DIR not properly set");
 	git_object_dir =3D getenv(DB_ENVIRONMENT);
 	if (!git_object_dir) {
 		git_object_dir =3D xmalloc(strlen(git_dir) + 9);
diff --git a/setup.c b/setup.c
index 710e2f3..ae1ba52 100644
--- a/setup.c
+++ b/setup.c
@@ -396,8 +396,10 @@ const char *setup_git_directory_gently(int *nongit=
_ok)
 				die("Repository setup failed");
 			break;
 		}
-		if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
+		if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT)) {
+			set_git_dir(DEFAULT_GIT_DIR_ENVIRONMENT);
 			break;
+		}
 		if (is_git_directory(".")) {
 			inside_git_dir =3D 1;
 			if (!work_tree_env)
--=20
1.7.0.rc0.54.gd33ef
