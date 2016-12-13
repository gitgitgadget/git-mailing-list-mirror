Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBF89209B4
	for <e@80x24.org>; Tue, 13 Dec 2016 20:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941134AbcLMU5i (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 15:57:38 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36836 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934275AbcLMU5e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 15:57:34 -0500
Received: by mail-pg0-f48.google.com with SMTP id f188so51219605pgc.3
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 12:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gOOob8dF4CVI47H5MF5ZJfM2zhdVY+V2urCV5jKtYEU=;
        b=dyN7VSjGVr+Ynu8JTYm6Ah/vhmQG45WrUBc77jJwDHPb3ilhjamF5TCphWA5udtCOY
         ZUR68ryPEvHfdz4SzFqsE9wxPhrbr9CHNCd3U5EJIUf2E3UzIIguC+5cdrMfIS9VG4aQ
         Rg4joxhroQM7qbGNeDh1pHBWjtCZLUl1D5GadDcm15JXqZ0BqvAk9rSGDl6QoBfuAyPC
         p7+2RatgCZT4/ikZVoUSR2AavUF1JqaOJY3+ZvAW6V0ElhmoGxxRIjvlwpKq+94FemM5
         mggJxsSVmBHatL68ylYzIC8UwprvCcxn/U/Nhvc+X/ybp/XQavLhkXt43/5EDqeoMDIW
         Mq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gOOob8dF4CVI47H5MF5ZJfM2zhdVY+V2urCV5jKtYEU=;
        b=cjOz324CHUkNH/wzdJCofFu9dJZt8VfBgyTXyyYNXi79wrQbLmfbrmSTCpbSINJNgR
         KdTCLXOqq5yAJusRl8qRzkxfJ0ThVn4dGc+QKkzddl9DMol0ALgES7PQAduZ6GDE5Euw
         zB+bBWUY3Z9TJRufRKf3aDdX4MRBwwa5oVzaXWN32pGOjdZlxFP3wT//1TdKrMdQS819
         9dGf12GRX+4//EuDQaQ7hj6BCskvdOgH9eVOQcsDLSpxVIcot+qKDjoXlaOC9if0i6Yh
         ARm9b6hubxtby9bsy8fQs4MXw2Entj5usLwsYDTg5QlHxwVVd+9Yl2iWUErXNpKHCXkx
         8l0Q==
X-Gm-Message-State: AKaTC01hYSEbpWmYW4TtN11dMiPSqwQ9nuvDIbZxDUeE8MDYFRTqqltxluWUMn3UhHHV6NgR
X-Received: by 10.99.5.21 with SMTP id 21mr179184895pgf.32.1481662594779;
        Tue, 13 Dec 2016 12:56:34 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:5b5:8785:ab45:d22f])
        by smtp.gmail.com with ESMTPSA id c128sm81987056pfc.39.2016.12.13.12.56.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 12:56:34 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, David.Turner@twosigma.com, bmwill@google.com,
        sandals@crustytoothpaste.net, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 4/5] ok_to_remove_submodule: absorb the submodule git dir
Date:   Tue, 13 Dec 2016 12:56:21 -0800
Message-Id: <20161213205622.841-5-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.35.g26e18c9
In-Reply-To: <20161213205622.841-1-sbeller@google.com>
References: <20161213205622.841-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is a major reason to say no, when deciding if a submodule can be
deleted, if the git directory of the submodule being contained in the
submodule's working directory.

Migrate the git directory into the superproject instead of failing,
and proceed with the other checks.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index 2d13744b06..e42efa2337 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1026,11 +1026,22 @@ int ok_to_remove_submodule(const char *path, unsigned flags)
 	struct strbuf buf = STRBUF_INIT;
 	int ok_to_remove = 1;
 
+	/* Is it there? */
 	if (!file_exists(path) || is_empty_dir(path))
 		return 1;
 
-	if (!submodule_uses_gitfile(path))
-		return 0;
+	/* Does it have a .git directory? */
+	if (!submodule_uses_gitfile(path)) {
+		absorb_git_dir_into_superproject("", path,
+			ABSORB_GITDIR_RECURSE_SUBMODULES);
+
+		/*
+		 * We should be using a gitfile by now. Let's double
+		 * check as losing the git dir would be fatal.
+		 */
+		if (!submodule_uses_gitfile(path))
+			return 0;
+	}
 
 	argv_array_pushl(&cp.args, "status", "--porcelain",
 				   "--ignore-submodules=none", NULL);
-- 
2.11.0.rc2.35.g26e18c9

