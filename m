Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD53C433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 21:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiGTVWT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 17:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiGTVWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 17:22:09 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704CD4D4EB
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:08 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bv24so3987955wrb.3
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4tzKr6Zdx/APqS2VHPSKRGztZbS/2v1preti/sPlm+M=;
        b=VgalTTSM8Amksm1SGo2KRs25hau7Ys6c6HiFJWwseltvRgSm1QINoPGCFedxwHggmm
         6zGAsZ2Dr37c26+jJodAUc/8t+xJzKAS8M1jn89BzQ07wLZu63+m3EpCRW3cph26R/Pj
         NXQ5eCTwyjrGsGffC0DcgkaGPMscwDP9u8ECIDRZjf0YYJmnEXehoGMn6Nw+MuK/9Ex9
         pWpQSmEhWhXp+djhnTfjWA+xg2iISJE+k3JAEB4azcbb7LQUskJSd47mRvanSADGRgIi
         FeY7MR24xTLfyA6qV7M3MH0dU593H80ULZvYpm1QoyNTXcje//pRteaHiKB5Xxqbjg1K
         bZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4tzKr6Zdx/APqS2VHPSKRGztZbS/2v1preti/sPlm+M=;
        b=n/CPsA30aaIgSuPOzpe7ZRka+S5pPSj3TvCIQnmJZK+rl7a6cgUKQc7uutiVHSFFL5
         nXVwLvUegx2ndRU6lXI1a8jWxLfdvIodFbVXU9c0+KucGC8//240u918XfsEHrP7qM0U
         jq6W88GMrWTg2L/7zLrkzoY+b8iLfw0KniUrBFRUrIXD+pqhgscmavgWe8OrzIjub8Gl
         39lgCKD3D7bwsivqRcjiOlkI21hGk6ZzuhKyztQ+AQWiNHEYtMWyvWYWu0roimbCkoTa
         krig/FMXCPQ/jGJlZqZF2jnKZmh7NVp+O6UKrRFwmKXDH0pW5KAYiTB0GyWiMjhmkgAO
         P9Dg==
X-Gm-Message-State: AJIora8SHNxECSheXnUYYX3mfrr7i23bwZBN6760l3S8ZgkXqXno7Jr5
        CVUubHoXsfQ8rsDxXjHCRd+Iy3zRlvLdnA==
X-Google-Smtp-Source: AGRyM1vANsrzq66oui9qj4vqLetqAIKSPA5w0ySBUl9jEMsPSVCpGP/CSdbvXypVpsY4Y920gC410g==
X-Received: by 2002:adf:e192:0:b0:21d:62ee:ef10 with SMTP id az18-20020adfe192000000b0021d62eeef10mr33069010wrb.693.1658352126499;
        Wed, 20 Jul 2022 14:22:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b003a0375c4f73sm3605441wmj.44.2022.07.20.14.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 14:22:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/14] test-lib: fix GIT_EXIT_OK logic errors, use BAIL_OUT
Date:   Wed, 20 Jul 2022 23:21:41 +0200
Message-Id: <patch-v2-03.14-419bc2c6a6e-20220720T211221Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1064.gc96144cf387
In-Reply-To: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com> <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change various "exit 1" checks that happened after our "die" handler
had been set up to use BAIL_OUT instead. See 234383cd401 (test-lib.sh:
use "Bail out!" syntax on bad SANITIZE=leak use, 2021-10-14) for the
benefits of the BAIL_OUT function.

The previous use of "error" here was not a logic error, but the "exit"
without "GIT_EXIT_OK" would emit the "FATAL: Unexpected exit with code
$code" message on top of the error we wanted to emit.

Since we'd also like to stop "prove" in its tracks here, the right
thing to do is to emit a "Bail out!" message.

Let's also move the "GIT_EXIT_OK=t" assignments to just above the
"exit [01]" in "test_done". It's not OK if we exit in
e.g. finalize_test_output.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index c8c84ef9b14..118720493bb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1173,8 +1173,6 @@ test_done () {
 	# removed, so the commands can access pidfiles and socket files.
 	test_atexit_handler
 
-	GIT_EXIT_OK=t
-
 	finalize_test_output
 
 	if test -z "$HARNESS_ACTIVE"
@@ -1246,6 +1244,7 @@ test_done () {
 		fi
 		test_at_end_hook_
 
+		GIT_EXIT_OK=t
 		exit 0 ;;
 
 	*)
@@ -1255,6 +1254,7 @@ test_done () {
 			say "1..$test_count"
 		fi
 
+		GIT_EXIT_OK=t
 		exit 1 ;;
 
 	esac
@@ -1387,14 +1387,12 @@ fi
 GITPERLLIB="$GIT_BUILD_DIR"/perl/build/lib
 export GITPERLLIB
 test -d "$GIT_BUILD_DIR"/templates/blt || {
-	error "You haven't built things yet, have you?"
+	BAIL_OUT "You haven't built things yet, have you?"
 }
 
 if ! test -x "$GIT_BUILD_DIR"/t/helper/test-tool$X
 then
-	echo >&2 'You need to build test-tool:'
-	echo >&2 'Run "make t/helper/test-tool" in the source (toplevel) directory'
-	exit 1
+	BAIL_OUT 'You need to build test-tool; Run "make t/helper/test-tool" in the source (toplevel) directory'
 fi
 
 # Are we running this test at all?
@@ -1448,9 +1446,7 @@ remove_trash_directory () {
 
 # Test repository
 remove_trash_directory "$TRASH_DIRECTORY" || {
-	GIT_EXIT_OK=t
-	echo >&5 "FATAL: Cannot prepare test area"
-	exit 1
+	BAIL_OUT 'cannot prepare test area'
 }
 
 remove_trash=t
@@ -1466,7 +1462,7 @@ fi
 
 # Use -P to resolve symlinks in our working directory so that the cwd
 # in subprocesses like git equals our $PWD (for pathname comparisons).
-cd -P "$TRASH_DIRECTORY" || exit 1
+cd -P "$TRASH_DIRECTORY" || BAIL_OUT "cannot cd -P to \"$TRASH_DIRECTORY\""
 
 start_test_output "$0"
 
-- 
2.37.1.1064.gc96144cf387

