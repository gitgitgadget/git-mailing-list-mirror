Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B072C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 17:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJKRLy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 13:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiJKRLs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 13:11:48 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B629D7D7AE
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 10:11:45 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E762914B970;
        Tue, 11 Oct 2022 13:11:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=sOAAFf967Ol/KAaUByT5FmdqQn0o+f+d5asVvRIHCqo=; b=hpG3
        k3lorh7y3TDlh1dxVt2CRqFXzFfGddzaf6DeczZpcVg93bn1VK+TPSriPouSl0xP
        czerBYmH50au5no2LV8EjnRwjsRPcvdVoeAsRpcTLMkKwmec+K/Iqh+54sxpXaks
        Ge2d/Bx9ujlTgVCgk/xbKbshfMrP6nP7hrnnoZA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DDA6C14B96F;
        Tue, 11 Oct 2022 13:11:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4CC0414B96C;
        Tue, 11 Oct 2022 13:11:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] bisect--helper: plug strvec leak
References: <5c6a4c30-d454-51b6-ec57-9af036b9c4e0@web.de>
        <221005.8635c2u3k5.gmgdl@evledraar.gmail.com>
        <xmqqy1tunjgp.fsf@gitster.g>
        <221006.86a668r5mf.gmgdl@evledraar.gmail.com>
        <xmqqk05cipq8.fsf@gitster.g>
        <1965b54b-122a-c965-f886-1a7dd6afbfb4@web.de>
        <Y0TXTl0gSBOFQa9B@coredump.intra.peff.net>
        <xmqq35buykz1.fsf@gitster.g>
        <Y0VtkmNwjKcXcemP@coredump.intra.peff.net>
Date:   Tue, 11 Oct 2022 10:11:42 -0700
Message-ID: <xmqqpmeyuvxt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C768AB32-4987-11ED-ADE4-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The bug I'm worried about it is in a human writing the list of strings
> and forgetting the NULL, so there we are losing the (admittedly minor)
> protection.

I expect that this story will repeat itself, especially given that
we asserted that it is OK to initialize such an array with variable
reference recently in this thread.

Here are a couple that I found with a quick eyeballing of the output
of "git grep -e 'run_command_v_opt([^,]*\.v,' \*.c" command.



diff --git a/builtin/clone.c b/builtin/clone.c
index ed8d44bb6a..c93345bc75 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -651,9 +651,8 @@ static void update_head(const struct ref *our, const struct ref *remote,
 
 static int git_sparse_checkout_init(const char *repo)
 {
-	struct strvec argv = STRVEC_INIT;
 	int result = 0;
-	strvec_pushl(&argv, "-C", repo, "sparse-checkout", "set", NULL);
+	const char *argv[] = { "-C", repo, "sparse-checkout", "set", NULL };
 
 	/*
 	 * We must apply the setting in the current process
@@ -661,12 +660,11 @@ static int git_sparse_checkout_init(const char *repo)
 	 */
 	core_apply_sparse_checkout = 1;
 
-	if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
+	if (run_command_v_opt(argv, RUN_GIT_CMD)) {
 		error(_("failed to initialize sparse-checkout"));
 		result = 1;
 	}
 
-	strvec_clear(&argv);
 	return result;
 }
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 0a0ca8b7c4..d261bc652f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -384,24 +384,20 @@ static void reset_hard(const struct object_id *oid, int verbose)
 static void restore_state(const struct object_id *head,
 			  const struct object_id *stash)
 {
-	struct strvec args = STRVEC_INIT;
-
 	reset_hard(head, 1);
 
-	if (is_null_oid(stash))
-		goto refresh_cache;
-
-	strvec_pushl(&args, "stash", "apply", "--index", "--quiet", NULL);
-	strvec_push(&args, oid_to_hex(stash));
+	if (!is_null_oid(stash)) {
+		const char *argv[] = {
+			"stash", "apply", "--index", "--quiet", oid_to_hex(stash), NULL
+		};
 
-	/*
-	 * It is OK to ignore error here, for example when there was
-	 * nothing to restore.
-	 */
-	run_command_v_opt(args.v, RUN_GIT_CMD);
-	strvec_clear(&args);
+		/*
+		 * It is OK to ignore error here, for example when there was
+		 * nothing to restore.
+		 */
+		run_command_v_opt(argv, RUN_GIT_CMD);
+	}
 
-refresh_cache:
 	if (discard_cache() < 0 || read_cache() < 0)
 		die(_("could not read index"));
 }
