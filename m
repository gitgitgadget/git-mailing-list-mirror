From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/7] unset: discard GIT_WORK_TREE if GIT_DIR is not set
Date: Wed, 27 Oct 2010 21:58:11 +0700
Message-ID: <1288191496-31176-2-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:58:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7SX-0002wu-Sg
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761046Ab0J0O6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 10:58:31 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:48504 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761017Ab0J0O62 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:58:28 -0400
Received: by mail-gx0-f174.google.com with SMTP id 23so433771gxk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=FG4pnTu2RtUD9IiT0N67UgSQX1jGbzhwaZRv8zQvUt8=;
        b=XJfbG2qE0Iyq2vHxMjHkRG0pwxFhXzLIoO9BBrWBEFN43hAwtc8WLRDpn8dDx4QA8v
         t3i1i32f8tLxFoeD1Ap78BbSYPsF9NX/R5kKrU5FqoXCoWczcxWUsCjYh7pg0ZIVPJoJ
         xtcd1kVdq68VeDO7Shg1vKXtPBFibq+DXs5DY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=P8QQy4CC/o/mtwbfGjWVyi04aur9C4ago0K8uzkptlZMDkfTFn4TinAUuAYx98/GQv
         3DmGBO0tJK9DeCCXipqvjtf5HDcdZybKUoTZJrwW+6frQbAQAEwCt+3IXdHaWm061TU6
         LsXTF9Dm+JzTYRFYcD3BSh5CswVaSx0YmMl/E=
Received: by 10.90.16.18 with SMTP id 18mr1065850agp.166.1288191508310;
        Wed, 27 Oct 2010 07:58:28 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id z10sm11927551anj.14.2010.10.27.07.58.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:58:27 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:58:26 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160077>

GIT_WORK_TREE can only be used together with GIT_DIR. Unfortunately
get_git_work_tree() checks that env variable unconditionally. As a
work around, discard the variable.
---
 setup.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/setup.c b/setup.c
index 2e7387d..992a944 100644
--- a/setup.c
+++ b/setup.c
@@ -364,14 +364,12 @@ static int cwd_contains_git_dir(const char **gitfile_dirp)
 	return is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT);
 }
 
-static const char *setup_discovered_git_dir(const char *work_tree_env,
-		int offset, int len, char *cwd, int *nongit_ok)
+static const char *setup_discovered_git_dir(int offset, int len, char *cwd, int *nongit_ok)
 {
 	int root_len;
 
 	inside_git_dir = 0;
-	if (!work_tree_env)
-		inside_work_tree = 1;
+	inside_work_tree = 1;
 	root_len = offset_1st_component(cwd);
 	git_work_tree_cfg = xstrndup(cwd, offset > root_len ? offset : root_len);
 	if (check_repository_format_gently(nongit_ok))
@@ -386,14 +384,12 @@ static const char *setup_discovered_git_dir(const char *work_tree_env,
 	return cwd + offset;
 }
 
-static const char *setup_bare_git_dir(const char *work_tree_env,
-		int offset, int len, char *cwd, int *nongit_ok)
+static const char *setup_bare_git_dir(int offset, int len, char *cwd, int *nongit_ok)
 {
 	int root_len;
 
 	inside_git_dir = 1;
-	if (!work_tree_env)
-		inside_work_tree = 0;
+	inside_work_tree = 0;
 	if (offset != len) {
 		if (chdir(cwd))
 			die_errno("Cannot come back to cwd");
@@ -457,6 +453,11 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
 	if (gitdirenv)
 		return setup_explicit_git_dir(gitdirenv, work_tree_env, nongit_ok);
+	else {
+		/* prevent get_git_work_tree() from using it because GIT_DIR is not set */
+		if (work_tree_env)
+			unsetenv(GIT_WORK_TREE_ENVIRONMENT);
+	}
 
 	if (!getcwd(cwd, sizeof(cwd)-1))
 		die_errno("Unable to read current working directory");
@@ -482,11 +483,9 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 		current_device = get_device_or_die(".", NULL);
 	for (;;) {
 		if (cwd_contains_git_dir(&gitfile_dir))
-			return setup_discovered_git_dir(work_tree_env, offset,
-							len, cwd, nongit_ok);
+			return setup_discovered_git_dir(offset, len, cwd, nongit_ok);
 		if (is_git_directory("."))
-			return setup_bare_git_dir(work_tree_env, offset,
-							len, cwd, nongit_ok);
+			return setup_bare_git_dir(offset, len, cwd, nongit_ok);
 		while (--offset > ceil_offset && cwd[offset] != '/');
 		if (offset <= ceil_offset)
 			return setup_nongit(cwd, nongit_ok);
-- 
1.7.0.2.445.gcbdb3
