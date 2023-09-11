Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D350ECA0ECD
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 03:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbjILDUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 23:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235632AbjILDQG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 23:16:06 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C7190F36
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 16:11:40 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 14A9D38C54;
        Mon, 11 Sep 2023 18:53:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Zh7DuGn9cc497cgPB+d4YVPtmVeuMoSVi/7FPx
        H/PFw=; b=ozRN0e+uRqH+E3d9gmuylN58JkLgA8WWpGWirsKP0L8EDCCuJjWC2l
        lVk8BepZ5EsJxUCkhaw8NfJUVSN0MI8Rs23fmvLLN/MVmdqwNdRCz8DOu5eK8HLt
        Jt6FTr2wYwQZyiVpRvGNAk5iRoYHBjDJ/35qyfnd1eoZ311XQBv2I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EE3B838C53;
        Mon, 11 Sep 2023 18:53:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 50AF438C52;
        Mon, 11 Sep 2023 18:53:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josip Sokcevic <sokcevic@google.com>
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH v3] diff-lib: Fix check_removed when fsmonitor is on
In-Reply-To: <20230911170901.49050-2-sokcevic@google.com> (Josip Sokcevic's
        message of "Mon, 11 Sep 2023 10:09:02 -0700")
References: <20230906060241.944886-2-sokcevic@google.com>
        <20230911170901.49050-2-sokcevic@google.com>
Date:   Mon, 11 Sep 2023 15:53:32 -0700
Message-ID: <xmqqsf7ks4nn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 094FE698-50F6-11EE-8A0A-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josip Sokcevic <sokcevic@google.com> writes:

> git-diff-index may return incorrect deleted entries when fsmonitor is used in a
> repository with git submodules. This can be observed on Mac machines, but it
> can affect all other supported platforms too.
>
> If fsmonitor is used, `stat *st` is not initialized if cache_entry has
> CE_FSMONITOR_VALID set. But, there are three call sites that rely on stat
> afterwards, which can result in incorrect results.
>
> This change partially reverts commit 4f3d6d0.
>
> Signed-off-by: Josip Sokcevic <sokcevic@google.com>
> ---
>  diff-lib.c                   | 12 ++++++------
>  t/t7527-builtin-fsmonitor.sh |  5 +++++
>  2 files changed, 11 insertions(+), 6 deletions(-)

This certainly is more "complete" if simpler than the previous one
;-)

In the longer term, we would probably want to enable optimization
using what fsmonitor knows, but as we have seen in the review on
the previous round, this code needs a bit more work than the
original we are reverting here to get it right, and in the shorter
term, hopefully this would do.

Thanks.

> diff --git a/diff-lib.c b/diff-lib.c
> index d8aa777a73..5848e4f9ca 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -36,14 +36,14 @@
>   * exists for ce that is a submodule -- it is a submodule that is not
>   * checked out).  Return negative for an error.
>   */
> -static int check_removed(const struct index_state *istate, const struct cache_entry *ce, struct stat *st)
> +static int check_removed(const struct cache_entry *ce, struct stat *st)
>  {
> -	assert(is_fsmonitor_refreshed(istate));
> -	if (!(ce->ce_flags & CE_FSMONITOR_VALID) && lstat(ce->name, st) < 0) {
> +	if (lstat(ce->name, st) < 0) {
>  		if (!is_missing_file_error(errno))
>  			return -1;
>  		return 1;
>  	}
> +
>  	if (has_symlink_leading_path(ce->name, ce_namelen(ce)))
>  		return 1;
>  	if (S_ISDIR(st->st_mode)) {
> @@ -149,7 +149,7 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
>  			memset(&(dpath->parent[0]), 0,
>  			       sizeof(struct combine_diff_parent)*5);
>  
> -			changed = check_removed(istate, ce, &st);
> +			changed = check_removed(ce, &st);
>  			if (!changed)
>  				wt_mode = ce_mode_from_stat(ce, st.st_mode);
>  			else {
> @@ -229,7 +229,7 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
>  		} else {
>  			struct stat st;
>  
> -			changed = check_removed(istate, ce, &st);
> +			changed = check_removed(ce, &st);
>  			if (changed) {
>  				if (changed < 0) {
>  					perror(ce->name);
> @@ -303,7 +303,7 @@ static int get_stat_data(const struct index_state *istate,
>  	if (!cached && !ce_uptodate(ce)) {
>  		int changed;
>  		struct stat st;
> -		changed = check_removed(istate, ce, &st);
> +		changed = check_removed(ce, &st);
>  		if (changed < 0)
>  			return -1;
>  		else if (changed) {
> diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
> index 0c241d6c14..78503158fd 100755
> --- a/t/t7527-builtin-fsmonitor.sh
> +++ b/t/t7527-builtin-fsmonitor.sh
> @@ -809,6 +809,11 @@ my_match_and_clean () {
>  		status --porcelain=v2 >actual.without &&
>  	test_cmp actual.with actual.without &&
>  
> +	git -C super --no-optional-locks diff-index --name-status HEAD >actual.with &&
> +	git -C super --no-optional-locks -c core.fsmonitor=false \
> +		diff-index --name-status HEAD >actual.without &&
> +	test_cmp actual.with actual.without &&
> +
>  	git -C super/dir_1/dir_2/sub reset --hard &&
>  	git -C super/dir_1/dir_2/sub clean -d -f
>  }
