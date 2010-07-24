From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/9] setup: split off $GIT_DIR-set case from
 setup_git_directory_gently
Date: Sat, 24 Jul 2010 06:19:44 -0500
Message-ID: <20100724111944.GC16054@burratino>
References: <1279886651-14590-1-git-send-email-pclouds@gmail.com>
 <20100724111505.GC7150@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 13:20:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Occmg-00046H-Ps
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 13:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754621Ab0GXLUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 07:20:46 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62460 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754554Ab0GXLUp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 07:20:45 -0400
Received: by iwn7 with SMTP id 7so1094321iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 04:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=CztbsVc2g5ViMfFzbULvYlwVQQrb7XhAiKUtIIh/dc8=;
        b=ew+sl2p/1G6RrKnuYa1FHGdCz2luWR+Lyn925tH5vEegmP578iZUTIPEB7Jg/f+E0d
         C9bSEmbr8eve2abkOgIyBIBAXY9KC2UZNf6pxPUf5pY0hMDRgAvSzcB+KMpEN7LbxVVh
         nTMBRaKN9kya5Au3ROsuVQCAJvW0G6X5z5eUE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fJMzdzOBJPW8AHlmCiKcjNvrN0y5z1ucGpTVGaCzAXBGKvl5nQJx6sVu2vBqVJtXRu
         3p1Wfp3WB6TT9qNGg36XlRSpzLmjWqDkvs2L3FQC37KNnOfFp5JdLowKTOSfm87IRz7C
         d39eHW4DlKBsz+OoncLER7Aq9ZbrEofdQm4sU=
Received: by 10.231.177.25 with SMTP id bg25mr4971824ibb.154.1279970445115;
        Sat, 24 Jul 2010 04:20:45 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h8sm1248432ibk.21.2010.07.24.04.20.44
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 04:20:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100724111505.GC7150@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151614>

If $GIT_DIR is set, setup_git_directory_gently does not have
to do any repository discovery at all.  Split off a function
for the validation it still does do, in the hope that this will
make setup_git_directory_gently proper less daunting to read.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 setup.c |   69 +++++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/setup.c b/setup.c
index 2769160..16bee6d 100644
--- a/setup.c
+++ b/setup.c
@@ -313,6 +313,41 @@ const char *read_gitfile_gently(const char *path)
 	return path;
 }
 
+static const char *setup_explicit_git_dir(const char *gitdirenv,
+				const char *work_tree_env, int *nongit_ok)
+{
+	static char buffer[1024 + 1];
+	const char *retval;
+
+	if (PATH_MAX - 40 < strlen(gitdirenv))
+		die("'$%s' too big", GIT_DIR_ENVIRONMENT);
+	if (!is_git_directory(gitdirenv)) {
+		if (nongit_ok) {
+			*nongit_ok = 1;
+			return NULL;
+		}
+		die("Not a git repository: '%s'", gitdirenv);
+	}
+	if (!work_tree_env) {
+		retval = set_work_tree(gitdirenv);
+		/* config may override worktree */
+		if (check_repository_format_gently(nongit_ok))
+			return NULL;
+		return retval;
+	}
+	if (check_repository_format_gently(nongit_ok))
+		return NULL;
+	retval = get_relative_cwd(buffer, sizeof(buffer) - 1,
+			get_git_work_tree());
+	if (!retval || !*retval)
+		return NULL;
+	set_git_dir(make_absolute_path(gitdirenv));
+	if (chdir(work_tree_env) < 0)
+		die_errno ("Could not chdir to '%s'", work_tree_env);
+	strcat(buffer, "/");
+	return retval;
+}
+
 /*
  * We cannot decide in this function whether we are in the work tree or
  * not, since the config can only be read _after_ this function was called.
@@ -343,38 +378,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	 * validation.
 	 */
 	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
-	if (gitdirenv) {
-		if (PATH_MAX - 40 < strlen(gitdirenv))
-			die("'$%s' too big", GIT_DIR_ENVIRONMENT);
-		if (is_git_directory(gitdirenv)) {
-			static char buffer[1024 + 1];
-			const char *retval;
-
-			if (!work_tree_env) {
-				retval = set_work_tree(gitdirenv);
-				/* config may override worktree */
-				if (check_repository_format_gently(nongit_ok))
-					return NULL;
-				return retval;
-			}
-			if (check_repository_format_gently(nongit_ok))
-				return NULL;
-			retval = get_relative_cwd(buffer, sizeof(buffer) - 1,
-					get_git_work_tree());
-			if (!retval || !*retval)
-				return NULL;
-			set_git_dir(make_absolute_path(gitdirenv));
-			if (chdir(work_tree_env) < 0)
-				die_errno ("Could not chdir to '%s'", work_tree_env);
-			strcat(buffer, "/");
-			return retval;
-		}
-		if (nongit_ok) {
-			*nongit_ok = 1;
-			return NULL;
-		}
-		die("Not a git repository: '%s'", gitdirenv);
-	}
+	if (gitdirenv)
+		return setup_explicit_git_dir(gitdirenv, work_tree_env, nongit_ok);
 
 	if (!getcwd(cwd, sizeof(cwd)-1))
 		die_errno("Unable to read current working directory");
-- 
1.7.2.rc3.593.g19611.dirty
