Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AFFC001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 19:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbjHHTqK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 15:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbjHHTpq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 15:45:46 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB85411BDE1
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 09:49:36 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 258FD2B6AB;
        Tue,  8 Aug 2023 12:49:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cXV361mCUrrxEKWLTnzs1ZE2oV2XP5ygd8Urcl
        a1qqY=; b=ISV3kokYt0e63WCozUg/AYr5GDVYorG3EvsocsceC+Rl4OYFWzcfkf
        tYTJFShplpCjnRmcrZbh7DeAjxJIaPlS4l/g5cnm0wL7oARDDFywNR8gUdk8qNv+
        JqmbjS5bUFPI5PNTDlmDpnttTQIbI7IzL3wL2910KM+I+y8rVkBaA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1D7EC2B6AA;
        Tue,  8 Aug 2023 12:49:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 88CEB2B6A7;
        Tue,  8 Aug 2023 12:49:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        lenaic@lhuard.fr, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/6] maintenance: add get_random_minute()
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
        <fefdaa9457948ee5302e7cbfaae250e0b589d752.1691434300.git.gitgitgadget@gmail.com>
        <ZNFgIyuhlNd8I9Y2@nand.local> <xmqq4jlabea3.fsf@gitster.g>
        <xmqqzg329ycm.fsf@gitster.g> <ZNJVycLBUIXqZ0Xb@nand.local>
        <xmqqbkfha3xu.fsf@gitster.g>
Date:   Tue, 08 Aug 2023 09:49:30 -0700
In-Reply-To: <xmqqbkfha3xu.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        08 Aug 2023 09:34:21 -0700")
Message-ID: <xmqqsf8t8oo5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8BF61DB6-360B-11EE-B506-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Provided if code simplification is a good enough rationale, the
> patch looks sensible, but I find its use of u64 a bit questionable
> (though not wrong).  I would have expected that the type of "rand"
> would be the same as backoff_ms and wait_ms, two variables involved
> in the same expression.

Ah, not so fast.  The use of modulo means we need to be careful
about about the fuzzing factor going negative, and use of unsigned
type allows us to forget about it.

(fuzz % 250), when fuzz is of a signed random integral type, ranges
between -250 and +250 and because we want the center of our
distribution at 1000, so I think the following is equivalent.

 lockfile.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git c/lockfile.c w/lockfile.c
index 6587d407f4..7de53526ac 100644
--- c/lockfile.c
+++ w/lockfile.c
@@ -115,9 +115,8 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
 		remaining_ms = timeout_ms;
 
 	while (1) {
-		long backoff_ms, wait_ms;
+		long backoff_ms, wait_ms, fuzz;
 		int fd;
-		uint64_t rand;
 
 		fd = lock_file(lk, path, flags, mode);
 
@@ -130,10 +129,10 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
 
 		backoff_ms = multiplier * INITIAL_BACKOFF_MS;
 		/* back off for between 0.75*backoff_ms and 1.25*backoff_ms */
-		if (csprng_bytes(&rand, sizeof(uint64_t)) < 0)
+		if (csprng_bytes(&fuzz, sizeof(fuzz)) < 0)
 			return error_errno(_("unable to get random bytes for"
 					     "lockfile backoff"));
-		wait_ms = (750 + rand % 500) * backoff_ms / 1000;
+		wait_ms = (1000 + fuzz % 250) * backoff_ms / 1000;
 		sleep_millisec(wait_ms);
 		remaining_ms -= wait_ms;
 


