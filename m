Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80F07207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 22:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756913AbcILWXP (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 18:23:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63459 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752632AbcILWXO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 18:23:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 424443C0B9;
        Mon, 12 Sep 2016 18:23:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sBLbu34RPN6taLkSS1E0xepkpAQ=; b=yTnTm4
        ThGSuQX8jxCBoNdZu/v1dcmbedNY543AClX/2HSpB4vkAVPupyLL9nLFbiHVXpv7
        vzpAodP10xhG7WBFgHXXdo6Pmx/d1VxnitijY0aCs/8sYHSosQkY22IJYq+435XS
        3FGg1n9N5rG+J5k+MuU01C8+SyroU5P21EI1w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H5RpY2kI2AR8DSmb8LNQDr5OX8AnXWRG
        surO53cl5hZ3dl7W8dC5cy1dxYv+9HVLD75Kw9LPq4VC/4tFfRXaJdOfd7i0VoMu
        InkZPPPe3gW2ma39A4ymGpDFIea0gjF9B9YD4pl4IHw2AudqiaeTNDkdMk+5GHTW
        tpFZ88R/hC8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A33A3C0B8;
        Mon, 12 Sep 2016 18:23:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AD3373C0B7;
        Mon, 12 Sep 2016 18:23:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jan Keromnes <janx@linux.com>,
        Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH v3 4/4] add: modify already added files when --chmod is given
References: <20160911103028.5492-1-t.gummerer@gmail.com>
        <20160912210818.26282-1-t.gummerer@gmail.com>
        <20160912210818.26282-5-t.gummerer@gmail.com>
Date:   Mon, 12 Sep 2016 15:23:10 -0700
In-Reply-To: <20160912210818.26282-5-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Mon, 12 Sep 2016 22:08:18 +0100")
Message-ID: <xmqqy42wycz5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E24518C-7937-11E6-B85F-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> When the chmod option was added to git add, it was hooked up to the diff
> machinery, meaning that it only works when the version in the index
> differs from the version on disk.
>
> As the option was supposed to mirror the chmod option in update-index,
> which always changes the mode in the index, regardless of the status of
> the file, make sure the option behaves the same way in git add.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  builtin/add.c      | 36 +++++++++++++++++++++++++-----------
>  builtin/checkout.c |  2 +-
>  builtin/commit.c   |  2 +-
>  cache.h            | 10 +++++-----
>  read-cache.c       | 14 ++++++--------
>  t/t3700-add.sh     | 21 +++++++++++++++++++++
>  6 files changed, 59 insertions(+), 26 deletions(-)

The change looks quite large but this in essense reverts what Edward
did in the first round by hooking into "we add only modified files
here" and "we add new files here", both of which are made unnecessary,
because this adds the final "now we finished adding things, let's
fix modes of paths that match the pathspec".

Which makes sense.

> +static void chmod_pathspec(struct pathspec *pathspec, int force_mode)
> +{
> +	int i;
> +	
> +	for (i = 0; i < active_nr; i++) {
> +		struct cache_entry *ce = active_cache[i];
> +
> +		if (pathspec && !ce_path_match(ce, pathspec, NULL))
> +			continue;
> +
> +		if (chmod_cache_entry(ce, force_mode) < 0)
> +			fprintf(stderr, "cannot chmod '%s'", ce->name);
> +	}
> +}

If pathspec is NULL, this will chmod all paths in the index, which
is probably not very useful and quite risky operation at the same
time.

However ...

> +	if (force_mode)
> +		chmod_pathspec(&pathspec, force_mode);

... the caller never passes a NULL as pathspec.

In any case, I somehow expected to see

	if (force_mode && pathspec.nr)
        	chmod_pathspec(&pathspec, force_mode);

because it would make it very easy to see in the caller that

	git add --chmod=+x              ;# no pathspec
        cd subdir && git add --chmod=+x ;# no pathspec

will be a no-op, which is what we want, if I am not mistaken.  Of
course, if somebody really wants to drop executable bit from
everything, she can do

	git add --chmod=-x .

pretty easily.

Above three may want to be added as new tests.  The first two should
be a no-op, while the last one should drop executable bits from
everywhere.

Thanks.



