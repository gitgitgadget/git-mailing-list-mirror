Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961C8CE7AAA
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 17:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjIYRUc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 13:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYRUb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 13:20:31 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C73CBC
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 10:20:21 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DCEE71C9C18;
        Mon, 25 Sep 2023 13:20:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=bgm8PAqCxPhfInL1UE95TfDao/3WUoqu2s+Euf
        T57xM=; b=G9lMy1joN0OyNx348AVBa4SGJ/YgQvKrv3KKUekcUgIgrHvvvNO0so
        vWJ1gJ5gbPW5UORC4mB/Bi/6yJf5692vDvVt4Z6ymgTtivVK3KNK5sLPncViQNcs
        xs7ZXmoaP3lNwzvUPPO5DcHiJi/HF4tabFAx/cbDX3uJfURGoV+eQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4B631C9C17;
        Mon, 25 Sep 2023 13:20:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 448D41C9C16;
        Mon, 25 Sep 2023 13:20:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/6] Add a GitHub workflow to submit builds to
 Coverity Scan
In-Reply-To: <pull.1588.v2.git.1695642662.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Mon, 25 Sep 2023 11:50:56
        +0000")
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
        <pull.1588.v2.git.1695642662.gitgitgadget@gmail.com>
Date:   Mon, 25 Sep 2023 10:20:19 -0700
Message-ID: <xmqqy1guuq3w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDB6E19A-5BC7-11EE-AAD6-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Coverity [https://scan.coverity.com/] is a powerful static analysis tool
> that helps prevent vulnerabilities. It is free to use by open source
> projects, and Git benefits from this, as well as Git for Windows. As is the
> case with many powerful tools, using Coverity comes with its own set of
> challenges, one of which being that submitting a build is quite laborious.
> ...

One thing that caught my eye was the asterisks around "22" that look
as if they were designed to confuse readers and cause them wonder if
there are other codes like 122 and 224 that we would also want to
catch there.  Unless they know what the case statement replaced,
that is---the old code to match http_code that was scraped from a
text file may not have the code alone and may contain other cruft,
so it is entirely understandable, but the new one checks $? and
there is no reason other than to catch 122 and 224 to use *22*.



>      -+          http_code="$(sed -n 1p <"$RUNNER_TEMP"/headers.txt)"
>      -+          case "$http_code" in
>      -+          *200*) ;; # okay
>      -+          *401*) # access denied
>      -+            echo "::error::incorrect token or project? ($http_code)" >&2
>      +                    --fail \
>      +                    --form token='${{ secrets.COVERITY_SCAN_TOKEN }}' \
>      +                    --form project="$COVERITY_PROJECT" \
>      +-                   --form md5=1) &&
>      ++                   --form md5=1)
>      ++          case $? in
>      ++          0) ;; # okay
>      ++          *22*) # 40x, i.e. access denied
>      ++            echo "::error::incorrect token or project?" >&2
>       +            exit 1
>       +            ;;
>       +          *) # other error
>      -+            echo "::error::HTTP error $http_code" >&2
>      ++            echo "::error::Failed to retrieve MD5" >&2
>       +            exit 1
>       +            ;;
>       +          esac

Other than that, while I was watching from the sideline, I am very
happy to see that you, with Peff's constructive input, came up with
a new iteration that looks simpler and more consistent in its use of
curl.

Will replace but I may be tempted to edit those asterisks out myself
while queueing.

Thanks.
