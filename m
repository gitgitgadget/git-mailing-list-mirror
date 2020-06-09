Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E812C433E0
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 20:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFE9E2076A
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 20:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hTv4yM0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733002AbgFIUWa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 16:22:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61498 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729875AbgFIUW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 16:22:29 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3CCBFC1F1A;
        Tue,  9 Jun 2020 16:22:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=3LdvoPPlhOHUCMlqokM245AYT9U=; b=hTv4yM0qY2/U2YPjJuta
        lrEG79vYAWvNRNQ0x5rAr3EVKaZOZ8mFDVq5rSpwXcm6B64bmgixx89P8riyte7y
        WvRphILHAgcYhu3WXyO/OXg82DC2/EpvHz8Nad32za0PGI/hmOvlXllFPKVUC1Pd
        Ly6+46qkYepYkwgkjmf3hSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=VAHFlfQuZltH670kRfcVWuXcOEYAxz/BYned/+gzIrf2a5
        qletDdOws3qouwy2EP/OQ3kqmulaZD5wAQG2mEAqcSJLoTEl0ynejcPahwuhQMKG
        WaJh9X1Kcfokl0mPaEC6EmyoxNirWTiyiCyzNoe8oWH4Hy5QCTCyHdzeeXS/0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 362E8C1F17;
        Tue,  9 Jun 2020 16:22:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7C067C1F15;
        Tue,  9 Jun 2020 16:22:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1] builtin/checkout.c: replace bit-shift values for macros in call to check_stages
References: <20200607054849.1014185-1-eantoranz@gmail.com>
Date:   Tue, 09 Jun 2020 13:22:22 -0700
Message-ID: <xmqqwo4ggfb5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE1DEFCA-AA8E-11EA-A7E6-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

> Currently a call to check_stages is using bit-shift values to
> define what will be used as the first argument. If the reader
> doesn't know what the values are from heart, they have to go dig
> in cache.h what each value is.
>
> This patch is replacing those values for the macros from cache.h so that it's
> clear at first sight what they are (CE_ENTRY_REMOVED, CE_ENTRY_ADDED)

The patch does not make sense.  The hardcoded numbers you touched
have nothing to do with these macros.

The first argument to check_stages() is a bitmask for the stage
numbers in the index (which can span from 1 to 3), where 1 means
"common ancestor", 2 means "ours" and 3 means "theirs".  The caller
gives a position 'pos' in the in-core index and asks the function
this question: "starting at position 'pos', there must be cache
entries with the same path as 'ce'---are these enries cover all the
stages specified by this mask?"  This particular caller wants to
make sure that there are both "ours" and "theirs" entries for the
path.

The thing is, CE_ENTRY_REMOVED may also happen to have the value of
4, but that has nothing to do with (1<<2) used in the argument of
this.  It was not chosen to be the value of 1 shifted by the stage
number for "ours".  Same thing for CE_ENTRY_ADDED and (1<<3).  Even
when these macros are renumbered, the argument to check_stages()
must stay the values they are written in the original code
(i.e. (1<<2)|(1<<3) == 12).

> Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
> ---
>  builtin/checkout.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index ffa776c6e1..3a644b31f6 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -397,7 +397,7 @@ static int checkout_paths(const struct checkout_opts *opts,
>  			} else if (opts->writeout_stage) {
>  				errs |= check_stage(opts->writeout_stage, ce, pos, opts->overlay_mode);
>  			} else if (opts->merge) {
> -				errs |= check_stages((1<<2) | (1<<3), ce, pos);
> +				errs |= check_stages(CE_ENTRY_REMOVED | CE_ENTRY_ADDED, ce, pos);
>  			} else {
>  				errs = 1;
>  				error(_("path '%s' is unmerged"), ce->name);
