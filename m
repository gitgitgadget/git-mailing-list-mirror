Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA1AC4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 05:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJUF7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 01:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJUF7g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 01:59:36 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A5B23BF5
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 22:59:32 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0F06156CB2;
        Fri, 21 Oct 2022 01:59:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zr9WOGKCEcLcSU38EteEzFfdjTuS4HmNFrByf+
        1lv9k=; b=heumAqQJT8yrA3AKeatXxTe2y10Aj2I06p+pqr4MQ57vlJZ38MWf1R
        7CCeA9sY/QLxXknZKyoOhqzeQVZiCGQIuUJ6D8zirF5WR5ZABQYgKOR4iqah/tkt
        +B57amHw4PBKrf9aYC3MIYxmpiGm0VTCT8ceta2F+j/YxXBNL/lWg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A97AC156CB0;
        Fri, 21 Oct 2022 01:59:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1C9B2156CAF;
        Fri, 21 Oct 2022 01:59:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] ci: add address and undefined sanitizer tasks
References: <xmqq8rlo62ih.fsf@gitster.g> <xmqqtu4bz2fw.fsf@gitster.g>
        <Y0SyH34tdXQK2qhA@coredump.intra.peff.net>
Date:   Thu, 20 Oct 2022 22:59:28 -0700
In-Reply-To: <Y0SyH34tdXQK2qhA@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 10 Oct 2022 20:00:31 -0400")
Message-ID: <xmqqtu3xogxr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 867BFF18-5105-11ED-B7EB-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> You can make it a bit faster by running both at once as
> SANITIZE=address,undefined.

With a single combined sanitier job, we saw failures at CI of p4
tests, where the server "goes away" in the middle of tests, for
apparently no reason, and I just speculated perhaps the tests taking
too long may be causing an impatient server side to go away before
the client side finishes its work or something.  After splitting the
ASan and UBSan jobs into two and ejecting a topic out of 'seen', CI
started passing for the first time in several days.

So, here is what I ended up using, at least for now.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH] ci: add address and undefined sanitizer tasks

The current code is clean with these two sanitizers, and we would
like to keep it that way by running the checks for any new code.

The signal of "passed with asan, but not ubsan" (or vice versa) is
not that useful in practice, so it is tempting to run both santizers
in a single task, but it seems to take forever, so tentatively let's
try having two separate ones.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .github/workflows/main.yml | 6 ++++++
 ci/lib.sh                  | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 831f4df56c..bd6f75b8e0 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -251,6 +251,12 @@ jobs:
           - jobname: linux-leaks
             cc: gcc
             pool: ubuntu-latest
+          - jobname: linux-asan
+            cc: gcc
+            pool: ubuntu-latest
+          - jobname: linux-ubsan
+            cc: gcc
+            pool: ubuntu-latest
     env:
       CC: ${{matrix.vector.cc}}
       CC_PACKAGE: ${{matrix.vector.cc_package}}
diff --git a/ci/lib.sh b/ci/lib.sh
index 1b0cc2b57d..e3d49d3296 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -278,6 +278,12 @@ linux-leaks)
 	export GIT_TEST_PASSING_SANITIZE_LEAK=true
 	export GIT_TEST_SANITIZE_LEAK_LOG=true
 	;;
+linux-asan)
+	export SANITIZE=address
+	;;
+linux-ubsan)
+	export SANITIZE=undefined
+	;;
 esac
 
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
-- 
2.38.1-312-ge3e2987aab
