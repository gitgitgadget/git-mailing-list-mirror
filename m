Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A991EC433FE
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhLIFP4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbhLIFPu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:15:50 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2898BC0617A1
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:12:17 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id w1so4248864ilh.9
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eiG6PR0CcZTQqSabi2dA4C3nDap48YkcDEFZ9fUCqC8=;
        b=dGCabgi9/ldnYA3jaLuEinBFo6Syh1mSZe8La8GVnBKnIBbQAcHqSzXL33BL/fxiV5
         3FMsB4DOOWgVcJpO5GWjkVFoBMbf38TQeY0cgthY2DmJvuDNfbP4RXWwNJ5HMRRHlRvA
         hhr7DrLBciduVaHe/aC9fO0qyzSa0wRRHiubIWxa+G7baSeE2+47hygpnmHIHNh4B+Xl
         HwD7CMyzehI/hp72bd5KfCTkHgByGI7k3l39+kBN0tTVEtJys6HFsbGA/RFjwY/zS6NT
         dBT52AujaLOw7EBtRO/SZjr4Fe2sn3MeqcXp5jBglqovpa9AsMhLQ/bYRBGKabDJQOV+
         IN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=eiG6PR0CcZTQqSabi2dA4C3nDap48YkcDEFZ9fUCqC8=;
        b=pzhgYMTlzXIbErAyBrHMZxqKT7eR0IoNls6rLPHu3RCUNto7X/Q5AnI2MhI6FnJ8jn
         IGuewQx5/DgGrppWdWkh/CrUXjLWuvkwZ8ju/iGMRuv19bx3UbetDgFPSEMqdTw9Mkwk
         /MwOxvxA6P/XIuBLjh7GDWR0kp9IeTh7pzWtjkETx55Cm9SV573OFBFjSTlqkw6ypZ/T
         dhfXY3bccd/XW6Tx/Jjke8arOoLa07Z5b7nitHgIf8qh58o2LfaB+EqbcAaP7lxUdcCR
         vKH/zF/0nuAwp+yTkAgZzcVqNBW2fUWXxhe6gi2+J6esHbv0DFVZh7KCC2erifYRr181
         816A==
X-Gm-Message-State: AOAM532YMoGc414PjYUADmZX1fpNSb+vfZ96uxCKggY7RE9nM5MGqefg
        Ke3O5HSwLVgOsuYqMEswk5ZGyOKPbc1qTA==
X-Google-Smtp-Source: ABdhPJwPERLsQSy0iIbd9uNwjHxUwb6PEboHtf/fKrjKi2WULNrDMJM9on4BNpwZUawuFESBjeiP4g==
X-Received: by 2002:a05:6e02:1646:: with SMTP id v6mr10675686ilu.155.1639026736324;
        Wed, 08 Dec 2021 21:12:16 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id b8sm3127401iow.2.2021.12.08.21.12.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 21:12:16 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <ericsunshine@gmail.com>
Subject: [PATCH 11/19] tests: fix broken &&-chains in `$(...)` command substitutions
Date:   Thu,  9 Dec 2021 00:11:07 -0500
Message-Id: <20211209051115.52629-12-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd
In-Reply-To: <20211209051115.52629-1-sunshine@sunshineco.com>
References: <20211209051115.52629-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The top-level &&-chain checker built into t/test-lib.sh causes tests to
magically exit with code 117 if the &&-chain is broken. However, it has
the shortcoming that the magic does not work within `{...}` groups,
`(...)` subshells, `$(...)` substitutions, or within bodies of compound
statements, such as `if`, `for`, `while`, `case`, etc. `chainlint.sed`
partly fills in the gap by catching broken &&-chains in `(...)`
subshells, but bugs can still lurk behind broken &&-chains in the other
cases.

Fix broken &&-chains in `$(...)` command substitutions in order to
reduce the number of possible lurking bugs.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 contrib/subtree/t/t7900-subtree.sh |  2 +-
 t/t0005-signals.sh                 |  2 +-
 t/t0060-path-utils.sh              |  4 ++--
 t/t1006-cat-file.sh                | 10 +++++-----
 t/t3600-rm.sh                      |  2 +-
 t/t7010-setup.sh                   |  2 +-
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 4153b65321..1c1f76f04a 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -1445,7 +1445,7 @@ test_expect_success 'subtree descendant check' '
 	) &&
 	test_create_commit "$test_count" folder_subtree/0 &&
 	test_create_commit "$test_count" folder_subtree/b &&
-	cherry=$(cd "$test_count"; git rev-parse HEAD) &&
+	cherry=$(cd "$test_count" && git rev-parse HEAD) &&
 	(
 		cd "$test_count" &&
 		git checkout branch
diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index a5ec6a0315..eba75a2490 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -48,7 +48,7 @@ test_expect_success !MINGW 'a constipated git dies with SIGPIPE' '
 '
 
 test_expect_success !MINGW 'a constipated git dies with SIGPIPE even if parent ignores it' '
-	OUT=$( ((trap "" PIPE; large_git; echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=$( ((trap "" PIPE && large_git; echo $? 1>&3) | :) 3>&1 ) &&
 	test_match_signal 13 "$OUT"
 '
 
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 34d1061f32..71a5d370cc 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -216,7 +216,7 @@ test_expect_success SYMLINKS 'real path works on symlinks' '
 	mkdir second &&
 	ln -s ../first second/other &&
 	mkdir third &&
-	dir="$(cd .git; pwd -P)" &&
+	dir="$(cd .git && pwd -P)" &&
 	dir2=third/../second/other/.git &&
 	test "$dir" = "$(test-tool path-utils real_path $dir2)" &&
 	file="$dir"/index &&
@@ -224,7 +224,7 @@ test_expect_success SYMLINKS 'real path works on symlinks' '
 	basename=blub &&
 	test "$dir/$basename" = "$(cd .git && test-tool path-utils real_path "$basename")" &&
 	ln -s ../first/file .git/syml &&
-	sym="$(cd first; pwd -P)"/file &&
+	sym="$(cd first && pwd -P)"/file &&
 	test "$sym" = "$(test-tool path-utils real_path "$dir2/syml")"
 '
 
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 658628375c..67a3f64c2d 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -211,14 +211,14 @@ done
 test_expect_success "--batch-check for a non-existent named object" '
     test "foobar42 missing
 foobar84 missing" = \
-    "$( ( echo foobar42; echo_without_newline foobar84; ) | git cat-file --batch-check)"
+    "$( ( echo foobar42 && echo_without_newline foobar84 ) | git cat-file --batch-check)"
 '
 
 test_expect_success "--batch-check for a non-existent hash" '
     test "0000000000000000000000000000000000000042 missing
 0000000000000000000000000000000000000084 missing" = \
-    "$( ( echo 0000000000000000000000000000000000000042;
-	 echo_without_newline 0000000000000000000000000000000000000084; ) |
+    "$( ( echo 0000000000000000000000000000000000000042 &&
+	 echo_without_newline 0000000000000000000000000000000000000084 ) |
        git cat-file --batch-check)"
 '
 
@@ -226,8 +226,8 @@ test_expect_success "--batch for an existent and a non-existent hash" '
     test "$tag_sha1 tag $tag_size
 $tag_content
 0000000000000000000000000000000000000000 missing" = \
-    "$( ( echo $tag_sha1;
-	 echo_without_newline 0000000000000000000000000000000000000000; ) |
+    "$( ( echo $tag_sha1 &&
+	 echo_without_newline 0000000000000000000000000000000000000000 ) |
        git cat-file --batch)"
 '
 
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index bb9ef35dac..ed3952eb98 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -265,7 +265,7 @@ test_expect_success 'choking "git rm" should not let it die with cruft (induce S
 
 test_expect_success !MINGW 'choking "git rm" should not let it die with cruft (induce and check SIGPIPE)' '
 	choke_git_rm_setup &&
-	OUT=$( ((trap "" PIPE; git rm -n "some-file-*"; echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=$( ((trap "" PIPE && git rm -n "some-file-*"; echo $? 1>&3) | :) 3>&1 ) &&
 	test_match_signal 13 "$OUT" &&
 	test_path_is_missing .git/index.lock
 '
diff --git a/t/t7010-setup.sh b/t/t7010-setup.sh
index 0335a9a158..520f96d09f 100755
--- a/t/t7010-setup.sh
+++ b/t/t7010-setup.sh
@@ -137,7 +137,7 @@ test_expect_success 'setup deeper work tree' '
 
 test_expect_success 'add a directory outside the work tree' '(
 	cd tester &&
-	d1="$(cd .. ; pwd)" &&
+	d1="$(cd .. && pwd)" &&
 	test_must_fail git add "$d1"
 )'
 
-- 
2.34.1.307.g9b7440fafd

