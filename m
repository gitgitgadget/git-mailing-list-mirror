Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92E1D1F790
	for <e@80x24.org>; Tue,  2 May 2017 19:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751579AbdEBTca (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 15:32:30 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36005 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbdEBTc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 15:32:27 -0400
Received: by mail-pg0-f46.google.com with SMTP id t7so66079834pgt.3
        for <git@vger.kernel.org>; Tue, 02 May 2017 12:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6tlSSZsW8nm/ZDykFdX/XTsqI2G9/Cbrw8OtAIUjZ9s=;
        b=VJ37sKjDWbcetVlq5YlTeU9y7l6GFZpbrVJS1q51GwIGxEYdlU9N6HTYHQneIsVw6r
         Fus+4AsWgRhpPV9ME/TIB7u61j8i1bpxs9glqXeaO1fT8hsbLHcaDaQgq7DqvWwTldj1
         oluemE32sRwYv6FXVvpdbWBbDl0gDypFJakIl1tiUfHmo6RRLOej3GUU/IjP0+Yyh/g3
         LfkM8PCuxdL7ih+xwXjaX22katrDgTWlpPWp7vLtMntPZ61cs8H33KUalz5P+waoYV1J
         Iod9CqhrZfPZiL1jBzdBDhRUj2S3mfwL9QniQd1AIkLYcPUsezEO9CLjraPqCq+ROe5D
         C6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6tlSSZsW8nm/ZDykFdX/XTsqI2G9/Cbrw8OtAIUjZ9s=;
        b=C4N//tB4SkwQ7yNt0rGyOIEXL8gUQHQqN31HnPhZy3qXV0T084xDRFIvvzvdAyPlIn
         ArwaHiMjIFMoOtMt9BLvMSI0tHifH9McgmRDbuAhvIoOSLNQDDn4O4NkLOWKu/8lkGA4
         ewHqGHFuk1EZC4Bpm8hFXw9ZMJw/eH9cj7XMM6JWyQo51l2Z6ancwVGV/hltvtyCKSFx
         i1+jzOxp7CdWwushHlwbFWuahuQqIorFa3ZvYuTdY8PmPfvhfqxBJzgnEDahJzfRLUcy
         yzbokLBrIgW/Qg/vXbRGUBy2rFbeab8t6P2ym+Tx5/ueF9PDji/kGPBGNp+bsfSyokv7
         /Nyg==
X-Gm-Message-State: AN3rC/5sXnuQGxC+g8fopoluS+WGidYkxi2Z+IHd70+T7wfjeKA+Vrfe
        G3Z/1a9IxZaTO1g8
X-Received: by 10.99.50.66 with SMTP id y63mr13906509pgy.41.1493753546499;
        Tue, 02 May 2017 12:32:26 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c805:cf1:74c5:2e74])
        by smtp.gmail.com with ESMTPSA id u85sm365242pfg.64.2017.05.02.12.32.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 12:32:25 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com, bmwill@google.com
Cc:     jrnieder@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 2/3] submodule: avoid auto-discovery in new working tree manipulator code
Date:   Tue,  2 May 2017 12:32:13 -0700
Message-Id: <20170502193214.7121-3-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.18.g9ce9a66034
In-Reply-To: <20170502193214.7121-1-sbeller@google.com>
References: <20170501180058.8063-1-sbeller@google.com>
 <20170502193214.7121-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All commands that are run in a submodule, are run in a correct setup,
there is no need to prepare the environment without setting the GIT_DIR
variable. By setting the GIT_DIR variable we fix issues as discussed in
10f5c52656 (submodule: avoid auto-discovery in
prepare_submodule_repo_env(), 2016-09-01)

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index a2377ce019..b0141a66dd 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1363,7 +1363,7 @@ static int submodule_has_dirty_index(const struct submodule *sub)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 
-	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
+	prepare_submodule_repo_env(&cp.env_array);
 
 	cp.git_cmd = 1;
 	argv_array_pushl(&cp.args, "diff-index", "--quiet",
@@ -1380,7 +1380,7 @@ static int submodule_has_dirty_index(const struct submodule *sub)
 static void submodule_reset_index(const char *path)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
-	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
+	prepare_submodule_repo_env(&cp.env_array);
 
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
@@ -1438,7 +1438,7 @@ int submodule_move_head(const char *path,
 		}
 	}
 
-	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
+	prepare_submodule_repo_env(&cp.env_array);
 
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
-- 
2.13.0.rc1.19.g083305f9b1

