Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55799C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 19:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhLITaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 14:30:18 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64887 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhLITaR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 14:30:17 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 06806167595;
        Thu,  9 Dec 2021 14:26:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cJLx0wUAYuHWjwQCBCCK0ExrgHOCqECslLDnss
        a7KhI=; b=Bdv4QExXETVZpP/g/OelwNlzu+CGqaraawc3f8d/5eFAsxhhaMJLul
        KDJMDwIGbAOojT9pKui0sB5zShT63Uk0aY0BtKS0m+T3sk3cfwXFISd4Q1eGKWfH
        tI3eCU1KRA+PM6bU+ILLM1EoUVrUdK5Y55/anl7bfWV95s+x5vx2s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F188A167594;
        Thu,  9 Dec 2021 14:26:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 426FB167590;
        Thu,  9 Dec 2021 14:26:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 10/14] rebase: cleanup reset_head() calls
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
        <5ea636009e7858e50357f0f6f8d8fa42e056db60.1638975482.git.gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 11:26:38 -0800
In-Reply-To: <5ea636009e7858e50357f0f6f8d8fa42e056db60.1638975482.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Wed, 08 Dec 2021 14:57:57
        +0000")
Message-ID: <xmqqczm5r34h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF2B965A-5925-11EC-8ED4-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If ORIG_HEAD is not set by passing RESET_ORIG_HEAD then there is no
> need to pass anything for reflog_orig_head. In addition to the callers
> fixed in this commit move_to_original_branch() also passes
> reflog_orig_head without setting ORIG_HEAD. That caller is mistakenly
> passing the message it wants to put in the branch reflog which is not
> currently possible so we delay fixing that caller until we can pass
> the message as the branch reflog.

As I hinted elsewhere, these rules should be spelled out in a
comment before "int reset_head(...)" either in reset.[ch].

For this particular one, I wonder if 

 (A) we can lose RESET_ORIG_HEAD bit and use the presence of
     reflog_orig_head to mean what that bit currently means, or

 (B) we keep the current code strucure, but make it a BUG() if
     a non-NULL reflog_orig_head is given without RESET_ORIG_HEAD
     bit set.



> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/rebase.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 3d78b5c8bef..fdd822c470f 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -675,7 +675,7 @@ static int run_am(struct rebase_options *opts)
>  
>  		reset_head(the_repository, &opts->orig_head,
>  			   opts->head_name, 0,
> -			   "HEAD", NULL, DEFAULT_REFLOG_ACTION);
> +			   NULL, NULL, DEFAULT_REFLOG_ACTION);
>  		error(_("\ngit encountered an error while preparing the "
>  			"patches to replay\n"
>  			"these revisions:\n"
> @@ -1777,7 +1777,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			options.head_name ? options.head_name : "detached HEAD",
>  			oid_to_hex(&options.onto->object.oid));
>  		reset_head(the_repository, NULL, options.head_name,
> -			   RESET_HEAD_REFS_ONLY, "HEAD", msg.buf, NULL);
> +			   RESET_HEAD_REFS_ONLY, NULL, msg.buf, NULL);
>  		strbuf_release(&msg);
>  		ret = finish_rebase(&options);
>  		goto cleanup;
