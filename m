Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7407C433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 17:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343774AbiFIR4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 13:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243228AbiFIR4o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 13:56:44 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EA514E946
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 10:56:42 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E3B9199060;
        Thu,  9 Jun 2022 13:56:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pEa2Fn4fF/IX
        HAv+eNNdhNfIFGFscmrAOtHVMAdsa2U=; b=Cd6ML8APh8HOD9puImQTkU/rkn1o
        2TX6np9kJ5vO4SH2qnFJKfzKkm8GhPyG75D4YSSJfZkEfPHEK/EqHxMAG4zIlIwO
        UexeuIu8sWmsTD2Mivv3Yj8YhHb+ggqX5StzWoaoG9azQBEOEHtuSWktEb1zSq79
        qUulBeCXRuU5P2k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2585F19905F;
        Thu,  9 Jun 2022 13:56:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BAF2B19905E;
        Thu,  9 Jun 2022 13:56:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 1/6] docs: document bundle URI standard
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
        <e771b2971d092af5ea8a47eb708d03e34b284a0f.1654545325.git.gitgitgadget@gmail.com>
        <xmqqtu8x1fd4.fsf@gitster.g>
        <48e722dc-f860-f7a6-36d0-b0106087aef4@github.com>
        <xmqq5ylarhsg.fsf@gitster.g>
        <3d67b69b-fac8-3171-92dc-303ea672efbf@github.com>
Date:   Thu, 09 Jun 2022 10:56:37 -0700
In-Reply-To: <3d67b69b-fac8-3171-92dc-303ea672efbf@github.com> (Derrick
        Stolee's message of "Thu, 9 Jun 2022 12:00:27 -0400")
Message-ID: <xmqqk09plnze.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 82CD5818-E81D-11EC-90CE-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> =C3=86var's observation that bundles also add ref tips to the packfile =
is
> the key to breaking down this concern: these ref tips give us a way
> to negotiate the difference between what the client already has
> (including the bundles downloaded from a bundle provider) and what it
> wants from the origin Git server. This all happens without any change
> necessary to the origin Git server.
>
> And thus, this bundle URI design came about. It takes all of the best
> things about the GVFS Cache Server but then layers refs on top of the
> time-based prefetch packfiles so a normal Git client can do that
> "catch-up fetch" afterwards.

Yup.  My observation was that (1) you would need ref tips in some
way, (2) you are conveying not just "here are the set of bundle
files", but "this bundle file has these associated attributes" (like
.timestamp, and .uri to fetch it from), in the table-of-contents the
clients are expected to obtain anyway, hence (3) you could, but you
do not need to, use bundle as a way to convey "packfile contents
plus refs" to the clients (iow, instead you can use packfile and
then report these refs information in the table-of-contents as more
"associated attributes" to the items listed in the table-of-contents).

> I could imagine updating GVFS Cache Servers to generate bundles
> instead (or also) and updating the VFS for Git clients to use the
> bundle URI feature to download the data.

I could, too, but I do not think that would buy us anything.  If an
existing system is happily working, I do not see a point in switching
it to use bundle.  What I was imagining is going the other way.  A
new thing being written, instead of basing it on bundles, can be
based on packfiles, and that would allow you to share the on-disk
packfiles between the two systems.

> However, you seem to be hinting at "the GVFS Cache Servers seem to
> work just fine, so why do we need bundles?" but I think that the
> constraints of what is expected at the end of "git clone" or "git
> fetch" require us to not "catch up later" and instead complete the
> full download during the process. The refs in the bundles are critical
> to making that work.

The refs are critical.  They do not have to be recorded in a bundle.

> I see two major issues with that:
>
> 1. We don't have a way to add that metadata directly into packfiles,
>    so we would need to update the file standard or update the
>    packfile-URI protocol to include that metadata.
>
> 2. The only source of packfile-URI listings come as a response to the
>    "git fetch" request to the origin Git server, so there is no way
>    to allow an independent server to provide that data.

It might be end up being the same thing at the end, but I was
thinking about starting from the "bundle URI standard" document.  I
am not yet interested in discussing "packfile URI" feature that
independently exists already in this discussion (but going this
route we _might_ be able to share data and some code with it---but
that was not where I am coming from).

Starting from "bundle URI standard" document at the beginning of the
thread, if we replace all the mentions of "bundle file" with
"packfile" in it, and then add .positiveRefs and .negativeRefs to
each "packfile" (renamed from "bundle file") as additional
"packfile.<id>.*" (renamed from "bundle.<id>.*") attributes, without
changing anything else, the result would be feature equivalent to
the original "bundle URI standard", I would think, but without
having to wrap a packfile in a bundle file?

> I hope I am going in the right direction here, but I likely
> misunderstood some of your proposed alternatives.

I wasn't seriously "proposing" an alternative.  It was just that it
looked wasteful to go to a separate format (i.e. bundle) when packfiles
should suffice, as you would be adding extra information that is not
in bundles via the table-of-contents anyway, and what is given by a
bundle that is missing in a packfile is only the refs information,
which should be trivial to add to the table-of-contents.

