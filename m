Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D417C432C3
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 06:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EEA20714
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 06:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QwfHA1Sz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfKVGwl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:52:41 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61161 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfKVGwl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 01:52:41 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 52C428DADF;
        Fri, 22 Nov 2019 01:52:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m4R+af9Py4Qz1zCUhySodZ6OUYg=; b=QwfHA1
        Sze5OhH2Gi3UHlH2ZznP3vuE5d7BYuelpRkiN+5AGA0FS6G0tSG3fj8vSvaxaW1g
        ZXLCpJpm18C8yINqRCFcJtpgbLOY5sXRcEfxENoPmzkPPe/NfBdz+aR82cNZiYVn
        djF1U/6/3Y9j1eRg+QsI6FUonuF/LK+1Xqnk8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DkPduHERoBNSBe5nuVs8M4ZA0wAGtBhN
        TXJQW84VvIocgvf0+zalSgMhtoNGs6YVPwRMwkTpC3BSN5RfKWAwihPep0qW9wSN
        Zou7cDwGiWeHSlH0qBkuTIVoYO5r/tGLXPGCVETahsG6ljRtxiDHqLhy7LNUTy8l
        GXaLdPnelk4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 49BCD8DADE;
        Fri, 22 Nov 2019 01:52:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 733A28DADB;
        Fri, 22 Nov 2019 01:52:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/1] sequencer: fix empty commit check when amending
References: <pull.467.git.1574345181.gitgitgadget@gmail.com>
        <7d34c0ff805b8637b23d0ef0045370dfc931a3af.1574345181.git.gitgitgadget@gmail.com>
Date:   Fri, 22 Nov 2019 15:52:34 +0900
In-Reply-To: <7d34c0ff805b8637b23d0ef0045370dfc931a3af.1574345181.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Thu, 21 Nov 2019 14:06:21
        +0000")
Message-ID: <xmqqblt44d3h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AAC5FE62-0CF4-11EA-9647-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	if (!(flags & ALLOW_EMPTY)) {
> +		struct commit *first_parent = current_head;

I would have used first_parent_tree variable instead here.  That
way, you did not have to have an overlong ternary expression down
there, I expect.

> +		if (flags & AMEND_MSG) {
> +			if (current_head->parents) {
> +				first_parent = current_head->parents->item;
> +				if (repo_parse_commit(r, first_parent)) {
> +					res = error(_("could not parse HEAD commit"));
> +					goto out;
> +				}
> +			} else {
> +				first_parent = NULL;
> +			}
> +		}
> +		if (oideq(first_parent ? get_commit_tree_oid(first_parent) :
> +					 the_hash_algo->empty_tree, &tree)) {

Style.  It often makes the code much easier to read when you strive
to break lines at the boundary of larger syntactic units.  In this
(A ? B : C, D) parameter list, ternary A ? B : C binds much tighter
than the comma after it, so if you are breaking line inside it, you
should break line after the comma, too, i.e.

	oideq(first_parent
	      ? get_commit_tree_oid(first_parent)
	      : the_hash_algo->empty_tree,
	      &tree)

to avoid appearing if C and D have closer relationship than B and C,
which your version gives.

But I hope that it becomes a moot point, if we computed first_parent_tree
inside the new "if (flags & AMEND_MSG)" block to leave this oideq()
just

	if (oideq(first_parent_tree, &tree)) {

