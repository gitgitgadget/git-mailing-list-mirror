Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAB501FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 23:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934244AbcLTXUj (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 18:20:39 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33170 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934112AbcLTXUi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 18:20:38 -0500
Received: by mail-pg0-f54.google.com with SMTP id g1so38560333pgn.0
        for <git@vger.kernel.org>; Tue, 20 Dec 2016 15:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7YI8kWN/YAYlY2NrgjSn7ZgPojwgy/N0IjbpAT+7oM4=;
        b=flM1ZdqxFWoF3ZU/+ZgFZFYb7EkgC6f/R1LJGWG/J9Zco6L6ifoHI7cwLG5WJVUALg
         SkUd9PfCMbI1FUnN2SUeDIh2RVkSe0r7IoGAxt2VzFI1/9cskhmo4a1frKb7F9Q+0Oy4
         JnGWZpZzf8t1oPhEHpMi1ozIaLBaVyV1xqroxyrWtyXrDOrpjnf2epoha64wuAgS4bvx
         Tf6RbufNjcgDDkI/XIQ/p86kusDB2PYvZTGG4GgkWAWhSZnFNcM7rGL4HJ5cRK9m5FON
         aeXgeqJu5MWceQWAuIPHg7Q7jDUzhYNN98OrUtHKw2iTdvCxp8Ybt4838fiunzTPb8Bs
         chKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7YI8kWN/YAYlY2NrgjSn7ZgPojwgy/N0IjbpAT+7oM4=;
        b=Em4QjW64LZZO+4CKJhf0v+pvoQQZdX1IaMVpgdSg+UNaq2YbXn4o4NN15pfvpJJfjV
         jANidITunrZteXBt3D37447jZnmAIstaJZgllJ9HKhqrj0824y7Qu0NU/HHk0ukVOoVv
         ZVx10LoNTPQsne6k//HiOoasW21c36K8oNCZJTMBxR4YOwhcwJZ6S4nwbLeVKmGojOGB
         VUm5JwRF4pvGw1oL7V2cGE6ecLdLFjOnbdw7DWDI18G077repLEp4gdYuGZmTVFQmKtH
         Gl79jww+VgIfdh37/ZxAlOdinAPYVxMZrAsY9PM6ByagP91FCfg/rIe0bzqwdjfoqctM
         KLqQ==
X-Gm-Message-State: AIkVDXKxf3qpBLzQfJkveGK4nmOSCWdOopID1/oHQ6WoI2iMhCb85YlQDFa3DmKpC8WF8aUP
X-Received: by 10.99.102.69 with SMTP id a66mr2637611pgc.49.1482275566385;
        Tue, 20 Dec 2016 15:12:46 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:6c5b:c771:3806:a807])
        by smtp.gmail.com with ESMTPSA id t67sm41539985pfg.13.2016.12.20.15.12.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Dec 2016 15:12:46 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 2/4] submodule: modernize ok_to_remove_submodule to use argv_array
Date:   Tue, 20 Dec 2016 15:12:25 -0800
Message-Id: <20161220231227.14115-3-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.53.gb7b3fba.dirty
In-Reply-To: <20161220231227.14115-1-sbeller@google.com>
References: <20161220231227.14115-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of constructing the NULL terminated array ourselves, we
should make use of the argv_array infrastructure.

While at it, adapt the error messages to reflect the actual invocation.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/submodule.c b/submodule.c
index 45ccfb7ab4..9f0b544ebe 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1023,13 +1023,6 @@ int ok_to_remove_submodule(const char *path)
 {
 	ssize_t len;
 	struct child_process cp = CHILD_PROCESS_INIT;
-	const char *argv[] = {
-		"status",
-		"--porcelain",
-		"-u",
-		"--ignore-submodules=none",
-		NULL,
-	};
 	struct strbuf buf = STRBUF_INIT;
 	int ok_to_remove = 1;
 
@@ -1039,14 +1032,15 @@ int ok_to_remove_submodule(const char *path)
 	if (!submodule_uses_gitfile(path))
 		return 0;
 
-	cp.argv = argv;
+	argv_array_pushl(&cp.args, "status", "--porcelain", "-u",
+				   "--ignore-submodules=none", NULL);
 	prepare_submodule_repo_env(&cp.env_array);
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
 	cp.out = -1;
 	cp.dir = path;
 	if (start_command(&cp))
-		die("Could not run 'git status --porcelain -uall --ignore-submodules=none' in submodule %s", path);
+		die(_("could not run 'git status --porcelain -u --ignore-submodules=none' in submodule %s"), path);
 
 	len = strbuf_read(&buf, cp.out, 1024);
 	if (len > 2)
@@ -1054,7 +1048,7 @@ int ok_to_remove_submodule(const char *path)
 	close(cp.out);
 
 	if (finish_command(&cp))
-		die("'git status --porcelain -uall --ignore-submodules=none' failed in submodule %s", path);
+		die(_("'git status --porcelain -u --ignore-submodules=none' failed in submodule %s"), path);
 
 	strbuf_release(&buf);
 	return ok_to_remove;
-- 
2.11.0.rc2.53.gb7b3fba.dirty

