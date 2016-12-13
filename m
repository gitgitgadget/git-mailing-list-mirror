Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AAC0206A4
	for <e@80x24.org>; Tue, 13 Dec 2016 01:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932593AbcLMBlI (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 20:41:08 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35443 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932270AbcLMBlE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 20:41:04 -0500
Received: by mail-pg0-f47.google.com with SMTP id p66so41490121pga.2
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 17:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yOuVZNmEqNncRPCmEqtDp2hK6L256COWQXVqdud2q0A=;
        b=Do3dwl1vxkXC+3kDmmHoHHIKEVxY5zkefGZ45xVpM4VGDVNRnDorEJpBeq020Ph42r
         Ldiq+nRPKrdwEwiGpkffAHVAd0tqacJA7ajsJI6mBbjdyRHr7VCaZv0zDMaH/JJ8bwOd
         kN4BwKxlylpu8Cui7AKqQt2ob1Xd8/ZliEnLBwUahgnmF7cqQW/6c98/KI/5pauCOyqp
         Lb+VqcL7WryMLuHG5WkQvPYfeoS87AFsxVflztwqs/wbVx++4EgsnFEQkpVChJG1MHJ+
         IT3F89ww26BEkqrzr2eZuOipAR2Ri9JWyPfoldcOHKfdXtIjYsu33nZhoNCBSSKywJag
         E1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yOuVZNmEqNncRPCmEqtDp2hK6L256COWQXVqdud2q0A=;
        b=WQOKxjYf+JlqPBix176h+Rwt45rJlNl5zEW8wrGuuSMHB73nD7yuQltmdff+Tanha4
         k9mh8vEh9ZLvkz9ZKWq373k2qlWslyMxgBFb1U2wxG6kM8S22LfP9S1s3DrKZ+iE9Ii5
         sD+1RzRyyU8uPCdT2h2DQJooslB+SAQLwXHKW3I4xnuxnSgEyS5BHBl/7SOgV9AVGgJ/
         yv4s8hMIVRtt8nA1T7RmdMuIsXFi8z/kXwJ9hru8t3jvUOf2MN9d2roiuFi9Uc9qkcLc
         oc/+j5gSHBjrti1tCvWZ3BUs0Tc1JYrVjPmL8JLqjM0jLTX6LjkAE/e6XtrkKcvyTwTe
         4dqA==
X-Gm-Message-State: AKaTC01nBalp5faavFy4FvKtVFOUVWtc7LxqUV1ome5+bDb1E8DvWGlRntHw9sWSwbyjqK2c
X-Received: by 10.84.167.2 with SMTP id c2mr186997890plb.56.1481593263724;
        Mon, 12 Dec 2016 17:41:03 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:642c:37a4:3709:a2b3])
        by smtp.gmail.com with ESMTPSA id a22sm78282131pfg.7.2016.12.12.17.41.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Dec 2016 17:41:03 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, David.Turner@twosigma.com, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/6] ok_to_remove_submodule: absorb the submodule git dir
Date:   Mon, 12 Dec 2016 17:40:53 -0800
Message-Id: <20161213014055.14268-5-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.35.g26e18c9
In-Reply-To: <20161213014055.14268-1-sbeller@google.com>
References: <20161213014055.14268-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When deciding if a submodule can be deleted a major
reason to say no is the git directory of the submodule
being contained in the submodules working directory.

Instead of failing migrate the git directory into the
superproject and proceed with the other checks.

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
2.11.0.rc2.35.g7af3268

