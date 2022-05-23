Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE8FC433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbiEWUIh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiEWUIe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:08:34 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976D4980AF
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:08:23 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6220D121ED8;
        Mon, 23 May 2022 16:08:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=v0Y43C73NiUD
        jdHrk9nHB7MwGuFI37fJiSBP3f3Bh38=; b=fese9O1+BpWsS+4BZvITWPXal8Zn
        2vCl3OKS3t/DBVqcld/N8HpOCQ1lXp/VV41uAaS12O/AMlDZSYPNQBCfIUSGJYv5
        6qAdpXfE2womdCGQd61ym9x0CnKNMTm1PWd/Ads0NUB1nW1wytp9eC6udprlGG90
        +OWG3gTJ/sta4cI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59A18121ED7;
        Mon, 23 May 2022 16:08:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BC685121ED6;
        Mon, 23 May 2022 16:08:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
Subject: Re: [PATCH] diff: fix a segfault in >2 tree -I<regex> and
 --output=<file>
References: <a6a14213-bc82-d6fb-43dd-5a423c40a4f8@web.de>
        <patch-1.1-f7fd645468c-20220523T182954Z-avarab@gmail.com>
Date:   Mon, 23 May 2022 13:08:20 -0700
In-Reply-To: <patch-1.1-f7fd645468c-20220523T182954Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 23 May
 2022 20:31:28 +0200")
Message-ID: <xmqqleusqaff.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1856F616-DAD4-11EC-93ED-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix a regression in c45dc9cf30 (diff: plug memory leak from regcomp()
> on {log,diff} -I, 2021-02-11), as noted in [1] there was a logic error
> where we'd free the regex too soon.
>
> Now we'll ensure that diff_free() can be called repeatedly
> instead. We'd ultimately like to do away with the "no_free" confusion
> surrounding it, and to attempt to free() things only once, as outlined
> in [2]. But in the meantime this will fix the segfault.

Hmph, repeated calls to diff_free_file() now closes the file upon
the first call.  I would have expected that such a resource would be
released when all the references go away, i.e. upon the last call.
The same thing for the ignore-regex array.

Clearing the "options->close_file" bit, and using FREE_AND_NULL(),
would hide a breakage that could be caused by this change, doesn't
it, because any use-after-release will say "ah, no need to close the
file" and "oh, there is no regex".  The former is not so worrisome,
but the latter may be---we may no longer have regex because the
first call to diff_free_ignore_regex() has cleared it and the code
that wants to use the regex, if exists, would happily say "oh, there
is no regex", instead of exposing the use-after-release breakage to
a segfault.

> Thus we're here testing that -I<regex> is ignored in this case, and
> likewise for --output=3D<file>, but since this is what we were doing
> before c45dc9cf30 let's accept it for now.

It is true that the result of applying this patch is equivalent to
c45dc9cf (diff: plug memory leak from regcomp() on {log,diff} -I,
2021-02-11), but doesn't that merely point at the commit as the
source of behaviour breakage?  With ignore-regex leaking before that
commit, wouldn't we have been using ignore-regex with combined diff
machinery?

Sorry, but I am failing to convince myself that this is not sweep
the issue under the rug.

> 1. https://lore.kernel.org/git/a6a14213-bc82-d6fb-43dd-5a423c40a4f8@web=
.de/
> 2. https://lore.kernel.org/git/220520.86pmk81a9z.gmgdl@evledraar.gmail.=
com/
>
> Reported-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>
> On Sat, May 14 2022, Ren=C3=A9 Scharfe wrote:
>
>> Hi all,
>>
>> git diff segfaults when it's asked to produce a combined diff and igno=
re
>> certain lines with --ignore-matching-lines/-I, e.g.:
>>
>>    $ git diff -I DEF_VER v2.33.3 v2.33.3^@
>>    zsh: segmentation fault  ./git-diff -I DEF_VER v2.33.3 v2.33.3^@
>
>  diff.c                  |  9 ++++++---
>  t/t4013-diff-various.sh | 15 +++++++++++++++
>  2 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index e71cf758861..183c9f21305 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -6432,8 +6432,10 @@ static void diff_flush_patch_all_file_pairs(stru=
ct diff_options *o)
> =20
>  static void diff_free_file(struct diff_options *options)
>  {
> -	if (options->close_file)
> -		fclose(options->file);
> +	if (!options->close_file)
> +		return;
> +	options->close_file =3D 0;
> +	fclose(options->file);
>  }
> =20
>  static void diff_free_ignore_regex(struct diff_options *options)
> @@ -6444,7 +6446,8 @@ static void diff_free_ignore_regex(struct diff_op=
tions *options)
>  		regfree(options->ignore_regex[i]);
>  		free(options->ignore_regex[i]);
>  	}
> -	free(options->ignore_regex);
> +	options->ignore_regex_nr =3D 0;
> +	FREE_AND_NULL(options->ignore_regex);
>  }
> =20
>  void diff_free(struct diff_options *options)
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 056e922164d..b556d185f53 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -614,4 +614,19 @@ test_expect_success 'diff -I<regex>: detect malfor=
med regex' '
>  	test_i18ngrep "invalid regex given to -I: " error
>  '
> =20
> +test_expect_success 'diff -I<regex>: combined diff does not segfault' =
'
> +	revs=3D"HEAD~2 HEAD~ HEAD" &&
> +	git diff $revs >expect &&
> +	git diff -I . $revs >actual &&
> +	test_cmp expect actual

And indeed this casts such a broken behaviour in stone.

> +'
> +
> +test_expect_success 'diff --output=3D<file>: combined diff does not se=
gfault' '
> +	revs=3D"HEAD~2 HEAD~ HEAD" &&
> +	git diff --output=3Dexpect.file $revs >expect.out &&
> +	git diff $revs >actual &&
> +	test_cmp expect.out actual &&
> +	test_must_be_empty expect.file

So is this one.

> +'
> +
>  test_done

