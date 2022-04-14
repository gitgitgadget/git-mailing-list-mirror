Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF97C433EF
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 21:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343697AbiDNVRC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 17:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237304AbiDNVRB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 17:17:01 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047716331
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 14:14:33 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A6BEC18AA87;
        Thu, 14 Apr 2022 17:14:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u9vpCGaybbB/P+luyAUTc7zWcvvNlwpqPbiCi8
        uxvkQ=; b=OgaEuL2Hv2O4NKEc+LhuSzPMwSbqhTRK8a/ytdwrZLYgI7IMx0lwCO
        ylslA3YOrTqiBXLxudE+XQY6bI5dKOQu31ZbjN80cnaGO3wn636ewYhCFKvDtm4F
        Q9MJ233h0QWd3JDaaxhjLwlbmUUvwZqGqpiZcw1faxgVUww/vWCT8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9F97618AA86;
        Thu, 14 Apr 2022 17:14:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A1FD618AA83;
        Thu, 14 Apr 2022 17:14:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/4] Sparse index integration with 'git show'
References: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
        <Ylhp+q96KOt2+OGZ@google.com>
Date:   Thu, 14 Apr 2022 14:14:24 -0700
In-Reply-To: <Ylhp+q96KOt2+OGZ@google.com> (Josh Steadmon's message of "Thu,
        14 Apr 2022 11:37:46 -0700")
Message-ID: <xmqqk0brz7tb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD7C7A94-BC37-11EC-AE27-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

>> 'git show' is relatively simple to get working in a way that doesn't fail
>> when it would previously succeed, but there are some sutbleties when the
>> user passes a directory path. If that path happens to be a sparse directory
>> entry, we suddenly start succeeding and printing the tree information!
>>
>> Since this behavior can change depending on the sparse checkout definition
>> and the state of index entries within that directory, this new behavior
>> would be more likely to confuse users than help them.
>
> The two paragraphs above did not really convey to me on first
> read-through what the problem was. IIUC the main points are:
>
> * git-show does not currently work with the sparse index.
> * A simple change fixes the above, but causes us to sometimes print
>   unexpected information about trees.
> * We can use the simple change in our implementation, but must do
>   additional work to make sure we only print the expected information.
>
> I think this could be clarified by:
> * Including examples of the unhelpful output from the simple
>   implementation.
> * Describing in more detail the situations that trigger this.
> * Describing why those situations don't currently happen without support
>   for sparse indexes.

I think the issues patches 2-4 addresses are not limited to any
specific command, but how ":<path-in-the-index>" syntax is resolved
to an object name (including the way how error messages are issued
when the given path is not found in the index).

But the title of the series and presentation place undue stress on
"git show", which I suspect may be confusing to some readers.

For example, with these patches, wouldn't "git rev-parse" start
working better, even though the proposed log message for no commit
in the series talks about "rev-parse" and no tests are done with the
"rev-parse" command?

I am not suggesting that commands other than "show" should be also
discussed in detail or tested.  It would help readers if we said
that we are using 'show' merely as an example to demonstrate how
":<path-in-the-index>" syntax interacts with the sparse index
entries (1) before the series, and (2) how well the improved
object-name parsing logic works after the series.


