Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A5FC43464
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 01:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D170B20E65
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 01:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PfWO/Uzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgITBqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 21:46:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51914 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgITBqn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 21:46:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EDF97487C;
        Sat, 19 Sep 2020 21:46:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=m8Qh1ZXvTNz51rfhxeQE2rpZMEQ=; b=PfWO/UzoXamm+NlTckFv
        kTxrAaDlRLFRVLcQMrHTj4YPwB1MWJ/seCBcFrBqahFx41xEWa0J60pGOUa8TdIF
        aGHJDEnAGkIsYOIReyYZbEZLouF1RxfRX5dkcQ/wzfguQyjkNlNZFT5tQT8HtkZ7
        18DbyHU0qhS0SfbirajhEgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=Ovtm8x2jeXY5GFIODeq/wZP3Nab5hnJtqngQqvSJc6B9zF
        DdZDski783Q9+RjqyvKrPQ5xUF19+K3HSA5bozlwnPqUrekJm4WHQjy5T2Jh7HiF
        PfNSM6HyPrL3EcyPjDLYdDGDlcI819d93C/jnS4Wwy4fUtc0xGVTSQ8j1H/CY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 67E9174879;
        Sat, 19 Sep 2020 21:46:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D69DF74878;
        Sat, 19 Sep 2020 21:46:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Aaron Schrab <aaron@schrab.com>
Cc:     Ash Holland <ash@sorrel.sh>, git@vger.kernel.org
Subject: Re: `git describe --dirty` doesn't consider untracked files to be
 dirty
References: <CAHJUbDg2KA9Xo_CAO=cgrZewOH0zfEhOVydhMN8fLvVDmji4sQ@mail.gmail.com>
        <xmqqh7s8z0qw.fsf@gitster.c.googlers.com>
        <20200908231652.GC1014@pug.qqx.org>
        <xmqqo8m1k542.fsf@gitster.c.googlers.com>
Date:   Sat, 19 Sep 2020 18:46:40 -0700
Message-ID: <xmqq5z89i5j3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 21275524-FAE3-11EA-9CAA-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Aaron Schrab <aaron@schrab.com> writes:
>
>> It's perhaps worth noting that submodules are already considered dirty
>> when untracked files are added:
>>
>> $ git diff vim/bundle/fugitive
>>
>> $ echo foo >vim/bundle/fugitive/foo
>>
>> $ git diff vim/bundle/fugitive
>> diff --git i/vim/bundle/fugitive w/vim/bundle/fugitive
>> --- i/vim/bundle/fugitive
>> +++ w/vim/bundle/fugitive
>> @@ -1 +1 @@
>> -Subproject commit caf3b1d5696e8d39a905e48f1e89d8c0c565168c
>> +Subproject commit caf3b1d5696e8d39a905e48f1e89d8c0c565168c-dirty
>
> In other words, if we do this in the state:
>
>   $ git -C vim/bundle/fugitive describe --dirty
>
> the submodule directory is not reported as dirty.
>
> This is worth fixing.  I am leaning towards saying that `diff` is
> wrong in this case, but I am OK to consider unifying the behaviour
> the other way and making `describe --dirty` more strict.

"git diff" family of commands know the "--ignore-submodules=<what>"
option, and it seems that by default they do not ignore "untracked".

This seems to be what causes its output fail to pretend as if output
from "git describe --dirty" in the submodule directory were used on
the working-tree side of the comparison and leads to this
inconsistency.  Obviously we can tweak the default of "diff" family
of commands to ignore untracked paths in submodules and that would
make them consistent with "git describe --dirty", but that would not
give us a new way to tweak behaviour of "git describe" like we can
do with "git diff --ignore-submodules=<what>".

The current "untracked files do not count as part of dirtiness"
default behaviour of "git describe --dirty" is relied upon by
people's existing scripts, and changing it from under them would
cause unnecessary breakage.  But that does not have to stop us from
teaching "git describe --dirty" an optional "--ignore=<what>"
option, similar to what "diff --ignore-submodules=<what>" option
does to the submodules.

The first step would be to allow those who want their "git describe
--dirty --ignore=none" (untracked files are counted as dirtiness, to
be consistent with how "git diff" sees submodule directories by
default) to use presence of untracked files as dirty.  This is a
safe first step and can be done without breaking any existing users.

After that materializes and users gain experience, we may want to
discuss if we want to change the default behaviour of "git describe
--dirty" or what value the future default should be, how bad the
compatibility breakage would be if we change the default, and what
the transition plan and schedule looks like.  But we do not have to
do such a longer-term planning before the first step happens.



