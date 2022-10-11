Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6C5C433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 00:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiJKAVn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 20:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJKAVl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 20:21:41 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166A6357F9
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:21:41 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 54DA115F756;
        Mon, 10 Oct 2022 20:21:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=59hANjvhi6D/bnh7ZfxFetq8UR63RYAXOhFesx
        28K1U=; b=bVhVp66b4mPJQ1WsI4dybpJnXvi/O4J5kTozXxKmcBA9lzbPpz7M/0
        1LsRpk03aYB73y6xTtntFoc6Iv+zOe9VjyCh9RJy0IqGf9iz14NCR5qrmr3TZlAo
        Sbd9hd62d9+oNqiNUx/QheBYIXGyNOhCNaSPJY1tMMAVJKhhPzaII=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D84615F755;
        Mon, 10 Oct 2022 20:21:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BB8FB15F752;
        Mon, 10 Oct 2022 20:21:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2] ci: add address and undefined sanitizer tasks
References: <xmqq8rlo62ih.fsf@gitster.g>
Date:   Mon, 10 Oct 2022 17:21:38 -0700
In-Reply-To: <xmqq8rlo62ih.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        09 Oct 2022 15:44:22 -0700")
Message-ID: <xmqqpmezxl9p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ACE180BE-48FA-11ED-8811-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The signal of "passed with asan, but not ubsan" (or vice versa) is
not that useful in practice, run both santizers in a single task.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Range-diff against v1:
1:  04a9dc5439 ! 1:  cbf0d80ab1 ci: add address and undefined sanitizer tasks
    @@ Metadata
      ## Commit message ##
         ci: add address and undefined sanitizer tasks
     
    +    The signal of "passed with asan, but not ubsan" (or vice versa) is
    +    not that useful in practice, run both santizers in a single task.
    +
    +    Helped-by: Jeff King <peff@peff.net>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## .github/workflows/main.yml ##
    @@ .github/workflows/main.yml: jobs:
                - jobname: linux-leaks
                  cc: gcc
                  pool: ubuntu-latest
    -+          - jobname: linux-address
    -+            cc: gcc
    -+            pool: ubuntu-latest
    -+          - jobname: linux-undefined
    ++          - jobname: linux-sanitize
     +            cc: gcc
     +            pool: ubuntu-latest
          env:
    @@ ci/lib.sh: linux-leaks)
      	export GIT_TEST_PASSING_SANITIZE_LEAK=true
      	export GIT_TEST_SANITIZE_LEAK_LOG=true
      	;;
    -+linux-address | linux-undefined)
    -+	export SANITIZE=${jobname#linux-}
    ++linux-sanitize)
    ++	export SANITIZE=address,undefined
     +	;;
      esac
      

 .github/workflows/main.yml | 3 +++
 ci/lib.sh                  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 831f4df56c..92d27db0b9 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -251,6 +251,9 @@ jobs:
           - jobname: linux-leaks
             cc: gcc
             pool: ubuntu-latest
+          - jobname: linux-sanitize
+            cc: gcc
+            pool: ubuntu-latest
     env:
       CC: ${{matrix.vector.cc}}
       CC_PACKAGE: ${{matrix.vector.cc_package}}
diff --git a/ci/lib.sh b/ci/lib.sh
index 1b0cc2b57d..c9c4982e21 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -278,6 +278,9 @@ linux-leaks)
 	export GIT_TEST_PASSING_SANITIZE_LEAK=true
 	export GIT_TEST_SANITIZE_LEAK_LOG=true
 	;;
+linux-sanitize)
+	export SANITIZE=address,undefined
+	;;
 esac
 
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
-- 
2.38.0-146-gaff07b31d7

