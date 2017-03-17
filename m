Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D80C220951
	for <e@80x24.org>; Fri, 17 Mar 2017 22:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751299AbdCQWpV (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 18:45:21 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35663 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbdCQWpU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 18:45:20 -0400
Received: by mail-pg0-f47.google.com with SMTP id b129so49626003pgc.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 15:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RVYyiWhecI1ttKioJQpHMV5DWCgFEXU8nkuFUhzYRV0=;
        b=faRk1t3J0XXVcSsvzxQomHoAco8cURCOWE3dazU7v2clj9HLu/cb5nWK3ZSL20hLo3
         bnpUqKW58V/hKwxBWm/IFGUSTplcxszCULnjJvQJU0T4Gtm+w3uKDuLF7AyYunyy6yzv
         T0dubX4aMuShWFWy667CR8dDzJ0Trmdx7aYmgLDl/Ejy8K6ECfe6poKnQQTyWB7T6HEC
         ibXXKutDLzJ59s6KYyCFDmH5tmYcQVZdKagwclziwCEwYH86Q0a0aj7G8brUBacIEubL
         T5uSn+cGTjEs2MUYTu3uxw1Hb+eKRJxT1hlEdoOLf8jfC1DIlSOXHoC/piUScPksaemL
         YSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RVYyiWhecI1ttKioJQpHMV5DWCgFEXU8nkuFUhzYRV0=;
        b=dvrr1hOuuiq81mii5lQlox8wpsO5cZo0JfjFQ2/IPt9i9aVtGAHJGyrbn1b21YhxtN
         HAH6OafUETivJod3x6oT3l4nqmOiM9RdKADtYhujRNIchaHZ1RSuWqm6zCMGeaVde4p8
         CreiBJrrS/UdHEFnUyu1BGYCclkRW3g7Rzwd9Zjy1J/AkUy3cLHVxoRpDN++HY1C9z2F
         dlOBklFtDpnZ40JzkhXYaQSY82XgMO1X1ASHVUK7NOVkhjRPD5rpi7lsPD/ViD33/3FN
         w20hUd8uYIsztL2gkcovuKVTdpwiy0kjj+zitzJ2rKuvYwvDVfnUwAXhu1VfF7WuLJ8c
         SLyQ==
X-Gm-Message-State: AFeK/H24q9EBgxQk/FdL+e5O5skcBkk2mTMyzngwTEv2RuDh3f1ACM/5YJ6VhyChppLToRm5
X-Received: by 10.99.247.17 with SMTP id x17mr18721910pgh.5.1489790308136;
        Fri, 17 Mar 2017 15:38:28 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id d3sm18699763pfc.51.2017.03.17.15.38.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 15:38:26 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v5 09/10] submodule--helper init: set submodule.<name>.active
Date:   Fri, 17 Mar 2017 15:38:04 -0700
Message-Id: <20170317223805.95271-10-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170317223805.95271-1-bmwill@google.com>
References: <20170316222952.53801-1-bmwill@google.com>
 <20170317223805.95271-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When initializing a submodule set the submodule.<name>.active config to
true if the module hasn't already been configured to be active by some
other means (e.g. a pathspec set in submodule.active).

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/submodule--helper.c | 12 ++++++++++++
 t/t7400-submodule-basic.sh  | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 65208faa7..7700d8948 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -357,6 +357,18 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 			displaypath);
 
 	/*
+	 * NEEDSWORK: In a multi-working-tree world, this needs to be
+	 * set in the per-worktree config.
+	 *
+	 * Set active flag for the submodule being initialized
+	 */
+	if (!is_submodule_initialized(path)) {
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "submodule.%s.active", sub->name);
+		git_config_set_gently(sb.buf, "true");
+	}
+
+	/*
 	 * Copy url setting when it is not set yet.
 	 * To look up the url in .git/config, we must not fall back to
 	 * .gitmodules, so look it up directly.
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 3af1c00ff..cf77a3a35 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1256,4 +1256,15 @@ test_expect_success 'clone and subsequent updates correctly auto-initialize subm
 	test_cmp expect2 actual
 '
 
+test_expect_success 'init properly sets the config' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	git clone --recurse-submodules="." \
+		  --recurse-submodules=":(exclude)sub0" \
+		  multisuper multisuper_clone &&
+
+	git -C multisuper_clone submodule init -- sub0 sub1 &&
+	git -C multisuper_clone config --get submodule.sub0.active &&
+	test_must_fail git -C multisuper_clone config --get submodule.sub1.active
+'
+
 test_done
-- 
2.12.0.367.g23dc2f6d3c-goog

