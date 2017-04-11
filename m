Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3480420970
	for <e@80x24.org>; Tue, 11 Apr 2017 23:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753079AbdDKXt4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 19:49:56 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33360 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752663AbdDKXtw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 19:49:52 -0400
Received: by mail-pg0-f42.google.com with SMTP id x125so5772481pgb.0
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 16:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dP92cViUloap6m/MmMBS2Y2Z0S6Pig1ynwZb+LOo1CE=;
        b=gm79XeNgi9S5P5xZNMF2303D5bCe/B2iGpsIxNPaz7rfC3IDAXPVGPq65luUD6a45j
         vLE+xFYsvX3m083SEDpw+lZZ/5er8xLFaAAWoYTo1Xd2EYq4RI4gF/F5ktCo6mKgJ7x/
         8NGOnnjHqnA1a+piL4jKeHuIrELTDzhYLRWmEdtclo+dkR6tRGs+pJ9QS4s52UxCZJqT
         KRpAVNoKlrYee1ZXJ750FqUaursUOarq4M6tjnHJcJsjvXbs40cmxyqb1/jPRfWj2iF0
         vejoJwgaMZ1JQPy/IgNhsz0M5Lsxgz6VLBVIoLcesiSjdlXjhJJS/2boqxkXs7qJ/KrF
         /uuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dP92cViUloap6m/MmMBS2Y2Z0S6Pig1ynwZb+LOo1CE=;
        b=g5oTiy3ZaUPwa89p1CU7fWsjPxY6BUAgqf0FijcWR4vJ7+Lg1mswmQYd+NIfjlRvhn
         u9siXwJpi69B8LPl5zCxn49ba0mzeXinJ/RMEG7DkZxfijRTUJWE0/O34iOLxoNcPjLG
         abYrmf9q8uWJNj2SdxlN634ZNHwzXOMNBg7dn7ZotbnvoA7AsHFEHkA0w9g2REh0KuIk
         pi671eupB5yA6tcV+1hKe0IR7KDEOjVRA3CM4HriDqTRbD4BGw8LJ3ZrRMfQk6H6w8Ak
         +oUknk6jYrnh3XGbccT0HvW2IO7JwNK15cvHNElxIeYE6xp31WywWciLd1UOyKxEp3s4
         BEmw==
X-Gm-Message-State: AFeK/H2Es/YP8LlFLgUys3acS7YLln1r5WqdGLx0qcdjuGXrTLNEFFDcHgkVsk5EeO5G7Zym
X-Received: by 10.84.232.10 with SMTP id h10mr78639672plk.143.1491954591420;
        Tue, 11 Apr 2017 16:49:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:118b:650f:9c66:86dd])
        by smtp.gmail.com with ESMTPSA id i185sm27532300pge.48.2017.04.11.16.49.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 16:49:50 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/4] builtin/reset: add --recurse-submodules switch
Date:   Tue, 11 Apr 2017 16:49:23 -0700
Message-Id: <20170411234923.1860-5-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.603.g7b28dc31ba
In-Reply-To: <20170411234923.1860-1-sbeller@google.com>
References: <20170411234923.1860-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-reset is yet another working tree manipulator, which should
be taught about submodules.

One use case of "git-reset" is to reset to a known good state,
and dropping commits that did not work as expected.
In that case one of the expected outcomes from a hard reset
would be to have broken submodules reset to a known good
state as well.  A test for this was added in a prior patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/reset.c            | 30 ++++++++++++++++++++++++++++++
 t/t7112-reset-submodule.sh |  8 ++++++++
 2 files changed, 38 insertions(+)

diff --git a/builtin/reset.c b/builtin/reset.c
index fc3b906c47..5ce27fcaed 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -21,6 +21,27 @@
 #include "parse-options.h"
 #include "unpack-trees.h"
 #include "cache-tree.h"
+#include "submodule.h"
+#include "submodule-config.h"
+
+static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+
+static int option_parse_recurse_submodules(const struct option *opt,
+					   const char *arg, int unset)
+{
+	if (unset) {
+		recurse_submodules = RECURSE_SUBMODULES_OFF;
+		return 0;
+	}
+	if (arg)
+		recurse_submodules =
+			parse_update_recurse_submodules_arg(opt->long_name,
+							    arg);
+	else
+		recurse_submodules = RECURSE_SUBMODULES_ON;
+
+	return 0;
+}
 
 static const char * const git_reset_usage[] = {
 	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
@@ -283,6 +304,9 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				N_("reset HEAD, index and working tree"), MERGE),
 		OPT_SET_INT(0, "keep", &reset_type,
 				N_("reset HEAD but keep local changes"), KEEP),
+		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules,
+			    "reset", "control recursive updating of submodules",
+			    PARSE_OPT_OPTARG, option_parse_recurse_submodules },
 		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")),
 		OPT_BOOL('N', "intent-to-add", &intent_to_add,
 				N_("record only the fact that removed paths will be added later")),
@@ -295,6 +319,12 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 						PARSE_OPT_KEEP_DASHDASH);
 	parse_args(&pathspec, argv, prefix, patch_mode, &rev);
 
+	if (recurse_submodules != RECURSE_SUBMODULES_DEFAULT) {
+		gitmodules_config();
+		git_config(submodule_config, NULL);
+		set_config_update_recurse_submodules(RECURSE_SUBMODULES_ON);
+	}
+
 	unborn = !strcmp(rev, "HEAD") && get_sha1("HEAD", oid.hash);
 	if (unborn) {
 		/* reset on unborn branch: treat as reset to empty tree */
diff --git a/t/t7112-reset-submodule.sh b/t/t7112-reset-submodule.sh
index 2eda6adeb1..f86ccdf215 100755
--- a/t/t7112-reset-submodule.sh
+++ b/t/t7112-reset-submodule.sh
@@ -5,6 +5,14 @@ test_description='reset can handle submodules'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
+KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED=1
+KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
+KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED=1
+
+test_submodule_switch_recursing "git reset --recurse-submodules --keep"
+
+test_submodule_forced_switch_recursing "git reset --hard --recurse-submodules"
+
 test_submodule_switch "git reset --keep"
 
 test_submodule_switch "git reset --merge"
-- 
2.12.2.603.g7b28dc31ba

