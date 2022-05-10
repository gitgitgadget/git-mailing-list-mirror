Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD21C433F5
	for <git@archiver.kernel.org>; Tue, 10 May 2022 00:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiEJA1U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 20:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbiEJA1P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 20:27:15 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D8029C89
        for <git@vger.kernel.org>; Mon,  9 May 2022 17:23:18 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28545136C04;
        Mon,  9 May 2022 20:23:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y5GJ/wMXRZBWrB9oIC4RxnnXoaRGpDQndOOKum
        WL5Ho=; b=Tcl9fXN9SfD+ix10XxRgrVAB1As1SUzE3LztWPbBVHOCYoAUTjSYIP
        nAz5B6ckHWi/S2nI4gqSMIfwafagQlHoouMPZgss36Yuwh87V5TXOLtpa4L4nrOb
        qjjWskYw5/D/1isvJOtW6+Pmg4B/nw4f/IlL8Yuzxud0P55OOUncE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1ECB1136C03;
        Mon,  9 May 2022 20:23:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7CB85136C02;
        Mon,  9 May 2022 20:23:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] [RFC] setup.c: make bare repo discovery optional
References: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com>
        <YnmKwLoQCorBnMe2@nand.local> <xmqq8rrab9m7.fsf@gitster.g>
        <YnmqgdJUaKCYOT4J@nand.local>
Date:   Mon, 09 May 2022 17:23:15 -0700
In-Reply-To: <YnmqgdJUaKCYOT4J@nand.local> (Taylor Blau's message of "Mon, 9
        May 2022 19:57:53 -0400")
Message-ID: <xmqqbkw69qx8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62EE6D90-CFF7-11EC-89ED-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> > My concern is that if we ever flipped the default (i.e. that
>> > "safe.bareRepository" might someday be ""), that many legitimate cases
>> > of using bare repositories would be broken. I think there are many such
>> > legitimate use cases that _do_ rely on discovering bare repositories
>> > (i.e., Git invocations that do not have a `--git-dir` in their
>> > command-line).
>>
>> I think 99% of such use is to chdir into the directory with HEAD,
>> refs/ and objects/ in it and let git recognise the cwd is a git
>> directory.  Am I mistaken, or are there tools that chdir into
>> objects/08/ and rely on setup_git_directory_gently_1() to find the
>> parent directory of that 'objects' directory to be a git directory?
>
> If you took this change, and then at some point in the future we changed
> the default value of safe.bareRepository to "", wouldn't that break that
> 99% of use cases you are talking about?

Our spawning (e.g. "fetch" run_command()s "upload-pack" in a local
repository, or "fetch" runs "upload-pack" over ssh connection, or
http gateway runs "upload-pack" after learning which repository the
request is fetching from) of subcommands can and should be fixed by
exporting "GIT_DIR=." when we spawn them in the target directory,
and such a fix should be more or less trivial.  It must happen
before such a switch of default happens (if it is what we plan to
do, that is).  Also, the trivial fix must be conveyed to third-party
tool authors and give them time to adjust their ware.

That's part of the usual migration process, and I am not so worried
about it.

If some third-party tool for whatever reason wants to start from a
random subdirectory in a bare repository, that is a different story.
Fixing such a third-party tool would be more involved than "more or
less trivial".

> When I read your "I think 99% of such use is ...", it makes me think
> that this change won't disrupt bare repo discovery when we only traverse
> one layer above $CWD. But this change disrupts the case where we don't
> need to traverse at all to do discovery (i.e., when $CWD is the root of
> a bare repository).

By "this change" you mean what Glen proposes?  I think it was
designed to break the use case where you go there to signal that you
want to use the directory as a repository.

>> I am wondering if another knob to help that particular use case
>> easier may be sufficient.  If you are a forge operator, you'd just
>> set a boolean configuration variable to say "it is sufficient to
>> chdir into a directory to use it a bare repository without exporting
>> the environment variable GIT_DIR=."

And such a boolean, without safe.bareRepository setting, should be
sufficient to cover that 99% of such use, because it disables that
deliberate refusal of treating CWD as a repository without
explicitly saying that is what you want with "GIT_DIR=.".  One thing
I wasn't sure about was if that 99% number is close to reality,
hence my question.

> Yes, GitHub would almost certainly set safe.bareRepository to "*"
> regardless of what Git's own default would be.

And with such a boolean, I am hoping that GitHub do not have to make
such a wildly open setting.  Only $CWD that is the top of a repository,
without allowing it to be any random subdirectory, would be allowed.

> I'm not sure I agree that end-users wouldn't want to touch this knob. If
> they have embedded bare repositories that they rely on as test fixtures,
> for example, wouldn't safe.bareRepository need to be tweaked?

But not in the "My $CWD is always fine" knob, whose only reason is
to simplify things without opening you up unnecessarily too widely
for hosting sites.
