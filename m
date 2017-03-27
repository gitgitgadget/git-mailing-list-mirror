Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 792441FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 21:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752271AbdC0VxH (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 17:53:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56496 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752108AbdC0VxG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 17:53:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B7E118146F;
        Mon, 27 Mar 2017 17:46:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3x/wARKMmgyGcGV7ir+Rb/AaLb0=; b=PTbQ/Q
        1XpDsVOQv6GroaJitbcfwRO/Mh9hAy5T5W0wUm5UbjP7qxBWh+xQQGksk5j2CGjB
        TuJHpTbh8WzUWqgYr/Awafob3GBub+PqmTWmdv0JVTLDVSgSjliPog5YKIvDW/sZ
        dt02C1uEeYLtXr2SWglALzfwDBKOUHNWutIik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TtUiAFfLIsBb+cNcof3B+Z+UhbfTLJcJ
        kXQAEh2SfLmp5kXzcKY02ApuMU9b74HO6Rs3fpEThksWlHFCQXmHktIqCRHz3ix8
        fNcTK8xm25YhnRQ85BaBKvetm7PkVL0ZmfBRj9UT6p8mRNZDXMeQCF2KpCYqZauF
        B+Y7uIauu1k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE98F8146E;
        Mon, 27 Mar 2017 17:46:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 18DE18146D;
        Mon, 27 Mar 2017 17:46:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     jrnieder@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH 7/7] submodule.c: correctly handle nested submodules in is_submodule_modified
References: <20170324182902.19280-1-sbeller@google.com>
        <20170325003610.15282-1-sbeller@google.com>
        <20170325003610.15282-8-sbeller@google.com>
Date:   Mon, 27 Mar 2017 14:46:17 -0700
In-Reply-To: <20170325003610.15282-8-sbeller@google.com> (Stefan Beller's
        message of "Fri, 24 Mar 2017 17:36:10 -0700")
Message-ID: <xmqqpoh2z93q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CFA83A3E-1336-11E7-A4B9-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> When a nested submodule has untracked files, it would be reported as
> "modified submodule" in the superproject, because submodules are not
> parsed correctly in is_submodule_modified as they are bucketed into
> the modified pile as "they are not an untracked file".

I cannot quite parse the above.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c                 | 23 +++++++++++++++++++++--
>  t/t3600-rm.sh               |  2 +-
>  t/t7506-status-submodule.sh |  2 +-
>  3 files changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index fa21c7bb72..730cc9513a 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1078,8 +1078,27 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
>  		/* regular untracked files */
>  		if (buf.buf[0] == '?')
>  			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
> -		else
> -			dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
> +
> +		if (buf.buf[0] == 'u' ||
> +		    buf.buf[0] == '1' ||
> +		    buf.buf[0] == '2') {
> +			/*
> +			 * T XY SSSS:
> +			 * T = line type, XY = status, SSSS = submodule state
> +			 */
> +			if (buf.len < 1 + 1 + 2 + 1 + 4)
> +				die("BUG: invalid status --porcelain=2 line %s",
> +				    buf.buf);
> +
> +			/* regular unmerged and renamed files */
> +			if (buf.buf[5] == 'S' && buf.buf[8] == 'U')
> +				/* nested untracked file */
> +				dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;

OK, we have untracked one.

> +			if (memcmp(buf.buf + 5, "S..U", 4))
> +				/* other change */
> +				dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;

And for other cases like C at buf.buf[6] or M at buf.buf[7],
i.e. where the submodule not just has untracked files but has real
changes, we say it is truly MODIFIED here.

If there are changes to paths that is not a submodule but a tracked
file in the submodule in question would have N at buf.buf[5] and is
also caught with the same "not S..U so that's MODIFIED" logic.

OK.

Shouldn't this done as part of 4/7 where is_submodule_modified()
starts reading from the porcelain v2 output?  4/7 does adjust for
the change from double question mark (porcelain v1) to a single one
for untracked, but at the same time it needs to prepare for these
'u' (unmerged), '1' (normal modification) and '2' (mods with rename)
to appear in the output, no?

IOW, with 4/7 and 7/7 done as separate steps, isn't the system
broken between these steps?

