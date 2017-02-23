Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 020852022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbdBWXtE (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:49:04 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35991 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751392AbdBWXs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:48:58 -0500
Received: by mail-pg0-f53.google.com with SMTP id s67so2687287pgb.3
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 15:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZcJ5rH8jvPqGqHOsQuca5VUeg+FuG5EeNGKTipjMnqk=;
        b=QLqCYiqa0WJ+UgNJ+NVX2rs8rf1O0PVhafflwhmzX5cQT7BAvZaoOPprlaQdPQM3IU
         kr7yNTBpyANKxPAQSXyDKYZq1odpi/1dZcCwh5p2mcxt6GQDmR1sCTfHT9cVeXMx1FAl
         SYkheslo+3vzon1rPQnJEYd2lD1USYADv8B63G7lNgvu0E6ETs1Uf3habJbwrMy4kvjY
         /gDLsJ+TikzegnRFZWsWdOsRv6qf7I/DwBh4dJjPKPcyuhsKs8ftHD5PyKIQ2Ydk/R2u
         QOjX53spe2TuUJ5AqddQPBiV6Lpro4bxAZRXYHPhEWmI/ekFr5SN0h9Czt1pF76MLAcP
         ucpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZcJ5rH8jvPqGqHOsQuca5VUeg+FuG5EeNGKTipjMnqk=;
        b=OJLi2D93evJZAiwoEM1qMJ+JY/Ot3ESRBVbzgkvW6sydmYTz082OgVY2Op24xcuDLj
         nY9E4ojBoxFK4XWA2ff4AgoQu05DkAep0d5jMQgP9aX2q1n8wO5D13ZgJo3Mey3NI7k4
         F5j5iRWHaS9Nwddd7MKdOoZdZ61isckUmJKi1uZz8yMQyPrg9AuMtNRC1+M65e/t46IO
         k3hW1RKfjNGjHJerYk+DZyS/2usQ5oLDDlc+hhEWmTAwpHWzmlLdFu+g8sytOxKyPmVf
         PwBN4op9w/QJ3Y24RjVgkPhLqECX8LSFDpSQMLzNJqPuTFEws0IQZkNeX8XUTVURnkCI
         9nHA==
X-Gm-Message-State: AMke39kNe/gyO38qzRP7brNpA7hP5e/KMpJCtT3FMPADgRfqPh40rp2efrKpnA5Er6v/sZHS
X-Received: by 10.98.3.3 with SMTP id 3mr2498476pfd.95.1487893666292;
        Thu, 23 Feb 2017 15:47:46 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id r74sm11660300pfb.67.2017.02.23.15.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 15:47:45 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 05/10] submodule--helper: add is_active command
Date:   Thu, 23 Feb 2017 15:47:23 -0800
Message-Id: <20170223234728.164111-6-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170223234728.164111-1-bmwill@google.com>
References: <20170223234728.164111-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a lot of places where an explicit check for
submodule."<name>".url is done to see if a submodule exists.  In order
to more easily facilitate the use of the submodule.active config option
to indicate active submodules, add a helper which can be used to query
if a submodule is active or not.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/submodule--helper.c    | 11 ++++++++
 t/t7413-submodule-is-active.sh | 63 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100755 t/t7413-submodule-is-active.sh

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index df0d9c166..dac02604d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1128,6 +1128,16 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int is_active(int argc, const char **argv, const char *prefix)
+{
+	if (argc != 2)
+		die("submodule--helper is-active takes exactly 1 arguments");
+
+	gitmodules_config();
+
+	return !is_submodule_initialized(argv[1]);
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -1147,6 +1157,7 @@ static struct cmd_struct commands[] = {
 	{"init", module_init, 0},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
+	{"is-active", is_active, 0},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
new file mode 100755
index 000000000..683487020
--- /dev/null
+++ b/t/t7413-submodule-is-active.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+
+test_description='Test submodule--helper is-active
+
+This test verifies that `git submodue--helper is-active` correclty identifies
+submodules which are "active" and interesting to the user.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	git init sub &&
+	test_commit -C sub initial &&
+	git init super &&
+	test_commit -C super initial &&
+	git -C super submodule add ../sub sub1 &&
+	git -C super submodule add ../sub sub2 &&
+	git -C super commit -a -m "add 2 submodules at sub{1,2}"
+'
+
+test_expect_success 'is-active works with urls' '
+	git -C super submodule--helper is-active sub1 &&
+	git -C super submodule--helper is-active sub2 &&
+
+	git -C super config --unset submodule.sub1.URL &&
+	test_must_fail git -C super submodule--helper is-active sub1 &&
+	git -C super config submodule.sub1.URL ../sub &&
+	git -C super submodule--helper is-active sub1
+'
+
+test_expect_success 'is-active works with basic submodule.active config' '
+	git -C super config --add submodule.active "." &&
+	git -C super config --unset submodule.sub1.URL &&
+	git -C super config --unset submodule.sub2.URL &&
+
+	git -C super submodule--helper is-active sub1 &&
+	git -C super submodule--helper is-active sub2 &&
+
+	git -C super config submodule.sub1.URL ../sub &&
+	git -C super config submodule.sub2.URL ../sub &&
+	git -C super config --unset-all submodule.active
+'
+
+test_expect_success 'is-active correctly works with paths that are not submodules' '
+	test_must_fail git -C super submodule--helper is-active not-a-submodule &&
+
+	git -C super config --add submodule.active "." &&
+	test_must_fail git -C super submodule--helper is-active not-a-submodule &&
+
+	git -C super config --unset-all submodule.active
+'
+
+test_expect_success 'is-active works with exclusions in submodule.active config' '
+	git -C super config --add submodule.active "." &&
+	git -C super config --add submodule.active ":(exclude)sub1" &&
+
+	test_must_fail git -C super submodule--helper is-active sub1 &&
+	git -C super submodule--helper is-active sub2 &&
+
+	git -C super config --unset-all submodule.active
+'
+
+test_done
-- 
2.11.0.483.g087da7b7c-goog

