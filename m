Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21B67206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 19:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752812AbcLLTEo (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 14:04:44 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34467 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbcLLTEn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 14:04:43 -0500
Received: by mail-pf0-f182.google.com with SMTP id c4so13935649pfb.1
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 11:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/evIKvxjwnKqkPdCKz1nQ+gSdw0rmiX4A7QswI0hp5U=;
        b=itRPzkgD0nk1qns+NKPo0wQXbuJPqVEPMHuAZqU/hQcoqg8fqqgcQvkyTKg/U+51ZN
         +UqsHlhnh2jtONPp7qFDzzw1OAyWaDWj3SM9SWhqlaLDmsoV+9iJMHcwIMb0R4JUb/gl
         tXMSBNxA7KrIfaExAlpkRyiAxs/36bY3bQhfxejnuhpYN+/OEC2uzEM8TQZVZp8MsGvN
         WWmvBA5Pjij2QWTAI7T1y2RRrBw8IialIlEYmslh1w3u5rIUazO2Km8X0XMDMUxCyriv
         9SBYhblYo812s5olaUbS/GtRzhISTWgTU/srlYzQ5AWaJZJv441fKbX/2qeLaPtLfdiZ
         vBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/evIKvxjwnKqkPdCKz1nQ+gSdw0rmiX4A7QswI0hp5U=;
        b=eDpr59YYXF15wMlQYYEhNkVDAw1ZLSi2bkMSS0pHdvqgZRmS1VKCrk5OFAIleeTId2
         RSiVMQsx3UqXeM+u32v0t6qQYqxqFaoUdvDlMPpA/FkijfH0pCvOjA5FEBBdi+ulICRI
         ONSc9rPmMguznRgoIrVQv4dW4ufWQDwd6M+doC21Nfb0HRUubQo1OlCpz9W497IMp7Ur
         fZ5AyTRL+FKJDF6p1/A9qc5U5CN362pe/xVLI20YX42b2EZ2n/TlRdgHDiCg1aD5q7tR
         J4KYVwPjKPWHhH4MGPEFjVGJwtG34YdUaCEGqFAXBPUAdgudNeiNL1iOldJXawl/qeYV
         UVNw==
X-Gm-Message-State: AKaTC02vLlyQ/mSHrtdeoBZHhzV2JVWvW7npLa8R3UAUF9nRh0QUhJm/QlBVJ41Z5Lds/kMU
X-Received: by 10.98.52.71 with SMTP id b68mr99396609pfa.18.1481569482194;
        Mon, 12 Dec 2016 11:04:42 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:642c:37a4:3709:a2b3])
        by smtp.gmail.com with ESMTPSA id b126sm16843299pfg.52.2016.12.12.11.04.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Dec 2016 11:04:40 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv8 1/6] submodule: use absolute path for computing relative path connecting
Date:   Mon, 12 Dec 2016 11:04:30 -0800
Message-Id: <20161212190435.10358-2-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.49.ge1f3b0c.dirty
In-Reply-To: <20161212190435.10358-1-sbeller@google.com>
References: <20161212190435.10358-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current caller of connect_work_tree_and_git_dir passes
an absolute path for the `git_dir` parameter. In the future patch
we will also pass in relative path for `git_dir`. Extend the functionality
of connect_work_tree_and_git_dir to take relative paths for parameters.

We could work around this in the future patch by computing the absolute
path for the git_dir in the calling site, however accepting relative
paths for either parameter makes the API for this function much harder
to misuse.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/submodule.c b/submodule.c
index 6f7d883de9..d4f7afe2f1 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1223,27 +1223,28 @@ int merge_submodule(unsigned char result[20], const char *path,
 }
 
 /* Update gitfile and core.worktree setting to connect work tree and git dir */
-void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
+void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
 {
 	struct strbuf file_name = STRBUF_INIT;
 	struct strbuf rel_path = STRBUF_INIT;
-	const char *real_work_tree = xstrdup(real_path(work_tree));
+	char *git_dir = xstrdup(real_path(git_dir_));
+	char *work_tree = xstrdup(real_path(work_tree_));
 
 	/* Update gitfile */
 	strbuf_addf(&file_name, "%s/.git", work_tree);
 	write_file(file_name.buf, "gitdir: %s",
-		   relative_path(git_dir, real_work_tree, &rel_path));
+		   relative_path(git_dir, work_tree, &rel_path));
 
 	/* Update core.worktree setting */
 	strbuf_reset(&file_name);
 	strbuf_addf(&file_name, "%s/config", git_dir);
 	git_config_set_in_file(file_name.buf, "core.worktree",
-			       relative_path(real_work_tree, git_dir,
-					     &rel_path));
+			       relative_path(work_tree, git_dir, &rel_path));
 
 	strbuf_release(&file_name);
 	strbuf_release(&rel_path);
-	free((void *)real_work_tree);
+	free(work_tree);
+	free(git_dir);
 }
 
 int parallel_submodules(void)
-- 
2.11.0.rc2.49.ge1f3b0c.dirty

