Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D755A1FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 02:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121AbcFUCPU (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 22:15:20 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34947 "EHLO
	mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbcFUCPT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 22:15:19 -0400
Received: by mail-qk0-f194.google.com with SMTP id b136so479361qkg.2
        for <git@vger.kernel.org>; Mon, 20 Jun 2016 19:15:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=MkMI4XauBFQgVoKJK26gulH3u9WjPCv3zD/Ku0Tsexo=;
        b=frYVjLX7uVFhWT5xHZ4sYp5fnFHqw3AxnQ4Vu9YMiV3s10aHuQlLUGTzExbJLMVTsZ
         NC72MaKvUjBKXeaBe/qb1uuVUjCevG1wW1er9Ar+kTcRgvwfxuQn/YVAFA1HL7VdFMVq
         MuGwAytJDdLFrY4kp3/mPtZj1nJ/pfxGmBsEgXlqX8vz2D3em86i95/HE4naK5KSj6Tx
         YpkM1sjqEdg1O6+xRQqiNePmp9ozPOjrqvkOLGQHtLCfcRPKLVOyLlUOWRjihvsG3DjJ
         BrH0Aou8GUdUri5Epv0fGS1g0OdOq4Ge7iN6LcL13mK/tiK4zfXWvHM4L8cc04RBQhSZ
         knGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MkMI4XauBFQgVoKJK26gulH3u9WjPCv3zD/Ku0Tsexo=;
        b=UxuonEh+ouZvWLHJLP6qclGbj96YL82dkTdK/urECuHkis8E6SEe/noaEv609zUsT9
         oxP5uJq9kP6PyrHVl5YbFDFPLMPKcuoJ9hlxP0qw3PAX1O54d6AhNc8lxMITmsuJMPgW
         1rQBKaoWb9phhA3JNgYGOEGW9xHqP2F4WRhKg5pkpLL7qdaEZefajuijvEWxHjKyo2/f
         y8suRqKIr7LFd7T4v9BMcclOMIkTor1g5uvTLKz9kVjaaL1f2XoiaBK5kGzT+2w//x4U
         elz29TgR2jUC2pVUfiKmOyqh0AzFsStKY3TUNMpDklOkTHG1jX7axqjeWSz2ARICi2mZ
         N41Q==
X-Gm-Message-State: ALyK8tK8ftpimu/Fyw98YjRn3V3cCJ89qNXzODBDixASEzAukqnF9la5avRgbfoZzeTanQ==
X-Received: by 10.55.167.19 with SMTP id q19mr5013268qke.7.1466475318733;
        Mon, 20 Jun 2016 19:15:18 -0700 (PDT)
Received: from Emily-Xies-MacBook-Pro-2.local.com ([207.251.103.46])
        by smtp.gmail.com with ESMTPSA id l37sm12160479qte.41.2016.06.20.19.15.17
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 20 Jun 2016 19:15:18 -0700 (PDT)
From:	Emily Xie <emilyxxie@gmail.com>
To:	git@vger.kernel.org
Cc:	novalis@novalis.org, gitster@pobox.com,
	Emily Xie <emilyxxie@gmail.com>
Subject: [PATCH] pathspec: warn on empty strings as pathspec
Date:	Mon, 20 Jun 2016 22:15:15 -0400
Message-Id: <20160621021515.64964-1-emilyxxie@gmail.com>
X-Mailer: git-send-email 2.8.4
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

For any command that takes a pathspec, passing an empty string will
execute the command on all files in the current directory. This
results in unexpected behavior. For example, git add "" adds all
files to staging, while git rm -rf "" recursively removes all files
from the working tree and index. A two-step implemetation will
prevent such cases.

This patch, as step one, invokes a warning whenever an empty
string is detected as a pathspec, introducing users to the upcoming
change. For step two, a follow-up patch several release cycles later
will remove the warnings and actually implement the change by
throwing an error instead.

Signed-off-by: Emily Xie <emilyxxie@gmail.com>
Reported-by: David Turner <novalis@novalis.org>
Mentored-by: Michail Denchev <mdenchev@gmail.com>
Thanks-to: Sarah Sharp <sarah@thesharps.us> and James Sharp <jamey@minilop.net>
---
 pathspec.c     | 6 +++++-
 t/t3600-rm.sh  | 6 +++++-
 t/t3700-add.sh | 4 ++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index c9e9b6c..79e370e 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -402,8 +402,12 @@ void parse_pathspec(struct pathspec *pathspec,
 	}
 
 	n = 0;
-	while (argv[n])
+	while (argv[n]) {
+		if (*argv[n] == '\0')
+			warning(_("empty strings are not valid pathspecs and will no longer "
+			          "be supported in upcoming releases"));
 		n++;
+	}
 
 	pathspec->nr = n;
 	ALLOC_ARRAY(pathspec->items, n);
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index d046d98..4503a14 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -881,4 +881,8 @@ test_expect_success 'rm files with two different errors' '
 	test_i18ncmp expect actual
 '
 
-test_done
+test_expect_success 'rm empty string should invoke warning' '
+	git rm -rf "" 2>&1 | grep "warning: empty string"
+'
+
+test_done
\ No newline at end of file
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index f14a665..5dbe8c2 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -207,6 +207,10 @@ test_expect_success POSIXPERM,SANITY 'git add should fail atomically upon an unr
 	! ( git ls-files foo1 | grep foo1 )
 '
 
+test_expect_success 'git add empty string should invoke warning' '
+	git add "" 2>&1 | grep "warning: empty string"
+'
+
 rm -f foo2
 
 test_expect_success POSIXPERM,SANITY 'git add --ignore-errors' '
-- 
2.8.4

