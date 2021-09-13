Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B17C433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 06:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FCD760FE6
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 06:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237438AbhIMGmy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 02:42:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57185 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237364AbhIMGmx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 02:42:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ED01FF7FF1;
        Mon, 13 Sep 2021 02:41:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=w3wpf4nFRRRE
        Yf5pDOmk0Uu+XJwnsDaJIR8ADtsSPg4=; b=ILRf/kMMWhR2GGrPsA6YP2S0Irem
        LenBA/CKB+f5etn6i36/bjyKBylcM0C3YSjkA/xNJbZKUXWs9q7mQUroOlRtqgV5
        h7FqobC4JTkQzDa/QZB0vPik3sywY/awAPcEdS/tC79KfQBDN/ogXxXAFqPcEbhW
        GvfIvWF51/hr9J0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4F36F7FEF;
        Mon, 13 Sep 2021 02:41:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4F500F7FEE;
        Mon, 13 Sep 2021 02:41:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 4/4] parse-options: properly align continued usage
 output
References: <cover-v3-0.6-00000000000-20210911T190239Z-avarab@gmail.com>
        <cover-v4-0.4-00000000000-20210912T235347Z-avarab@gmail.com>
        <patch-v4-4.4-55480dee680-20210912T235347Z-avarab@gmail.com>
Date:   Sun, 12 Sep 2021 23:41:36 -0700
In-Reply-To: <patch-v4-4.4-55480dee680-20210912T235347Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 13 Sep
 2021 02:13:22
        +0200")
Message-ID: <xmqq8s01geov.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A4F10884-145D-11EC-B375-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Some commands such as "git stash" emit continued options output with
> e.g. "git stash -h", because usage_with_options_internal() prefixes
> with its own whitespace the resulting output wasn't properly
> aligned. Let's account for the added whitespace, which properly aligns
> the output.
>
> The "git stash" command has usage output with a N_() translation that
> legitimately stretches across multiple lines;
>
> 	N_("git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n=
"
> 	   "          [-u|--include-untracked] [-a|--all] [-m|--message <messa=
ge>]\n"
>            [...]
>
> We'd like to have that output aligned with the length of the initial
> "git stash " output, but since usage_with_options_internal() adds its
> own whitespace prefixing we fell short, before this change we'd emit:
>
>     $ git stash -h
>     usage: git stash list [<options>]
>        or: git stash show [<options>] [<stash>]
>        [...]
>        or: git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--qu=
iet]
>               [-u|--include-untracked] [-a|--all] [-m|--message <messag=
e>]
>               [...]
>
> Now we'll properly emit aligned output.  I.e. the last four lines
> above will instead be (a whitespace-only change to the above):
>
>        [...]
>        or: git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--qu=
iet]
>                      [-u|--include-untracked] [-a|--all] [-m|--message =
<message>]
>                      [...]
>
> We could also go for an approach where we have the caller support no
> padding of their own, i.e. (same as the first example, except for the
> padding on the second line):
>
> 	N_("git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n=
"
> 	   "[-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
>            [...]
>
> But to do that we'll need to find the length of "git stash". We can
> discover that from the "cmd" in the "struct cmd_struct", but there
> might cases with sub-commands or "git" itself taking arguments that

A "be" is missing here.

> would make that non-trivial.
>
> Even if it was I still think this approach is better, because this way

"was" -> "were,", I think.

Even though this step has quite a lot of comment strings meant for
human consumption, I didn't hunt for grammos and typos and only
looked at the code.  Somebody else may want to proof-read it.

The new code looked OK.  Do we want to have some new test in
t/helper/test-*.c with fixed "command help string"?

Thanks.
