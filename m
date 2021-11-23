Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B509C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 22:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239565AbhKWWtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 17:49:24 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52245 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239023AbhKWWtX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 17:49:23 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 37EA815F1F4;
        Tue, 23 Nov 2021 17:46:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IxLAyi05Uok/ZQ21ABPEAJphN/0NQsEgX0KUY0
        axtX8=; b=iOEMp+ImZty2773doMaUl2pgL8Po50qvVNjxbAnaNiNieeAy3GG1Bd
        1VAjMRhPls49ePWwqkznL/DNC1ft1Dz+/T4hmzQxNXmNUlDURdr1ABNhJLRxk/DO
        JR5ZNu5+yWNrhFsspoVlGNsNyDRa/5PkIR315c3W6prKXy/FGXQ+Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 30D9B15F1F3;
        Tue, 23 Nov 2021 17:46:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6C1B615F1F0;
        Tue, 23 Nov 2021 17:46:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 1/4] submodule-config: add submodules_of_tree() helper
References: <20211122223252.19922-1-chooglen@google.com>
        <20211122223252.19922-2-chooglen@google.com>
Date:   Tue, 23 Nov 2021 14:46:10 -0800
In-Reply-To: <20211122223252.19922-2-chooglen@google.com> (Glen Choo's message
        of "Mon, 22 Nov 2021 14:32:49 -0800")
Message-ID: <xmqqh7c27aod.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27EEEABA-4CAF-11EC-B5B5-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> +struct submodule_entry_list *
> +submodules_of_tree(struct repository *r, const struct object_id *treeish_name)
> +{
> +	struct tree_desc tree;
> +	struct name_entry entry;
> +	struct submodule_entry_list *ret;
> +
> +	CALLOC_ARRAY(ret, 1);
> +	fill_tree_descriptor(r, &tree, treeish_name);
> +	while (tree_entry(&tree, &entry)) {
> +		if (!S_ISGITLINK(entry.mode))
> +			continue;
> +		ALLOC_GROW(ret->name_entries, ret->entry_nr + 1, ret->entry_alloc);
> +		ret->name_entries[ret->entry_nr++] = entry;
> +	}
> +	return ret;
> +}

This only looks at the root level of the tree, doesn't it?  Without
any caller in the same step, it is impossible to tell if that is an
outright bug, or merely an incomplete code that will gain recursion
in a later step.

If it is the latter, I do not think that is a patch series
organization that is very friendly to reviewers.


