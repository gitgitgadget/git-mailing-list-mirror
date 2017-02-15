Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72D9E2013C
	for <e@80x24.org>; Wed, 15 Feb 2017 00:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbdBOAfR (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 19:35:17 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:37556 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdBOAfN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 19:35:13 -0500
Received: by mail-it0-f44.google.com with SMTP id x75so54906310itb.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 16:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ciJpgIf2pP/R8HIoDCcArN38sA/IbWZi9LBYrCra7q8=;
        b=h0Pid60MAvMf4MqKqDUqawq0pCisZ4wr9R/tq1iHAsTpkeD5R9r3krl3VhHkUMS+bp
         ZobQwU7rp1EyzOy6dV4R8uL9Ib8zz66fWsyqAWQqcQ6Jtvf0fnNVjbhgWIK4RAhSOXKk
         so85HTOy9Cj1SQxm5CKi8gf/X6Fe+wLQXHNg2aj59JD7/TRSk9Ou1YmPWmY533/vbEnY
         5XyV80BqkvGJ0KxaWRMJe7VkowkUox/kyTftwLIWjHyMYIdH/JeCY4YZ7j1NYG0tMBo3
         g/uMGVFPzr6RXu3T1ojxe6GwNd9NsMigBEAV6N/qs8xpeHixeW53ADx6DsjjnSew8UVW
         RLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ciJpgIf2pP/R8HIoDCcArN38sA/IbWZi9LBYrCra7q8=;
        b=ugV+NmgtrmKbWAGuZbfJf2o0374wMq4qzhF5SWnF847ABrxn1ltCtNwIB6x7DK03mL
         y7SmZIIGw9MUSNyKjYqgZ6Ssl98ouUlk07WvYw6a5AikbwhjmPsP7hPWKJMlpY9b27SZ
         48p0fEhCH6MnmtHEsbstEOUTdiN2n4n+7bJu6N2+PChxTvrwxWh9xiX7zIa/4GyTn1iH
         XbUEf+oeQNFJf1MOreBBrMiVuWvwZwic2csjnjKLrKYxErGuMhM6hrLPQIgJFo+dlCL0
         PZYIZgbStGs2dqT95FXiic11ld+gXsL6kUnOdX1qDcfKbChpgifuoPWrc0D3XmrNzxpF
         sGyQ==
X-Gm-Message-State: AMke39ky+SKKnvt6o0TidTkfikK9GynhMkh0+KJA2rklsnUycBpbOasrOTBNVH/rFB/E2m9s
X-Received: by 10.99.67.130 with SMTP id q124mr35896295pga.221.1487118912592;
        Tue, 14 Feb 2017 16:35:12 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:c832:5c94:8ab0:6fa4])
        by smtp.gmail.com with ESMTPSA id x15sm3292243pgo.56.2017.02.14.16.35.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 16:35:12 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        sandals@crustytoothpaste.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 07/14] update submodules: introduce is_interesting_submodule
Date:   Tue, 14 Feb 2017 16:34:16 -0800
Message-Id: <20170215003423.20245-8-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc0.16.gd1691994b4.dirty
In-Reply-To: <20170215003423.20245-1-sbeller@google.com>
References: <20170215003423.20245-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In later patches we introduce the --recurse-submodule flag for commands
that modify the working directory, e.g. git-checkout.

It is potentially expensive to check if a submodule needs an update,
because a common theme to interact with submodules is to spawn a child
process for each interaction.

So let's introduce a function that pre checks if a submodule needs
to be checked for an update.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 26 ++++++++++++++++++++++++++
 submodule.h |  8 ++++++++
 2 files changed, 34 insertions(+)

diff --git a/submodule.c b/submodule.c
index c0060c29f2..4c33374ae8 100644
--- a/submodule.c
+++ b/submodule.c
@@ -551,6 +551,32 @@ void set_config_update_recurse_submodules(int value)
 	config_update_recurse_submodules = value;
 }
 
+int submodules_interesting_for_update(void)
+{
+	/*
+	 * Update can't be "none", "merge" or "rebase",
+	 * treat any value as OFF, except an explicit ON.
+	 */
+	return config_update_recurse_submodules == RECURSE_SUBMODULES_ON;
+}
+
+int is_interesting_submodule(const struct cache_entry *ce)
+{
+	const struct submodule *sub;
+
+	if (!S_ISGITLINK(ce->ce_mode))
+		return 0;
+
+	if (!submodules_interesting_for_update())
+		return 0;
+
+	sub = submodule_from_path(null_sha1, ce->name);
+	if (!sub)
+		return 0;
+
+	return sub->update_strategy.type != SM_UPDATE_NONE;
+}
+
 static int has_remote(const char *refname, const struct object_id *oid,
 		      int flags, void *cb_data)
 {
diff --git a/submodule.h b/submodule.h
index c4e1ac828e..84b67a7c4a 100644
--- a/submodule.h
+++ b/submodule.h
@@ -59,6 +59,14 @@ extern void show_submodule_inline_diff(FILE *f, const char *path,
 		const struct diff_options *opt);
 extern void set_config_fetch_recurse_submodules(int value);
 extern void set_config_update_recurse_submodules(int value);
+
+/*
+ * Traditionally Git ignored changes made for submodules.
+ * This function checks if we are interested in the given submodule
+ * for any kind of operation.
+ */
+extern int submodules_interesting_for_update(void);
+extern int is_interesting_submodule(const struct cache_entry *ce);
 extern void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 extern int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
-- 
2.12.0.rc0.16.gd1691994b4.dirty

