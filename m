Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B26F202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 22:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753688AbdCIWQM (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:16:12 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35632 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753629AbdCIWQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 17:16:09 -0500
Received: by mail-pg0-f42.google.com with SMTP id b129so31147802pgc.2
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 14:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=to/FPnJd/Awh/oUgCIIwW/hejw7xuPBflNohpKeW+pk=;
        b=PAt4Yrz0gyi8O0BM6K7BUxIP7hhny7ynSqsXp0g7ifGowSJZLn/KgJKxNdUG67Oz9A
         gz47L0tEnqx8gSeVuPZxkFxW6jP74FZQFzGCjd/wFJvbuWpU17nVfvhiBr9jCCVeEQVs
         JKkhhS6B/Yop8o6lvuQezGLdlftF7zqZl43WE3O9mS6f+WKjKiUdHRfDcxndb6+NSeIV
         5DkSJ/DwQ1DL4tagwi7Dq227qopl00mWJKhAOzjIfBAMuRx45YsztrdvZuMDCiXoU+LF
         8J0Ts5LpiTVA5IWTElK5SEf9zYjgYL2aMrqL2RdpjaymYfIObxwjJQY5fchPZs/oaTQh
         Vq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=to/FPnJd/Awh/oUgCIIwW/hejw7xuPBflNohpKeW+pk=;
        b=rnO5L47jFppUmUUfoIJDh9hAXALxTHmTTXIyi8VVfQuSzn9uOg8eaxhBBIA6zgHJVF
         GrJtYMDJE4t1W/tT95eS9kGxZ2syUXGt3QgJoGVDfWc8nvxpmX3JJY9r6vfQOs7frgzX
         AKuP4aThAbW+eG6Mc124pNpK1vggC3iI8jGrjpfLnB75dgyhtU16l5W4GD9WxGDg54Z7
         x4+0s42zfu8VVhAr6bram0b9CgOsaKx94C9Hqd/TH3xXZKIejxvJyfhlhS4zzp5mHbuX
         5Ka39YMMyGgv+mY84AreLerI+wQerRZxQBKrg9/5igpwf1BtqcjFKMHVt4wQ+8ziCkBf
         LAQQ==
X-Gm-Message-State: AMke39nvK1TZszqvfUPAjtHFr+PuAGWEdKVgai2sPkWTlnh12kQbGPgzWyZuFtK7qL2rJpmh
X-Received: by 10.98.34.86 with SMTP id i83mr16853617pfi.89.1489097768440;
        Thu, 09 Mar 2017 14:16:08 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:7494:19e8:830b:a2d7])
        by smtp.gmail.com with ESMTPSA id h25sm14285273pfk.119.2017.03.09.14.16.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 14:16:07 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 10/17] submodules: introduce check to see whether to touch a submodule
Date:   Thu,  9 Mar 2017 14:15:36 -0800
Message-Id: <20170309221543.15897-11-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.45.gf291f29c2e
In-Reply-To: <20170309221543.15897-1-sbeller@google.com>
References: <20170306205919.9713-1-sbeller@google.com>
 <20170309221543.15897-1-sbeller@google.com>
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
 submodule.c | 16 ++++++++++++++++
 submodule.h |  7 +++++++
 2 files changed, 23 insertions(+)

diff --git a/submodule.c b/submodule.c
index 591f4a694e..8b2c0212be 100644
--- a/submodule.c
+++ b/submodule.c
@@ -548,6 +548,22 @@ void set_config_update_recurse_submodules(int value)
 	config_update_recurse_submodules = value;
 }
 
+int should_update_submodules(void)
+{
+	return config_update_recurse_submodules == RECURSE_SUBMODULES_ON;
+}
+
+const struct submodule *submodule_from_ce(const struct cache_entry *ce)
+{
+	if (!S_ISGITLINK(ce->ce_mode))
+		return NULL;
+
+	if (!should_update_submodules())
+		return NULL;
+
+	return submodule_from_path(null_sha1, ce->name);
+}
+
 static int has_remote(const char *refname, const struct object_id *oid,
 		      int flags, void *cb_data)
 {
diff --git a/submodule.h b/submodule.h
index b4e60c08d2..6f3fe85c7c 100644
--- a/submodule.h
+++ b/submodule.h
@@ -65,6 +65,13 @@ extern void show_submodule_inline_diff(FILE *f, const char *path,
 		const struct diff_options *opt);
 extern void set_config_fetch_recurse_submodules(int value);
 extern void set_config_update_recurse_submodules(int value);
+/* Check if we want to update any submodule.*/
+extern int should_update_submodules(void);
+/*
+ * Returns the submodule struct if the given ce entry is a submodule
+ * and it should be updated. Returns NULL otherwise.
+ */
+extern const struct submodule *submodule_from_ce(const struct cache_entry *ce);
 extern void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 extern int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
-- 
2.12.0.rc1.45.g207f5fbb2b

