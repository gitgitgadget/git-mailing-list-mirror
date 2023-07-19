Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB9EC001DE
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 16:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjGSQPV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 12:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjGSQPU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 12:15:20 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9180E113
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 09:15:11 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5E6762F460;
        Wed, 19 Jul 2023 12:15:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/bDxMhekMw6dc/x/e8wvALbMwRFAF4Mde/+3/X
        sHt40=; b=x8yTS68PyiChamQGSwQMV3+XurKPf+jJnYVTRw0UaD4OwAwXRbGNA4
        w3S1l/R6kJ9NsAPTYFeMNrC63jBh/Z+0s8P+St22hhcfRvItJsoYcpJ1B3aqQPhf
        QLg5Xd+SPjRd9EVuzS+j1zwD46GdnI/X38/g9mONgCL7uz2MXi94k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5741A2F45F;
        Wed, 19 Jul 2023 12:15:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5B5A92F45E;
        Wed, 19 Jul 2023 12:15:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [QUESTION] how to diff one blob with nothing
References: <CAOLTT8TVGna+C9nYy9nj3h5bT7AdAT0SKtUM3YVz6h=KZhGHHg@mail.gmail.com>
Date:   Wed, 19 Jul 2023 09:15:03 -0700
In-Reply-To: <CAOLTT8TVGna+C9nYy9nj3h5bT7AdAT0SKtUM3YVz6h=KZhGHHg@mail.gmail.com>
        (ZheNing Hu's message of "Wed, 19 Jul 2023 17:59:15 +0800")
Message-ID: <xmqqo7k7c1yw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B8F3024-264F-11EE-98D6-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> I want to diff two blobs right now, and one of them
> may be empty, so I tried using
> 0000000000000000000000000000000000000000 or
> e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 (empty blobID)
> to test its effect, and the result I found was:
>
> git diff 00750edc07d6415dcc07ae0351e9397b0222b7ba
> 0000000000000000000000000000000000000000
> fatal: bad object 0000000000000000000000000000000000000000

As the object name for an empty blob is not all-0, this is expected.

> git diff 00750edc07d6415dcc07ae0351e9397b0222b7ba
> e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
> fatal: bad object e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
>
> Since the "empty object" has not been created, the
> git diff operation fails.

If you haven't created one, of course it would fail.  It should help
to do

    $ git hash-object -w --stdin </dev/null

before running

    $ git diff 00750edc e69de29bb

Long time ago, with 346245a1 (hard-code the empty tree object,
2008-02-13) we taught git what an empty-tree looks like, but it
seems that we never did the same for an empty blob, perhaps?

Interesting.  I am not sure if it is a good idea to teach empty_blob
to find_cached_object() and leaning negative but I haven't thought
things through on this.



