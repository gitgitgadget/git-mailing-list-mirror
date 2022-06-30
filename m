Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846E5C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 15:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbiF3PlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 11:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiF3Pk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 11:40:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F22836152
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 08:40:58 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4B2AB1A6906;
        Thu, 30 Jun 2022 11:40:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PEPIY7ufXQk6
        fuPXGSnHlmEureTDYKlgjoLAyjwSE2I=; b=iW0/W89zsqXhHtWKqKPi2DF9koc1
        PYlFGoUXTetTGdtkAOgcV4/YjNPyrALLVJ31/SO0AjN9FJb5FNa81fFpqc8OYfPd
        sE/RYlvIwDtjLGt9k9O56eQ3eOff267DV+ta0cNx1GEuRJyf3G8X5TW5xFRybnOf
        ynbnMxQd6BkPJO0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 428371A6905;
        Thu, 30 Jun 2022 11:40:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C66481A6904;
        Thu, 30 Jun 2022 11:40:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Han Xin <hanxin.hx@bytedance.com>, chiyutianyi@gmail.com,
        derrickstolee@github.com, git@vger.kernel.org,
        haiyangtand@gmail.com, jonathantanmy@google.com, me@ttaylorr.com,
        ps@pks.im
Subject: Re: [PATCH v3 2/2] commit-graph.c: no lazy fetch in
 lookup_commit_in_graph()
References: <cover.1656044659.git.hanxin.hx@bytedance.com>
        <cover.1656381667.git.hanxin.hx@bytedance.com>
        <3cdb1abd43779844b8e8dc094e2fd2da1adc461a.1656381667.git.hanxin.hx@bytedance.com>
        <220628.865yklgr6g.gmgdl@evledraar.gmail.com>
        <xmqq35folmgf.fsf@gitster.g>
        <5n35o008-pso2-6440-424p-q387q9n4so41@tzk.qr>
        <220630.86v8siclh5.gmgdl@evledraar.gmail.com>
Date:   Thu, 30 Jun 2022 08:40:52 -0700
In-Reply-To: <220630.86v8siclh5.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 30 Jun 2022 15:43:48 +0200")
Message-ID: <xmqq5ykignwb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 06B49AF6-F88B-11EC-8A53-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Jun 30 2022, Johannes Schindelin wrote:
>
>> Hi Junio,
>>
>> On Tue, 28 Jun 2022, Junio C Hamano wrote:
>>
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>>
>>> >> +test_expect_success 'setup: prepare a repository with commit-grap=
h contains the commit' '
>>> >> +	git init with-commit-graph &&
>>> >> +	echo "$(pwd)/with-commit/.git/objects" \
>>> >> +		>with-commit-graph/.git/objects/info/alternates &&
>>> >
>>> > nit: you can use $PWD instead of $(pwd).
>>>
>>> We can, and it would not make any difference on non-Windows.
>>>
>>> But which one should we use to cater to Windows?  $(pwd) is a full
>>> path in Windows notation "C:\Program Files\Git\..." while $PWD is
>>> MSYS style "/C/Program Files/Git/..." or something like that, IIRC?
>>
>> Indeed, and since the `alternates` file is supposed to be read by
>> `git.exe`, a non-MSYS program, the original was good, and the nit
>> suggested the incorrect form.
>
> I looked at t5615-alternate-env.sh which does the equivalent of:
>
> 	GIT_ALTERNATE_OBJECT_DIRECTORIES=3D"$PWD/one.git/objects:$PWD/two.git/=
objects" \
>         	git cat-file [...]
>
> We run that test on all our platforms, does the $PWD form work in the
> environment variable, but not when we write it to the "alternates" file=
?
> Or is there some other subtlety there that I'm missing?

I am also curious to see a clear and concise explanation so that we
do not have to repeat this discussion later.  We have

 - When a test checks for an absolute path that a git command generated,
   construct the expected value using $(pwd) rather than $PWD,
   $TEST_DIRECTORY, or $TRASH_DIRECTORY. It makes a difference on
   Windows, where the shell (MSYS bash) mangles absolute path names.
   For details, see the commit message of 4114156ae9.

in t/README, but even with the log mesasge of 4114156a (Tests on
Windows: $(pwd) must return Windows-style paths, 2009-03-13) [*1*],
I have no idea what makes the thing you found in t5615 work and your
suggestion to use $PWD in the new one not work.

GIT_ALTERNATE_OBJECT_DIRECTORIES is a PATH_SEP (not necessarily a
colon) separated list, and I think the way t5615 uses it is broken
on Windows where PATH_SEP is defined as semicolon without the $PWD
vs $(pwd) issue.  Is the test checking the right thing?


[Footnote]

*1*

    Tests on Windows: $(pwd) must return Windows-style paths

    Many tests pass $(pwd) in some form to git and later test that the ou=
tput
    of git contains the correct value of $(pwd). For example, the test of
    'git remote show' sets up a remote that contains $(pwd) and then the
    expected result must contain $(pwd).

    Again, MSYS-bash's path mangling kicks in: Plain $(pwd) uses the MSYS=
 style
    absolute path /c/path/to/git. The test case would write this name int=
o
    the 'expect' file. But when git is invoked, MSYS-bash converts this n=
ame to
    the Windows style path c:/path/to/git, and git would produce this for=
m in
    the result; the test would fail.

    We fix this by passing -W to bash's pwd that produces the Windows-sty=
le
    path.

    There are a two cases that need an accompanying change:

    - In t1504 the value of $(pwd) becomes part of a path list. In this c=
ase,
      the lone 'c' in something like /foo:c:/path/to/git:/bar inhibits
      MSYS-bashes path mangling; IOW in this case we want the /c/path/to/=
git
      form to allow path mangling. We use $PWD instead of $(pwd), which a=
lways
      has the latter form.

    - In t6200, $(pwd) - the Windows style path - must be used to constru=
ct the
      expected result because that is the path form that git sees. (The c=
hange
      in the test itself is just for consistency: 'git fetch' always sees=
 the
      Windows-style path, with or without the change.)

    Signed-off-by: Johannes Sixt <j6t@kdbg.org>

