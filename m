Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BFCC433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 22:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbiCNWXB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 18:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbiCNWXB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 18:23:01 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F3412ABB
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 15:21:50 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DE5DE1898E6;
        Mon, 14 Mar 2022 18:21:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gYB8WKB0ZZKz3jfOOT8qPjeb+bDxqw3P1/fUL8
        U9zKQ=; b=Py0QuzRsP7qEPgT7b90y0rdpqQReDB/Yln9Fxgor+ev7QKCCGkwyQc
        /PTTfEKQyOzvqwULMyB9WY/gU9D4sOiBtblPyimy8tTpPVV8LEQDrdcqq9OX0wSi
        2QUwqlqXXoP46zqsLv8YVXYWcUXB11jCTtn7+QxH6EkS0BYEVf8wU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D7F521898E5;
        Mon, 14 Mar 2022 18:21:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 594EC1898E2;
        Mon, 14 Mar 2022 18:21:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH] partial-clone: add a partial-clone test case
References: <pull.1175.git.1647193162570.gitgitgadget@gmail.com>
        <xmqq4k41vdwe.fsf@gitster.g>
        <1a383ecf-b350-9085-890f-d4b225cfa48a@github.com>
Date:   Mon, 14 Mar 2022 22:21:46 +0000
In-Reply-To: <1a383ecf-b350-9085-890f-d4b225cfa48a@github.com> (Derrick
        Stolee's message of "Mon, 14 Mar 2022 12:24:41 -0400")
Message-ID: <xmqqa6dsnpj9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2320492E-A3E5-11EC-A36C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> When "test_subcommand_inexact git pack-objects" is run, the printf
>> assigns to $expr:
>> 
>> 		expr='"git".*"pack-objects".*'
>> 
>> and the actual grep command invoked becomes
>> 
>> 	grep '"event":"child_start".*\["git".*"pack-objects".*\]'
>> 
>> I am not sure if that is what we really want.
>
> Ah, yes this certainly seems to not be the expected plan. It does
> allow for more flexibility than intended: the intention was to
> add flexibility at the end of the command, but instead adds
> flexibility throughout, only caring that a certain list of options
> is present as a subsequence (except that the first item is the
> first item, namely "git" in most cases).

I guess I sent a response before reading this message from you.

> That unintended flexibility would allow the current needs to use
>
> 	test_subcommand_inexact ! git fetch
>
> as desired, but there is the additional worries about whether it
> is too flexible for the existing uses.

Yeah, it looked a bit too loose.

> If you think that we should fix the helper to work differently, then
> I can work on a patch to do so, so Abhradeep doesn't get too
> sidetracked on that.

I agree that comparing what _inexact does and what its inventor
wanted it to do and reconciling the differences would be outside
the scope of this topic, which means the test in this patch should
refrain from using the _inexact helper at all.

I found it quite a roundabout way to look into trace to see if
a "fetch" was run to determine if we are doing the right thing.

Regardless of whatever mechanism is used to lazily fetch objects
that have become necessary from the promisor remotes, what we want
to ensure is that the blob object HEAD:new-file.txt is still missing
in our object store after running "log --follow", isn't it?  In a
future version of "git", our on-demand lazy fetch mechanism may not
even invoke "git fetch" under the hood, after all.

Don't we have a more direct way to ask "does this object exist in
our object store, or is it merely left as a promise?" without
triggering a lazy fetching that we can use in this test?  I think
such a direct approach is what we want to use in this test.


