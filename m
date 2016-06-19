Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C367220189
	for <e@80x24.org>; Sun, 19 Jun 2016 00:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbcFSA6x (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 20:58:53 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36585 "EHLO
	mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbcFSA6x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2016 20:58:53 -0400
Received: by mail-qk0-f193.google.com with SMTP id l81so17755920qke.3
        for <git@vger.kernel.org>; Sat, 18 Jun 2016 17:58:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=cHCVHtpUrBbfJsRJ4J1DqpIu5tF6a9RXV0pWQl3M9jM=;
        b=poQVWqqVxmXSnYAvq5dnn1IEXfyP8F+Ba1f7k7txLDWVFY5ShzUHEI0quLXEfv/iuS
         XpPvpDbGrfugCfKASQMDrDElR0Djbc4O21+sVhvl3OQN8mTTMo5lIIcXLsgqi+Z9MwIr
         7G8a6AhPTP2NVm+kuM+JkqtAgnkwxtJhb0hicjgHM7Q8NlTeer4UQKGlaukYQw84oCGN
         mS3A7RfxzZurhwyQcfKIeXz7NgnpHMiIP0EN0s/OntU0x/YNql/al+kolMX4zFHj1FkL
         jGUmXni7/DUZtYh/ZrO0QCalJkuBKOjcSkm1fr9GGfyjLVVF7wwgrKQHn4K8nLpoG4Sv
         rWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cHCVHtpUrBbfJsRJ4J1DqpIu5tF6a9RXV0pWQl3M9jM=;
        b=DVmh7BnEuet2oRyNDlCITv89A70TB74hHgAZ3L/NLzanVKDbTq68YokFyycZOpHYm7
         BZ/8vLmRPptnuLOo8LbOFREyg5yLNILEywcux1ntXlea3koaqQO5NmWNmyiX7veSGvMc
         EqtCtEIK5/eGGqb+n2Y4sklpPwu3lc4RrwjQFp5RhBvCk/vCqB9qlBhFeb7sRks4Qu7s
         DaVs3+71yKRJOyMwNoqc4f33ZkHQFvJqd/KPGn3AsJCWT9oALqLN9OWICtB5Wt3HYIwe
         uv/CoOR9RyzmYDk1IQKQiRoGBORIg8uSjgjb4Cv2aVkcd2yc4LiHouUVQkVXA08/cVev
         /q0A==
X-Gm-Message-State: ALyK8tII94mLSdILP71nDr/oyWi+xqS+AQABqPVzmH7GaTgukHSv5SwvKFZ48B3310wKlw==
X-Received: by 10.233.237.14 with SMTP id c14mr11872628qkg.88.1466297932331;
        Sat, 18 Jun 2016 17:58:52 -0700 (PDT)
Received: from Emily-Xies-MacBook-Pro-2.local.com ([207.251.103.46])
        by smtp.gmail.com with ESMTPSA id h32sm11936798qth.39.2016.06.18.17.58.51
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 18 Jun 2016 17:58:51 -0700 (PDT)
From:	Emily Xie <emilyxxie@gmail.com>
To:	git@vger.kernel.org
Cc:	novalis@novalis.org, Emily Xie <emilyxxie@gmail.com>
Subject: [PATCH] pathspec: prevent empty strings as pathspecs
Date:	Sat, 18 Jun 2016 20:57:04 -0400
Message-Id: <20160619005704.1771-1-emilyxxie@gmail.com>
X-Mailer: git-send-email 2.8.4
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

For any command that takes a pathspec, passing an empty string will
execute the command on all files in the current directory. This
results in unexpected behavior. For example, git add "" adds all
files to staging, while git rm -rf "" recursively removes all files
from the working tree and index. This patch prevents such cases by
throwing an error message whenever an empty string is detected as a
pathspec.

Signed-off-by: Emily Xie <emilyxxie@gmail.com>
Reported-by: David Turner <novalis@novalis.org>
Mentored-by: Michail Denchev <mdenchev@gmail.com>
Thanks-to: Sarah Sharp <sarah@thesharps.us> and James Sharp <jamey@minilop.net>
---
 pathspec.c     | 6 +++++-
 t/t3600-rm.sh  | 4 ++++
 t/t3700-add.sh | 4 ++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/pathspec.c b/pathspec.c
index c9e9b6c..11901a2 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -402,8 +402,12 @@ void parse_pathspec(struct pathspec *pathspec,
 	}
 
 	n = 0;
-	while (argv[n])
+	while (argv[n]) {
+		if (*argv[n] == '\0') {
+			die("Empty string is not a valid pathspec.");
+		}
 		n++;
+	}
 
 	pathspec->nr = n;
 	ALLOC_ARRAY(pathspec->items, n);
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index d046d98..1d7dc79 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -791,6 +791,10 @@ test_expect_success 'setup for testing rm messages' '
 	git add bar.txt foo.txt
 '
 
+test_expect_success 'rm files with empty string pathspec' '
+  test_must_fail git rm ""
+'
+
 test_expect_success 'rm files with different staged content' '
 	cat >expect <<-\EOF &&
 	error: the following files have staged content different from both the
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index f14a665..49cb080 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -207,6 +207,10 @@ test_expect_success POSIXPERM,SANITY 'git add should fail atomically upon an unr
 	! ( git ls-files foo1 | grep foo1 )
 '
 
+test_expect_success 'git add empty string as pathspec must fail' '
+  test_must_fail git add ""
+'
+
 rm -f foo2
 
 test_expect_success POSIXPERM,SANITY 'git add --ignore-errors' '
-- 
2.8.4

