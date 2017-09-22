Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E806B20281
	for <e@80x24.org>; Fri, 22 Sep 2017 06:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751860AbdIVGgG (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 02:36:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51628 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751637AbdIVGgD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 02:36:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E4C0A9458;
        Fri, 22 Sep 2017 02:36:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=aZ8y06vDeXrF
        yvuhjb+RzSbB/ys=; b=C2UaKTv7AEHt8NFcZbjXCbBGvo4P2y5HcNuVVcOBkCML
        W0hhwrV6VcnKJghBg7Gu5HlRJFaBak8xVt032mwzdc5qalvNb7+jrP2nV2XG12bj
        s9JkFtEE+82Ir1AvIr5vAddUwct6Inx8c/H3jztTeLVG41Jev3qeedFFVGM1pqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=GvJ3KG
        HOLS3RhycnK8TgXRzzdQVFMwmxG13SgaYlBocs7yiRwPaqzc8kdjh8k8EGTfPYR7
        YEtOZeQNj6m8bN7ZSNm8QtHjxOdk2p9LnyKUhpqlft6ZlV5tKV6nmevvEX2lBHKE
        ieTiEypm9O0XjjvMNrZQENhamtAGq9SOpkreA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 55C87A9456;
        Fri, 22 Sep 2017 02:36:02 -0400 (EDT)
Received: from [192.168.1.4] (unknown [76.215.41.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F2006A9451;
        Fri, 22 Sep 2017 02:35:59 -0400 (EDT)
Subject: Re: [PATCH] git: add --no-optional-locks option
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
References: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net>
From:   Daniel Santos <daniel.santos@pobox.com>
Message-ID: <c474bf47-5049-1425-d03c-2417eb53549e@pobox.com>
Date:   Fri, 22 Sep 2017 01:42:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Pobox-Relay-ID: 4C30B7CE-9F60-11E7-90A2-FE4B1A68708C-06139138!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/20/2017 11:32 PM, Jeff King wrote:
> Johannes, this is an adaptation of your 67e5ce7f63 (status: offer *not*
> to lock the index and update it, 2016-08-12). Folks working on GitHub
> Desktop complained to me that it's only available on Windows. :)
>
> I expanded the scope a bit to let us give the same treatment to more
> commands in the long run.  I'd also be OK with just cherry-picking your
> patch to non-Windows Git if you don't find my reasoning below
> compelling. But I think we need _something_ like this, as the other
> solutions I could come up with don't seem very promising.
>
> -Peff
>
> -- >8 --
> Some tools like IDEs or fancy editors may periodically run
> commands like "git status" in the background to keep track
> of the state of the repository. Some of these commands may
> refresh the index and write out the result in an
> opportunistic way: if they can get the index lock, then they
> update the on-disk index with any updates they find. And if
> not, then their in-core refresh is lost and just has to be
> recomputed by the next caller.
>
> But taking the index lock may conflict with other operations
> in the repository. Especially ones that the user is doing
> themselves, which _aren't_ opportunistic. In other words,
> "git status" knows how to back off when somebody else is
> holding the lock, but other commands don't know that status
> would be happy to drop the lock if somebody else wanted it.

Interestingly, this usually slaps me when performing an _interactive_
rebase.=C2=A0 It occurred to me that if I'm performing an interaction
operation, it doesn't seem unreasonable for git wait up to 125ms or so
for the lock and then prompting the user to ask if they want to continue
waiting for the lock.

> There are a couple possible solutions:
>
>   1. Have some kind of "pseudo-lock" that allows other
>      commands to tell status that they want the lock.
>
>      This is likely to be complicated and error-prone to
>      implement (and maybe even impossible with just
>      dotlocks to work from, as it requires some
>      inter-process communication).
>
>   2. Avoid background runs of commands like "git status"
>      that want to do opportunistic updates, preferring
>      instead plumbing like diff-files, etc.
>
>      This is awkward for a couple of reasons. One is that
>      "status --porcelain" reports a lot more about the
>      repository state than is available from individual
>      plumbing commands. And two is that we actually _do_
>      want to see the refreshed index. We just don't want to
>      take a lock or write out the result. Whereas commands
>      like diff-files expect us to refresh the index
>      separately and write it to disk so that they can depend
>      on the result. But that write is exactly what we're
>      trying to avoid.
>
>   3. Ask "status" not to lock or write the index.
>
>      This is easy to implement. The big downside is that any
>      work done in refreshing the index for such a call is
>      lost when the process exits. So a background process
>      may end up re-hashing a changed file multiple times
>      until the user runs a command that does an index
>      refresh themselves.

That is not necessarily the case.=C2=A0 I don't actually know git on the
inside, but I would ask you to consider a read-write lock and a hybrid
of one and three.

I don't know what dotlocks are, but I'm certain that you can implement a
rw lock using lock files and no other IPC, although it does increase the
complexity.=C2=A0 The way this works is that `git status' acquires a read
lock and does its thing.=C2=A0 If it has real changes, instead of discard=
ing
them it attempts to upgrade to a write lock.=C2=A0 If that fails, you thr=
ow
it away, otherwise you write them and release.

In order to implement rw locks with only lock files, "off the cuff" I
say you have a single "lock list" file that should never be deleted and
a "lock lock" file that is held in order to read or modify the list.=C2=A0
The format of the lock list would have a pair of 32-bit wrapping
modification counts (or versions) at the top -- one for modifications to
the lock list its self and another for modifications to the underlying
data (i.e., the number of times a write lock has been acquired).=C2=A0 Th=
is
header is followed by entries something like this:

<operation> <pid> <version> <timestamp>

<operation>=C2=A0 'r' if waiting for a read lock
             'R' if actively reading
             'w' if waiting for write lock
             'W' if actively writing
<pid>        The pid
<version>    If active, the version of the data at the time lock acquired=
 or zero.
<timestamp>  Time began waiting or time lock acquired


An operation of 'r' or 'w' means that you are waiting and upper case
means that you are active.=C2=A0 <version> is the version of the data at =
the
time the lock became active and writers increment it when they acquire a
lock.=C2=A0 You wait with file alteration notification on the lock list (=
if
there is any doubt based upon timestamp precision then you can examine
the lock list version).=C2=A0 When you want to read or write, you lock th=
e
lock-lock (this sounds like a joke... "Lock, lock.", "Who's there?",
"Reader.", "Reader who?"....) and examine the lock list.=C2=A0 If it's em=
pty,
you add yourself as an active reader or writer with an upper case 'R' or
'W' and release the lock-lock.=C2=A0 If there are only readers, and you w=
ant
to read, you add yourself as an active reader.=C2=A0 The version of the l=
ock
list is incremented every time it is modified.

Read-write locks need to be given a priority policy of either readers,
writers, fifo or don't-care.=C2=A0 In this case that should probably be
writers.=C2=A0 So if you want to read and there is an active or waiting
writer, the prospective reader would either add themselves with an 'r'
or fail if they don't want to wait.=C2=A0 If a process wants to write and
there are active readers or writers, it adds its self to the list or
fails as well.=C2=A0 When all active readers have exited, then which ever
prospective writers gets the lock-lock first can make themselves the
active writer.=C2=A0 When a process acquires a write lock, it increases t=
he
data version number.=C2=A0 If a reader lock tries to upgrade to a writer =
lock
but the data version changed than it fails.

Is there not already a library somewhere that does this?=C2=A0 Either way=
,
your current effort seems like a step in the right direction -- and
thanks for that!

Daniel

