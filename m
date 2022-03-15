Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E4CC433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 16:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349935AbiCOQOg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 12:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240683AbiCOQOf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 12:14:35 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0BA30F49
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 09:13:22 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D03E112352;
        Tue, 15 Mar 2022 12:13:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+UHvx9IyBb6OYfkMpfTn7CKiU7Nto7CWclH6jw
        LzJck=; b=GogK2v3d9+qAJUWDdiZ0T3wRu1FVnk1Ua7rVRn5GEd6cpflmK3JrDI
        l1l04eTumfYQmmxbdv2czRLZvZjC/fjdV1IknbA3Ck+Tax3p7ARi5Kg+1d1J9ETU
        DSQrMa8ED5/rftOWSTjJIJN7meuh+4BwVkTIKuSId7Qw0Bpg7L8zE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 219CC112351;
        Tue, 15 Mar 2022 12:13:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6E63B112350;
        Tue, 15 Mar 2022 12:13:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] partial-clone: add a partial-clone test case
References: <xmqqa6dsnpj9.fsf@gitster.g>
        <20220315113002.61748-1-chakrabortyabhradeep79@gmail.com>
        <4d78dece-1212-5232-a441-683e941016c5@github.com>
Date:   Tue, 15 Mar 2022 09:13:19 -0700
In-Reply-To: <4d78dece-1212-5232-a441-683e941016c5@github.com> (Derrick
        Stolee's message of "Tue, 15 Mar 2022 08:57:25 -0400")
Message-ID: <xmqqv8wffb34.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4CBE530-A47A-11EC-B68D-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> I tried to use `git rev-list --objects --missing=print` with `HEAD` and
>> first commit hash. But in both cases, I didn't found a missing `[?]` sign
>> before ` <blob-hash-ID> file.txt`. That means, both blob objects ( or I
>> think the same blob object) exists in the local repo.
> ...

Yup.  I was about to suggest --missing=allow-promisor to catch other
unexpected missing objects, but in this toy history for testing,
what is missing is all the objects expected from the promisor, so it
should be sufficient to use --missing=print.

> I think the key issue is that your clone says this:
>
> +	git clone --filter=blob:none "file://$(pwd)/repo" partial.git &&
>
> which will do a checkout and download the blobs at tip.
>
> If you add a "--bare" to this clone command, then no blobs should be
> downloaded, and your rev-list command should show the missing objects.

That sounds like pointing at a different issue.  If the test
repository downloads the blobs at the tip, then the fact that the
trace output did not have "fetch" in it does not mean much, does it?
It could be that we refrained from lazily download the blob because
we did not need its contents for the purpose of following through an
exact rename, but it could also be that we did not need to lazily
download it because we already had it.

> Hopefully my suggestion to use --bare will help.

Yup, thanks.

So regardless of "--missing=print" vs "grep in trace", there was a
bug in the test set-up, and we caught it in this discussion, which
is excellent.

