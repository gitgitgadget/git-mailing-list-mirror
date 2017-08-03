Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79391208B4
	for <e@80x24.org>; Thu,  3 Aug 2017 22:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbdHCWZu (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 18:25:50 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34870 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751921AbdHCWZt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 18:25:49 -0400
Received: by mail-pg0-f49.google.com with SMTP id v189so214168pgd.2
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 15:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=t59LhpWor6vMRYmfw88ejQ5MXSQ7yAKZuzSGK+VZwvI=;
        b=Llnnv48xx0hx+kTu1FvDwSVNUL8Vzg7nqolLtIPTSnIS7aPNSs7CWajWOnfN8o5fyn
         gY4Lrw03j4xA/koLOyS7HJ7POz6W7GBy6WRhkpSu5j0NWEyAUnyDWCfS6SG3aXu+Jp1X
         AfK36SGgWKaOS473sL1fYxcFcZOMBDaBp/k8QZdX0Rk0LEGrnKgW89gzDDDTmWC8T+80
         6CblO9oiMnhMEGhkRzUnTQnvlgoujwFu2BLe4Yc+rgQqjqG+dmVbfjiWCx3+ahAXEVGz
         bLKMhM8XaKfjJ8TIOmiGVpc5uupLEj8NzePe4evtaMiwytWpHtad6e6HsOB1tFfgZLzS
         4Eqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=t59LhpWor6vMRYmfw88ejQ5MXSQ7yAKZuzSGK+VZwvI=;
        b=ikjQrraeHL7bxuvbv6mmO6izQmjhtHcf8xP8qQJ0lRhsdO/0YnMGceX7vlh+8EM7Bx
         jCTnzM81zMfV7+AXOS0sADqt3SXMeH78BZcBvvWuAGhMzGZyeiloKIXHw8ooIbz4M1XD
         FZOs6bvr+jlKGw+xqTBfaoYb+euG7U/DJktkc7GC1WzTHkGKc48d5now3eJZuKPNmEgs
         AToav9OgIJK8fdFvhgjyrWtzROUTWSxfOVZ6XEFeuMMfiF3PCB1fSaaklw6959Dy8OuY
         LwTz+ASRbFSblzBqImQAZdQqNHlEWMQIhAs339sAfsP+WwLsLofXUQk6YoAWz+l1hXHA
         xl2A==
X-Gm-Message-State: AIVw111tMVl/vbxOf2Y6QpGHLswyHVKU5kWJe+8mdYT4J6A7kvL/+Nue
        p54+GGYPDP+zwlw5NIcl5g==
X-Received: by 10.84.168.4 with SMTP id e4mr340747plb.227.1501799148271;
        Thu, 03 Aug 2017 15:25:48 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id p123sm18023pfb.177.2017.08.03.15.25.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 15:25:47 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH] clone: teach recursive clones to respect -q
Date:   Thu,  3 Aug 2017 15:25:44 -0700
Message-Id: <20170803222544.17216-1-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach 'git clone --recurse-submodules' to respect the '-q' option by
passing down the quiet flag to the process which handles cloning of
submodules.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/clone.c            | 3 +++
 t/t7400-submodule-basic.sh | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 08b5cc433..f7e17d229 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -768,6 +768,9 @@ static int checkout(int submodule_progress)
 		if (submodule_progress)
 			argv_array_push(&args, "--progress");
 
+		if (option_verbosity < 0)
+			argv_array_push(&args, "--quiet");
+
 		err = run_command_v_opt(args.argv, RUN_GIT_CMD);
 		argv_array_clear(&args);
 	}
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index dcac364c5..e9c3335b7 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1289,4 +1289,10 @@ test_expect_success 'init properly sets the config' '
 	test_must_fail git -C multisuper_clone config --get submodule.sub1.active
 '
 
+test_expect_success 'recursive clone respects -q' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	git clone -q --recurse-submodules multisuper multisuper_clone >actual &&
+	test_must_be_empty actual
+'
+
 test_done
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

