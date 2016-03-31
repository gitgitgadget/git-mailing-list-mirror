From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/4] submodule--helper: use relative path if possible
Date: Wed, 30 Mar 2016 17:17:37 -0700
Message-ID: <1459383457-6848-5-git-send-email-sbeller@google.com>
References: <1459383457-6848-1-git-send-email-sbeller@google.com>
Cc: norio.nomura@gmail.com, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 02:18:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alQJD-00054y-L5
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 02:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905AbcCaARx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 20:17:53 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33368 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbcCaARt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 20:17:49 -0400
Received: by mail-pa0-f49.google.com with SMTP id zm5so52627407pac.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 17:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bSC3Y0v3zg3a/In1Y/o8DpGBbNqYqUzmlm+bV/bqWFs=;
        b=memfqVtYA1y4QtcBlu33w5ZGZ05QsgOjceU0bv6vPynYIEMXkC9qXbKiHuiPvpE6Ff
         +nL4gKjh3jrQf3hB78AlKQUv8Fi3uaT65fw/LYX7xqMqsxhoYd/lGACzoWVm/KxAIULH
         TIshOcNtqXuffIns98tNjPQ+hFpq/X/jTIrBp3sAVz9LnRittaquKT4XFFf7Q6I7djUC
         B43lAfkpJJWc/uJf4CyhHLhAZu0OqxYzXcUxMW6H/fDS8hyLkB0HpNYRn/fql/mgixZp
         XQTyaNI9iVdUIOLeKc0LbZ7+axPdqBdPnuoPQJ/4TqY8g45VNgeyMWjCn6QLcyJur7jb
         t2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bSC3Y0v3zg3a/In1Y/o8DpGBbNqYqUzmlm+bV/bqWFs=;
        b=WPFKVhSfzetxfowK4BEIuNkdAUx7zxjgpvXIUqZZiJTwrf7Xn1082lrRqn8x/euJHL
         66Fo8OWGXLQqpaL335HIszWRBOSlxNx0vTRdSOVj9qI1zFcMTmllnb9qy+4kghBczyOT
         zuIC2uKVpiXiIKBu1jEs/c1ChLJP4JLbTB3L7YGUMwisa8O/e1XamT/1GcI9f/6OTfhY
         kEPwziPmTcwoxPRwKjeUUGT+K2xKl01a7uiv5pX9Lxeept9b/UA5ZY6Sa7yaus1V5Nvf
         UI5UiGFwTTVDYe7iKTHuyhAGSXKTEybmenOxrUuswMWqZ5j6HYI7UKsvV6DJEVl3aHPU
         m7Jg==
X-Gm-Message-State: AD7BkJI/oPZUk7bOQW2+rYN3hwKqpBXiMHaXyU+SpU9GwCFa5H6A5ouWSXOtchaaA3/P+uUc
X-Received: by 10.66.122.66 with SMTP id lq2mr2226031pab.155.1459383469152;
        Wed, 30 Mar 2016 17:17:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:30b6:9b24:6e56:d07e])
        by smtp.gmail.com with ESMTPSA id e87sm8486742pfb.76.2016.03.30.17.17.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Mar 2016 17:17:48 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g4004fdc.dirty
In-Reply-To: <1459383457-6848-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290362>

As submodules have working directory and their git directory far apart
relative_path(gitdir, work_dir) will not produce a relative path when
git_dir is absolute. When the gitdir is absolute, we need to convert
the workdir to an absolute path as well to compute the relative path.

(e.g. gitdir=/home/user/project/.git/modules/submodule,
workdir=submodule/, relative_dir doesn't take the current working directory
into account, so there is no way for it to know that the correct answer
is indeed "../.git/modules/submodule", if the workdir was given as
/home/user/project/submodule, the answer is obvious.)

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 7 +++++++
 t/t7400-submodule-basic.sh  | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 914e561..0b0fad3 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -159,6 +159,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	FILE *submodule_dot_git;
 	char *sm_gitdir, *cwd, *p;
 	struct strbuf rel_path = STRBUF_INIT;
+	struct strbuf abs_path = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
 
 	struct option module_clone_options[] = {
@@ -219,7 +220,12 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	if (!submodule_dot_git)
 		die_errno(_("cannot open file '%s'"), sb.buf);
 
+	strbuf_addf(&abs_path, "%s/%s",
+		    get_git_work_tree(),
+		    path);
 	fprintf(submodule_dot_git, "gitdir: %s\n",
+		is_absolute_path(sm_gitdir) ?
+		relative_path(sm_gitdir, abs_path.buf, &rel_path) :
 		relative_path(sm_gitdir, path, &rel_path));
 	if (fclose(submodule_dot_git))
 		die(_("could not close file %s"), sb.buf);
@@ -242,6 +248,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 			       relative_path(sb.buf, sm_gitdir, &rel_path));
 	strbuf_release(&sb);
 	strbuf_release(&rel_path);
+	strbuf_release(&abs_path);
 	free(sm_gitdir);
 	free(cwd);
 	free(p);
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
2.5.0.264.g4004fdc.dirty
