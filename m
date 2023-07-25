Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B377CC0015E
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 17:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjGYRZu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 13:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjGYRZt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 13:25:49 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B68137
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 10:25:48 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A64EA1D810;
        Tue, 25 Jul 2023 13:25:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jMRbM0eHV9kctIoySnN6Jeod5Ad4STZ2NKY3f8
        NvfxI=; b=RWgT5yPpAFXhTXvtKMAvWaz/7CUrUpTi0XNoxJ0ccS+s8VyRvDYrXd
        lxVysTRy6dHTh9VA0X8KJsJRqC7MlL3s8TyFdhlkwbnU7sJzQbxD0GRPgZNOke2L
        aLEtw8eJpE7/1Spa+rO+vhWshGi22aAbsuIdLNArT9vVu56kdWFgY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9EBC31D80F;
        Tue, 25 Jul 2023 13:25:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 415091D80E;
        Tue, 25 Jul 2023 13:25:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 5/8] repack: add `--filter=<filter-spec>` option
References: <20230614192541.1599256-1-christian.couder@gmail.com>
        <20230705060812.2865188-1-christian.couder@gmail.com>
        <20230705060812.2865188-6-christian.couder@gmail.com>
        <xmqqh6qi1byn.fsf@gitster.g>
        <CAP8UFD0aa+EZQ2Q=C2WjWrNL9desg-KLLjOKS8BUBR4DS1ytsQ@mail.gmail.com>
        <xmqqila9p3j8.fsf@gitster.g>
        <CAP8UFD3b6gCog5P7WKzTuPQV2Lhf51=xO7ys+W7o0pGewJMcFg@mail.gmail.com>
Date:   Tue, 25 Jul 2023 10:25:43 -0700
In-Reply-To: <CAP8UFD3b6gCog5P7WKzTuPQV2Lhf51=xO7ys+W7o0pGewJMcFg@mail.gmail.com>
        (Christian Couder's message of "Tue, 25 Jul 2023 17:22:46 +0200")
Message-ID: <xmqqcz0fnbs8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4936792C-2B10-11EE-AFB3-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> We have the following order:
>
>   - finish_pack_objects_cmd() is called for the first pack-objects
> process. It populates the 'names' string_list with the temporary name
> of the packfile it generated (which doesn't contain the filtered out
> objects) and calls finish_command() to finish the first pack-objects
> process. So as far as I understand nothing can be written anymore to
> the packfile when finish_pack_objects_cmd() returns.
>
>   - write_filtered_pack() is called. It starts the second pack-objects
> process and passes it the temporary name of the packfile that was just
> written, taking it from the 'names' string_list. It then calls
> finish_pack_objects_cmd() for the second process which populates the
> 'names' string_list with the temporary name of the packfile created by
> the second process and finishes the second process. So nothing can
> then be written in the second packfile anymore.
>
>   - close_object_store() is called which renames the packfiles from
> the 'names' string_list giving them their final name.

"which renames" -> "and then we enter a loop to rename" and
close_object_store() itself and its callees do not do much, but yes,
you are right.  As finish_pack_objects_cmd() is synchronous, there
cannot be such race as a feared (if we were feeding the pack objects
process that collects the objects that would have filtered out with
the final packfile paths, and if we were only renaming them to the
final paths after that close_object_store() call, then the process
would want to see the final names that are not there yet, but that's
not a race but a bug that would reliably trigger).

> So the final names are given only once both processes are finished and
> both packfiles have been fully written.

Thanks for walking through the codepaths involved.  We are good
then.
