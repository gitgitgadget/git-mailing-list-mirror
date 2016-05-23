From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH] builtin/commit.c: memoize git-path for COMMIT_EDITMSG
Date: Mon, 23 May 2016 23:46:30 +0530
Message-ID: <1464027390-1512-1-git-send-email-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, larsxschneider@gmail.com,
	chriscool@tuxfamily.org, christian.couder@gmail.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 20:17:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4uQH-0006At-Ff
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 20:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbcEWSRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 14:17:45 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33709 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbcEWSRo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 14:17:44 -0400
Received: by mail-pa0-f65.google.com with SMTP id f8so6834173pag.0
        for <git@vger.kernel.org>; Mon, 23 May 2016 11:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=8bZAG++/8HKAFVFc30J24pWehEfXf7M0D/SqxOTyvMo=;
        b=oGz59rGeJS6ZQ/d11sVsuu0tahxyAObJYuNo9dpQ916c9RZc0CL/UB3Md/mFrVzP0M
         Dvc8sjJ1wW7i7sAfq98p2JM6dq8W+I5PB4hXvsEEdL8IcYXfWnbzC6zu1v8FmytTlas5
         bFznFgSqkS5r4wHdj8h+0iNyZGTKd49xBE/WtBGveyw9255/tnQpauYwvFvkeXHrt+E5
         0C6Pq6oJkwL7Uw7AHAbEVBLMC4p/FKBVRnuPgM21wunEJ+dUPRuIRJVhL1iGgqtaWvap
         3/TeWe0m3zPKqWVRPXegHFFfz2p3FxWFOqBWXfPuQy9oYPemUP3qFkAWpPF2odtItily
         w5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8bZAG++/8HKAFVFc30J24pWehEfXf7M0D/SqxOTyvMo=;
        b=LCZEfGwbU84hPcZZdJVTaCpZD3JgE0SmsbWbj8QdErgxzaYztHkx4/7tSBHaIb9Xnn
         HeYejQpOmwTTuwD/JrccEBFfZOZ9X0xB094mg6pWcnapDXRayX6VnA1IOKNBa6qYjAzY
         YEB9B857K+7kv/EwgtGAtMFPKvbn/VsEGkqi6BMvHSPtp1yluVH76lpNmIPr0YUiI4QD
         UCUqejEavLnFElPK0RGWJX0sEvg5G7zznb13YhzTX2tuR1tGxWB4BGL+G5Lg96HlK7L/
         V4tpRx75j09kRbn8hprRlu9qzu7jfM1lJG041JyVltNrEE0wSV5Nz7OJzdpwvb+dljR/
         O/bQ==
X-Gm-Message-State: ALyK8tKTAXyFUlPCFpUoyiNOEcW1PKjB+295LsXTfFvsCt3dMbyP0POB/ByysIJ6gAjq3Q==
X-Received: by 10.66.7.69 with SMTP id h5mr285598paa.11.1464027463926;
        Mon, 23 May 2016 11:17:43 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id c190sm48287530pfb.33.2016.05.23.11.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 May 2016 11:17:43 -0700 (PDT)
X-Mailer: git-send-email 2.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295345>

This is a follow up commit for f932729c (memoize common git-path
"constant" files, 10-Aug-2015).

It serves two purposes:
  1. It reduces the number of calls to git_path() .

  2. It serves the benefits of using GIT_PATH_FUNC as mentioned in the
     commit message of f932729c.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/commit.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 391126e..ffa242c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -92,8 +92,10 @@ N_("If you wish to skip this commit, use:\n"
 "Then \"git cherry-pick --continue\" will resume cherry-picking\n"
 "the remaining commits.\n");
 
+static GIT_PATH_FUNC(git_path_commit_editmsg, "COMMIT_EDITMSG")
+
 static const char *use_message_buffer;
-static const char commit_editmsg[] = "COMMIT_EDITMSG";
+static const char commit_editmsg_path[] = git_path_commit_editmsg();
 static struct lock_file index_lock; /* real index */
 static struct lock_file false_lock; /* used only for partial commits */
 static enum {
@@ -771,9 +773,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		hook_arg2 = "";
 	}
 
-	s->fp = fopen_for_writing(git_path(commit_editmsg));
+	s->fp = fopen_for_writing(commit_editmsg_path);
 	if (s->fp == NULL)
-		die_errno(_("could not open '%s'"), git_path(commit_editmsg));
+		die_errno(_("could not open '%s'"), commit_editmsg_path);
 
 	/* Ignore status.displayCommentPrefix: we do need comments in COMMIT_EDITMSG. */
 	old_display_comment_prefix = s->display_comment_prefix;
@@ -950,7 +952,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	}
 
 	if (run_commit_hook(use_editor, index_file, "prepare-commit-msg",
-			    git_path(commit_editmsg), hook_arg1, hook_arg2, NULL))
+			    commit_editmsg_path, hook_arg1, hook_arg2, NULL))
 		return 0;
 
 	if (use_editor) {
@@ -958,7 +960,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		const char *env[2] = { NULL };
 		env[0] =  index;
 		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
-		if (launch_editor(git_path(commit_editmsg), NULL, env)) {
+		if (launch_editor(commit_editmsg_path, NULL, env)) {
 			fprintf(stderr,
 			_("Please supply the message using either -m or -F option.\n"));
 			exit(1);
@@ -966,7 +968,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	}
 
 	if (!no_verify &&
-	    run_commit_hook(use_editor, index_file, "commit-msg", git_path(commit_editmsg), NULL)) {
+	    run_commit_hook(use_editor, index_file, "commit-msg", commit_editmsg_path, NULL)) {
 		return 0;
 	}
 
@@ -1728,7 +1730,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	/* Finally, get the commit message */
 	strbuf_reset(&sb);
-	if (strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0) {
+	if (strbuf_read_file(&sb, commit_editmsg_path, 0) < 0) {
 		int saved_errno = errno;
 		rollback_index_files();
 		die(_("could not read commit message: %s"), strerror(saved_errno));
-- 
2.8.2
