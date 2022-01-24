Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB3DC433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 21:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378911AbiAXVrZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 16:47:25 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65498 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376733AbiAXVTO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 16:19:14 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A3C6411C879;
        Mon, 24 Jan 2022 16:19:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tqO2udFvla7Wsy5C1IrjbJp8+wOto43n5fx99A
        E5Ir4=; b=yYveEW2WbaSnsqiZifQ7wokBTmUtRs8BPKsrCKQ1K2NUm2w3LfGAHK
        uYAkBThznvnVIV/No4iMRqamX45zOwALwP4uyrQcjLOUJjO7aa7DKvogcuHNf/tu
        MuOy0Qut8XdL9jpIGNuC0nfNRxFqxYJQVt9/ZmHXoHbDVVDzVlpj8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A99311C878;
        Mon, 24 Jan 2022 16:19:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D214911C877;
        Mon, 24 Jan 2022 16:19:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Herrmann <michael@herrmann.io>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: A puzzle: reset --hard and hard links
References: <CABrKpmDseZkPCpRb8KmBJaxDp24sySJay5ffZrxqgSMGKyj5qQ@mail.gmail.com>
        <YeiOoAcM7TMK2pgz@camp.crustytoothpaste.net>
        <xmqqilufl5cv.fsf@gitster.g>
        <CABrKpmCt3zKONLp5ZjV1PxLyfM-koc=tKopKUUpx4nF2n_eo_w@mail.gmail.com>
        <YengSfSDzVzvrJ6f@camp.crustytoothpaste.net>
        <CABrKpmASHgBwPYgKnO2ZZRVVxMti=NFaxw6cBV=pst0xpVZYGA@mail.gmail.com>
        <CABrKpmBFrrWgBh7QAOX35zQr_e+LC1E6Jn5FKb_XP-7bew9Hkg@mail.gmail.com>
        <xmqqk0ep57ou.fsf@gitster.g>
        <CABrKpmB7UEGzLCiNHQtY5-Dt16jLkpcpBEx3o8y9OBGZ418keA@mail.gmail.com>
Date:   Mon, 24 Jan 2022 13:19:07 -0800
In-Reply-To: <CABrKpmB7UEGzLCiNHQtY5-Dt16jLkpcpBEx3o8y9OBGZ418keA@mail.gmail.com>
        (Michael Herrmann's message of "Mon, 24 Jan 2022 15:16:43 -0300")
Message-ID: <xmqqfspc3k8k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 44A513BE-7D5B-11EC-89D3-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Herrmann <michael@herrmann.io> writes:

>> It is merely because you helped Git to realize
>
> I don't want to "help Git realize". I'm sorry but in my opinion `git
> status` should not have any effects on other commands. I don't
> understand how you can argue that calling `git status` is a valid fix
> to "help Git".
>
>> With another step 1.5 "append a line to the file in question", git
>> should severe the link,
>
> I don't want to sever the hard link. I want to avoid that it gets severed.

Sorry, if that is the case, what you want is not a version control,
and it is certainly not Git.  You want something else.

Think about this scenario.

    $ rm -fr one && git init one && cd one
    $ echo 0 >a; echo 0 >b; git add a b; git commit -m zero

We have two files, a and b, each of which has "0" in it.

    $ echo 1 >b; git add b; git commit -m one

Now they have "0" and "1" respectively.

    $ echo 2 >a; echo 2 >b; git commit -a -m two
    $ ln -f a b
    $ git diff
    $ git diff HEAD

Now they have "2".  Since they have identical contents, "diff" would
report no difference relative to the index or HEAD, even after we
manually break the working tree by making one of them a hardlink to
the other.

Now, what should this command do?

    $ git reset --hard HEAD^

What the user is asking is (1) to move the branch to point at the
previous commit, which had 0 and 1 in a and b respectively, and (2)
to make sure that the index and the working tree contents match what
is recorded in the commit.

So for Git to be a usefully correct version control system, it is
essential to make sure what it writes out would not affect any path
other than the one it is writing out.  When it writes "0" to "a", it
MUST break the hardlink from elsewhere that points at "a" before it
does so.  Otherwise, the "0" it writes into "a" will also be seen
elsewhere, which is not what the updated HEAD (i.e. commit "one")
wants to see.  The same for "b" when it is updated from "2" to "1"
when this happens.

