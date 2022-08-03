Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AA5C19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 06:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbiHCGQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 02:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbiHCGQV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 02:16:21 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418AD1C12F
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 23:16:20 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A85E14856F;
        Wed,  3 Aug 2022 02:16:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XkHcKlWtmN0NXx1Le27T5/QXBaxpXn0xL4B4Hv
        sI7RU=; b=CTOGrbS0qoE7btm6L08HMUnzntGLQAMOI/f2Zj0Pj/s/1xsbdT+dyT
        eAMMgk43I4efD2dxEuNDGyP5Oi3z+U1bEyGqS2zQVg3cPXVmefQx7YxoIwYEVWJy
        0P5CR+SrQYypdLQMb8MaIkA+1OVD4eXzcIrLXCXObFKPyzRgph2MY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7030E14856E;
        Wed,  3 Aug 2022 02:16:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CEED914856D;
        Wed,  3 Aug 2022 02:16:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 03/10] refs: add array of ref namespaces
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
        <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
        <d7486390d57849971ee6a4ac27a0a784c41623ee.1659122979.git.gitgitgadget@gmail.com>
Date:   Tue, 02 Aug 2022 23:16:17 -0700
In-Reply-To: <d7486390d57849971ee6a4ac27a0a784c41623ee.1659122979.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 29 Jul 2022
        19:29:32 +0000")
Message-ID: <xmqqzggldf7y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9B37928-12F3-11ED-9161-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	[NAMESPACE_REPLACE] = {
> +		/*
> +		 * This namespace allows Git to act as if one object ID
> +		 * points to the content of another. Unlike the other
> +		 * ref namespaces, this one can be changed by the
> +		 * GIT_REPLACE_REF_BASE environment variable. This
> +		 * .namespace value will be overwritten in setup_git_env().
> +		 */

Thanks---it is a shame that we have unnecessary flexibility that
requires us to have this code.

> +		.ref = "refs/replace/",
> +		.decoration = DECORATION_GRAFTED,
> +	},
> +	[NAMESPACE_NOTES] = {
> +		/*
> +		 * The refs/notes/commit ref points to the tip of a
> +		 * parallel commit history that adds metadata to commits
> +		 * in the normal history. This branch can be overwritten

This is not "branch" but is a ref.


> +		 * by the core.notesRef config variable or the
> +		 * GIT_NOTES_REFS environment variable.
> +		 */
> +		.ref = "refs/notes/commit",
> +		.exact = 1,

Allowing just "the default" to be replaced by another "custom
default" is a good start, but we probably want to support more than
one notes refs, to parallel how "struct display_notes_opt" has
extra_notes_refs to allow multiple notes refs to decorate objects.

