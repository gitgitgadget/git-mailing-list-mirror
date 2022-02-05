Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9433BC433F5
	for <git@archiver.kernel.org>; Sat,  5 Feb 2022 00:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378646AbiBEAEl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 19:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355186AbiBEAEk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 19:04:40 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C55DF8C1BC
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 16:04:39 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j16so14020852wrd.8
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 16:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SPcyix5qoBcufBUj2dLbOGeHOmgKn72YlrrUer6XYbs=;
        b=pxJoT6Dfq0NF144P1/mVR5CcoXHaM051w0/TTiuCxLQmtTQl7oe0d+H9NLSlo6xYyK
         KCS5W3iyaMvovd4exWTy7KDrkobJefyEQYKdr1cLLABrXF1x2zU58WNFUm9odgFOJbPp
         nfATz0Jpi3jZ4kmto2YuRw2W5x1O/HrraoY6qnFoQRoPNnEAJK4UZOPgHdjaCNS58hRy
         x8q9vp4nTnr244KZn2SenSOd3SI7XnbEhhouIAC/Aj4/O6KaR6bXhiqixFEv0BCyYthU
         2zlW1PqlVv4VoJRQUygZ+OE0Ze7dxN/XY+z1q7nnp3GFZRy6v817XR04vdJWo19dk+tf
         CzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SPcyix5qoBcufBUj2dLbOGeHOmgKn72YlrrUer6XYbs=;
        b=d9El6hxZRSJPPjP8OEB9Eh1aUoF2QmVWezTHiWjTkCzk9O4aHbnB3dVxiZ5qsx4ch/
         +2GGPKLv/zDMcqi7BwiFUhUVp/DcI6YiA/zaNLKM02oypA/CeL8l8rYa7gX7f/l0BAV0
         6Ey69SkdNtmawsodT+gniqzNSFr9P/VAhvHvjvfoccJAx7G4WLzxNR76aMCWK0BGlsjY
         jELy7sTyAlLOcfVyTwx3H6FYwxj4coGepb6jFve8nfTSr56smEX61Gj0reolbOMOkh+H
         uLIOPYZe1dQLjtc1zKiFLMm7YZ6Fgr68MqFPpav4GP3PSYtHyx2Gj60TqhsrN0/pGRLf
         Q4MA==
X-Gm-Message-State: AOAM531GmadysEvNL4KpNDLRx60LDcvFst07xzFN3SCZoDR6hRuNtv3s
        McBYF5Y8BgYk49NtNKJeHH2XtAisxyniIw==
X-Google-Smtp-Source: ABdhPJyU4fheQsV7SlvEThDjAS83GdyYPh93i8lhMSMeP4HGZgOQqOpQ4qLHhDjelrJ/ejq90sCM0w==
X-Received: by 2002:a5d:6483:: with SMTP id o3mr972613wri.67.1644019477472;
        Fri, 04 Feb 2022 16:04:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y6sm2441235wma.48.2022.02.04.16.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 16:04:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Dmitry Potapov <dpotapov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] hash-object: fix a trivial leak in --path
Date:   Sat,  5 Feb 2022 01:04:29 +0100
Message-Id: <patch-1.1-53863df1455-20220205T000422Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.945.g180f8b8dd92
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak that happened when the --path option was
provided. This leak has been with us ever since the option was added
in 39702431500 (add --path option to git hash-object, 2008-08-03).

We can now mark "t1007-hash-object.sh" as passing when git is compiled
with SANITIZE=leak. It'll now run in the the
"GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks" CI
target).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/hash-object.c  | 9 +++++++--
 t/t1007-hash-object.sh | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index c7b3ad74c60..db9b2535271 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -92,6 +92,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 	int nongit = 0;
 	unsigned flags = HASH_FORMAT_CHECK;
 	const char *vpath = NULL;
+	char *vpath_free = NULL;
 	const struct option hash_object_options[] = {
 		OPT_STRING('t', NULL, &type, N_("type"), N_("object type")),
 		OPT_BIT('w', NULL, &flags, N_("write the object into the object database"),
@@ -114,8 +115,10 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 	else
 		prefix = setup_git_directory_gently(&nongit);
 
-	if (vpath && prefix)
-		vpath = prefix_filename(prefix, vpath);
+	if (vpath && prefix) {
+		vpath_free = prefix_filename(prefix, vpath);
+		vpath = vpath_free;
+	}
 
 	git_config(git_default_config, NULL);
 
@@ -156,5 +159,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 	if (stdin_paths)
 		hash_stdin_paths(type, no_filters, flags, literally);
 
+	free(vpath_free);
+
 	return 0;
 }
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 64b340f2272..ac5ad8c7402 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -2,6 +2,7 @@
 
 test_description="git hash-object"
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 echo_without_newline() {
-- 
2.35.1.945.g180f8b8dd92

