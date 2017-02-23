Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91A5A2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751308AbdBWXEM (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:04:12 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35684 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbdBWXEL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:04:11 -0500
Received: by mail-pg0-f47.google.com with SMTP id b129so2284752pgc.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 15:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nIgQr/8hm+W/sovAd2jP4vl9pDza121ThQNvA3PF+uw=;
        b=Tjmaj2a6CHOPYyBhjTKj7ghxp0DSBtOpmO8QJYSfeQQs/Zs3ln8KiMxSRvFLp9N2NU
         mRvCbtQSo26+tXBpal7bQMzvgzWWFwIjdEf1W76O1lgopH/dxbyYL1O+rVh2dQe72YZx
         RDRQSzY0zs/dCV4fKP4EF/CY04zN1VZ5GuuNE17UF9vjHFlK6Lj1M7v2G0x7TPjSb3X4
         rd1mUDm6r/Fg0Cpya95Jj2cfZTt2i07kpaQ6s3tAWMPs9bX9/+kW95JOBU3a5iJSc4Si
         pvjbQsK+wMue5NOh57tOxL8wPp4tgS4etd7zJxHPwzMx1J9dOdY/TfTAvHM/X0Mlqxqx
         9QfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nIgQr/8hm+W/sovAd2jP4vl9pDza121ThQNvA3PF+uw=;
        b=GywDZ6JIEFreOeEYOweZL9fluGl0JnYHW0iWcm9qkSt/xcu1VrUpNrQFhrU0bzsRaV
         gDRBlgcs35kIXMR5pAdyTGYneubrxOuX3noVGry5sNgawHt3DD0GoFTEUNCGRi7gGHN0
         OQjxqVAke81JIgo6H76YVhHQvRfixSoDdRB7sGKFGz0faq0fBiUwSv+VLB672/AzyXZR
         tb3AudP26PJj2BQVZwLQ/AssNdVOommP4hClenIE25ckBE/G0nkChh0DPzSibAeI6aR1
         tU+/iYUxyDNJsf+U7MfrA+Vk68VdLMTYxTigRLHrDzewG2HwDojnIBwgJPWWv4+zC9mn
         c+jg==
X-Gm-Message-State: AMke39nh/PWn521mMeeCDAJxSo4v0P9Bm91cLDaRLZNKzYLvYndg52eo7IiNEIuDC2eDfnWS
X-Received: by 10.99.67.130 with SMTP id q124mr51461769pga.221.1487890681470;
        Thu, 23 Feb 2017 14:58:01 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:ad75:dfc7:8a6:1152])
        by smtp.gmail.com with ESMTPSA id t6sm11654623pgo.42.2017.02.23.14.58.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 14:58:00 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com, gitster@pobox.com,
        novalis@novalis.org
Subject: [PATCH 08/15] submodules: introduce check to see whether to touch a submodule
Date:   Thu, 23 Feb 2017 14:57:28 -0800
Message-Id: <20170223225735.10994-9-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <20170223225735.10994-1-sbeller@google.com>
References: <xmqqlgt5vlse.fsf@gitster.mtv.corp.google.com>
 <20170223225735.10994-1-sbeller@google.com>
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
2.12.0.rc1.16.ge4278d41a0.dirty

