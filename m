Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95FBD207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 23:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S979243AbdDXXvl (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 19:51:41 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:32823 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S979033AbdDXXvj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 19:51:39 -0400
Received: by mail-pf0-f176.google.com with SMTP id a188so18720227pfa.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 16:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gP34P9WyYa6Bl9LW9JXo2aj3UBU7/9Tfq/yO63481pA=;
        b=I2FTaWHnd7ezZRjfIXYDxAnjZE410+TvPK7Q93D+M6PFX4r0DGLuG2JRbKDFIwckA8
         BXx5FEnUtIrMX1OjqLm/Bl5eP4ws1QEEZfRd5ACiIH+WVO7tclXy8HyolZ8WnTaZgUk7
         C2i4alKxXzxOaVdza3OfE0kvJ8WeLFWUVn04QK/uQW9/41ieglDcxp9FU5WyzpvBYby5
         MkYCUy32zg51VOzlS0WRzxDBRm1Nj8djUxjtLavw/Vm6DoKNGWcx7AI1nzKm/UBJpCCT
         zhg9QZwedB7eiFeze6H5DUvG2U5O3PApRDIQ9cz678tLfOz7kKywWfKjDkWmcAzCOYOQ
         UlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gP34P9WyYa6Bl9LW9JXo2aj3UBU7/9Tfq/yO63481pA=;
        b=sU3z+ncnZGTTwz4XUZRzGHib9kSeABm9NDF8fVIGa9+OMziA6dLu2KaNsh6IwqYOud
         LMUtl9YTJG3+C4DwJb06uDbCHsfyw0fRMx9ideLDgEYjQEaLjpcHQ9zUKQdc4c2eHoI2
         Z6SiGNwIK7com+rZtWSpy9DjqznRXMM8UbkDjfExh+pL1KvhGrO6Gh2Uf76xo6ISMe5X
         inYLqiUpy+gbkoea0bHv3YTuFzH5Xnjhjx19HjXkwVpCe0/dm13GMkyqw9190qqC6AAD
         oyNm8zhBGPDDuR0bXVanOe3aCk04qCvONpqqZHf9GI+7vucVCwA+PHm20m6A+73T6d5d
         elzA==
X-Gm-Message-State: AN3rC/6OCd7DrvuWsI2zM4EskThGvx6Zp+g3DRss5CRVjH2cqwVBZv4v
        OYHM6VuW3UXLtiR+
X-Received: by 10.98.87.203 with SMTP id i72mr27301659pfj.151.1493077898822;
        Mon, 24 Apr 2017 16:51:38 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id h89sm32660313pfh.45.2017.04.24.16.51.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 16:51:37 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        j6t@kdbg.org, sbeller@google.com, e@80x24.org, jrnieder@gmail.com
Subject: [PATCH v6 12/11] run-command: don't try to execute directories
Date:   Mon, 24 Apr 2017 16:50:42 -0700
Message-Id: <20170424235042.26627-1-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d-goog
In-Reply-To: <20170424223752.GB105623@google.com>
References: <20170424223752.GB105623@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some situations run-command will incorrectly try (and fail) to
execute a directory instead of an executable.  For example:

Lets suppose a user has PATH=~/bin (where 'bin' is a directory) and they
happen to have another directory inside 'bin' named 'git-remote-blah'.
Then git tries to execute the directory:

	$ git ls-remote blah://blah
	fatal: cannot exec 'git-remote-blah': Permission denied

This is due to only checking 'access()' when locating an executable in
PATH, which doesn't distinguish between files and directories.  Instead
use 'stat()' and check that the path is to a regular file.  Now
run-command won't try to execute the directory 'git-remote-blah':

	$ git ls-remote blah://blah
	fatal: Unable to find remote helper for 'blah'

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 run-command.c          | 3 ++-
 t/t0061-run-command.sh | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index a97d7bf9f..ece0bf342 100644
--- a/run-command.c
+++ b/run-command.c
@@ -127,6 +127,7 @@ static char *locate_in_PATH(const char *file)
 
 	while (1) {
 		const char *end = strchrnul(p, ':');
+		struct stat st;
 
 		strbuf_reset(&buf);
 
@@ -137,7 +138,7 @@ static char *locate_in_PATH(const char *file)
 		}
 		strbuf_addstr(&buf, file);
 
-		if (!access(buf.buf, F_OK))
+		if (!stat(buf.buf, &st) && S_ISREG(st.st_mode))
 			return strbuf_detach(&buf, NULL);
 
 		if (!*end)
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 98c09dd98..30c4ad75f 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -37,6 +37,13 @@ test_expect_success !MINGW 'run_command can run a script without a #! line' '
 	test_cmp empty err
 '
 
+test_expect_success 'run_command should not try to execute a directory' '
+	test_when_finished "rm -rf bin/blah" &&
+	mkdir -p bin/blah &&
+	PATH=bin:$PATH test_must_fail test-run-command run-command blah 2>err &&
+	test_i18ngrep "No such file or directory" err
+'
+
 test_expect_success POSIXPERM 'run_command reports EACCES' '
 	cat hello-script >hello.sh &&
 	chmod -x hello.sh &&
-- 
2.13.0.rc0.306.g87b477812d-goog

