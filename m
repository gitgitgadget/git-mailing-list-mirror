Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF83DC43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 18:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74B0A214F1
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 18:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M1k+KFGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgIJSge (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:36:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58041 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbgIJSfr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 14:35:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 86C6E6C915;
        Thu, 10 Sep 2020 14:35:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=jBeVYemeKkCskkAGbXYlDTAEAf8=; b=M1k+KFGUW2cJFT9duhBl
        DfVWjGWba0R398AmzPEXNXs7jmVvzU4wPyJOFaGCuAN8JzCohLScWDnpBatxsbic
        CXEk1vh3kDVIQgl42cw0I+9EwdR902c96QKDPUA1luqLRLdIWeHEVgbEVGR+zreR
        SsYTJNBXex9iTI5e9pq5C2c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=VFL2OH2KWqYrHZf90ZjSU55Q3AJrHB/JWhyNnS4gEXZP7e
        1T+oFjLAx0bSuecgUqhxw7/PNRni25uEmWxFsApYip11TU0/P5zmt1j+Eyq9+lHY
        m+OrOgY1WRmr6C5qKdjMbA0vlI2pKl15RtqR794Aa1HgM7Fm3StsR07Hv9e8I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DBF96C913;
        Thu, 10 Sep 2020 14:35:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EDE656C912;
        Thu, 10 Sep 2020 14:35:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] builtin/diff: parse --no-index using parse_options()
References: <cover.1599332861.git.liu.denton@gmail.com>
        <cover.1599723087.git.liu.denton@gmail.com>
        <ea6717e7b3a8b89fc3750505678321803cde78dc.1599723087.git.liu.denton@gmail.com>
Date:   Thu, 10 Sep 2020 11:35:42 -0700
Message-ID: <xmqqo8mdpji9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6EEC7470-F394-11EA-A556-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Instead of parsing the `--no-index` option with a plain strcmp, use
> parse_options() to parse options. This allows us to easily add more
> options in a future commit.
>
> As a result of this change, `--no-index` is removed from `argv` so, as a
> result, we no longer need to handle it in diff_no_index().
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  builtin/diff.c  | 33 ++++++++++++++++++++++-----------
>  diff-no-index.c | 15 +++------------
>  2 files changed, 25 insertions(+), 23 deletions(-)
>
> diff --git a/builtin/diff.c b/builtin/diff.c
> index cb98811c21..0e086ed7c4 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -373,6 +373,13 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  	int nongit = 0, no_index = 0;
>  	int result = 0;
>  	struct symdiff sdiff;
> +	struct option options[] = {
> +		OPT_SET_INT_F(0, "no-index", &no_index,
> +			   N_("compare the given paths on the filesystem"),
> +			   DIFF_NO_INDEX_EXPLICIT,
> +			   PARSE_OPT_NONEG),
> +		OPT_END(),
> +	};

What's the reasoning behind teaching the "--merge-base" option only
to "diff" and not allowing "diff-index" and "diff-tree" to also
benefit from the new support?  It should be taught to be handled by
diff.c::diff_opt_parse() instead, like all other "diff" options.  I
simply do not see what makes "--merge-base" so special compared to
other options like "-R", "--color-words", etc.

And with that, this step will become totally unnecessary, because
the options[] array will still have only the "no-index" option and
nothing else.

UNLESS we are planning to use this array to parse all diff options
here, whether it is for the no-index mode or the normal invocation
of diff, but that is unlikely to happen---we'd still share many
options between the plumbing "diff-*" family and Porcelain "diff"
commands.

Thanks.
