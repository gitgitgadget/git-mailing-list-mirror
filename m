From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 0/2] Fix relative path issues in recursive submodules.
Date: Thu, 31 Mar 2016 17:17:27 -0700
Message-ID: <1459469849-9643-1-git-send-email-sbeller@google.com>
Cc: norio.nomura@gmail.com, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org, sunshine@sunshineco.com,
	jacob.keller@gmail.com
X-From: git-owner@vger.kernel.org Fri Apr 01 02:17:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1almmP-00089C-Qz
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 02:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752AbcDAARd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 20:17:33 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35748 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424AbcDAARc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 20:17:32 -0400
Received: by mail-pf0-f172.google.com with SMTP id n5so80781981pfn.2
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 17:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=b6QwpKmRPwmKnnmrZz+kxGR2XfOEXHqmv4nd8wfupxI=;
        b=nAk2/xIzBiYLGPhg8mTerHNMjLcJy0wYcBr0XXB8QF7h4K8+U3TdgRXVPUcuWcgeAW
         huTNGzRb6XUESDjRV57mbgd02UsdowALUQhC7rJXQfq3tYWT9PD5g/gSZLvaFVxsfCu6
         OsQ6PvJM1+Bt2a7Jga9JR2oQz/5rWAR1OBrdK+K//AMxlj4ZwtetScS1x8nGdVi7jjDA
         h8yjjRllg97T6Q5fN1axbehQJrpUwU9bWWEEREZTi2cd/6t3IxmCD3eKIs/apB/3megD
         sknvVIqvyt8MhvrDHX+8Upk4a8oFez6TqaKP2qyoBO4+oJqbBoCS/+Zmb4QZYeVahLLG
         VtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b6QwpKmRPwmKnnmrZz+kxGR2XfOEXHqmv4nd8wfupxI=;
        b=fdsRzqFWgpoYSbW/1Xw5to7Foc6aPw+x+jWnteWQpndi/aEjbW35X8IZl8p3LOawwz
         gBtORWii0emDFFExoXb9VGhN2De/b59K1JxeaMicFEaOIpI4I2e+vsbkqT2NxWIK//UF
         TSgLG8nGpsaGmxyTvW3gEE+umu6yHGPdF8b+ofewm531DpZB1w8y9LWf2VeAfOc0dUor
         lCxiB/v0LUe9xyR9Qx91PYCSBl4ZhNcZizC86LfPysMFZS+sKjs8G9WWMVoJKEnpOrl4
         Gb+Ajh4h3Lzl0vAu6LC6ch/YblHLbu+rtvQfyhsJcKyz/CxAe4uGr4u7YD/5xCpqWOeH
         1XWg==
X-Gm-Message-State: AD7BkJLcvfjy5tXF0+nRoEhzzNCDw/7DSeYTfaKV7+ekz12H521e66QlnPQNdhYMIlZ2hqEw
X-Received: by 10.98.76.22 with SMTP id z22mr5238928pfa.78.1459469851593;
        Thu, 31 Mar 2016 17:17:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:a519:64be:5369:a180])
        by smtp.gmail.com with ESMTPSA id ey7sm15929256pab.47.2016.03.31.17.17.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 31 Mar 2016 17:17:30 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.gc776916.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290491>

Thanks Junio for review!

v3:
 * This is a resend of the last two patches of the series, i.e. it replaces
   44859d6626d4 and efdef1e2e in sb/submodule-helper-clone-regression-fix
  
 * use absolute_path for sm_gitdir
 * removed todo
 * we need to free the intermediate sm_gitdir, so rename that to sm_gitdir_rel
   and free it afterwards.
 * while we currently do not support an absolute `path`, we eventually might.
   If `path` is absolute it would be a pointer to `argv`, which would lead to a
   crash. Duplicate the path and the crash is prevented.
 (* I thought we could use it as well for `path`, but we cannot; as 
   get_git_work_tree() != cwd)
 * diff to sb/submodule-helper-clone-regression-fix:

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 89cbbda..be7bf5f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -153,12 +153,13 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
 
 static int module_clone(int argc, const char **argv, const char *prefix)
 {
-	const char *path = NULL, *name = NULL, *url = NULL;
+	const char *name = NULL, *url = NULL;
 	const char *reference = NULL, *depth = NULL;
 	int quiet = 0;
 	FILE *submodule_dot_git;
-	char *sm_gitdir, *p;
-	struct strbuf rel_path = STRBUF_INIT; /* for relative_path */
+	char *sm_gitdir_rel, *p, *path = NULL;
+	const char *sm_gitdir;
+	struct strbuf rel_path = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
 
 	struct option module_clone_options[] = {
@@ -198,26 +199,14 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		die(_("submodule--helper: unspecified or empty --path"));
 
 	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
-	sm_gitdir = strbuf_detach(&sb, NULL);
-
-
-	if (!is_absolute_path(sm_gitdir)) {
-		char *cwd = xgetcwd();
-		strbuf_addf(&sb, "%s/%s", cwd, sm_gitdir);
-		sm_gitdir = strbuf_detach(&sb, 0);
-		free(cwd);
-	}
+	sm_gitdir_rel = strbuf_detach(&sb, NULL);
+	sm_gitdir = absolute_path(sm_gitdir_rel);
 
 	if (!is_absolute_path(path)) {
-		/*
-		 * TODO: add prefix here once we allow calling from non root
-		 * directory?
-		 */
-		strbuf_addf(&sb, "%s/%s",
-			    get_git_work_tree(),
-			    path);
+		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), path);
 		path = strbuf_detach(&sb, 0);
-	}
+	} else
+		path = xstrdup(path);
 
 	if (!file_exists(sm_gitdir)) {
 		if (safe_create_leading_directories_const(sm_gitdir) < 0)
@@ -240,6 +229,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	submodule_dot_git = fopen(sb.buf, "w");
 	if (!submodule_dot_git)
 		die_errno(_("cannot open file '%s'"), sb.buf);
+
 	fprintf_or_die(submodule_dot_git, "gitdir: %s\n",
 		       relative_path(sm_gitdir, path, &rel_path));
 	if (fclose(submodule_dot_git))
@@ -255,8 +245,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 			       relative_path(path, sm_gitdir, &rel_path));
 	strbuf_release(&sb);
 	strbuf_release(&rel_path);
-	free(sm_gitdir);
-
+	free(sm_gitdir_rel);
+	free(path);
 	free(p);
 	return 0;
 }

v2:
 * reworded commit message for test (Thanks Junio!)
 * instead of "simplifying" the path handling in patch 2, we are prepared
   for anything the user throws at us (i.e. instead of segfault we
       die(_("submodule--helper: unspecified or empty --path"));
   (Thanks Eric, Jacob for pushing back here!)
 * reword commit message for patch 3 (safe_create_leading_directories_const is
   not a check, Thanks Junio!)
 * patch 4 (the fix): That got reworked completely. No flow controlling
   conditions in the write out phase!
 * patch 5 is a bonus! (replace fprintf by fprintf_or die) When implementing
   that I wondered if we also have close_or_die and open_or_die, but that doesn't
   seem to be the case.

Thanks,
Stefan

v1:

It took me longer than expected to fix this bug.

It comes with a test and minor refactoring and applies on top of
origin/sb/submodule-helper, such that it can be merged into 2.7, 2.8 as well
as master.

Patch 1 is a test which fails; it has a similar layout as the
real failing repository Norio Nomura pointed out, but simplified to the
bare essentials for reproduction of the bug.

Patch 2&3 are not strictly necessary for fixing the isseu, but it removes
stupid code I wrote, so the resulting code looks a little better.

Patch 4 fixes the issue by giving more information to relative_path,
such that a relative path can be found in all cases.

Thanks,
Stefan

Stefan Beller (2):
  submodule--helper, module_clone: always operate on absolute paths
  submodule--helper, module_clone: catch fprintf failure

 builtin/submodule--helper.c | 32 ++++++++++++++------------------
 t/t7400-submodule-basic.sh  |  2 +-
 2 files changed, 15 insertions(+), 19 deletions(-)

-- 
2.5.0.262.g0ef869b.dirty
