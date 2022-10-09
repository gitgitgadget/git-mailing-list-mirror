Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13311C433FE
	for <git@archiver.kernel.org>; Sun,  9 Oct 2022 23:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiJIXUZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 19:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiJIXUB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 19:20:01 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683AC5E675
        for <git@vger.kernel.org>; Sun,  9 Oct 2022 15:46:17 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7DBF71B7438;
        Sun,  9 Oct 2022 18:44:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=8
        N1B50RgzwR88zBlcTAnAb4U/NoW61XzDWNmGVQOtUk=; b=t1bxqyVrBMEqqOP1c
        vOXIj9aiPu9pMFbY2Fhod+/qA9XV2uIC40Kb/qvEbtNmvSLWD/3MRBOkLNTpCbOE
        3p5Yq1fXn8jD1oJ+S9ISkdXUgwkQGKZYfH7Fr+dhgeQ69Gxwyz02P9qK9A35yRfg
        AD8I6zNjUaqpLW1faZU8z1KgUQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7698E1B7437;
        Sun,  9 Oct 2022 18:44:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 96E9A1B7436;
        Sun,  9 Oct 2022 18:44:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] ci: add address and undefined sanitizer tasks
Date:   Sun, 09 Oct 2022 15:44:22 -0700
Message-ID: <xmqq8rlo62ih.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EBD99C8E-4823-11ED-95B2-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * I've been running my local post-integration-pre-pushout tests of
   'seen' with these two sanitizer tests, which has saved me from a
   few potential embarrassments early.  As it takes a lot extra time
   to run these locally, I am aiming to burden contributors who run
   their due diligence "before sending the patch" checks using the
   GitHub Actions CI ;-).

   The way the patch adds jobs to CI just imitates how -leaks one is
   defined.

 .github/workflows/main.yml | 6 ++++++
 ci/lib.sh                  | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 831f4df56c..2f80da7cfb 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -251,6 +251,12 @@ jobs:
           - jobname: linux-leaks
             cc: gcc
             pool: ubuntu-latest
+          - jobname: linux-address
+            cc: gcc
+            pool: ubuntu-latest
+          - jobname: linux-undefined
+            cc: gcc
+            pool: ubuntu-latest
     env:
       CC: ${{matrix.vector.cc}}
       CC_PACKAGE: ${{matrix.vector.cc_package}}
diff --git a/ci/lib.sh b/ci/lib.sh
index 1b0cc2b57d..678edd5abb 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -278,6 +278,9 @@ linux-leaks)
 	export GIT_TEST_PASSING_SANITIZE_LEAK=true
 	export GIT_TEST_SANITIZE_LEAK_LOG=true
 	;;
+linux-address | linux-undefined)
+	export SANITIZE=${jobname#linux-}
+	;;
 esac
 
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
-- 
2.38.0-167-gf9a88ca9e9

