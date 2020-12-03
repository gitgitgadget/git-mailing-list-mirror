Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC51C71155
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 00:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E415E221FD
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 00:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbgLCAfE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 19:35:04 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64389 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgLCAfE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 19:35:04 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3A6B1FF782;
        Wed,  2 Dec 2020 19:34:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PSUTi8oojqxeR9huflIgoJ7POuc=; b=KGRVOy
        FOSJf8PsGqnHQuPP1F4Os/h3ELWOxFyAcV24hULFL9TD9QncU/IiclNR0cj6tXei
        9HAR8CNo/0qkoWA68cIEht+BlrlLeIvB7ut4pdSvlHNlNGzTZ+MgtAa1T4SXRjIF
        5VavUWj/AuNHtwBoW6Koxqk0BkAHKvXmEaG8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wq9zX7LLaZvbsAY40phjNkLQbrc1CUh9
        bk0vsxXPw1bF6sU8c0IJ+hGlmg+MbqyQt5VMC/KNyDCXCfEhLlwuvOSNnQsST0Bh
        +Zf525dUos7jj7Kks4zKqFapTkRlSmypbzkmY+v3gCOGxa061b8atCGKLw37LzwS
        zwUK7yLVsMc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 25AC7FF781;
        Wed,  2 Dec 2020 19:34:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5F3B8FF780;
        Wed,  2 Dec 2020 19:34:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org
Subject: Re: [PATCH v1 02/27] revision: factor out setup of diff-merge
 related settings
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201108213838.4880-1-sorganov@gmail.com>
        <20201108213838.4880-3-sorganov@gmail.com>
Date:   Wed, 02 Dec 2020 16:34:17 -0800
In-Reply-To: <20201108213838.4880-3-sorganov@gmail.com> (Sergey Organov's
        message of "Mon, 9 Nov 2020 00:38:13 +0300")
Message-ID: <xmqqr1o7k9rq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47FDB714-34FF-11EB-BCAC-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Move all the setting code related to diffing merges into new
> setup_diff_merge_revs() function.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  revision.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

Looks trivially correct.

> diff --git a/revision.c b/revision.c
> index a09f4872acd7..739295bb9ff4 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2191,6 +2191,16 @@ static int parse_diff_merge_opts(struct rev_info *revs, const char **argv) {
>  	return 1;
>  }
>  
> +static void setup_diff_merges_revs(struct rev_info *revs)
> +{
> +	if (revs->combine_merges && revs->ignore_merges < 0)
> +		revs->ignore_merges = 0;
> +	if (revs->ignore_merges < 0)
> +		revs->ignore_merges = 1;
> +	if (revs->combined_all_paths && !revs->combine_merges)
> +		die("--combined-all-paths makes no sense without -c or --cc");
> +}
> +
>  static int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
>  			       int *unkc, const char **unkv,
>  			       const struct setup_revision_opt* opt)
> @@ -2885,12 +2895,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  			copy_pathspec(&revs->diffopt.pathspec,
>  				      &revs->prune_data);
>  	}
> -	if (revs->combine_merges && revs->ignore_merges < 0)
> -		revs->ignore_merges = 0;
> -	if (revs->ignore_merges < 0)
> -		revs->ignore_merges = 1;
> -	if (revs->combined_all_paths && !revs->combine_merges)
> -		die("--combined-all-paths makes no sense without -c or --cc");
> +
> +	setup_diff_merges_revs(revs);
>  
>  	revs->diffopt.abbrev = revs->abbrev;
