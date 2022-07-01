Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0B1C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 20:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiGAUrN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 16:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiGAUrM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 16:47:12 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A813AA5D
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 13:47:10 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B8D3F198869;
        Fri,  1 Jul 2022 16:47:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OuS75UtCB/ohr0xZcrQujiHIPf9J8QgkV/isg3
        ggoZs=; b=PByNpWd6KpMj+RKvBGlZ6ORCOLi0vPQVXOybFcoPnOeV1IK2pB9oA3
        cY3YgMgCOoLdP9SWLlhsOASFUIxpuxLK+EUbPgtPP0nhpDPz0c2RkpqIYhtSGTFj
        94xHjDuBcryOcAzFuiUcjsSTFyVw4v37uoyMz6P92T9vWsWvmJLms=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B0C39198868;
        Fri,  1 Jul 2022 16:47:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 24536198867;
        Fri,  1 Jul 2022 16:47:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
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
        <xmqq5ykignwb.fsf@gitster.g>
        <n3p471no-671q-2701-1r72-s0q02ns09053@tzk.qr>
Date:   Fri, 01 Jul 2022 13:47:04 -0700
In-Reply-To: <n3p471no-671q-2701-1r72-s0q02ns09053@tzk.qr> (Johannes
        Schindelin's message of "Fri, 1 Jul 2022 21:31:26 +0200 (CEST)")
Message-ID: <xmqq1qv48ss7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F7E2B3EC-F97E-11EC-9879-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Whenever you call a non-MSYS program from an MSYS program (and remember,
> an MSYS program is a program that uses the MSYS2 runtime that acts as a
> POSIX emulation layer), "magic" things are done. In our context,
> `bash.exe` is an MSYS program, and the non-MSYS program that is called is
> `git.exe`.
>
> So what are those "magic" things? The command-line arguments and the
> environment variables are auto-converted: everything that looks like a
> Unix-style path (or path list, like the `PATH` environment variable) is
> converted to a Windows-style path or path list (on Windows, the colon
> cannot be the separator in `PATH`, therefore the semicolon is used).
>
> And this is where it gets _really_ tricky to explain what is going on:
> what _does_ look like a Unix-style path? The exact rules are convoluted
> and hard to explain, but they work _most of the time_. For example,
> `/usr/bin:/hello` is converted to `C:\Program Files\Git\usr\bin;C:\Program
> Files\Git\hello` or something like that. But `kernel.org:/home/gitster` is
> not, because it looks more like an SSH path. Similarly, `C:/Program Files`
> is interpreted as a Windows-style path, even if it could technically be a
> Unix-style path list.
>
> Now, if you call `git.exe -C /blabla <command>`, it works, because
> `git.exe` is a non-MSYS program, therefore that `/blabla` is converted to
> a Windows-style path before executing `git.exe`. However, when you write a
> file via `echo /blabla >file`, that `echo` is either the Bash built-in, or
> it is an MSYS program, and no argument conversion takes place. If you
> _then_ ask `git.exe` to read and interpret the file as a path, it won't
> know what to do with that Unix-style path.
>
> You can substitute `$PWD` for `/blabla` in all of this, and it will hold
> true just the same.
>
> So what makes `pwd` special?
>
> Well, `pwd.exe` itself is an MSYS program, so it would still report a path
> that `git.exe` cannot understand. But in Git's test suite, we specifically
> override `pwd` to be a shell function that calls `pwd.exe -W`, which does
> output Windows-style paths.
>
> The thing that makes that `GIT_*=$PWD git ...` call work is that the
> environment is automagically converted because `git` is a non-MSYS
> program. The thing that makes `echo $PWD >.git/objects/info/alternates`
> not work is that `echo` _is_ an MSYS program (or Bash built-in, which is
> the same thing here, for all practical purposes), so it writes the path
> verbatim into that file, but then we expect `git.exe` to read this file
> and interpret it as a list of paths.

----- 8< --------- 8< --------- 8< --------- 8< --------- 8< -----

> Hopefully that clarifies the scenario a bit, even if it is far from a
> concise explanation (I did edit this mail multiple times for clarity and
> brevity, though, as I do with pretty much all of my mails).

Certainly it does help.  Thanks.

I wonder if it makes sense to keep a copy of the bulk of your
response in t/ somewhere, and refer to it from t/README, to help
fellow non-Windows developers to avoid breaking tests on Windows
without knowing.
