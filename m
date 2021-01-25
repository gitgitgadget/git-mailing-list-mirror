Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E339C433E6
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 20:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E860A2256F
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 20:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731970AbhAYUMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 15:12:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52270 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732261AbhAYULa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 15:11:30 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A6CA90F5E;
        Mon, 25 Jan 2021 15:10:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZL9GbmH+hgBdJ/KmaKP4cEH5v6s=; b=v4lEZf
        e58HhSyIgqEwJ34YfkEImG5VxA5GCZselDaVJlpuH6Dutifv2CnF/b51ieBcrh+e
        rbmNrUCP3QtHXzgeqGCJKGbz1DOAEz8KFv/0G0vvg3zJ6bEdai96SE6u5s6dUo/A
        PquUYlV2nXN1P+XNlm37zDbM+wrlTqP+u5TNA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uWUngccxuYPZlxj2xH185dlo9PG07rDz
        4WYe0JEtGhNTvXnNJhZaJOOA/NN+GCeIrW3PWNNokd/g3Oms2HQpg0E0NglyrCmT
        pV3BDkfard1EPImSqo1MAASz8uEhKoV+FjyaZ84K6Ksqkfa8l+PIR2LtB8vje77B
        ZtlXzXpAxYM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8DD8490F5D;
        Mon, 25 Jan 2021 15:10:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1671290F5C;
        Mon, 25 Jan 2021 15:10:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net,
        jrnieder@gmail.com, sunshine@sunshineco.com, pclouds@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 00/27] [RFC] Sparse Index
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 12:10:47 -0800
In-Reply-To: <pull.847.git.1611596533.gitgitgadget@gmail.com> (Derrick Stolee
        via GitGitGadget's message of "Mon, 25 Jan 2021 17:41:46 +0000")
Message-ID: <xmqqh7n4ydyw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A089FEE-5F49-11EB-9CD3-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This RFC proposes an update to the index formats to allow "sparse directory
> entries". These entries correspond to directories that are completely
> excluded from the sparse checkout definition. We can detect that a directory
> is excluded when using "cone mode" patterns.

Yay.

> Since having directory entries is a radical departure from the existing
> index format, a new extension "extensions.sparseIndex" is added. Using a
> sparse index should cause incompatible tools to fail because they do not
> understand this extension.

Safety is good, but because the index is purely a local matter, we
do not have to be so careful as updating the network protocols or
pack/object formats.

I think the use of "extensions.*" mechanism to render the repository
that uses the new feature unusable by older Git is safe enough, but
it may be too draconian.  For example, when things go wrong, don't
you want to "fetch"/"clone" from it into another repository to first
save the objects and refs?  You do not need a version of the index
file you understand in order to do that.

The index format has a mechanism to make older versions of Git bail
when it encounters a file that uses newer feature that they do not
understand.  Perhaps using it is sufficient instead?
