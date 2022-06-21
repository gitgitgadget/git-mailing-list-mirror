Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBABCC43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 15:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349766AbiFUPfl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 11:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiFUPfk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 11:35:40 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7B415A04
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 08:35:39 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 003FF132FE1;
        Tue, 21 Jun 2022 11:35:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=F2rrwU8fNu59
        xSbpWUhs/PxoKmwg6xsaaqnPEIVPIys=; b=HoujxSCC9CVgAOe3syi6JLScIyCo
        vCrje8EpmlITcM/LDxyctKRcHt2zegNhaVmGWqgJ8rWXVxb2d+qoghJVy5qzM7XX
        b0SmGJ+CQw+nfhQ8qMvejJF8BI9yy5ejcxo4dmiM4QgC4srnyg+1K54MDPvhuAdo
        uA1OhUZqYwHyDB0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA932132FDF;
        Tue, 21 Jun 2022 11:35:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4964B132FDE;
        Tue, 21 Jun 2022 11:35:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
Subject: Re: [PATCH 1/2] combine-diff: abort if --ignore-matching-lines is
 given
References: <a6a14213-bc82-d6fb-43dd-5a423c40a4f8@web.de>
        <patch-1.1-f7fd645468c-20220523T182954Z-avarab@gmail.com>
        <xmqqleusqaff.fsf@gitster.g>
        <220524.86leurw3my.gmgdl@evledraar.gmail.com>
        <xmqqmtf6hgae.fsf@gitster.g>
        <220524.86v8tuvfl1.gmgdl@evledraar.gmail.com>
        <49bcadd1-7dc2-d5ee-36a5-59456450aeca@web.de>
Date:   Tue, 21 Jun 2022 08:35:35 -0700
In-Reply-To: <49bcadd1-7dc2-d5ee-36a5-59456450aeca@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 18 Jun 2022 13:12:28 +0200")
Message-ID: <xmqqedzijago.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CBBCE652-F177-11EC-AA40-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> The code for combined diffs doesn't currently support ignoring changes
> that match a regex.  Abort and report that fact instead of running into
> a segfault.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  combine-diff.c | 4 ++++
>  1 file changed, 4 insertions(+)

Makes sense.

> diff --git a/combine-diff.c b/combine-diff.c
> index b724f02123..11df1d7f39 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -1498,6 +1498,10 @@ void diff_tree_combined(const struct object_id *=
oid,
>  	int i, num_paths, needsep, show_log_first, num_parent =3D parents->nr=
;
>  	int need_generic_pathscan;
>
> +	if (opt->ignore_regex_nr)
> +		die("combined diff and '%s' cannot be used together",
> +		    "--ignore-matching-lines");

"X cannot be used together _with_ Y" perhaps?

>  	/* nothing to do, if no parents */
>  	if (!num_parent)
>  		return;
> --
> 2.36.1
