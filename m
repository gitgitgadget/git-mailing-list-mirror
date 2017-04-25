Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 958181FE90
	for <e@80x24.org>; Tue, 25 Apr 2017 17:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1951577AbdDYRzJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 13:55:09 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33194 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947451AbdDYRzB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 13:55:01 -0400
Received: by mail-pg0-f44.google.com with SMTP id 63so31863913pgh.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 10:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X2An7unIDCtam000uINkRspPywYrwV9iwGQfmf68+xg=;
        b=ObUo20csn78fAJrVjR5F9D81a5h93/RceVdv8yjxenM2U8WtroD1Dags3pb0N2NbHJ
         RH+fUUFK1Mh7LgaGmRQ2+/+MNvUrl0KWGrac6uhGmDvg8u/BPLP7FcDHEalMT95r8KvA
         5LXVPrt1vP4mu6aN2H5WFgo3lFcjOLA/yXKenTObSuLNw6wWlVJ5lZ25jMlIKzC6KKRN
         ru+QgH7iI9V37SpCzVii9lgOUNMKsgCDCsEGPObTeZJFgozpyH7Co1Xy79DYsIJ2WP42
         aEAlDp0YvHlYUyXg9HgahOVMGODRRDwDrrYtJEKnbxmwkVzkAKQufXqbxLV6nJKjGPiL
         Wa2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X2An7unIDCtam000uINkRspPywYrwV9iwGQfmf68+xg=;
        b=piK9jebxkGEDiAq/ur1R/EZcODOjw27UdqOruUA5RaWRrx5brWm31P0gV/qWhiZ9fX
         ue/+xDuJuBh3kAeRuB4/Uv0hQFYnNi7rsobH7uBHHqnem9gYpLyzn/stbLv+XOxRbDA8
         dFLhgwj2ahL/jQjsUhG6uqEYfOadoThrYN2vtkYkwhSfiM8/mVSgF4j6r0iJ0NL7HoNe
         WU8HEro3+TPC6StzQbF3Bxw81afoHm+NNO3K3CYRfQR+6qV6o/Q0qXo4zLXhrsTl0xaI
         CchdyAMfZooOGXB/XQPo2YV8CClkD1roeblqYZWjQSZ9y7pqy6/lg9Fsb1h0DkgusppF
         luMQ==
X-Gm-Message-State: AN3rC/7CIvweUtlFAaSrJoU5IvDJcKbQDRVEdHPIW78MxSJQ8OIqiUAa
        x0IZJ1Rh4Kd8VPcX
X-Received: by 10.98.62.9 with SMTP id l9mr29678198pfa.114.1493142900685;
        Tue, 25 Apr 2017 10:55:00 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id s89sm37701549pfi.79.2017.04.25.10.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 10:54:59 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        j6t@kdbg.org, sbeller@google.com, e@80x24.org, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v7 2/2] run-command: don't try to execute directories
Date:   Tue, 25 Apr 2017 10:54:46 -0700
Message-Id: <20170425175446.113553-2-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d-goog
In-Reply-To: <20170425175446.113553-1-bmwill@google.com>
References: <20170424235042.26627-1-bmwill@google.com>
 <20170425175446.113553-1-bmwill@google.com>
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
 run-command.c          |  2 +-
 t/t0061-run-command.sh | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index a97d7bf9f..ec08e0951 100644
--- a/run-command.c
+++ b/run-command.c
@@ -137,7 +137,7 @@ static char *locate_in_PATH(const char *file)
 		}
 		strbuf_addstr(&buf, file);
 
-		if (!access(buf.buf, F_OK))
+		if (is_executable(buf.buf))
 			return strbuf_detach(&buf, NULL);
 
 		if (!*end)
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 98c09dd98..fd5e43766 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -37,6 +37,29 @@ test_expect_success !MINGW 'run_command can run a script without a #! line' '
 	test_cmp empty err
 '
 
+test_expect_success 'run_command should not try to execute a directory' '
+	test_when_finished "rm -rf bin1 bin2 bin3" &&
+	mkdir -p bin1/greet bin2 bin3 &&
+	write_script bin2/greet <<-\EOF &&
+	cat bin2/greet
+	EOF
+	chmod -x bin2/greet &&
+	write_script bin3/greet <<-\EOF &&
+	cat bin3/greet
+	EOF
+
+	# Test that run-command does not try to execute the "greet" directory in
+	# "bin1", or the non-executable file "greet" in "bin2", but rather
+	# correcty executes the "greet" script located in bin3.
+	(
+		PATH=$PWD/bin1:$PWD/bin2:$PWD/bin3:$PATH &&
+		export PATH &&
+		test-run-command run-command greet >actual 2>err
+	) &&
+	test_cmp bin3/greet actual &&
+	test_cmp empty err
+'
+
 test_expect_success POSIXPERM 'run_command reports EACCES' '
 	cat hello-script >hello.sh &&
 	chmod -x hello.sh &&
-- 
2.13.0.rc0.306.g87b477812d-goog

