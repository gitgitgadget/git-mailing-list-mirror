From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 4/5] submodule--helper, module_clone: always operate on absolute paths
Date: Thu, 31 Mar 2016 14:04:39 -0700
Message-ID: <1459458280-17619-5-git-send-email-sbeller@google.com>
References: <1459458280-17619-1-git-send-email-sbeller@google.com>
Cc: sunshine@sunshineco.com, jacob.keller@gmail.com,
	norio.nomura@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 31 23:05:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aljm3-0008WL-81
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 23:05:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933222AbcCaVEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 17:04:51 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36814 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932457AbcCaVEt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 17:04:49 -0400
Received: by mail-pa0-f41.google.com with SMTP id tt10so74054097pab.3
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 14:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2KAYyiiWNuKjXMoa4G5+bR8NsLx+SSNA6NVZZ5bkjP4=;
        b=QytFWtBq2deA5N4UCJ1XUKskdKD0YdAE3Wnh3XOV2/dGzPIh1fJL6diSX2SiXcDRJ5
         E75ZhVYcDnjWykoSfW6eAiHpb23GvfwCatReb8mWnH3l2Zr4xZCOpZNnsumMvqhg02AX
         lWpGMmDV5FPI4wstdgtVbqMgSVs5o5b7NDOhjJgvTgq9SbkzY+fx2YnzvAYXZTaWLuii
         G4++h0cAZ7gvmEkpzfw5H9LxM1NQTUTMSJcMqpkZ5jV+dD6mJfw4KsV2TvcbuhDu83Q0
         wIBgA8ADl7KRz4xiVHGmSlek0NQ9Vyp6gfLJqHeUehyNm+6O9wW6FkT/Aa/KFWVtEZBC
         fPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2KAYyiiWNuKjXMoa4G5+bR8NsLx+SSNA6NVZZ5bkjP4=;
        b=aiXq0rgAd3EHEqYSyjm8TnUqmEXptxNvKsKYhwk0XhwT/uj4y3BmOOCkjCmXHMnPu4
         tlpi/9NhhF2yiKRfGzED88yHL6pzlCDIzxr1vFRSsSOTH9SJn80x1ATUulUQoimXGBBP
         UeEekjmT3MCyT6yOWPyDBKXar+QZI2VgvFlmcUtMOeFahpZLBUurz7R/4zIaxfidv/IA
         +d3IB1lPT91BTfDzjCrA7ghe8QDmEXndG3GmghR/LwZJz33HePhwlC9HnU1BwABKBEk4
         bqEdleJmvNI1Sn8gtsO02/XI6ZQmAAgcf378bNl8VZdaVtcUQUgNvYZv3q0+xbOFFeS7
         +1Jw==
X-Gm-Message-State: AD7BkJJWVkWJGLWerbH0TfOWbXgoWkM+JhZ3nHXpnoh4qtr7mYK8EG8vKHzdpPpX1gqqEn/5
X-Received: by 10.66.231.100 with SMTP id tf4mr25188609pac.44.1459458288462;
        Thu, 31 Mar 2016 14:04:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:30b6:9b24:6e56:d07e])
        by smtp.gmail.com with ESMTPSA id fw9sm15524761pac.21.2016.03.31.14.04.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 31 Mar 2016 14:04:47 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g39f00fe
In-Reply-To: <1459458280-17619-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290471>

When giving relative paths to `relative_path` to compute a relative path
from one directory to another, this may fail in `relative_path`.
Make sure both arguments to `relative_path` are always absolute.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    Notice how the 2 relative path calls
      relative_path(sm_gitdir, path, &rel_path)
      relative_path(path, sm_gitdir, &rel_path)
    now have the same arguments, just switched?
    The symmetry there looks nice to read.
    
    This proposal is slightly more code than the previous patch,
    but looking at the end result

 builtin/submodule--helper.c | 36 +++++++++++++++++++++++-------------
 t/t7400-submodule-basic.sh  |  2 +-
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0b9f546..56c3033 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -157,8 +157,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	const char *reference = NULL, *depth = NULL;
 	int quiet = 0;
 	FILE *submodule_dot_git;
-	char *sm_gitdir, *cwd, *p;
-	struct strbuf rel_path = STRBUF_INIT;
+	char *sm_gitdir, *p;
+	struct strbuf rel_path = STRBUF_INIT; /* for relative_path */
 	struct strbuf sb = STRBUF_INIT;
 
 	struct option module_clone_options[] = {
@@ -200,6 +200,25 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
 	sm_gitdir = strbuf_detach(&sb, NULL);
 
+
+	if (!is_absolute_path(sm_gitdir)) {
+		char *cwd = xgetcwd();
+		strbuf_addf(&sb, "%s/%s", cwd, sm_gitdir);
+		sm_gitdir = strbuf_detach(&sb, 0);
+		free(cwd);
+	}
+
+	if (!is_absolute_path(path)) {
+		/*
+		 * TODO: add prefix here once we allow calling from non root
+		 * directory?
+		 */
+		strbuf_addf(&sb, "%s/%s",
+			    get_git_work_tree(),
+			    path);
+		path = strbuf_detach(&sb, 0);
+	}
+
 	if (!file_exists(sm_gitdir)) {
 		if (safe_create_leading_directories_const(sm_gitdir) < 0)
 			die(_("could not create directory '%s'"), sm_gitdir);
@@ -221,7 +240,6 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	submodule_dot_git = fopen(sb.buf, "w");
 	if (!submodule_dot_git)
 		die_errno(_("cannot open file '%s'"), sb.buf);
-
 	fprintf(submodule_dot_git, "gitdir: %s\n",
 		relative_path(sm_gitdir, path, &rel_path));
 	if (fclose(submodule_dot_git))
@@ -229,24 +247,16 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	strbuf_reset(&sb);
 	strbuf_reset(&rel_path);
 
-	cwd = xgetcwd();
 	/* Redirect the worktree of the submodule in the superproject's config */
-	if (!is_absolute_path(sm_gitdir)) {
-		strbuf_addf(&sb, "%s/%s", cwd, sm_gitdir);
-		free(sm_gitdir);
-		sm_gitdir = strbuf_detach(&sb, NULL);
-	}
-
-	strbuf_addf(&sb, "%s/%s", cwd, path);
 	p = git_pathdup_submodule(path, "config");
 	if (!p)
 		die(_("could not get submodule directory for '%s'"), path);
 	git_config_set_in_file(p, "core.worktree",
-			       relative_path(sb.buf, sm_gitdir, &rel_path));
+			       relative_path(path, sm_gitdir, &rel_path));
 	strbuf_release(&sb);
 	strbuf_release(&rel_path);
 	free(sm_gitdir);
-	free(cwd);
+
 	free(p);
 	return 0;
 }
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index fc11809..ea3fabb 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -818,7 +818,7 @@ test_expect_success 'submodule add --name allows to replace a submodule with ano
 	)
 '
 
-test_expect_failure 'recursive relative submodules stay relative' '
+test_expect_success 'recursive relative submodules stay relative' '
 	test_when_finished "rm -rf super clone2 subsub sub3" &&
 	mkdir subsub &&
 	(
-- 
2.5.0.264.g39f00fe
