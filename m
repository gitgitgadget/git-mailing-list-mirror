Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0012C433EF
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 21:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbiAPVqq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 16:46:46 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61400 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbiAPVqq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 16:46:46 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A2C6817ED04;
        Sun, 16 Jan 2022 16:46:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KdgJk9vtPOfvynlKhw2oXV8RdNmhQ4ftuJQKOa
        19UCM=; b=PV1znqTFI8DAPJZKu1nwCkZK+ASEPQluVMHVUGr8HuMLQCM7GBV+io
        h354UPyu/ZgsQcAgWhffycoA9p+agstu+M7iCzNEDHHc3Wrt5E+GUFDgAWsosxV1
        74jjlNOErx5McDIlUM52dJd+93rWUH6DCRswRK1e8NvufBTKdf2vs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9A60F17ED03;
        Sun, 16 Jan 2022 16:46:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A890117ED02;
        Sun, 16 Jan 2022 16:46:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] merge-ort: avoid assuming all renames detected
References: <pull.1194.git.git.1642212566346.gitgitgadget@gmail.com>
Date:   Sun, 16 Jan 2022 13:46:40 -0800
In-Reply-To: <pull.1194.git.git.1642212566346.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Sat, 15 Jan 2022 02:09:26
        +0000")
Message-ID: <xmqqczkr1hhb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA7FF6C6-7715-11EC-B8E7-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> In commit 8b09a900a1 ("merge-ort: restart merge with cached renames to
> reduce process entry cost", 2021-07-16), we noted that in the merge-ort
> steps of
>     collect_merge_info()
>     detect_and_process_renames()
>     process_entries()
> that process_entries() was expensive, and we could often make it cheaper
> by changing this to
>     collect_merge_info()
>     detect_and_process_renames()
>     <cache all the renames, and restart>
>     collect_merge_info()
>     detect_and_process_renames()
>     process_entries()
> because the second collect_merge_info() would be cheaper (we could avoid
> traversing into some directories), the second
> detect_and_process_renames() would be free since we had already detected
> all renames, and then process_entries() has far fewer entries to handle.
>
> However, this was built on the assumption that the first
> detect_and_process_renames() actually detected all potential renames.
> If someone has merge.renameLimit set to some small value, that
> assumption is violated which manifests later with the following message:
>
>     $ git -c merge.renameLimit=1 rebase upstream
>     ...
>     git: merge-ort.c:546: clear_or_reinit_internal_opts: Assertion
>     `renames->cached_pairs_valid_side == 0' failed.
>
> Turn off this cache-renames-and-restart whenever we cannot detect all
> renames, and add a testcase that would have caught this problem.
>
> Reported-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---

Thanks.  Will fork from maint-2.33 and park on 'seen' for now.
