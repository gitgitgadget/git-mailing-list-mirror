Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 111C4207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 23:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1952655AbdDYXrR (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 19:47:17 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33656 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1952537AbdDYXrO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 19:47:14 -0400
Received: by mail-pg0-f42.google.com with SMTP id 63so35217130pgh.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 16:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AtLLhdsHnFnMT7vQarRm80sI8tiP9/h7CXAiTQcp/Ko=;
        b=syUwykPnOa1EXyGgT7QXKcMJkSCDHbq5qRxTzNEN7t+UNx48IRXMkKlfN7hcvanIiJ
         h/zeu4o848uNDGZgnrpBKzt8lCISD7D71/kVQOPDRnhMHxChru1aJQC3X+O/pl5pSEGV
         ydRik/vA/dKht1A9WCbu0zyIwKPEOPYaLFqRKSYVIf6eIheJPnOb5reuATTLJa0UfM9x
         ws5rpxDUsC9P1jFFU0emRc4R4aLj5kVJJttix1WFKJ8qwNwhH5/gUpZ/p62fY20fs9Fg
         7MZMJDi8EHsajV8tV/hCoDWafcwU9wIfjcEjscWEIFvc8f7ifCIlHd84tcWQxbisR6VJ
         diJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AtLLhdsHnFnMT7vQarRm80sI8tiP9/h7CXAiTQcp/Ko=;
        b=csuZtLWee/TGL3NHMSO9pQNzBC/CQ/P4BdRvDQlDJ454koYS3gpZBYDHx43Xi+4xL9
         wwtMjSU0/ZFS2J4Bo59VSUriqNHWEmRugwRdnlrXLm9lwCjiOH+L2I4eY8cr5djq75O5
         yowrMUOUwqR4pegJkYWW6zkHWzKxwGdjztOz9yHtGMSO+TlHirluXWMHhXDYU4vA9oAR
         2MbB/Uvs+HcCEx4me4jleLeh6CtTyY4scYTaiMBLPS+FMxBMTY9O4EIcgsx0Vn5Z2l2n
         BPYAmHi67apoHxm8L4/F8v2lewuph6XMZ61k2xroghhXw3rNFIKnGaMHP2tprTXMXHxV
         yf2g==
X-Gm-Message-State: AN3rC/7ZWjV4A6UiGkSi4RihZ5w1OdUXXRWvyLDgjLTddTOkTi4bTdrF
        IXLR5DZeRf3FJnu2
X-Received: by 10.99.107.198 with SMTP id g189mr29312195pgc.162.1493164033543;
        Tue, 25 Apr 2017 16:47:13 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id i30sm8802671pgn.39.2017.04.25.16.47.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 16:47:12 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        j6t@kdbg.org, sbeller@google.com, e@80x24.org, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v8 2/2] run-command: restrict PATH search to executable files
Date:   Tue, 25 Apr 2017 16:47:00 -0700
Message-Id: <20170425234700.194277-2-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d-goog
In-Reply-To: <20170425234700.194277-1-bmwill@google.com>
References: <20170425175446.113553-1-bmwill@google.com>
 <20170425234700.194277-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some situations run-command will incorrectly try (and fail) to
execute a directory instead of an executable file.  This was observed by
having a directory called "ssh" in $PATH before the real ssh and trying
to use ssh protoccol, reslting in the following:

	$ git ls-remote ssh://url
	fatal: cannot exec 'ssh': Permission denied

It ends up being worse and run-command will even try to execute a
non-executable file if it preceeds the executable version of a file on
the PATH.  For example, if PATH=~/bin1:~/bin2:~/bin3 and there exists a
directory 'git-hello' in 'bin1', a non-executable file 'git-hello' in
bin2 and an executable file 'git-hello' (which prints "Hello World!") in
bin3 the following will occur:

	$ git hello
	fatal: cannot exec 'git-hello': Permission denied

This is due to only checking 'access()' when locating an executable in
PATH, which doesn't distinguish between files and directories.  Instead
use 'is_executable()' which check that the path is to a regular,
executable file.  Now run-command won't try to execute the directory or
non-executable file 'git-hello':

	$ git hello
	Hello World!

Reported-by: Brian Hatfield <bhatfield@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 run-command.c          | 19 ++++++++++++++++++-
 t/t0061-run-command.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 2ffbd7e67..9e36151bf 100644
--- a/run-command.c
+++ b/run-command.c
@@ -159,6 +159,23 @@ int is_executable(const char *name)
 	return st.st_mode & S_IXUSR;
 }
 
+/*
+ * Search $PATH for a command.  This emulates the path search that
+ * execvp would perform, without actually executing the command so it
+ * can be used before fork() to prepare to run a command using
+ * execve() or after execvp() to diagnose why it failed.
+ *
+ * The caller should ensure that file contains no directory
+ * separators.
+ *
+ * Returns the path to the command, as found in $PATH or NULL if the
+ * command could not be found.  The caller inherits ownership of the memory
+ * used to store the resultant path.
+ *
+ * This should not be used on Windows, where the $PATH search rules
+ * are more complicated (e.g., a search for "foo" should find
+ * "foo.exe").
+ */
 static char *locate_in_PATH(const char *file)
 {
 	const char *p = getenv("PATH");
@@ -179,7 +196,7 @@ static char *locate_in_PATH(const char *file)
 		}
 		strbuf_addstr(&buf, file);
 
-		if (!access(buf.buf, F_OK))
+		if (is_executable(buf.buf))
 			return strbuf_detach(&buf, NULL);
 
 		if (!*end)
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 98c09dd98..e4739170a 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -37,6 +37,36 @@ test_expect_success !MINGW 'run_command can run a script without a #! line' '
 	test_cmp empty err
 '
 
+test_expect_success 'run_command does not try to execute a directory' '
+	test_when_finished "rm -rf bin1 bin2" &&
+	mkdir -p bin1/greet bin2 &&
+	write_script bin2/greet <<-\EOF &&
+	cat bin2/greet
+	EOF
+
+	PATH=$PWD/bin1:$PWD/bin2:$PATH \
+		test-run-command run-command greet >actual 2>err &&
+	test_cmp bin2/greet actual &&
+	test_cmp empty err
+'
+
+test_expect_success POSIXPERM 'run_command passes over non-executable file' '
+	test_when_finished "rm -rf bin1 bin2" &&
+	mkdir -p bin1 bin2 &&
+	write_script bin1/greet <<-\EOF &&
+	cat bin1/greet
+	EOF
+	chmod -x bin1/greet &&
+	write_script bin2/greet <<-\EOF &&
+	cat bin2/greet
+	EOF
+
+	PATH=$PWD/bin1:$PWD/bin2:$PATH \
+		test-run-command run-command greet >actual 2>err &&
+	test_cmp bin2/greet actual &&
+	test_cmp empty err
+'
+
 test_expect_success POSIXPERM 'run_command reports EACCES' '
 	cat hello-script >hello.sh &&
 	chmod -x hello.sh &&
-- 
2.13.0.rc0.306.g87b477812d-goog

