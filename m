Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520B7C433E2
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 20:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16232207DF
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 20:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O/svwO6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgGTUZ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:25:56 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63649 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbgGTUZz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 16:25:55 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0838DE259C;
        Mon, 20 Jul 2020 16:25:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JC2SCcj1tqBq
        TQWbaU11cscB+74=; b=O/svwO6XsaBPtxpwjpRPPApXttqjKnXm5Y3WsBKT/ZUZ
        rZ1FkpH3TapDLjC9WjREXDBt77/kzMlJs+bvGh/7YL5TdiBFtjLeG12SF50nE+VX
        7ivStUxsKUR7L9nln9nBC6nDAX9X7PpmejTxS9XRSgZsL9he/3NWjjOhLCKLlyk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=IJ58rK
        pcK1a9ZJoAoWtDYt4tmRswFXc7941/SuffiGiFHyp79KLiDQrS8gdqumWdaxdO6n
        DcpygfE2wlmFdQ9GcYF2ag/66T78wpF7T8hsbMiJ+KQDiVDAi+PYCoh9sj6L5OL+
        Ked3ALH+89w0ef8EOn+xCoDsPHoDYYB+shBVI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F3966E259A;
        Mon, 20 Jul 2020 16:25:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4A4D6E2599;
        Mon, 20 Jul 2020 16:25:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Martin Melka <martin.melka@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] dir: check pathspecs before returning `path_excluded`
References: <CABPp-BH6xYb8a5hkV_68vbXhH4kApCxw0WG9oveXOk5zzU==1A@mail.gmail.com>
        <20200720184529.22449-1-martin.agren@gmail.com>
Date:   Mon, 20 Jul 2020 13:25:49 -0700
In-Reply-To: <20200720184529.22449-1-martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Mon, 20 Jul 2020 20:45:29 +0200")
Message-ID: <xmqqtuy27x2q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 34509F6C-CAC7-11EA-A867-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> In 95c11ecc73 ("Fix error-prone fill_directory() API; make it only
> return matches", 2020-04-01), we taught `fill_directory()`, or more
> specifically `treat_path()`, to check against any pathspecs so that we
> could simplify the callers.
>
> But in doing so, we added a slightly-to-early return for the "excluded"
> case. We end up not checking the pathspecs, meaning we return
> `path_excluded` when maybe we should return `path_none`. As a result,
> `git status --ignored -- pathspec` might show paths that don't actually
> match "pathspec".
>
> Move the "excluded" check down to after we've checked any pathspecs.
>
> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> Reviewed-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---

Makes sense.  Thanks.  Will queue.
