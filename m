Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EE2EE4996
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 00:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjHVAbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 20:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjHVAbh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 20:31:37 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EF4131
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 17:31:34 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C69B1BD9DF;
        Mon, 21 Aug 2023 20:31:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xuzaRHtw4r3OumJ9+2oE1bbBl4cVXooazgk8qu
        lzNmE=; b=TER6iiqi823A14cchzLDWzyUv9WY5jYe91tNfrvEtwwZIJKsamLGs3
        E9xk2LhDM1TW4YCY5kwvf7UsZptQMsFESjpKKkTKWWtFsh2ypZNV6fxk7GWyJ9vc
        5BIQN8mvx/fvothBUr4tto4EkyDVRN0VKVb+rKmgIfY1YJa0naUNI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8208A1BD9DE;
        Mon, 21 Aug 2023 20:31:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9DBC11BD9DD;
        Mon, 21 Aug 2023 20:31:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, 'Jeff King' <peff@peff.net>,
        'Taylor Blau' <me@ttaylorr.com>,
        'Andy Koppe' <andy.koppe@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] ci: avoid building from the same commit in parallel
References: <20230715103758.3862-1-andy.koppe@gmail.com>
        <20230715160730.4046-1-andy.koppe@gmail.com>
        <kl6l351j22dr.fsf@chooglen-macbookpro.roam.corp.google.com>
        <CAHWeT-ZA8f-TGRwDHixAvi5kddVBbuK8LpVGJ9cjYZMsMk5ODw@mail.gmail.com>
        <xmqq7cpwjhr1.fsf@gitster.g>
        <006574bd-4d53-495e-8cfe-677ede521908@gmail.com>
        <xmqq350kjfk8.fsf@gitster.g>
        <ce5d20db-2220-45dd-8c39-2a52e0f9f816@gmail.com>
        <ZNv5PQlkn6tbUcH7@nand.local>
        <20230816022420.GA2248431@coredump.intra.peff.net>
        <000901d9d045$e780f790$b682e6b0$@nexbridge.com>
        <xmqqo7j5uqza.fsf@gitster.g>
        <15b89f2e-adb8-ea2b-fd74-2cbe95e20501@gmx.de>
        <xmqqttssqsj5.fsf@gitster.g>
Date:   Mon, 21 Aug 2023 17:31:26 -0700
In-Reply-To: <xmqqttssqsj5.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        21 Aug 2023 09:17:18 -0700")
Message-ID: <xmqq1qfvor35.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B67DD80-4083-11EE-B020-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At times, we may need to push the same commit to multiple branches
in the same push.  Rewinding 'next' to rebuild on top of 'master'
soon after a release is such an occasion.  Making sure 'main' stays
in sync with 'master' to help those who expect that primary branch
of the project is named either of these is another.

We used to use the branch name as the "concurrency group" key, but
by switching to use the commit object name would make sure the
builds for the same commit would happen serially, and by the time
the second job becomes ready to run, the first job's outcome would
be available and mking it unnecessary to run the second job.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * There are tons of concurrency groups defined, but as a trial
   change, here is to cover the "regular" matrix that consumes the
   most resources (linux-asan-ubsan is the worst culprit, it seems).

 .github/workflows/main.yml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 30492eacdd..27b151aadf 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -240,8 +240,7 @@ jobs:
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
     concurrency:
-      group: ${{ matrix.vector.jobname }}-${{ matrix.vector.pool }}-${{ github.ref }}
-      cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
+      group: ${{ matrix.vector.jobname }}-${{ matrix.vector.pool }}-${{ github.sha }}
     strategy:
       fail-fast: false
       matrix:
-- 
2.42.0

