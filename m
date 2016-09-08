Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74C7B1F856
	for <e@80x24.org>; Thu,  8 Sep 2016 21:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753151AbcIHVWg (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 17:22:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60858 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751455AbcIHVWf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 17:22:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 399693BDFA;
        Thu,  8 Sep 2016 17:22:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D1X1KP0zTwAbAlryZZ6xsawk6rY=; b=xAuOiO
        Rt5/0rxCc6+esrMJIfTjnGpqr1fsUyjcEWLQKS+9n1K4EkDAjmwX8ty1+8l5p+kf
        OFdvMP3DthtQstlViJSzminrJLtho4gPBWFaNQkAEg/DcrNeLOocivD7BPWGiStg
        GsrR5fG7T2Phf+wRoZIG2TeYyA6YB238dYphE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lxBZPg/ZUXR6OYMsQC0ApTl5KLpmmGkq
        A9wXXwy6MgdsuUpsxpJ/fZRfZypsNgbEGA6QDtR/VPAZOQPtqhrMNpdAatFIxbkr
        M+iRmwRmIO/8Ej0CKh6qgYQ9ILtDVmq5zXs0htqhFVE0Hx7Ipr471bg3zryjwST9
        hSD1pewNfgY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 31CEE3BDF9;
        Thu,  8 Sep 2016 17:22:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EE6183BDF8;
        Thu,  8 Sep 2016 17:22:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, =peartben@gmail.com,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH] checkout: eliminate unnecessary merge for trivial checkout
References: <20160908204431.14612-1-benpeart@microsoft.com>
Date:   Thu, 08 Sep 2016 14:22:16 -0700
In-Reply-To: <20160908204431.14612-1-benpeart@microsoft.com> (Ben Peart's
        message of "Thu, 8 Sep 2016 16:44:31 -0400")
Message-ID: <xmqqh99qf5o7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 594BD450-760A-11E6-959A-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> Teach git to avoid unnecessary merge during trivial checkout.  When
> running 'git checkout -b foo' git follows a common code path through
> the expensive merge_working_tree even when it is unnecessary.

I would be lying if I said I am not sympathetic to the cause, but...

> +	/*
> +	 * Optimize the performance of checkout when the current and
> +	 * new branch have the same OID and avoid the trivial merge.
> +	 * For example, a "git checkout -b foo" just needs to create
> +	 * the new ref and report the stats.
> +	 */
> +	if (!old.commit || !new->commit
> +		|| oidcmp(&old.commit->object.oid, &new->commit->object.oid)
> +		|| !opts->new_branch || opts->new_branch_force || opts->new_orphan_branch
> +		|| opts->patch_mode || opts->merge || opts->force || opts->force_detach
> +		|| opts->writeout_stage || !opts->overwrite_ignore
> +		|| opts->ignore_skipworktree || opts->ignore_other_worktrees
> +		|| opts->new_branch_log || opts->branch_exists || opts->prefix
> +		|| opts->source_tree) {

... this is a maintenance nightmare in that any new option we will
add later will need to consider what this "optimization" is trying
(not) to skip.  The first two lines (i.e. we need a real checkout if
we cannot positively say that old and new commits are the same
object) are clear, but no explanation was given for all the other
random conditions this if condition checks.  What if opts->something
was not listed (or "listed" for that matter) in the list above--it
is totally unclear if it was missed by mistake (or "added by
mistake") or deliberately excluded (or "deliberately added").

For example, why is opts->prefix there?  If

	git checkout -b new-branch HEAD

should be able to omit the two-way merge, shouldn't

	cd t && git checkout -b new-branch HEAD

also be able to?

Even the main condition is unclear.  It wants to see that old and
new have exactly the same commit, but shouldn't the "the result of
the two-way merge is known to be no-op" logic equally apply if the
old and two trees are the same?




