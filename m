Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4BE21F991
	for <e@80x24.org>; Thu,  3 Aug 2017 18:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbdHCSUt (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 14:20:49 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:38396 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbdHCSUR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 14:20:17 -0400
Received: by mail-pg0-f48.google.com with SMTP id l64so9224395pge.5
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 11:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ql8UGod1bgI7ZFsY0nZ4it7Zh2MHrDOgDT1cn0XT4iM=;
        b=MI+qbD3BB+bHdgmqrnkLeyx7OXORt20tE9H3fjgiDCAYQdrdfpmc5vBJHpfie+kaxS
         d7KLmp5LPonDFAPemmb3ACOnNCg3NkFFt8Nj/ZeyFL3DKvMvwCTYx0MNQ0JCpUPCsgzE
         7Rzxa7jk8ScJMOP3BTW2WOwEK4171++8fvNvmxGVs5vty8cZtkqQw22hXdHLdSXFOJvh
         ME565uEI+aHg6yJQeo/xvKvdmmYWonT+Hvw77HuNBoy6ObfOgalIwG5A9fp6qYz7uz92
         wZwmRwiu8zwC5zEUO7nP7IAILzlslv6/rcdu6fOzeW2Kt51Pn8FrxK38jWhPGnLNUb43
         s3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ql8UGod1bgI7ZFsY0nZ4it7Zh2MHrDOgDT1cn0XT4iM=;
        b=m0ufM9aGmbvOhLqSZRLgoFqessjG10BZ7KwEWfmey6sPAXZInoyLvnF9m6M0DkXsaS
         IZjUxBqkbHrHeUOMS9qNPVc4r5vlvlfgvUAGSXHIocaGdktt/XpWfk8+qnRlQavxKDtA
         8E5yCjTmEXmLKlYDeLE1Hdg0yEQer3vJLUMjYw2GUjD4s5Smkr9ejKEpzCG4qduZVE6u
         KaWB2OL29M46E0JAQGW4hpJDlET/iz12fPQ4ThXcoj0zNLlo3aXKySF68Pb8QmIZ0rec
         HN7dfvrRtwPmZq8xQyVyuJO/tgyQkN5gz6y+E8u2T/yr8mfR+J3uwHpk9+1jjOI1eNGs
         uLpw==
X-Gm-Message-State: AIVw1131VS9DWZVf/Ig0MbXjH/JNpNwsKvDd63O02KYre2qwggi0h+so
        Acej1PhmTx6RhRP6uDCIOA==
X-Received: by 10.99.182.5 with SMTP id j5mr2346403pgf.137.1501784416107;
        Thu, 03 Aug 2017 11:20:16 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d1sm10706293pgc.57.2017.08.03.11.20.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 11:20:14 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Jens.Lehmann@web.de, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 06/15] fetch: don't overlay config with submodule-config
Date:   Thu,  3 Aug 2017 11:19:51 -0700
Message-Id: <20170803182000.179328-7-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <20170803182000.179328-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
 <20170803182000.179328-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't rely on overlaying the repository's config on top of the
submodule-config, instead query the repository's config directly for the
fetch_recurse field.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c |  1 -
 submodule.c     | 24 +++++++++++++++++-------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index d84c26391..3fe99073d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1362,7 +1362,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
 		gitmodules_config();
-		git_config(submodule_config, NULL);
 	}
 
 	if (all) {
diff --git a/submodule.c b/submodule.c
index 8a9b964ce..59e3d0828 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1194,14 +1194,24 @@ static int get_next_submodule(struct child_process *cp,
 
 		default_argv = "yes";
 		if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
-			if (submodule &&
-			    submodule->fetch_recurse !=
-						RECURSE_SUBMODULES_NONE) {
-				if (submodule->fetch_recurse ==
-						RECURSE_SUBMODULES_OFF)
+			int fetch_recurse = RECURSE_SUBMODULES_NONE;
+
+			if (submodule) {
+				char *key;
+				const char *value;
+
+				fetch_recurse = submodule->fetch_recurse;
+				key = xstrfmt("submodule.%s.fetchRecurseSubmodules", submodule->name);
+				if (!repo_config_get_string_const(the_repository, key, &value)) {
+					fetch_recurse = parse_fetch_recurse_submodules_arg(key, value);
+				}
+				free(key);
+			}
+
+			if (fetch_recurse != RECURSE_SUBMODULES_NONE) {
+				if (fetch_recurse == RECURSE_SUBMODULES_OFF)
 					continue;
-				if (submodule->fetch_recurse ==
-						RECURSE_SUBMODULES_ON_DEMAND) {
+				if (fetch_recurse == RECURSE_SUBMODULES_ON_DEMAND) {
 					if (!unsorted_string_list_lookup(&changed_submodule_paths, ce->name))
 						continue;
 					default_argv = "on-demand";
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

