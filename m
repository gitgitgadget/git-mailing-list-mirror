Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFE5A207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 17:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbdDZRK0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 13:10:26 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33488 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbdDZRKY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 13:10:24 -0400
Received: by mail-pf0-f170.google.com with SMTP id a188so3013999pfa.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 10:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KLnerhp2485ekfhk6Ynv0REv6kfPIGWhWDLi0uN/9qM=;
        b=Q976M7PWfFs3yeiqnMToHEqsYlcuMsQ4F2eZwbPBRGXItlD8eFg1w1Wc9RFVJ7QiWS
         wpl3/pcwfJ1kOno+MysI0PZMB1pZJymEYXKP/CQxgKYAB5MPvQoqvdIerEdC6WwjRMXA
         orQisQzbQijKExVI9tKO4X/UcTCFEqKrD+jNv/VfEvnULumYEgn8Sk3U3qA7VZDnBqTW
         62gRyiWrKSpM5W2b3sWqx8Av6vP4HW201HTbO9lPTFlbCGYDM/g9ZPzAf57mpDAAi+Ty
         p565j91FaD0gJVxOE4bPn3s54hbaUIOsMO7p0wqgcIHD7W8pIzA9l23ftEcFFTXBOwLM
         GAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KLnerhp2485ekfhk6Ynv0REv6kfPIGWhWDLi0uN/9qM=;
        b=BVFA4boVNe548lgYAaUXy6bPoFGre8D5ZN/2dK6cHqEYKWnBcNW3NdjlbPwq7Nshnx
         pR3SpocuCChyauC2/Aj4piPJ2iLsfRa9oi2QVUsRM3vM19eub3rL4lfkvH7irFPIiUPc
         2ml1rLzDkOBTQmZqWln9NAR7RdLv19G+T8eY/CriWF1zUCahH0wxKiZwtcrkNOtSC6vd
         jBQRD1y/zU1LXicw0HTYhHU2r5aU+0OWWeXXAAbuggrCouH3DutFWMaEq7saPOdfbgc2
         n9hqasmzZioCF33tynAruuDXEYlmeIrs2rsRMZtvGHL4gLeHaWCeWYl89LXwUKOek0qE
         1soQ==
X-Gm-Message-State: AN3rC/5CRiCi3rHnQNps5VjQpIFlmGXbLLneCD/2kXCKch1dUgemeWEl
        jL1NJs030hQH3Dl9
X-Received: by 10.98.73.214 with SMTP id r83mr876797pfi.253.1493226623114;
        Wed, 26 Apr 2017 10:10:23 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id u128sm1634093pfb.55.2017.04.26.10.10.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 10:10:22 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        j6t@kdbg.org, sbeller@google.com, e@80x24.org, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v9 2/2] run-command: restrict PATH search to executable files
Date:   Wed, 26 Apr 2017 10:10:17 -0700
Message-Id: <20170426171017.82737-1-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d-goog
In-Reply-To: <xmqqzif4t01f.fsf@gitster.mtv.corp.google.com>
References: <xmqqzif4t01f.fsf@gitster.mtv.corp.google.com>
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

This matches what 'execvp()' would have done with a request to execute
'git-hello' with such a $PATH.

Reported-by: Brian Hatfield <bhatfield@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---

This [2/2] patch has the exact same diff as v8, the only difference is to the
commit message per Junio's request to add an explanation for why this
particular behavior is desirable (because it matches what execvp() does).

I didn't resend out [1/2] of this fixup because it is identical to the v8
version.

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

