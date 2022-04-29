Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D790C4332F
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 20:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380492AbiD2UGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 16:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359680AbiD2UGT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 16:06:19 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EF3BCB4F
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 13:03:00 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E60BC11C138;
        Fri, 29 Apr 2022 16:02:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R6aHQmFXjEu0EN6fnzlB4pf8CBbq6m0S8tDrhx
        LotXg=; b=fymIe3CyabFC2P5Nu49kI/VJPBRWK1IG6kKWZ53PHnQzhQqTsVlb5i
        S+D+PUpK8seDZXx+TqbPCuB9/t43hxHVrn7XREJxkC97RxjWL2VNvffalOa39ZhW
        EGkPX5VIvH1OFYtQ5l96Epu++MnTatlIU6CUn/Ptrmvldc9apoX2k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DEA4611C135;
        Fri, 29 Apr 2022 16:02:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 504B711C133;
        Fri, 29 Apr 2022 16:02:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Benedek Kozma <cyberbeni@gmail.com>
Subject: Re: Bugreport - submodules are fetched twice in some cases
References: <CAN8jHOgwVF5g=jM_KYT0Oh+j+Lk3qvdyA4zNRbzf8e1Xp5WAUw@mail.gmail.com>
        <xmqqczgzdc1r.fsf@gitster.g>
        <kl6l4k2bpv61.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Fri, 29 Apr 2022 13:02:57 -0700
In-Reply-To: <kl6l4k2bpv61.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Fri, 29 Apr 2022 12:05:26 -0700")
Message-ID: <xmqq1qxfbqtq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DA2E1D4-C7F7-11EC-817D-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> A simple and concrete reproduction 
>>
>>     git init top
>>     cd top
>>     date >file1
>>     git init sub
>>     cd sub
>>     date >subfile1
>>     git add .
>>     git commit -m subinitial
>>     cd .. ;# back to top
>>     git submodule add ./sub sub
>>     git add file1
>>     git commit -m initial
>>     cd .. ;# out of top
>>     git clone --recurse-submodules top copy
>>     cd copy
>>     git config submodule.recurse true
>>     git config fetch.parallel 0
>>     GIT_TRACE2=$(pwd)/trace git fetch --all --prune --prune-tags
>>
>> This throws the three lines to the output.
>>
>> Fetching origin
>> Fetching submodule sub
>> Fetching submodule sub
>>
>> The two "Fetching submodule" messages are coming from two separate
>> calls to get_fetch_task_from_index(), and the trace does show that
>> the code is doing "git-upload-pack" three times (one for the top
>> level, twice for the same top/sub).  We can see it by grepping
>> for "git-upload-pack" in the resulting 'trace' file above.
>
>  
> Thanks for the reproduction recipe and findings, that'll be very helpful
> :)
>
>> Glen, as submodule.c::fetch_submodules() was created in your heavy
>> refactoring quite recently, I thought I'd redirect this report in
>> your direction, as I expect you'd be the most clueful in this area
>> ;-)
>
> Hm, this does look like something that I probably introduced. But even
> if it turns out to be older than that, I think I am the right person to
> fix it, yes.

It seems that ever since the introduction of the --prune-tags option
at v2.16.1-16-g97716d217c (fetch: add a --prune-tags option and
fetch.pruneTags config, 2018-02-09), we always behaved this way.

Without "--prune-tags" (but still with "--prune"), we can go even
older than that version, and v2.10.0 seems to fetch only once.

And the command keeps working that way all the way back to the
commit that starts honoring submodule.recurse configuration, at
v2.13.0-137-g58f4203e7d (builtin/fetch.c: respect
'submodule.recurse' option, 2017-05-31)

If we instead use "git fetch --recurse-submodules" with versions
of GIt older than that, we can go even older.  I saw v2.5.0 behaves
that way before I got tired and gave up.

So, we still would want to eventually get to it, but no rush.  This
is an old thing and not as urgent as fixing a recent regression.

FWIW, without "--all", we do not make an extra fetch at all, with
the current code or with code as ancient as v2.5.0

Thanks.
