Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F82C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 17:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF3622472
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 17:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgLSRlb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 12:41:31 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60408 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgLSRla (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 12:41:30 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6A8FB11788F;
        Sat, 19 Dec 2020 12:40:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NCUr4wcktl81Xim2yumj1SXvpc4=; b=QTyJ5s
        DIspUtUoq4kSmw79l7MIqr92z82pqhtP4jwffDBSluQ/yr6BiwtYnGF0R1CFUSPO
        RgMC+WcHrpuCjB+5/MPZgHyIQJA166RUonYWBsWL1DW29My5dVytvlwSjvps/ugF
        QcU0ZGd5e+wOdQbGqG+1eyV6fYoTgzoNVmv34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k0IE8VYQYirO7drwZ5nqkic0XdpFwEvq
        T/uRSjKZw4LvYHGI+iDD5lE1WTPZVaezHDOV7aB6IU2O/61yrq4ZLJ8V/qZLgUoj
        hGL+SGUGVPaOIezt/ViyqPeT/eKJbQagLNzWWecCIT2HMXjQho1RlOh85HjVgpu+
        BOR39lpnc+4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 641FA11788E;
        Sat, 19 Dec 2020 12:40:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AFD4E11788D;
        Sat, 19 Dec 2020 12:40:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] checkout -p: handle tree arguments correctly again
References: <pull.819.git.1608389760050.gitgitgadget@gmail.com>
Date:   Sat, 19 Dec 2020 09:40:43 -0800
In-Reply-To: <pull.819.git.1608389760050.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Sat, 19 Dec 2020 14:55:59
        +0000")
Message-ID: <xmqq5z4xpuck.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5251AF7A-4221-11EB-8C88-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>     I literally just ran into this segmentation fault after rebasing Git for
>     Windows onto -rc1, and did not really think that the regression was
>     introduced in the v2.30.0 cycle, but was proven wrong by my
>     investigation: it was introduced by v2.30.0-rc0151^23.

As "checkout -p branch~4" is easier than "checkout -p branch~4:", I
think you have to work harder to give a true tree object rather than
the containing commit object.

It still is curious how you stumbled onto this, but I am glad you
did ;-)

> @@ -482,7 +482,7 @@ static int checkout_paths(const struct checkout_opts *opts,
>  		 * properly. However, there is special logic for the HEAD case
>  		 * so we mustn't replace that.
>  		 */
> -		if (rev && strcmp(rev, "HEAD"))
> +		if (rev && new_branch_info->commit && strcmp(rev, "HEAD"))

The comment above talks about why "&& strcmp()" is there.  We now
have two.

I'd squash this in while queuing.  Thanks.


 builtin/checkout.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git c/builtin/checkout.c w/builtin/checkout.c
index 6f24b381c5..728c67e8ca 100644
--- c/builtin/checkout.c
+++ w/builtin/checkout.c
@@ -479,7 +479,9 @@ static int checkout_paths(const struct checkout_opts *opts,
 		 * with the hex of the commit (whether it's in `...` form or
 		 * not) for the run_add_interactive() machinery to work
 		 * properly. However, there is special logic for the HEAD case
-		 * so we mustn't replace that.
+		 * so we mustn't replace that.  Also, when we were given a
+		 * tree-object, new_branch_info->commit would be NULL, but we
+		 * do not have to do any replacement, either.
 		 */
 		if (rev && new_branch_info->commit && strcmp(rev, "HEAD"))
 			rev = oid_to_hex_r(rev_oid, &new_branch_info->commit->object.oid);
