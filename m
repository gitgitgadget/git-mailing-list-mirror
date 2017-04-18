Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE0B9207B9
	for <e@80x24.org>; Tue, 18 Apr 2017 21:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754922AbdDRVhp (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 17:37:45 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35090 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753784AbdDRVhl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 17:37:41 -0400
Received: by mail-pf0-f177.google.com with SMTP id i5so2483020pfc.2
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 14:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=egnwUX7uiqEyGwdSL6G8FciAWPpsSKgq7IMc7smcnpg=;
        b=Uh+TI02rH+cyEvPojiHuaKlWkT+wtmPeJKe10ywOZsxx4irzeZuOpnjEM9ELA3Ha6A
         9aV4x0gkrbPlcF/dRfUL1uTzwFgWcACvd0FZSDyD7IDzk/d5PFPs7kH1QTfcd6pr6URP
         L8wPx0MNgk0u/NPwMnU3M8rXci0L7pPCXQDjWsBFUkNP04GSnHwlaaPQDn4e2CI0IpJM
         Nh4WsJ26H53C4ZtCzVQkyeu4iiYMS207aeAhcllo43gDE6vRBL/dQi/pVewb/hEJl8cX
         1/OOTxFlhkkQnHYvt7lpaFqPl3GeD2i5Z7pUHsZP61K8axpuevYhzuMhywud8wMLrFbE
         oAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=egnwUX7uiqEyGwdSL6G8FciAWPpsSKgq7IMc7smcnpg=;
        b=VRLv54P0cg+0Jft9lfxSVp4zCzKdonQ7Nlq873UYvawLaNQ9vGlhDgoB4eOudfJdVm
         WtcOfLK1Oi6s2wlr+2+BalYstVxj2JQI5LE1xBzebTZuVqUYkiWzi7k3shYiOaD555ZN
         ncMGgfOnZZNjkJmtGenz/uI8yYWodcuLAtqzVds34irb8jUZs4OhLIN0kAh0Y7QbmE+K
         dIWr/vqbUzi5+jK5vUodHXS4NkxSzq9A8APlpJu48D1Pks5yFS8uGS7SB6wLoOwiMY8k
         DpJloEXpWx5dmfCflifSPIl5WnWRI4/ni/XnASpBoyCc3GlCxamgsGeUhmMbYjmaGZmv
         FeTQ==
X-Gm-Message-State: AN3rC/4U/wJjzOfnyij1oOa5MBE5CFlgl0YhsDVN/QYoh3caxfvO2OmR
        ItqvfScHlCTyt2Gj
X-Received: by 10.99.3.8 with SMTP id 8mr7092698pgd.208.1492551459694;
        Tue, 18 Apr 2017 14:37:39 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c47b:4f4d:6233:ff9f])
        by smtp.gmail.com with ESMTPSA id 128sm317882pgi.49.2017.04.18.14.37.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 18 Apr 2017 14:37:39 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
        jonathantanmy@google.com, philipoakley@iee.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 2/4] submodule.c: uninitialized submodules are ignored in recursive commands
Date:   Tue, 18 Apr 2017 14:37:23 -0700
Message-Id: <20170418213725.7901-3-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.642.g1b8cc69eee.dirty
In-Reply-To: <20170418213725.7901-1-sbeller@google.com>
References: <20170418213725.7901-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was an oversight when working on the working tree modifying commands
recursing into submodules.

To test for uninitialized submodules, introduce another submodule
"uninitialized_sub". Adding it via `submodule add` will activate the
submodule in the preparation area (in create_lib_submodule_repo we
setup all the things in submodule_update_repo), but the later tests
will use a new testing repo that clones the preparation repo
in which the new submodule is not initialized.

By adding it to the branch "add_sub1", which is the starting point of
all other branches, we have wide coverage.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c               | 3 +++
 t/lib-submodule-update.sh | 1 +
 2 files changed, 4 insertions(+)

diff --git a/submodule.c b/submodule.c
index 7c3c4b17fb..ccf8932731 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1333,6 +1333,9 @@ int submodule_move_head(const char *path,
 	struct child_process cp = CHILD_PROCESS_INIT;
 	const struct submodule *sub;
 
+	if (!is_submodule_initialized(path))
+		return 0;
+
 	sub = submodule_from_path(null_sha1, path);
 
 	if (!sub)
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index fb4f7b014e..22dd9e060c 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -73,6 +73,7 @@ create_lib_submodule_repo () {
 
 		git checkout -b "add_sub1" &&
 		git submodule add ../submodule_update_sub1 sub1 &&
+		git submodule add ../submodule_update_sub1 uninitialized_sub &&
 		git config -f .gitmodules submodule.sub1.ignore all &&
 		git config submodule.sub1.ignore all &&
 		git add .gitmodules &&
-- 
2.12.2.642.g1b8cc69eee.dirty

