Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A1EC07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 19:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C785961C4C
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 19:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhGFTvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 15:51:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59226 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGFTvA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 15:51:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E621C152F;
        Tue,  6 Jul 2021 15:48:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DmRBm2BMDFZxOYT1TqCPt1/Krue/jw034nsNKR
        OF3+U=; b=ULTUvUxe0Cv/xc6Hzu5LDvY2qllDy0ysaN0EWVWyuJqE2aVbp5H2nk
        Npiha4mu7TxJaMDol8tSJX+gYuGNZuDMIplnNNPm0rJCcQWc04Rbzi/l87m9tgZv
        OqsPRiDyFQfTzx69BFpjFcYRsPPCKPv5XrOTRnwBnwwV7vJJ8lKqQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6618EC152D;
        Tue,  6 Jul 2021 15:48:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E557AC1529;
        Tue,  6 Jul 2021 15:48:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Clemens Fruhwirth <clemens@endorphin.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch: Fix segfault on pull --set-upstream outside a
 branch.
References: <20210706162238.575988-1-clemens@endorphin.org>
        <xmqq1r8bl40i.fsf@gitster.g>
Date:   Tue, 06 Jul 2021 12:48:16 -0700
In-Reply-To: <xmqq1r8bl40i.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        06 Jul 2021 10:57:01 -0700")
Message-ID: <xmqqzguzi5q7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B99E48E-DE93-11EB-9018-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Nit.  What do you mean by "outside a branch"?  If you mean "when the
> HEAD is detached", please say so, and use the same terminology in
> your warning message.

Here is what I queued for today's integration run.  Eric's
suggestion to add a simple test is a good idea, too.

Thanks.

-- >8 --
From: Clemens Fruhwirth <clemens@endorphin.org>
Date: Tue, 6 Jul 2021 18:22:38 +0200
Subject: [PATCH] fetch: fix segfault on pull --set-upstream while on a detached HEAD

branch_get("HEAD") can return NULL, when HEAD is detached, and cause
the code to segfault when the user calls "pull --set-upstream".

Catch this case and warn the user to avoid a segfault.

Signed-off-by: Clemens Fruhwirth <clemens@endorphin.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index dfde96a435..0a11430df4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1602,6 +1602,10 @@ static int do_fetch(struct transport *transport,
 		struct ref *rm;
 		struct ref *source_ref = NULL;
 
+		if (!branch) {
+			warning(_("no branch detected to use --set-upstream with."));
+			goto skip;
+		}
 		/*
 		 * We're setting the upstream configuration for the
 		 * current branch. The relevant upstream is the
-- 
2.32.0-288-g654beb0eda

