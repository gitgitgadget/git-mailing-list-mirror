Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D56C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 08:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbiF0IcM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 04:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbiF0IcL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 04:32:11 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F34625B
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 01:32:10 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B9AC113CFFB;
        Mon, 27 Jun 2022 04:32:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=jiuSXMLZjn9gTzY/rGdmAg9BrdnQDRyQgJPDnEK9bOU=; b=wWL5
        w0e99Z4HmCBT1L+Q/U4N/FDeEd/OSDnBUUSlbWWFLlaj4eJrewsGJnBLwxsKcft8
        rTMllgTlIyXpY3oLhFolTB6bhxXHPbJF5jF2wIoW7QunIsgNCqz2MAzfaD6Ylp3K
        wrKckrlz4spvbhfL3x6xuR7TQDM1LrGeLRWoFD8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF7C313CFFA;
        Mon, 27 Jun 2022 04:32:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0A1F313CFF9;
        Mon, 27 Jun 2022 04:32:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v4] ls-files: introduce "--format" option
References: <pull.1262.v3.git.1655777140231.gitgitgadget@gmail.com>
        <pull.1262.v4.git.1656257376109.gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 01:32:07 -0700
Message-ID: <xmqq1qvase0o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A24FC28C-F5F3-11EC-81A7-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Range-diff vs v3:
> ...
>       +test_done

I omitted 300 lines of range-diff, which is not exactly illuminating
in this case.  I wonder if there is a way to turn it off when it is
not helping automatically...

> +FIELD NAMES
> +-----------
> +Various values from structured fields can be used to interpolate
> +into the resulting output. For each outputting line, the following
> +names can be used:
> +
> +objectmode::
> +	The mode of the file which is recorded in the index.
> +objectname::
> +	The name of the file which is recorded in the index.
> +stage::
> +	The stage of the file which is recorded in the index.


> +eolinfo:index::
> +	The <eolinfo> of the file which is recorded in the index.
> +eolinfo:worktree::
> +	The <eolinfo> of the file which is recorded in the working tree.

These sound somewhat strange, as the above makes it sound as if we
are recording eolinfo for something (we never record eolinfo of
anything anywhere).

	eolinfo:index::
	eolinfo:worktree::
        	The <eolinfo> (see the description of the `--eol` option) of
                the contents in the index or in the worktree for the path

perhaps?  I dunno.

> +eolattr::
> +	The <eolattr> of the file which is recorded in the index.

Likewise, eolattr comes from the attribute subsystem and not
recorded in the index.  It is more like

	eolattr:
                The <eolattr> (see the description of the `--eol` option)
                that applies to the path.

Because attribute applies to the path, it applies equally to both
what is in the index and what is in the working tree.

> +path::
> +	The pathname of the file which is recorded in the index.

As ls-tree already uses %(path) for it, this is probably OK
(otherwise we would probably have called it %(pathname)).
