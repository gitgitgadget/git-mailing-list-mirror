Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D205E20899
	for <e@80x24.org>; Wed,  2 Aug 2017 19:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbdHBTtq (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 15:49:46 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36610 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752535AbdHBTto (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 15:49:44 -0400
Received: by mail-pf0-f174.google.com with SMTP id z129so24956690pfb.3
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 12:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HNmm1jfYz8DG7sUu5WuDz+75UgMfAC7co4l8wczMaic=;
        b=eVkHUo1mVDlpjWCj2TJ6OWBkyG8Hh+qa43cdk4EzUD8sAs1o2C2MacQ3CAOShuV6cA
         lNBPf50G9lKbUnWEamlMJCyZT9h+EIgE+lvWFjMIBUoZ6LQFbMea34HRAZnqlP6bDoBy
         eKwDVgRx4vAMJEa2O4GLeEXvhmZaX8HF0I8MV/Wpcd5oqVJxGle3bb/vs1OfqdZoBDJm
         /2ZUvhdOwfFm+062OA5O02Daqfx0rvXGl2z8/uLBo4CnH2tVCPv12b6xrcJdC6z9rv04
         JR7Zm8y+9pbTd88dYCejorvEuStaYQGpjH+oc13KdSRsPiw3UE14N9q6Od6EY8Hs6R3P
         mnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HNmm1jfYz8DG7sUu5WuDz+75UgMfAC7co4l8wczMaic=;
        b=P88vsBTzoEviTQKQyttqx9TE96limDcaFzwdxs/L9VJvJkLup88CMhsuqjrdBPJ6ja
         Z093kSULPHVkCaiMd5K3J6V96aL5l2527Uqxg6ii0wsOL+MsJ1U7sv+q+zaPO2B9KAsJ
         T60suWuoFcEeYP/Z637/favFzL5A40lD0YZIjxqdpFxZrKze6hjjuRMipij/uR3Jmkzm
         aR2dCcsNlZshBjMTNXazOWhDtY0x+MbLwd7CdM/o8hsw4d3Rhu297m0PE92fp89TaAAI
         WbY9DBKu7pWVikiwsub0w+0EdYNtmI5f2hEaVJqT+L7bPZJdgZwHPM6Y70ReoVpHmtJe
         GAkw==
X-Gm-Message-State: AIVw113wevMI4zjDIZ4JvFJga1XHrEBlPZMpOy7uoudQUtNSVDxaiUrw
        vL7qfRNKvUOyFlSyF0NWdg==
X-Received: by 10.98.81.194 with SMTP id f185mr23203003pfb.96.1501703382950;
        Wed, 02 Aug 2017 12:49:42 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id e64sm63401460pfb.129.2017.08.02.12.49.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Aug 2017 12:49:41 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 09/10] submodule: merge repo_read_gitmodules and gitmodules_config
Date:   Wed,  2 Aug 2017 12:49:22 -0700
Message-Id: <20170802194923.88239-10-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <20170802194923.88239-1-bmwill@google.com>
References: <20170718190527.78049-1-bmwill@google.com>
 <20170802194923.88239-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 69aba5329 (submodule: add repo_read_gitmodules) there have been
two ways to load a repository's .gitmodules file:
'repo_read_gitmodules()' is used if you have a repository object you are
working with or 'gitmodules_config()' if you are implicitly working with
'the_repository'.  Merge the logic of these two functions to remove
duplicate code.

In addition, 'repo_read_gitmodules()' can segfault by passing in a NULL
pointer to 'git_config_from_file()' if a repository doesn't have a
worktree.  Instead check for the existence of a worktree before
attempting to load the .gitmodules file.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/submodule.c b/submodule.c
index 3b0e70c51..9d5eacaf9 100644
--- a/submodule.c
+++ b/submodule.c
@@ -230,23 +230,6 @@ void load_submodule_cache(void)
 	git_config(submodule_config, NULL);
 }
 
-void gitmodules_config(void)
-{
-	const char *work_tree = get_git_work_tree();
-	if (work_tree) {
-		struct strbuf gitmodules_path = STRBUF_INIT;
-		strbuf_addstr(&gitmodules_path, work_tree);
-		strbuf_addstr(&gitmodules_path, "/" GITMODULES_FILE);
-		if (read_cache() < 0)
-			die("index file corrupt");
-
-		if (!is_gitmodules_unmerged(&the_index))
-			git_config_from_file(git_modules_config,
-				gitmodules_path.buf, NULL);
-		strbuf_release(&gitmodules_path);
-	}
-}
-
 static int gitmodules_cb(const char *var, const char *value, void *data)
 {
 	struct repository *repo = data;
@@ -255,10 +238,24 @@ static int gitmodules_cb(const char *var, const char *value, void *data)
 
 void repo_read_gitmodules(struct repository *repo)
 {
-	char *gitmodules_path = repo_worktree_path(repo, GITMODULES_FILE);
+	if (repo->worktree) {
+		char *gitmodules;
+
+		if (repo_read_index(repo) < 0)
+			return;
 
-	git_config_from_file(gitmodules_cb, gitmodules_path, repo);
-	free(gitmodules_path);
+		gitmodules = repo_worktree_path(repo, GITMODULES_FILE);
+
+		if (!is_gitmodules_unmerged(repo->index))
+			git_config_from_file(gitmodules_cb, gitmodules, repo);
+
+		free(gitmodules);
+	}
+}
+
+void gitmodules_config(void)
+{
+	repo_read_gitmodules(the_repository);
 }
 
 void gitmodules_config_sha1(const unsigned char *commit_sha1)
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

