Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8BECA0EC7
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 01:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbjILBlX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 21:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbjILBlG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 21:41:06 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06441A3D3A
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 18:18:15 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7EE41AB992;
        Mon, 11 Sep 2023 17:01:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=POxY6Ixt5m0jB26yBT3objdO4Va5ta/H1FIt8d
        1GkF0=; b=qFrURggXddUgRGrFFWecE6GdWUMfBUH0M7Nc1nzIwji7TLegcI1N8I
        RCgZ2rphh7GaAB5RpwbnZO6JjjTDgRaeFyAfKlcHCF/DZ60V9UeSHPos0+spZeiB
        i0elZCq28EiBig7EBOwIsmIHTyxBv9A8ZoJe8SKsP7lDddRIC8weU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BED9F1AB991;
        Mon, 11 Sep 2023 17:01:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 235F71AB990;
        Mon, 11 Sep 2023 17:01:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] diff-merges: introduce '-d' option
In-Reply-To: <20230909125446.142715-3-sorganov@gmail.com> (Sergey Organov's
        message of "Sat, 9 Sep 2023 15:54:46 +0300")
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20230909125446.142715-3-sorganov@gmail.com>
Date:   Mon, 11 Sep 2023 14:01:15 -0700
Message-ID: <xmqqtts0tof8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 590A4A62-50E6-11EE-AAFA-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> This option provides a shortcut to request diff with respect to first
> parent for any kind of commit, universally. It's implemented as pure
> synonym for "--diff-merges=first-parent --patch".
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---

Sounds very straight-forward.

Given that "--first-parent" in "git log --first-parent -p" already
defeats "-m" and shows the diff against the first parent only,
people may find it confusing if "git log -d" does not act as a
shorthand for that.  From the above and also from the documentation
update, it is hard to tell if that is what you implemented, or it
only affects the "diff-merges" part.

Other than that, the patch looks quite small and to the point.

Thanks.

>  Documentation/diff-options.txt | 4 ++++
>  Documentation/git-log.txt      | 2 +-
>  diff-merges.c                  | 3 +++
>  t/t4013-diff-various.sh        | 8 ++++++++
>  4 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index f93aa3e46a52..d773dafcb10a 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -51,6 +51,10 @@ ifdef::git-log[]
>  Note: This option not implying `-p` is legacy feature that is
>  preserved for the sake of backward compatibility.
>  
> +-d::
> +	Produce diff with respect to first parent.
> +	Shortcut for '--diff-merges=first-parent -p'.
> +
>  -c::
>  	Produce combined diff output for merge commits.
>  	Shortcut for '--diff-merges=combined -p'.
> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index 9b7ec96e767a..59bd74a1a596 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -120,7 +120,7 @@ By default, `git log` does not generate any diff output. The options
>  below can be used to show the changes made by each commit.
>  
>  Note that unless one of `--diff-merges` variants (including short
> -`-m`, `-c`, and `--cc` options) is explicitly given, merge commits
> +`-d`, `-m`, `-c`, and `--cc` options) is explicitly given, merge commits
>  will not show a diff, even if a diff format like `--patch` is
>  selected, nor will they match search options like `-S`. The exception
>  is when `--first-parent` is in use, in which case `first-parent` is
> diff --git a/diff-merges.c b/diff-merges.c
> index ec97616db1df..6eb72e6fc28a 100644
> --- a/diff-merges.c
> +++ b/diff-merges.c
> @@ -125,6 +125,9 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
>  	if (!suppress_m_parsing && !strcmp(arg, "-m")) {
>  		set_to_default(revs);
>  		revs->merges_need_diff = 0;
> +	} else if (!strcmp(arg, "-d")) {
> +		set_first_parent(revs);
> +		revs->merges_imply_patch = 1;
>  	} else if (!strcmp(arg, "-c")) {
>  		set_combined(revs);
>  		revs->merges_imply_patch = 1;
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 5de1d190759f..a07d6eb6dd97 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -473,6 +473,14 @@ test_expect_success 'log --diff-merges=on matches --diff-merges=separate' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'log -d matches --diff-merges=1 -p' '
> +	git log --diff-merges=1 -p master >result &&
> +	process_diffs result >expected &&
> +	git log -d master >result &&
> +	process_diffs result >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'deny wrong log.diffMerges config' '
>  	test_config log.diffMerges wrong-value &&
>  	test_expect_code 128 git log
