Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F2AF203EA
	for <e@80x24.org>; Sat,  3 Dec 2016 00:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757302AbcLCAbD (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 19:31:03 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:32970 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754720AbcLCAat (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 19:30:49 -0500
Received: by mail-pg0-f44.google.com with SMTP id 3so112882867pgd.0
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 16:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mx+deCGPQM3HE2sw91xL6W4DgQ4ZzJL96h2wnPD0uwg=;
        b=pIAzGOWRyqGkz9AeaaMJnfXxQh27vat+kPR5PPx4FkG6NXkQPTkNf1CyK4aD1twMdZ
         SkR7meBFgFAwWNI1l4p5opxUsotMAAQUdabqbpzoVxic0+0eErWtlKZoIw/mA5bVwF6e
         YdgqdTeUJa376EnlvMcDIgmCNKVDWjqBTfartD+oWAqFcyX+4qA+iF+rZVK6FwwrtyFr
         Fge08dslecM+pgWaXFnRZfK2A6Un6mj5cP0qEa6z6B10aBaq0WLHYGuMdymyD//oH5aF
         +438uzbLwVoi08BTbQMjnkm9oprP+/gMd8U/Kg4HPbkX02ZF5/EIv/zD3IZZA3nUQU1S
         UkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mx+deCGPQM3HE2sw91xL6W4DgQ4ZzJL96h2wnPD0uwg=;
        b=AByWp2Spvyz8aq2PUyEM7IqHWDyQnxzYjMNcZF5QUBMG2YtB0hu3XGCBiAoeULWZnm
         cbs47mEX/XnNT7sQwlm3bUd/4ABqeCOIuqEBRDMMH9/BNC9qM4dLMRglwgbAx5eF2iRD
         SNr1zE8dXTmC2283iOofj4fCkj0JioWe/8lLTt/SWYL5d0FtTmnfYsy7sxMUX+d09eav
         YlGik9uS9Xiw8H1JVbgaqge4e6AILDa6T1zPWkjDEA2tSo65lbytQW85mqfajm8YJ0NN
         qSQNS5B9BO7TSlEbzMkON07qFUXdQ1/goTQkPzcT10SABftHyxu3Ve6dBaxWZ8t4qgN+
         JtJg==
X-Gm-Message-State: AKaTC03u/C65VIojdl4mvIYkc0lRV4l9z3y3GAU8qbit/gSomX4ClESXqKBTweON2xxhCSJ6
X-Received: by 10.99.99.195 with SMTP id x186mr85004580pgb.100.1480725041449;
        Fri, 02 Dec 2016 16:30:41 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:99ac:e2be:c532:3e35])
        by smtp.gmail.com with ESMTPSA id l11sm10263238pfb.28.2016.12.02.16.30.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 16:30:41 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, David.Turner@twosigma.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        hvoigt@hvoigt.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [RFC PATCHv2 07/17] update submodules: introduce submodule_is_interesting
Date:   Fri,  2 Dec 2016 16:30:12 -0800
Message-Id: <20161203003022.29797-8-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2673dad
In-Reply-To: <20161203003022.29797-1-sbeller@google.com>
References: <20161203003022.29797-1-sbeller@google.com>
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
 submodule.c | 23 +++++++++++++++++++++++
 submodule.h |  9 +++++++++
 2 files changed, 32 insertions(+)

diff --git a/submodule.c b/submodule.c
index 1ba398ba3b..62e9ef3872 100644
--- a/submodule.c
+++ b/submodule.c
@@ -516,6 +516,29 @@ void set_config_update_recurse_submodules(int value)
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
+int submodule_is_interesting(const char *path)
+{
+	const struct submodule *sub;
+
+	if (!submodules_interesting_for_update())
+		return 0;
+
+	sub = submodule_from_path(null_sha1, path);
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
index 21236b095c..7d890e0464 100644
--- a/submodule.h
+++ b/submodule.h
@@ -54,6 +54,15 @@ extern void show_submodule_inline_diff(FILE *f, const char *path,
 		const struct diff_options *opt);
 extern void set_config_fetch_recurse_submodules(int value);
 extern void set_config_update_recurse_submodules(int value);
+
+/**
+ * When updating the working tree, we need to check if the submodule needs
+ * updating. We do not require a check if we are already sure that the
+ * submodule doesn't need updating, e.g. when we are not interested in submodules
+ * or the submodule is marked uninteresting by being not initialized.
+ */
+extern int submodule_is_interesting(const char *path);
+extern int submodules_interesting_for_update(void);
 extern void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 extern int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
-- 
2.11.0.rc2.28.g2673dad

