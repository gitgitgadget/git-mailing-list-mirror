Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10D5C433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 21:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 595FA60238
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 21:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241834AbhCAV3x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 16:29:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61130 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238761AbhCAV1t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 16:27:49 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 20CA7ABD7D;
        Mon,  1 Mar 2021 16:26:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fgNH1PilQCN/
        n11asVEPx3p6eD4=; b=sHrf9KPLdHyXJjB1SI3IPRcv4Flw+ozIw/Nzyq9uvs2Z
        j2HvsAsjKzAu1b2LnL3iQmD8WoB+tlKnkW92V0B8KAPDxXXQbiZxeu6GjGPY6idj
        fYZJS1JRS5fRGvmW13u/2t2Zy3ovx8iaHCgqU2TNp4rMB0zMVoqEr4asAYY3rZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=R1wpzY
        Lx7ro5uRsmlqKewCEJF7ytbSHvT4jTt+yuBw5z+FcD0TYf1x1ixCpDP4CnEbAIdG
        hhQCzFLI6fEftA4VwPQ3PHaI64eLXnNBgKlcQ46ArKgyqcSE3cm0RKh9qMpaVhUs
        IhHCyY475qFEzXzwFISmwwxgOpyo1AMCnTPOI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 17A95ABD7C;
        Mon,  1 Mar 2021 16:26:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 92DD8ABD7B;
        Mon,  1 Mar 2021 16:26:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 02/10] describe tests: refactor away from glob matching
References: <20200223125102.6697-1-benno@bmevers.de>
        <20210228195414.21372-3-avarab@gmail.com>
Date:   Mon, 01 Mar 2021 13:26:37 -0800
In-Reply-To: <20210228195414.21372-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 28 Feb 2021 20:54:06 +0100")
Message-ID: <xmqq1rcypnua.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CECE19E4-7AD4-11EB-8075-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the glob matching via a "case" statement to a "test_cmp" after
> we've stripped out the hash-specific g<hash-abbrev>
> suffix. 5312ab11fbf (Add describe test., 2007-01-13).
>
> This means that we can use test_cmp to compare the output. I could
> omit the "-8" change of e.g. "A-*" to "A-8-gHASH", but I think it
> makes sense to test that here explicitly. It means you need to add new
> tests to the bottom of the file, but that's not a burden in this case.

I think the point in these tests are that they consider "which tip
the tested commit is the closest" is the only piece of information
that matter, and allows the numbers ("number of commits on top of")
to be redefined in the future without having to change the tests,
but I tend to agree that such a change should be accompanied by and
documented with changes to these tests.=20

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t6120-describe.sh | 78 ++++++++++++++++++++++-----------------------
>  1 file changed, 38 insertions(+), 40 deletions(-)
>
> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index 7bc2aaa46e..e4fd5d567f 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -21,12 +21,10 @@ check_describe () {
>  	shift
>  	describe_opts=3D"$@"

Just a style thing, when we are not invoking the "each positional
arg is double-quoted individually against being split at $IFS" magic,
we prefer to spell this as "$*".

>  	test_expect_success "describe $describe_opts" '
> +		git describe $describe_opts 2>err.actual >raw &&
> +		sed -e "s/-g[0-9a-f]*\$/-gHASH/" <raw >actual &&

The exact ones would be passed as-is (i.e. "test_cmp raw actual"
could pass), which is what we want anyway.

If we are planning to further extend this helper to make it more
capable, we might want to consider quoting $describe to be evaled
properly so that we can do an equivalent of

	check_describe A-8-gHASH --dirty=3D'.d i r t y' HEAD

when we gain new option that is more intresting than --dirty=3D<mark>
that legitimately would benefit from being able to pass arguments
with $IFS whitespace in them.

But that is outside the scope of this step.  I haven't seen the
overall topic yet, so it may or may not be within the scope of this
series.  We'll see.

> +		echo $expect >expect &&

Let's double-quote to relieve readers from having to wonder if you
are expecting the callers to feed crazy things like "a  b" and this
echo to normalize it to "a b".

> +		test_cmp expect actual
>  	'
>  }
