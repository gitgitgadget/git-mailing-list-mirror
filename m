Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE5EC433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 21:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347493AbiBBVWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 16:22:53 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52719 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238553AbiBBVWw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 16:22:52 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30B0B10FA73;
        Wed,  2 Feb 2022 16:22:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=pO80Vknj1Bwb8xd/fH13Bkj6RZKz7ytL+AbUMSOlgt0=; b=uzlr
        4QKywXnDTBeTO4Km8SIqjajReVQQs2g/9LSjA0hLwCStZtZPmTDMEbmrxTgpZLnO
        kZuBpud/oyX90578ZHn+r9QH+2FcGkh/H9sheiM9lDizcvZp7vY83i6uCsFSsDXA
        bkHofvwWm9SMQh47FrGqAyUWdGviWK267ScbMEo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 278F810FA72;
        Wed,  2 Feb 2022 16:22:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 84BCE10FA71;
        Wed,  2 Feb 2022 16:22:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 04/15] merge-tree: implement real merges
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
        <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
        <02c29f920d0d5fde6d85f7b86a69be92e3f0f34d.1643787281.git.gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 13:22:50 -0800
Message-ID: <xmqqy22tx8t1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4717FEDA-846E-11EC-A2EA-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -392,7 +395,46 @@ struct merge_tree_options {
>  static int real_merge(struct merge_tree_options *o,
>  		      const char *branch1, const char *branch2)
>  {
> -	die(_("real merges are not yet implemented"));
> +	struct commit *parent1, *parent2;
> +	struct commit_list *common;
> +	struct commit_list *merge_bases = NULL;
> +	struct commit_list *j;
> +	struct merge_options opt;
> +	struct merge_result result = { 0 };
> +
> +	parent1 = get_merge_parent(branch1);
> +	if (!parent1)
> +		help_unknown_ref(branch1, "merge-tree",
> +				 _("not something we can merge"));
> +
> +	parent2 = get_merge_parent(branch2);
> +	if (!parent2)
> +		help_unknown_ref(branch2, "merge-tree",
> +				 _("not something we can merge"));
> +
> +	init_merge_options(&opt, the_repository);
> +
> +	opt.show_rename_progress = 0;
> +
> +	opt.branch1 = branch1;
> +	opt.branch2 = branch2;
> +
> +	/*
> +	 * Get the merge bases, in reverse order; see comment above
> +	 * merge_incore_recursive in merge-ort.h
> +	 */
> +	common = get_merge_bases(parent1, parent2);
> +	if (!common)
> +		die(_("refusing to merge unrelated histories"));

It appears to me that "merge-tree" in this mode, with the above
code, cannot be used as a workhorse to implement server-side
cherry-pick (or revert), which needs to allow the user to specify an
arbitrary "common ancestor", instead of computing on its own.

To replay the change made by commit A on top of commit X (i.e.
"cherry-pick A on X"), we have to be able to say "compute the
three-way merge between A and X, pretending as if A^ were their
common ancestor".  The story is the same for revert---we compute
three-way merge between A^ and X, pretending as if A were their
common ancestor.

The above interface into this function, sadly, does not seem to
allow such a request, unless I am missing something.

And if I am correct, it is a shame---after all, the point of the
merge-trees command is to take three trees and run a three-way
merge, and not being able to merge three "trees" and require
"commits" makes this mode much less useful than its potential.
