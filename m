Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACCD920951
	for <e@80x24.org>; Tue, 14 Mar 2017 21:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbdCNVrH (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 17:47:07 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36426 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752190AbdCNVrE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 17:47:04 -0400
Received: by mail-pf0-f178.google.com with SMTP id o126so75980739pfb.3
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 14:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oi50E2XBC6FBBykVtVVuvYSmeV2EkbaXo7E4J/rdxPo=;
        b=AzvUqedBF0zHX/CTMuMYZH1pDqz3CuMlwvbIwjXWtC34N7UOXkOLfkSRojFDjk/+Y4
         jajZM0Lkhh1h5JSC9EtBnKGndDIMab5J4Nqo37Us8q4WAQwbdq5V46Qk4l3OqpmixIdv
         eql17JodKkabZ5AmuMQRaP8WJs5+PZYfGpkjrkDtHb1N3btgKP+jksMWW43EVYfztolK
         ooyKV0Kv6q48JhVqf+R0hdNf0FvQEsWlXo1XREIlxUeJOkNdTCB9OEAwUDYnQvlR49ms
         YeQ6awM5xJwEzXPS4fW1TuMFRJ0NjGg3oaxggZYo8k++6oHJQwwClNDyTeIL7KNrR36/
         wjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oi50E2XBC6FBBykVtVVuvYSmeV2EkbaXo7E4J/rdxPo=;
        b=QF5K9Ks4Yx2kdyozkYWfo05wRZACHoGH1zaPeTT55IP1WXpq7jh1JVyHJkEp7B0dN6
         TK/SGHyaserw6ReQiMAwJmNiCcUC6LN0tmw1K9yblFNQkVgR8QhOXjPpg+6wR+V4q9Yf
         tHo2iquE8onO4yadWTOIbpeGV3h/C7XcVMTN2BxYtxQzLQcG36loM+pvRChNnnNs1+5C
         q9DNUkEvXYJTBcBnqQywXESU/BEv2BebSKMW8QHzAFW5W7vijQEYUMl7yC8NpCR1SSCa
         III25NOC0jihoOKK8fRROp3Itk/P0f1rVTebdNKOUdjEgNflylZ6pZ4bwGmLyl25iNmg
         qAqQ==
X-Gm-Message-State: AMke39mzbtbnNPromub0aXOc1yBVBtAlZrh2+mtExe+hNMB8FekMR+m/8jYoZcK89g/1eVqf
X-Received: by 10.98.44.15 with SMTP id s15mr46621156pfs.161.1489528022989;
        Tue, 14 Mar 2017 14:47:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:8559:2c0d:dab3:f802])
        by smtp.gmail.com with ESMTPSA id z68sm40567099pgz.11.2017.03.14.14.47.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 14:47:02 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 11/19] submodules: introduce check to see whether to touch a submodule
Date:   Tue, 14 Mar 2017 14:46:34 -0700
Message-Id: <20170314214642.7701-12-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.49.g0cfd38c5f6.dirty
In-Reply-To: <20170314214642.7701-1-sbeller@google.com>
References: <20170309221543.15897-1-sbeller@google.com>
 <20170314214642.7701-1-sbeller@google.com>
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
2.12.0.rc1.49.g0cfd38c5f6.dirty

