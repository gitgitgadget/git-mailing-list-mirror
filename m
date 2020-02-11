Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894E9C352A3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 16:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A5E20848
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 16:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WAktJEge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgBKQ4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:56:40 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61155 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbgBKQ4k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 11:56:40 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 50E1798259;
        Tue, 11 Feb 2020 11:56:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wh234KpQnoFgqi6pX0/Zfsv2K7Y=; b=WAktJE
        ge1IAULmjE/yz74+N4uw1ucIZJazLR1xi1niZgGEs//xSihgkSZf8ZgW6N7n6AUq
        rgTS19NRDgn1egTSE6YMcnXWBxcvJ8WUVRMSsump5xfCnVRe7oT04hHSUzcvk6ik
        NWEcq3WhbOcn6tu4vEiktCKhgjZVLjdT5xEro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q3t1Fq94nL/0gQcXAeLTMWsB0Dv22F5C
        GvOCSh+CWZPl5b1CACKucNmPmCU9ODbMAAtK2w40Vl1PALHdyHW04BmA7boZa3Lg
        E4OTRPjzZqYiJeOIFeEnAoUHQr4lswUwN85BvFyBeRm9E7rrLDOjGeYAzWLWZMO3
        QpFtLrusNUE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 491A998258;
        Tue, 11 Feb 2020 11:56:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7646D98257;
        Tue, 11 Feb 2020 11:56:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        newren@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/4] sparse-checkout: extract add_patterns_from_input()
References: <pull.546.git.1581433344.gitgitgadget@gmail.com>
        <75ee62caa940e7232e0edb50788302f36a08b5b9.1581433344.git.gitgitgadget@gmail.com>
Date:   Tue, 11 Feb 2020 08:56:30 -0800
In-Reply-To: <75ee62caa940e7232e0edb50788302f36a08b5b9.1581433344.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 11 Feb 2020
        15:02:21 +0000")
Message-ID: <xmqqo8u5vz9d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 749491F6-4CEF-11EA-AEF5-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
> +static void add_patterns_from_input(struct pattern_list *pl,
> +				    int argc, const char **argv)

Separating out what happens _after_ parse_options into its own
helper function makes sense.

Everything, not limited to this function, works on its input, so the
name suffix does not add much value to the readers.  IOW, I do not
think I, as a new reader of this code, would be confused if this
function were called add_patterns().

If we wanted to add more words to the name, perhaps I'd use them to
describe the shape of the input (e.g. "add_patterns_from_acav") but
that is obvious from the list of input parameter, so...

I haven't read the rest of the series, but will we ever call this
helper function with an array we manufacture ourselves?  If the
input array is known to be NULL terminated (and at this step in the
series, it certainly is, as we are using the ac/av supplied by the C
runtime entry point), perhaps we can omit argc from the parameter to
simplify the calling convention a bit?

>  {
>  	int i;
> -	struct pattern_list pl;
> -	int result;
> -	int changed_config = 0;
> -
> -	static struct option builtin_sparse_checkout_set_options[] = {
> -		OPT_BOOL(0, "stdin", &set_opts.use_stdin,
> -			 N_("read patterns from standard in")),
> -		OPT_END(),
> -	};
> -
> -	repo_read_index(the_repository);
> -	require_clean_work_tree(the_repository,
> -				N_("set sparse-checkout patterns"), NULL, 1, 0);
> -
> -	memset(&pl, 0, sizeof(pl));
> -
> -	argc = parse_options(argc, argv, prefix,
> -			     builtin_sparse_checkout_set_options,
> -			     builtin_sparse_checkout_set_usage,
> -			     PARSE_OPT_KEEP_UNKNOWN);
> -
>  	if (core_sparse_checkout_cone) {
>  		struct strbuf line = STRBUF_INIT;
>  
> -		hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
> -		hashmap_init(&pl.parent_hashmap, pl_hashmap_cmp, NULL, 0);
> -		pl.use_cone_patterns = 1;
> +		hashmap_init(&pl->recursive_hashmap, pl_hashmap_cmp, NULL, 0);
> +		hashmap_init(&pl->parent_hashmap, pl_hashmap_cmp, NULL, 0);
> +		pl->use_cone_patterns = 1;
> ...

