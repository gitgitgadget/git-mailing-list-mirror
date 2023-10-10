Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EFDCD68E0
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 00:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379188AbjJJAj0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 20:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379152AbjJJAjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 20:39:25 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB4F99
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 17:39:24 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E6BD61BD7B0;
        Mon,  9 Oct 2023 20:39:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=zaCx/c8IlyiOX82l/hSUHCHj8l1aiR/yAZwT/0
        CrpFQ=; b=FfVzhr+JbIhqPWp1EkkxUAEVQQnwx5LrX5iUbOMH1jl4L8W2ggkYS+
        9d27bEF30xvj3IpFFvgRVqAeQQQ8TBJ+j13FGHL/X96QI1/66zyOLITVCYq+P8ul
        PIHMBoysSIo5MGCBSkDrnYuDlAgrCp9nA970gPtnKv1SKM7krBufU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DEFC91BD7AF;
        Mon,  9 Oct 2023 20:39:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 50BC41BD7AE;
        Mon,  9 Oct 2023 20:39:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hugo Sales <hugo@hsal.es>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: Re: [PATCH 0/3] Add `-p' option to `git-mv', inspired by `mkdir'
In-Reply-To: <20231009233458.1371351-1-hugo@hsal.es> (Hugo Sales's message of
        "Tue, 10 Oct 2023 00:34:55 +0100")
References: <20231009233458.1371351-1-hugo@hsal.es>
Date:   Mon, 09 Oct 2023 17:39:22 -0700
Message-ID: <xmqq1qe3wbt1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 752E1432-6705-11EE-8AFE-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hugo Sales <hugo@hsal.es> writes:

> Allow passing a new `-p'/`--parents' option to `git-mv' making it so
> missing directories in the given target path get created if they don't
> exist. This allows running `git mv -p foo bar/quux/' to first create
> the `bar/' and `bar/quux/' directories if they don't exist, and then
> move `foo' to `bar/quux/foo'.
>
> This is inspired by `mkdir -p foo/bar/quux/' which will create the
> `foo/', `foo/bar/', and `foo/bar/quux/' directories if they don't
> exist.

I'll step back and ask a related design question without reading the
patches (yet).

Is there a reason why somebody benefits by us retaining the current
behaviour, where

    $ git mv file no/such/dir/yet/file

fails with "No such file or directory", and they are forced to say
either

    $ mkdir -p no/such/dir/yet
    $ git mv file no/such/dir/yet/file

or

    $ git mv -p file no/such/dir/yet/file

Yes, what I am getting at is if it makes sense to just "fix" the
behaviour of "git mv" about missing leading directories and do what
the end-user wanted to do without requiring "-p".

Regardless of the "do we require, or is it sifficient to imply, the
'-p' option when we lack leading directories?" question, once we
start "auto-creating" the leading directory hierarchy, one worrysome
thing such a new feature introduces is an ambiguity and unexpected
behaviour.  Imagine there is no "no" directory (so nothing under it
exists), and you did this (you do have a regular file "file").

    $ git mv [-p] file no/such/dir/yet

What should happen?  Would we do the equivalent of

    $ mkdir -p no/such/dir && git mv file no/such/dir/yet

or are we doing

    $ mkdir -p no/such/dir/yet && git mv file no/such/dir/yet/file

Both are plausible, and "mkdir -p" does not have such a nasty
ambiguity.  That is what makes me unsure about the new feature
(again, either with required "-p" or with implied "-p").

Thanks.
