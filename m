Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B345FC6369E
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 00:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 605EB221FB
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 00:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgLCAjo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 19:39:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62434 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgLCAjo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 19:39:44 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14CA59A8B7;
        Wed,  2 Dec 2020 19:39:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=62h/GdC1AB/VyByHWRHI33IPf0Q=; b=liCGY/
        GExxaDRXl3ieE+gZwNvVVAIjiqMHiV40IA+BRkSannlryUGAq61+4gZJ5lJ1Gr+s
        FAtcZyzIOJGIKyXvQAu7QHgiDAWMhcmWEzdUsoK10idmr9MwXg28eO5M+gJrFwSt
        qkjf0NDNE6QuFKwtl9i4+YbUOXM3tFccobocQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UVtkxyMEKEOIFZCeAl6J0V83KdPELUOL
        Tv20PyIbq/UsY+w4fQxDrsVMY3TS7qbtlHo0y77V6bCF8g3sDTpt24fi/8SVIk8F
        CnaeSqIkZ01KFsbQaNmoMlZPXiHqAcoSM5tcnxldHIDvnvBrQYmRoacslfAt+0d1
        QoGO1ZGx/9o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0DF229A8B6;
        Wed,  2 Dec 2020 19:39:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7D08D9A8B5;
        Wed,  2 Dec 2020 19:39:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org
Subject: Re: [PATCH v1 03/27] revision: factor out initialization of
 diff-merge related settings
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201108213838.4880-1-sorganov@gmail.com>
        <20201108213838.4880-4-sorganov@gmail.com>
Date:   Wed, 02 Dec 2020 16:39:00 -0800
In-Reply-To: <20201108213838.4880-4-sorganov@gmail.com> (Sergey Organov's
        message of "Mon, 9 Nov 2020 00:38:14 +0300")
Message-ID: <xmqqmtyvk9jv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F026FD56-34FF-11EB-A5D6-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Move initialization code related to diffing merges into new
> init_diff_merge_revs() function.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  revision.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/revision.c b/revision.c
> index 739295bb9ff4..bc568fb79778 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1805,6 +1805,8 @@ static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
>  	return 1;
>  }
>  
> +static void init_diff_merge_revs(struct rev_info *revs);
> +

It is not wrong per-se, but I do not see why we do not define the
function here, not just forward-declare it like so.

>  void repo_init_revisions(struct repository *r,
>  			 struct rev_info *revs,
>  			 const char *prefix)
> @@ -1813,7 +1815,7 @@ void repo_init_revisions(struct repository *r,
>  
>  	revs->repo = r;
>  	revs->abbrev = DEFAULT_ABBREV;
> -	revs->ignore_merges = -1;
> +	init_diff_merge_revs(revs);
>  	revs->simplify_history = 1;
>  	revs->pruning.repo = r;
>  	revs->pruning.flags.recursive = 1;
> @@ -2153,6 +2155,10 @@ static void add_message_grep(struct rev_info *revs, const char *pattern)
>  	add_grep(revs, pattern, GREP_PATTERN_BODY);
>  }
>  
> +static void init_diff_merge_revs(struct rev_info *revs) {
> +	revs->ignore_merges = -1;
> +}

Style.  A brace that begins a function body begins its own line.  In
any case, I'd move this new definition before its sole caller; that
way we do not even need an extra forward-declaration.

>  static int parse_diff_merge_opts(struct rev_info *revs, const char **argv) {
>  	int argcount;
>  	const char *optarg;
