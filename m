Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A3892021E
	for <e@80x24.org>; Tue, 15 Nov 2016 23:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964950AbcKOXOP (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 18:14:15 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35997 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964793AbcKOXOP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 18:14:15 -0500
Received: by mail-pg0-f45.google.com with SMTP id f188so71429403pgc.3
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 15:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SvDEfOCbBpM78CJXEiaxXO4LHzOBwjajGYlxzrV6PP0=;
        b=PpmTErT6lMhcAo1xCIWcVLx5fXSIoHqosOjF69Mk0V+aIz+bC48x+I88H6sDZlgAEL
         Q36lGU+2Qff7DxcA+megHxQsPazzB3K0PJRDZ/X6FfBQP5Vqy11YGXg/OxnxWy5EaFdK
         CZRzTkElMhAcD0XYsAhhK3RKP+W/T4w/gPSpd94Ri5Bg8WY8WNSmjz5C4TaG9vn8ccuB
         a2G0uQ+vagSkIMJ3/1Q6jL7/F5K/CCE5pD2lJT3Gz6yXEaJf+NwLb7DUC4gyzKmvfxMQ
         fthVZPnsJhfCCJITuEc87VUnYtEK3/8yzvQ3I10BYucvjF+yjlQroe0KLPuj6X9+HVhS
         dnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SvDEfOCbBpM78CJXEiaxXO4LHzOBwjajGYlxzrV6PP0=;
        b=LxvErFxT3HZtbXiONpFBHBdbklMlCmwB7H2U+xJzxl0C8ANTO21TkW3Loq6kHu+zDH
         UW5iMj4oNjUBQJ5+yiCSKFvSMW7HuBC9VB64u3xG3hBhlWpLZgLS+EdW/Rr4jkyCrSr/
         6jYocuiSWXw+hYB7VDDa/elnK88EwiaZ9GUsMrQFRu27T9vA9XFlW49nkkjrjScC+ymI
         G3AOjeOUlGgIdSGR2giRloVeua3Gu6HvH+ZDcYKj0ixsxcns9V0W96WtcA6NcVo672ai
         ly4UbKPXjivnkZSP3LiV2pVSVcKCFPC2AAOWd8A68vdvOwekt+mxHm4EQOFu6FELbQse
         y8fw==
X-Gm-Message-State: ABUngvdgiQUqZIQaEYvBVCGtDW9czVWHq23rxqXP51PV3219GoTBSC5HDkyOEqgolMmqHK9/
X-Received: by 10.98.35.5 with SMTP id j5mr61061pfj.91.1479251217521;
        Tue, 15 Nov 2016 15:06:57 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:1161:a721:e128:bf5f])
        by smtp.gmail.com with ESMTPSA id n2sm46259901pfa.75.2016.11.15.15.06.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 15:06:57 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com,
        jrnieder@gmail.com, mogulguy10@gmail.com,
        David.Turner@twosigma.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 02/16] submodule: modernize ok_to_remove_submodule to use argv_array
Date:   Tue, 15 Nov 2016 15:06:37 -0800
Message-Id: <20161115230651.23953-3-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161115230651.23953-1-sbeller@google.com>
References: <20161115230651.23953-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of constructing the NULL terminated array ourselves, we
should make use of the argv_array infrastructure.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/submodule.c b/submodule.c
index 6f7d883..53a6dbb 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1022,13 +1022,6 @@ int ok_to_remove_submodule(const char *path)
 {
 	ssize_t len;
 	struct child_process cp = CHILD_PROCESS_INIT;
-	const char *argv[] = {
-		"status",
-		"--porcelain",
-		"-u",
-		"--ignore-submodules=none",
-		NULL,
-	};
 	struct strbuf buf = STRBUF_INIT;
 	int ok_to_remove = 1;
 
@@ -1038,7 +1031,8 @@ int ok_to_remove_submodule(const char *path)
 	if (!submodule_uses_gitfile(path))
 		return 0;
 
-	cp.argv = argv;
+	argv_array_pushl(&cp.args, "status", "--porcelain", "-uall",
+				   "--ignore-submodules=none", NULL);
 	prepare_submodule_repo_env(&cp.env_array);
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
-- 
2.10.1.469.g00a8914

