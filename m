Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B686C20281
	for <e@80x24.org>; Tue,  3 Oct 2017 04:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750830AbdJCEHn (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 00:07:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52771 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750708AbdJCEHm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 00:07:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D8BAA79A1;
        Tue,  3 Oct 2017 00:07:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=Ug6J
        S1MqYe8Lll6By7aHaCRRaVk=; b=Uf8aA3OBsU97jaHAtUEY+lDkj0oqimpavUNw
        rBzs4uHEHk4BLCO7Zmk+uceSQL0lRqluh7YlHc20P1VpV5IG7pcl3elxZWpMm6k/
        dzpBsusGhf5z9KvpsayloTAyFMHnKJHDp3Xl8j4/xUHwTL6Xgd/np/+WZOooQN3S
        0k4LrLI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        wLCDW8HWsl3B2a7ZVgNgFx154Sxdqx+zxoJ846EhNUXssd+CHF7bCaQiKyONcWRL
        ONVj2AB1y9kItDVNwb1X2sEVih9SA/I1DwswKFKX0RUXpRUC0beXXNxg2wu+aEdB
        bJzTVfVLmlPgOoW9p3qZQ2oDKXsOIh1L9DaVtyBCvlM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C442A79A0;
        Tue,  3 Oct 2017 00:07:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 912B1A799F;
        Tue,  3 Oct 2017 00:07:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH 1/2] Revert "color: check color.ui in git_default_config()"
Date:   Tue,  3 Oct 2017 13:07:36 +0900
Message-Id: <20171003040737.2336-2-gitster@pobox.com>
X-Mailer: git-send-email 2.14.2-882-gfe33df219d
In-Reply-To: <20171003040737.2336-1-gitster@pobox.com>
References: <20171002230017.GT19555@aiede.mtv.corp.google.com>
 <20171003040737.2336-1-gitster@pobox.com>
X-Pobox-Relay-ID: 6629FB8E-A7F0-11E7-BB48-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reverts commit 136c8c8b8fa39f1315713248473dececf20f8fe7.

Even though we do want to fix the fallout from 4c7f1819 ("make
color.ui default to 'auto'", 2013-06-10), which made it impossible
to override it with "git -c color.ui={never,always} $plumbing",
allowing the plumbing commands to pay attention to color.ui
configuration variable turned out to be an unsatisfactory fix.

People who had color.ui=always, thinking that it should be safe to
do, because it won't apply to plumbing commands, got burned by it.

A bit of fix-up patches are needed, as the series that included the
patch being reverted, and changes after the series landed, have
and/or added code that assumes git_default_config() would read the
color.ui, and they need to be adjusted.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/branch.c      | 2 +-
 builtin/clean.c       | 3 ++-
 builtin/grep.c        | 2 +-
 builtin/show-branch.c | 2 +-
 color.c               | 8 ++++++++
 config.c              | 4 ----
 diff.c                | 3 +++
 7 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 16d391b407..1969c7116c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -92,7 +92,7 @@ static int git_branch_config(const char *var, const char *value, void *cb)
 			return config_error_nonbool(var);
 		return color_parse(value, branch_colors[slot]);
 	}
-	return git_default_config(var, value, cb);
+	return git_color_default_config(var, value, cb);
 }
 
 static const char *branch_get_color(enum color_branch ix)
diff --git a/builtin/clean.c b/builtin/clean.c
index c1bafda5b6..057fc97fe4 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -125,7 +125,8 @@ static int git_clean_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	return git_default_config(var, value, cb);
+	/* inspect the color.ui config variable and others */
+	return git_color_default_config(var, value, cb);
 }
 
 static const char *clean_get_color(enum color_clean ix)
diff --git a/builtin/grep.c b/builtin/grep.c
index a7157f5632..0d6e669732 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -284,7 +284,7 @@ static int wait_all(void)
 static int grep_cmd_config(const char *var, const char *value, void *cb)
 {
 	int st = grep_config(var, value, cb);
-	if (git_default_config(var, value, cb) < 0)
+	if (git_color_default_config(var, value, cb) < 0)
 		st = -1;
 
 	if (!strcmp(var, "grep.threads")) {
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 28f245c8cc..7073a3eb97 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -554,7 +554,7 @@ static int git_show_branch_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	return git_default_config(var, value, cb);
+	return git_color_default_config(var, value, cb);
 }
 
 static int omit_in_dense(struct commit *commit, struct commit **rev, int n)
diff --git a/color.c b/color.c
index 7aa8b076f0..31b6207a00 100644
--- a/color.c
+++ b/color.c
@@ -361,6 +361,14 @@ int git_color_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
+int git_color_default_config(const char *var, const char *value, void *cb)
+{
+	if (git_color_config(var, value, cb) < 0)
+		return -1;
+
+	return git_default_config(var, value, cb);
+}
+
 void color_print_strbuf(FILE *fp, const char *color, const struct strbuf *sb)
 {
 	if (*color)
diff --git a/config.c b/config.c
index bc290e7563..a9356c1383 100644
--- a/config.c
+++ b/config.c
@@ -16,7 +16,6 @@
 #include "string-list.h"
 #include "utf8.h"
 #include "dir.h"
-#include "color.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -1351,9 +1350,6 @@ int git_default_config(const char *var, const char *value, void *dummy)
 	if (starts_with(var, "advice."))
 		return git_default_advice_config(var, value);
 
-	if (git_color_config(var, value, dummy) < 0)
-		return -1;
-
 	if (!strcmp(var, "pager.color") || !strcmp(var, "color.pager")) {
 		pager_use_color = git_config_bool(var,value);
 		return 0;
diff --git a/diff.c b/diff.c
index 9c38258030..85e714f6c6 100644
--- a/diff.c
+++ b/diff.c
@@ -299,6 +299,9 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (git_color_config(var, value, cb) < 0)
+		return -1;
+
 	return git_diff_basic_config(var, value, cb);
 }
 
-- 
2.14.2-882-gfe33df219d

