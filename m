From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v2] builtin/commit.c: memoize git-path for COMMIT_EDITMSG
Date: Wed, 25 May 2016 00:49:50 +0530
Message-ID: <20160524191950.21889-1-pranit.bauva@gmail.com>
References: <1464027390-1512-1-git-send-email-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, larsxschneider@gmail.com,
	chriscool@tuxfamily.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 21:23:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5Hv4-0001FX-8C
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 21:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbcEXTW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 15:22:58 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35664 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932073AbcEXTW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 15:22:56 -0400
Received: by mail-pf0-f193.google.com with SMTP id f144so3063687pfa.2
        for <git@vger.kernel.org>; Tue, 24 May 2016 12:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c6L1bSjXIVR9QAdPTtnqBljjViXkMUqBYI57eRbZH9A=;
        b=0fUb7BXwVOQDsaU+g8nRYMxjMP0pLNaLYcvDHyjD/zF+W8e2Gs90vRdad8zLz82c7R
         hqofLP7x92gYJMoX+Uf5fiFuAqyRxWLDY2xjHfSyoNTa/R4L4es7iPwQZz6jYcnu2PfJ
         FJSkcHauY5ZJ7CA4PEdgmeQos349etT7zn+Tobum6CKLxh+25Ey2G8CJIMUu6W5D85+d
         Ezz5ynIdEyjn80EIhYnny76k8JYlS70r4KT3IDhX7siCzKBqujGuiSbpiFKGc5Gpgr0d
         zSpXNhdqCaaBgDzeaPj/MixuzjI8xpNSmTkVU8XX4mTIYuqVVEGb2383Io1XPd+WcSke
         fbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c6L1bSjXIVR9QAdPTtnqBljjViXkMUqBYI57eRbZH9A=;
        b=mq05QMWFzkCkodgc1UMyh8xyIsqsmEg0Rby5AbvO3Tg8dshHyeWu94Ef3fZRN5I3lz
         8MgyTaWBxGnyLI/fKsCZ6jMhJd/ak5YpycDTpl7j9zsEgSaIM2PjE16SM9y5sm2G5Xe8
         q0FkNJcaRv/hMxcsLz21FWPQXfzA8g0c3O30RgvJDmkL8ekfJ5B2fbUF/C0JmEOnL0Dm
         XNVLrjBPhvZYb3mcJGiYTHRMbyip2AbLVfzx1hGaAzH8tanD6yDN8bS7v9YHcpIK0hvh
         Yq8M73CgbOOci7pWPf1yNHBwfIUIryDV0gkQIPN3nPCkOB22GaFXTS2rIV9X5JdqW3iA
         LOBQ==
X-Gm-Message-State: ALyK8tIuy6DJX0ZQe1IBqgyFTccq45ZKgpJ81WbXE1Wfxbp0RSYGc91ltpm3Jdfa0yVDMw==
X-Received: by 10.98.30.132 with SMTP id e126mr9529088pfe.109.1464117775205;
        Tue, 24 May 2016 12:22:55 -0700 (PDT)
Received: from localhost.localdomain ([183.87.140.254])
        by smtp.gmail.com with ESMTPSA id n78sm15774612pfi.79.2016.05.24.12.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 12:22:54 -0700 (PDT)
X-Mailer: git-send-email 2.8.3
In-Reply-To: <1464027390-1512-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295524>

This is a follow up commit for f932729c (memoize common git-path
"constant" files, 10-Aug-2015).

The many function calls to git_path() are replaced by
git_path_commit_editmsg() and which thus eliminates the need to repeatedly
compute the location of "COMMIT_EDITMSG".

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
Link for v1[1].

Changes wrt v1:

 * Remove the call to git_path_commit_editmsg() which would directly assign
   the value to the string.
 * Remove the string commit_editmsg[] as it is redundant now.
 * Call git_path_commit_editmsg() everytime when it is needed.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/295345

 builtin/commit.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 391126e..01b921f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -92,8 +92,9 @@ N_("If you wish to skip this commit, use:\n"
 "Then \"git cherry-pick --continue\" will resume cherry-picking\n"
 "the remaining commits.\n");
 
+static GIT_PATH_FUNC(git_path_commit_editmsg, "COMMIT_EDITMSG")
+
 static const char *use_message_buffer;
-static const char commit_editmsg[] = "COMMIT_EDITMSG";
 static struct lock_file index_lock; /* real index */
 static struct lock_file false_lock; /* used only for partial commits */
 static enum {
@@ -771,9 +772,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		hook_arg2 = "";
 	}
 
-	s->fp = fopen_for_writing(git_path(commit_editmsg));
+	s->fp = fopen_for_writing(git_path_commit_editmsg());
 	if (s->fp == NULL)
-		die_errno(_("could not open '%s'"), git_path(commit_editmsg));
+		die_errno(_("could not open '%s'"), git_path_commit_editmsg());
 
 	/* Ignore status.displayCommentPrefix: we do need comments in COMMIT_EDITMSG. */
 	old_display_comment_prefix = s->display_comment_prefix;
@@ -950,7 +951,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	}
 
 	if (run_commit_hook(use_editor, index_file, "prepare-commit-msg",
-			    git_path(commit_editmsg), hook_arg1, hook_arg2, NULL))
+			    git_path_commit_editmsg(), hook_arg1, hook_arg2, NULL))
 		return 0;
 
 	if (use_editor) {
@@ -958,7 +959,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		const char *env[2] = { NULL };
 		env[0] =  index;
 		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
-		if (launch_editor(git_path(commit_editmsg), NULL, env)) {
+		if (launch_editor(git_path_commit_editmsg(), NULL, env)) {
 			fprintf(stderr,
 			_("Please supply the message using either -m or -F option.\n"));
 			exit(1);
@@ -966,7 +967,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	}
 
 	if (!no_verify &&
-	    run_commit_hook(use_editor, index_file, "commit-msg", git_path(commit_editmsg), NULL)) {
+	    run_commit_hook(use_editor, index_file, "commit-msg", git_path_commit_editmsg(), NULL)) {
 		return 0;
 	}
 
@@ -1728,7 +1729,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	/* Finally, get the commit message */
 	strbuf_reset(&sb);
-	if (strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0) {
+	if (strbuf_read_file(&sb, git_path_commit_editmsg(), 0) < 0) {
 		int saved_errno = errno;
 		rollback_index_files();
 		die(_("could not read commit message: %s"), strerror(saved_errno));
-- 
2.8.3
