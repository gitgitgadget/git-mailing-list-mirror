Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23D931F8CF
	for <e@80x24.org>; Wed,  7 Jun 2017 03:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751513AbdFGDdg (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 23:33:36 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33037 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbdFGDdf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 23:33:35 -0400
Received: by mail-qt0-f195.google.com with SMTP id w1so163368qtg.0
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 20:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rpJHRV3fReKEpo8/bK8DGZnvmXEicZikmDcmLMSe07U=;
        b=NJ4xShweN1AnAA/jg3c+RrurRBDNgNjJJWB0OXnZMoLfBYYJTSSeaQToyVku4OS2vk
         qQ1nWSYQEi5zZVKeXj5vGapzOsvfpk/8oHu+ocHs2vL5OmL2MFKT2gT7ea2N4PEyX0R5
         BLyeVuQTCEsoRD8GiEo0t3U7Nrcc9+hgJVIVbpD0PXAuWLtmEBQ5MteS9fbk88+EtdLD
         KVVFJyTyY3uGhyFJdUIBTFmhTLEvp/j6SWUwRdCM96sdOZ+BshmYxJT+PDGidNYJjYv5
         Y91JIfw5v+0CuSvEaRLmSZtpfuq7vqh4jl3ZxozGUDsEC8Jhuec12BoFCwjcrYxZtJIJ
         oS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rpJHRV3fReKEpo8/bK8DGZnvmXEicZikmDcmLMSe07U=;
        b=T9bSdwP/2YcJ8iMw+hPtWcOHPfJ3f5j4F4y+vLjC+PbN8nTl3uXV+6mrQ3KVWbCuMO
         O7ub6uMIQwDIcfIbximqdWfyf3kCEZ88BueL13AV4Dx+Be8V+wNsbbZ2J/TeBeMBXsJZ
         j1g0y9Ra1O7thlxNdKwDjFB4cLdVz2TVrIKVoYsEUQ5+DWoZ7qX5gVKw+s/yCRpu3Jx7
         bOgp6nA384FdaX78C4VecDvB/9tZNR6yJ85JP4uf0YoiKw3WXQMbvX1hUaq3pZeRtugl
         wwkUxKZrr+hW1Vr1zGTpl6PzMo/lqnYd3Xfuk/K4bGIYbtB2lV315JzyVZTzJlNV9JWc
         VCXA==
X-Gm-Message-State: AODbwcD4wKP+Yt7eQUlwcFITDxZN3j0eO7NjICMonYu6FVj50ykAWPQx
        qczDg36UZ1bHzgEUsbM=
X-Received: by 10.237.33.220 with SMTP id m28mr34457406qtc.33.1496806414709;
        Tue, 06 Jun 2017 20:33:34 -0700 (PDT)
Received: from localhost.localdomain (cpe-74-72-136-2.nyc.res.rr.com. [74.72.136.2])
        by smtp.gmail.com with ESMTPSA id e36sm252272qtb.67.2017.06.06.20.33.33
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 06 Jun 2017 20:33:33 -0700 (PDT)
From:   Emily Xie <emilyxxie@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, novalis@novalis.org,
        Emily Xie <emilyxxie@gmail.com>
Subject: [PATCH] pathspec: die on empty strings as pathspec
Date:   Tue,  6 Jun 2017 23:33:08 -0400
Message-Id: <20170607033308.33550-1-emilyxxie@gmail.com>
X-Mailer: git-send-email 2.8.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An empty string as a pathspec element matches all paths.  A buggy
script, however, could accidentally assign an empty string to a
variable that then gets passed to a Git command invocation, e.g.:

  path=... compute a path to be removed in $path ...
        git rm -r "$path"

which would unintentionally remove all paths in the current
directory.

The fix for this issue comprises of two steps. Step 1, which warns
that empty strings as pathspecs will become invalid, has already
been implemented in commit d426430 ("pathspec: warn on empty strings
as pathspec", 2016-06-22).

This patch is step 2. It removes the warning and throws an error
instead.

Signed-off-by: Emily Xie <emilyxxie@gmail.com>
Reported-by: David Turner <novalis@novalis.org>
---
 pathspec.c     | 10 ++++------
 t/t3600-rm.sh  |  5 ++---
 t/t3700-add.sh |  5 ++---
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 50f76ff..65e18b1 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -605,7 +605,7 @@ void parse_pathspec(struct pathspec *pathspec,
 {
 	struct pathspec_item *item;
 	const char *entry = argv ? *argv : NULL;
-	int i, n, prefixlen, warn_empty_string, nr_exclude = 0;
+	int i, n, prefixlen, nr_exclude = 0;
 
 	memset(pathspec, 0, sizeof(*pathspec));
 
@@ -638,12 +638,10 @@ void parse_pathspec(struct pathspec *pathspec,
 	}
 
 	n = 0;
-	warn_empty_string = 1;
 	while (argv[n]) {
-		if (*argv[n] == '\0' && warn_empty_string) {
-			warning(_("empty strings as pathspecs will be made invalid in upcoming releases. "
-				  "please use . instead if you meant to match all paths"));
-			warn_empty_string = 0;
+		if (*argv[n] == '\0') {
+			die("empty string is not a valid pathspec. "
+				  "please use . instead if you meant to match all paths");
 		}
 		n++;
 	}
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 5f9913b..c787eac 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -858,9 +858,8 @@ test_expect_success 'rm files with two different errors' '
 	test_i18ncmp expect actual
 '
 
-test_expect_success 'rm empty string should invoke warning' '
-	git rm -rf "" 2>output &&
-	test_i18ngrep "warning: empty strings" output
+test_expect_success 'rm empty string should fail' '
+	test_must_fail git rm -rf ""
 '
 
 test_done
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index f3a4b4a..40a0d2b 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -331,9 +331,8 @@ test_expect_success 'git add --dry-run --ignore-missing of non-existing file out
 	test_i18ncmp expect.err actual.err
 '
 
-test_expect_success 'git add empty string should invoke warning' '
-	git add "" 2>output &&
-	test_i18ngrep "warning: empty strings" output
+test_expect_success 'git add empty string should fail' '
+	test_must_fail git add ""
 '
 
 test_expect_success 'git add --chmod=[+-]x stages correctly' '
-- 
2.8.4

