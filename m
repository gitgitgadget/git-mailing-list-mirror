Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F10EF2013A
	for <e@80x24.org>; Thu, 16 Feb 2017 00:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756249AbdBPAij (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 19:38:39 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36524 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752138AbdBPAif (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 19:38:35 -0500
Received: by mail-pf0-f180.google.com with SMTP id 189so782235pfu.3
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 16:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q2X8dmtjSZjcyWMLWOFNDKBLzO9R7rsOQzIHu1vw3xI=;
        b=BW0P4PYw1WxKAsBH5+TfSXZOK06elEM+Ypynmqw5hG/MrOFhu4DThS59Ykm1ubXXpT
         ai4hBn6KBlELGF2mRXLIPi/zirCyttiWlXMYMphzY00xgp2mbyIoCYYCkS7UvEzTegtn
         Bqh2yhQg2K1guqt64CBntuUNIvQb0pPD/vjl9TOPEZJkR0hIzIeS3qCqiqp+MXjYEfl3
         B5IUcIbj1chsqnf3yMTyNzqxUMd5bcURmu1vv6T/W0mv/Hb0tr0yXfyBV5TtgHYixruD
         OBt4AQlDG+Lr7jIBzqy9+VH7ogjNCx7O+gfTMnOgNHiMS5O54XVzxeX19gI1XXb0ewuW
         R0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q2X8dmtjSZjcyWMLWOFNDKBLzO9R7rsOQzIHu1vw3xI=;
        b=nyRc5WzGNCZ19Jvmut/E2sx8Kh4mE/Xaa5zpRVn1olvtGRMU7iKdnw1cpKB0WhRTnB
         zzrcw2jK8h46LCmSnwLsgpaA2MBdIXkZSmSKSksEzykWtDyyLqh7mP3PQaGVQQ4GIVNu
         thJYNyINTzu8wwqj2Ih2PHTXFw31p1hlhWVFcHXk3MYgkIm7uol+6+EuZfk9wOd4qUGs
         PpJWnc6HLUfUjWtKF1YTtPFdBvn4YgqWiNWGdfL1ZfaR8M0qKskK3//kHfuzTiG0Gcbp
         J8w0nmbJds6iUkyL4Npabj4eJ/UYNYPm40XduF4lg89MocZ7Q4ZXcFxIfj9Q64s5bknc
         40gw==
X-Gm-Message-State: AMke39kQUGIWPnJeqAMKgkM6wTls5YCye19a4qZf+nL9uHzKXlXBwqsFTVzpIpnonWiAjgy3
X-Received: by 10.99.125.68 with SMTP id m4mr42607720pgn.13.1487205509600;
        Wed, 15 Feb 2017 16:38:29 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2ca1:506:4965:89ed])
        by smtp.gmail.com with ESMTPSA id o24sm9537692pfj.78.2017.02.15.16.38.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 16:38:28 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 08/15] submodules: introduce check to see whether to touch a submodule
Date:   Wed, 15 Feb 2017 16:38:04 -0800
Message-Id: <20170216003811.18273-9-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <20170216003811.18273-1-sbeller@google.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com>
 <20170216003811.18273-1-sbeller@google.com>
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

So let's introduce a function that checks if a submodule needs
to be checked for an update before attempting the update.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 27 +++++++++++++++++++++++++++
 submodule.h | 13 +++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/submodule.c b/submodule.c
index 591f4a694e..2a37e03420 100644
--- a/submodule.c
+++ b/submodule.c
@@ -548,6 +548,33 @@ void set_config_update_recurse_submodules(int value)
 	config_update_recurse_submodules = value;
 }
 
+int touch_submodules_in_worktree(void)
+{
+	/*
+	 * Update can't be "none", "merge" or "rebase",
+	 * treat any value as OFF, except an explicit ON.
+	 */
+	return config_update_recurse_submodules == RECURSE_SUBMODULES_ON;
+}
+
+int is_active_submodule_with_strategy(const struct cache_entry *ce,
+				      enum submodule_update_type strategy)
+{
+	const struct submodule *sub;
+
+	if (!S_ISGITLINK(ce->ce_mode))
+		return 0;
+
+	if (!touch_submodules_in_worktree())
+		return 0;
+
+	sub = submodule_from_path(null_sha1, ce->name);
+	if (!sub)
+		return 0;
+
+	return sub->update_strategy.type == strategy;
+}
+
 static int has_remote(const char *refname, const struct object_id *oid,
 		      int flags, void *cb_data)
 {
diff --git a/submodule.h b/submodule.h
index b4e60c08d2..46d9f0f293 100644
--- a/submodule.h
+++ b/submodule.h
@@ -65,6 +65,19 @@ extern void show_submodule_inline_diff(FILE *f, const char *path,
 		const struct diff_options *opt);
 extern void set_config_fetch_recurse_submodules(int value);
 extern void set_config_update_recurse_submodules(int value);
+
+/*
+ * Traditionally Git ignored changes made for submodules.
+ * This function checks if we are interested in the given submodule
+ * for any kind of operation.
+ */
+extern int touch_submodules_in_worktree(void);
+/*
+ * Check if the given ce entry is a submodule with the given update
+ * strategy configured.
+ */
+extern int is_active_submodule_with_strategy(const struct cache_entry *ce,
+					     enum submodule_update_type strategy);
 extern void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 extern int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
-- 
2.12.0.rc1.16.ge4278d41a0.dirty

