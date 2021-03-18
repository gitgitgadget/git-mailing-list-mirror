Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757CAC433DB
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 20:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4525C64D74
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 20:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhCRUos (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 16:44:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64164 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhCRUoY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 16:44:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0CEA712377D;
        Thu, 18 Mar 2021 16:44:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WvwRCQLV+Sh63mrtNvivDi5W210=; b=GLX6Cq
        HG2HqSACVztV6oSvmRfxIslQkK9JAJtYlwrQQU/vZlIjk6m+H1P7nD8cswVsZMhJ
        DxuDEuCsff9kI8+rdR/0yR0Dqtok1vTNiGZY+WPDO96tA06GFOsiwViygBrIB9Hk
        CGWS74qzg4BFYuI1QEKSQoa/FPXPFf5154SJU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AZDDtoDvtOf4cwjcAazVjm5iQ7u48dtE
        uJCR48E7UnajtfKfqRTYXEJKMQUh9jVA6kzB/UTGNAtVhdkHfCrHyxJBTAe7OPMd
        5fn8L3NxLLS20+PXANLJMQk2f31E4dP29vU0M86FYry6kNQO5xbJaIVMK5Kj9eMR
        yOo1HmDAjMw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0508312377C;
        Thu, 18 Mar 2021 16:44:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 450D8123777;
        Thu, 18 Mar 2021 16:44:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Subject: Re: [PATCH v2 1/3] fsmonitor: skip lstat deletion check during git
 diff-index
References: <pull.903.git.1615760258.gitgitgadget@gmail.com>
        <pull.903.v2.git.1616016143.gitgitgadget@gmail.com>
        <75a3c46c405549d1f5127097729c556a7e297587.1616016143.git.gitgitgadget@gmail.com>
Date:   Thu, 18 Mar 2021 13:44:19 -0700
In-Reply-To: <75a3c46c405549d1f5127097729c556a7e297587.1616016143.git.gitgitgadget@gmail.com>
        (Nipunn Koorapati via GitGitGadget's message of "Wed, 17 Mar 2021
        21:22:21 +0000")
Message-ID: <xmqqo8fgry3g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7771F8A-882A-11EB-A07B-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Nipunn Koorapati <nipunn@dropbox.com>
>
> Teach git to honor fsmonitor rather than issuing an lstat
> when checking for dirty local deletes. Eliminates O(files)
> lstats during `git diff HEAD`
>
> Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
> ---
>  diff-lib.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/diff-lib.c b/diff-lib.c
> index b73cc1859a49..3fb538ad18e9 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -30,7 +30,7 @@
>   */
>  static int check_removed(const struct cache_entry *ce, struct stat *st)
>  {
> -	if (lstat(ce->name, st) < 0) {
> +	if (!(ce->ce_flags & CE_FSMONITOR_VALID) && lstat(ce->name, st) < 0) {

So when the cache entry is marked as VALID, we know it is there and
unmodified without asking lstat().  Otherwise we ask lstat() as
before.  OK.

>  		if (!is_missing_file_error(errno))
>  			return -1;
>  		return 1;
> @@ -574,6 +574,7 @@ int run_diff_index(struct rev_info *revs, unsigned int option)
>  	struct object_id oid;
>  	const char *name;
>  	char merge_base_hex[GIT_MAX_HEXSZ + 1];
> +	struct index_state *istate = revs->diffopt.repo->index;
>  
>  	if (revs->pending.nr != 1)
>  		BUG("run_diff_index must be passed exactly one tree");
> @@ -581,6 +582,8 @@ int run_diff_index(struct rev_info *revs, unsigned int option)
>  	trace_performance_enter();
>  	ent = revs->pending.objects;
>  
> +	refresh_fsmonitor(istate);

And the VALID bit is set only for the ones that are untouched?  When
core_fsmonitor is not set, or istate->fsmonitor_has_run_once is set,
refresh_fsmonitor() becomes no-op and does not even drop the VALID
bit from the cache entries.  As run_diff_index() is rather
library-ish part of the system, are we sure no earlier attempts to
invoke fsmonitor have touched ce to set the VALID bit on at this
point?

Assuming that we won't see stray VALID bit to confuse us, the patch
looks good to me, but I am not sure what to base confidence on that
assumption.

Thanks.

>  	if (merge_base) {
>  		diff_get_merge_base(revs, &oid);
>  		name = oid_to_hex_r(merge_base_hex, &oid);
