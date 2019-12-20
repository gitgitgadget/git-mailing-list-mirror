Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFBCC43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920692072B
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nCKr9jqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfLTSBZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:01:25 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57896 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfLTSBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:01:25 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B65738F66;
        Fri, 20 Dec 2019 13:01:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PDnK1XeKg4UZvfa8AoApHTEDdPw=; b=nCKr9j
        qjou63Qiqs1GYlwvavvUakKo3Uu+cutulQe61VIIW+zYKY6+PadEum5VNeQjh6t5
        uAO0o6SMsLx5dZVLIi6o1k28KESmDkqF7D509jSKo4SzM9x0TxyQ29ZSoUIa/Jgh
        +5UQjXNI9pIHqcMJ3gcTomSZas2noumHQ5JM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZreNgxyuUfVRvvvB1KnGfmZ1a/tACDtc
        hZaLomK6+8pNCMILrlSNuDCYtIE2J4bULOgzjSQRaFXTcsNKkToZ/Aqmb66FVzeD
        gQ4c6CDRc0HuowOUsEHlHqKF2aRVJpsC0cn39pA6pFwO637Net1pEkQfBu9Rc9ch
        zFL4aRFNNiI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1282938F65;
        Fri, 20 Dec 2019 13:01:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 64B4738F64;
        Fri, 20 Dec 2019 13:01:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, blees@dcon.de,
        Kyle Meyer <kyle@kyleam.com>, Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [PATCH v4 6/8] dir: fix checks on common prefix directory
References: <pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com>
        <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com>
        <1f3978aa461929923eeb5037e69be6569f0ba331.1576697386.git.gitgitgadget@gmail.com>
        <xmqq1rt1e30q.fsf@gitster-ct.c.googlers.com>
        <CABPp-BHhAPjL9daPdp7UmVT+vLrcpo6SX0rKt5s1bH4Vz31wxw@mail.gmail.com>
        <20191219222403.GA705525@coredump.intra.peff.net>
Date:   Fri, 20 Dec 2019 10:01:21 -0800
In-Reply-To: <20191219222403.GA705525@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 19 Dec 2019 17:24:03 -0500")
Message-ID: <xmqqlfr6anbi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB446890-2352-11EA-8B91-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Please use st_add3() while you are at it.
>
> I'd also usually suggest FLEX_ALLOC_MEM() for even more simplicity, but
> it looks like filling the string is handled separately (and done many
> times).
>
> I have to wonder, though, if it wouldn't be simpler to move away from
> "struct dirent" here (and it looks like Junio suggested the same earlier
> in the thread). I don't know this code very well, but it looks
> like it could easily get by passing around a name pointer and a dtype
> through the cached_dir. The patch below seems like it's not too bad a
> cleanup, but possibly the names could be better.

It does look like a good clean-up.

In the meantime, here is to apologize for merging the patch a bit
too early to 'next'.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Fri, 20 Dec 2019 09:55:53 -0800
Subject: [PATCH] dir.c: use st_add3() for allocation size

When preparing a manufactured dirent instance, we add a length of
path to the size of struct to decide how many bytes to allocate.
Make sure this addition does not wrap-around to cause us
underallocate.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index e1b74f6478..113170aeb9 100644
--- a/dir.c
+++ b/dir.c
@@ -2154,7 +2154,7 @@ static int treat_leading_path(struct dir_struct *dir,
 	 * For either case, padding with len+1 bytes at the end will ensure
 	 * sufficient storage space.
 	 */
-	de = xcalloc(1, sizeof(struct dirent)+len+1);
+	de = xcalloc(1, st_add3(sizeof(struct dirent), len, 1));
 	memset(&cdir, 0, sizeof(cdir));
 	cdir.de = de;
 #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
-- 
2.24.1-769-g187e15c71d



