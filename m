Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5BFC2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 18:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D462467E
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 18:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vvYN0AMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgA0Sru (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 13:47:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50322 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgA0Sru (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 13:47:50 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 31D3F3A65A;
        Mon, 27 Jan 2020 13:47:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bt9UvGqHEaB9U3Z437+nrvoFHsw=; b=vvYN0A
        MTynAHZrXEfFgSK7YGBCwCemgl/HVG8JhNCiW2J4smFTkxAP2KasePqlRm0kG2tY
        s4/Jq6zU0r0X6VsQrnvAnU9vBOHJ5JiOUal4VbkWvuYc8T/lS+7PGW+83nMtGWjp
        c66kPuHzFp/BFgIDmnpB88r+72pTk/4DVdEy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hj0FpW9ytiIcy6f6hzWUitHYPzZYfW2T
        52T6WP/SQH9pesbDrYZH9aDYTx3ugDBLamfAbw44TsRBoIpmf61+omhQ686mI01E
        XAYQRzpr/fyfOY+Edwgd9ibgKpVlLSumfXHBKV/HTIqAkyJHazGtANN9eCc/D6eT
        DtfUuZN/DjY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 291863A658;
        Mon, 27 Jan 2020 13:47:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 87C1E3A657;
        Mon, 27 Jan 2020 13:47:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     David =?utf-8?Q?Burstr=C3=B6m?= <davidburstrom@spotify.com>,
        git@vger.kernel.org
Subject: Re: Bug or unexpected behaviour in git show <rev>:a\b
References: <CAA-mk2_jB2X1J-NCXQ92spa-fmEct9G9f1iQo7t8=rvD5coFDA@mail.gmail.com>
        <20200124190119.GB1672342@coredump.intra.peff.net>
        <xmqqk15gzmc8.fsf@gitster-ct.c.googlers.com>
        <20200125000051.GA566074@coredump.intra.peff.net>
Date:   Mon, 27 Jan 2020 10:47:46 -0800
In-Reply-To: <20200125000051.GA566074@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 24 Jan 2020 19:00:51 -0500")
Message-ID: <xmqqmua8bust.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83091ABA-4135-11EA-B604-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Subject: verify_filename(): handle backslashes in "wildcards are pathspecs" rule
>
> Commit 28fcc0b71a (pathspec: avoid the need of "--" when wildcard is
> used, 2015-05-02) allowed:
>
>   git rev-parse '*.c'
>
> without the double-dash. But the rule it uses to check for wildcards
> actually looks for any glob special. This is overly liberal, as it means
> that a pattern that doesn't actually do any wildcard matching, like
> "a\b", will be considered a pathspec.
>
> If you do have such a file on disk, that's presumably what you wanted.
> But if you don't, the results are confusing: rather than say "there's no
> such path a\b", we'll quietly accept it as a pathspec which very likely
> matches nothing (or at least not what you intended). Likewise, looking
> for path "a\*b" doesn't expand the search at all; it would only find a
> single entry, "a*b".
>
> This commit switches the rule to trigger only when glob metacharacters
> would expand the search, meaning both of those cases will now report an
> error (you can still disambiguate using "--", of course; we're just
> tightening the DWIM heuristic).

Makes sense.  Thanks.
