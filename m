Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9ACB2021E
	for <e@80x24.org>; Tue, 15 Nov 2016 23:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934342AbcKOXM5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 18:12:57 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34852 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932927AbcKOXM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 18:12:57 -0500
Received: by mail-pf0-f179.google.com with SMTP id i88so38432926pfk.2
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 15:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DbwOG4epdec3jA1ARxqBfKToSmk6/v0js9cEWiPgaEE=;
        b=nuTCTcy35DLV3hC21rfQylgPtKgcLXTuoMRX9bQ+zkdf7hFrzBx8Cgmzy9oqj2IOGG
         tRCP7QIAWbk1K69Mo2JhWN6IRn+H74dA58k6S+qgbxy3JgmpIBq1yPLObagFgyGChrcM
         Lv56FJUVJOl6305BOOYGhrcIXH8z9hIbxOinWnBe50lpSWxqqE5m89SC8aqZvuVaHGqD
         YQxuDXRC8rlt7KZ+v5zM4GOnIGczfQQ60d8EP9aEY9N22eijycQ4wUza1mK4IB7Qd3ro
         JgnDvz+3g/2Dp8jya6unjVqT3/fsLE3FIfazRUYg+qqqfagFgrdCVY5A7G55aQg4/L0m
         Sc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DbwOG4epdec3jA1ARxqBfKToSmk6/v0js9cEWiPgaEE=;
        b=mYDzaGPyL9YaC8BiMAcTy7vP/t4vjrPVjGNBqD800O+cPIDDbuSLA7DjLgqcVbdsv7
         Q6L50d6YnR8Wx6dnErS8DgFWBGgrU3GfBccw8Sxxt5hpJQauRpesN3pbODK6JAeyw/yX
         3diZ46bFd1lMqdirapV1Le96GQ5DCJBEjikEJT3t5u9N9MDjyZrJEJEGMoY83+XCjfQy
         AlyAANshKnNRSw8TRBuNWTwLzb7xod+t1nWqJZRte1flsY9ZiHq3O2Jd9UwcgAql8XKV
         L+p91H2CgBU4SW3uCtrmsOA1QVVAp0KrCsliAekIz0arVf1yWvnZTreNvvyvTzEO6mzx
         /lyw==
X-Gm-Message-State: ABUngve+WxHzU1LpX68yWSgZRYGNXSkhUvFU6/UyrG8oNfg2U3Wm/Gq3Q/TVDYTbHKPo3uE/
X-Received: by 10.98.201.66 with SMTP id k63mr61746pfg.108.1479251222830;
        Tue, 15 Nov 2016 15:07:02 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:1161:a721:e128:bf5f])
        by smtp.gmail.com with ESMTPSA id q9sm46327534pfg.47.2016.11.15.15.07.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 15:07:02 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com,
        jrnieder@gmail.com, mogulguy10@gmail.com,
        David.Turner@twosigma.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 07/16] update submodules: introduce submodule_is_interesting
Date:   Tue, 15 Nov 2016 15:06:42 -0800
Message-Id: <20161115230651.23953-8-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161115230651.23953-1-sbeller@google.com>
References: <20161115230651.23953-1-sbeller@google.com>
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

I am not particular happy with the name `submodule_is_interesting`,
in internal iterations I had `submodule_requires_check_for_update`
and `submodule_needs_update`, but I was even less happy with those
names. Maybe `submodule_interesting_for_update`?

Generally this is to answer "Am I allowed to touch the submodule
at all?" or: "Does the user expect me to touch it?"
which includes all of creation/deletion/update.

This patch is based off a prior attempt by Jens Lehmann to add
submodules to checkout.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 37 +++++++++++++++++++++++++++++++++++++
 submodule.h |  8 ++++++++
 2 files changed, 45 insertions(+)

diff --git a/submodule.c b/submodule.c
index 38b0573..d34b721 100644
--- a/submodule.c
+++ b/submodule.c
@@ -500,6 +500,43 @@ void set_config_update_recurse_submodules(int value)
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
+int submodule_is_interesting(const char *path, const unsigned char *sha1)
+{
+	/*
+	 * If we cannot load a submodule config, we cannot get the name
+	 * of the submodule, so we'd need to follow the gitlink file
+	 */
+	const struct submodule *sub;
+
+	if (!submodules_interesting_for_update())
+		return 0;
+
+	sub = submodule_from_path(sha1, path);
+	if (!sub)
+		return 0;
+
+	switch (sub->update_strategy.type) {
+	case SM_UPDATE_UNSPECIFIED:
+	case SM_UPDATE_CHECKOUT:
+		return 1;
+	case SM_UPDATE_REBASE:
+	case SM_UPDATE_MERGE:
+	case SM_UPDATE_NONE:
+	case SM_UPDATE_COMMAND:
+		return 0;
+	}
+	return 0;
+}
+
 static int has_remote(const char *refname, const struct object_id *oid,
 		      int flags, void *cb_data)
 {
diff --git a/submodule.h b/submodule.h
index 185ad18..3df6881 100644
--- a/submodule.h
+++ b/submodule.h
@@ -57,6 +57,14 @@ extern void show_submodule_inline_diff(FILE *f, const char *path,
 		const struct diff_options *opt);
 extern void set_config_fetch_recurse_submodules(int value);
 extern void set_config_update_recurse_submodules(int value);
+/**
+ * When updating the working tree, do we need to check if the submodule needs
+ * updating. We do not require a check if we are already sure that the
+ * submodule doesn't need updating, e.g. when we are not interested in submodules
+ * or the submodule is marked uninteresting by being not initialized.
+ */
+extern int submodule_is_interesting(const char *path, const unsigned char *sha1);
+extern int submodules_interesting_for_update(void);
 extern void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 extern int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
-- 
2.10.1.469.g00a8914

