Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CB2C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiEWUf1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiEWUf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:35:26 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15FE980AC
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:35:25 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 111E518379D;
        Mon, 23 May 2022 16:35:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TzuN/vSqunBKeTqAAotITKsqf4e505h1BuBaiS
        SpLbk=; b=DB7XbmQuBNeKizBz8et2l22OckTDTi07rT3zmbmgSktADrjOMBjkEO
        QIYT0EjH9sTyZ1Q+Ov29duVrSGQ1cPpB06E9L0+XiqaHJSXzl8SMUMGYDNpBXwzZ
        j4SKtgWRby3Omg8hG17FB5Gt7+PxmydyzMfUzclWOyk4/kq2sFvSs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 08E2518379C;
        Mon, 23 May 2022 16:35:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 93748183798;
        Mon, 23 May 2022 16:35:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Nadav Goldstein via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nadav Goldstein <nadav.goldstein96@gmail.com>
Subject: Re: [PATCH v2 1/2] add-menu: added add-menu to lib objects
References: <pull.1232.git.1652649537647.gitgitgadget@gmail.com>
        <pull.1232.v2.git.1653286345.gitgitgadget@gmail.com>
        <13bc75a2b0510f55e9a73852838b3b11683f13a2.1653286345.git.gitgitgadget@gmail.com>
        <8d483e1d-1865-c475-cbe3-78fa1f7f8bfb@github.com>
Date:   Mon, 23 May 2022 13:35:20 -0700
In-Reply-To: <8d483e1d-1865-c475-cbe3-78fa1f7f8bfb@github.com> (Derrick
        Stolee's message of "Mon, 23 May 2022 16:03:34 -0400")
Message-ID: <xmqq1qwkq96f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DDD501FA-DAD7-11EC-A5DD-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> The biggest test of your new API is whether it can
> support _both_ of these existing interactive menus
> before adding one to 'git stash'.

A great piece of advice.

> One problem with this approach of adding the code to this
> new *.c file and then later removing the code from clean is
> that we lose 'git blame' or 'git log -L' history across the
> move. It's much harder to detect copies than to detect moved
> lines of code.
>
> I don't have a good solution in mind right now, but it's
> worth thinking about.

I actually do ;-)

One single preliminary patch can rename the helper functions, update
the direct reference to the color configuration table into passing a
parameter to the table, doing the same to the menu that defines the
shorthand, help text, and implementation of the command, and any
other necessary adjustment.  Or if these tasks are turns out to be
too large to do in a single commit, they can be done in steps.  This
preliminary refactoring patch (or a series of patches) can be done
while everything is still in builtin/clean.c (or we could start by
refactoring the one in add-interactive.c instead).

Then the second patch in the series would move the refactored
library-ish code into the new interactive-menu.c file, and add the
interactive-menu.h header for users to include.  The first such user
will be builtin/clean.c (or if we started from add-interactive.c,
then that one).  "blame", "log" and "diff --color-moved" would all
notice that an already refactored block of code was lifted from one
source file and moved to the new place in this step.

The third patch in the series would convert add-interactive.c (or if
we started from it, then builtin/clean.c) to be the second user of
the API.  There might need a few preliminary steps in the file to be
converted before it happens to match the function signatures, etc.

After that, "git stash" will have its own interactive mode that uses
the new API from day one.
