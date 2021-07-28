Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDCFC432BE
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 17:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82F8961039
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 17:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhG1RHL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 13:07:11 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61823 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhG1RHI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 13:07:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C6A96149480;
        Wed, 28 Jul 2021 13:07:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SyWHxPGvL6Z1bXIYPYm4r2CMhttKT57wZJKU8V
        Kao+w=; b=pXqbo17Wy+Ovq2rhMHMHIRkS0JwzugaF0wGlKGVmra65iYAxMH00QO
        Nb7i0YEvpaNDfpQib5dbmXp622mSM40hmHXjJSm19+x4Jp7Kq3UEv6LfL9RysPCB
        x+6txApjs5B4JT+9Zcs7VpTtTGl1dB2zyVWSqAxdQyGfvr6WGXjgg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BFD2114947F;
        Wed, 28 Jul 2021 13:07:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0DA6F14947E;
        Wed, 28 Jul 2021 13:07:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Oded S via GitGitGadget <gitgitgadget@gmail.com>,
        Oded S <oded@istraresearch.com>
Subject: Re* [PATCH] Fix git-bisect when show-branch is configured to run
 with pager
References: <pull.1003.git.1627311659384.gitgitgadget@gmail.com>
        <xmqq4kcgkjhk.fsf@gitster.g> <xmqq7dhbehwl.fsf@gitster.g>
        <CAP8UFD26AXTYPvSzBD1x6hSvK5SNbM0F5BPX5bLEbxUZa2dAUg@mail.gmail.com>
        <xmqq8s1qbdcr.fsf@gitster.g>
Date:   Wed, 28 Jul 2021 10:07:02 -0700
In-Reply-To: <xmqq8s1qbdcr.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        28 Jul 2021 09:41:08 -0700")
Message-ID: <xmqq4kcebc5l.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B333D9C-EFC6-11EB-B57F-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'll fix the missing 'a' in the log message, but the "res"
simplification is probably better done as a separate patch on top.

How does this look?

Thanks.

---- >8 ------- >8 ------- >8 ------- >8 ------- >8 ------- >8 ----
Subject: [PATCH] bisect: simplify return code from bisect_checkout()

The function was designed to return only BISECT_OK (0) or
BISECT_FAILED (-1) and no other values, but there were two issues:

 - The comment misspelled BISECT_FAILED as BISECT_FAILURE, even
   though the logic it described (i.e. any non-zero return should be
   reported as a single BISECT_FAILED) was correct.

 - It took the return value from run_command_v_opt(), and assumed it
   was either -1 or 1 upon error, which is not the case; it can relay
   errors from wait_or_whine(), which can report exit status of the
   child process.

Translate any error return from run_command_v_opt() to BISECT_FAILED,
and simplify the resulting code by losing the 'res' variable that is
no longer needed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 bisect.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/bisect.c b/bisect.c
index 2b8b6546e9..888949fba6 100644
--- a/bisect.c
+++ b/bisect.c
@@ -727,7 +727,6 @@ static int is_expected_rev(const struct object_id *oid)
 static enum bisect_error bisect_checkout(const struct object_id *bisect_rev, int no_checkout)
 {
 	char bisect_rev_hex[GIT_MAX_HEXSZ + 1];
-	enum bisect_error res = BISECT_OK;
 	struct commit *commit;
 	struct pretty_print_context pp = {0};
 	struct strbuf commit_msg = STRBUF_INIT;
@@ -740,14 +739,13 @@ static enum bisect_error bisect_checkout(const struct object_id *bisect_rev, int
 		update_ref(NULL, "BISECT_HEAD", bisect_rev, NULL, 0,
 			   UPDATE_REFS_DIE_ON_ERR);
 	} else {
-		res = run_command_v_opt(argv_checkout, RUN_GIT_CMD);
-		if (res)
+		if (run_command_v_opt(argv_checkout, RUN_GIT_CMD))
 			/*
 			 * Errors in `run_command()` itself, signaled by res < 0,
 			 * and errors in the child process, signaled by res > 0
-			 * can both be treated as regular BISECT_FAILURE (-1).
+			 * can both be treated as regular BISECT_FAILED (-1).
 			 */
-			return -abs(res);
+			return BISECT_FAILED;
 	}
 
 	commit = lookup_commit_reference(the_repository, bisect_rev);
@@ -755,7 +753,7 @@ static enum bisect_error bisect_checkout(const struct object_id *bisect_rev, int
 	fputs(commit_msg.buf, stdout);
 	strbuf_release(&commit_msg);
 
-	return -abs(res);
+	return BISECT_OK;
 }
 
 static struct commit *get_commit_reference(struct repository *r,
-- 
2.32.0-561-g6177dfa0d2

