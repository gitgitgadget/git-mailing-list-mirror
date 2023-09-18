Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1896ECD3424
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 23:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjIRXbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 19:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIRXbm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 19:31:42 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A1F97
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 16:31:36 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B7C441C0828;
        Mon, 18 Sep 2023 19:31:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=G7JoZQAo6oVfzkezzezynXKkhIOpTxsmvIM5gu
        K1lZU=; b=DEcC1gDRV8YZOavtrtwp8jogmKjXp6t/6DefVfkNzZQrAQtaAHwD24
        +u7Ir6PJi0/q0HXm4vwyu7oBkOsW+dN0GDaaW0Zb5RvBmX+1gkuUK4huNBZhgqpP
        rc9zuZWg4MWTnVe+Rsk0/2IPlkqTQWdpgDV8K/GKUOjFXsSP5aL1k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B0D301C0827;
        Mon, 18 Sep 2023 19:31:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1BF881C0826;
        Mon, 18 Sep 2023 19:31:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Zach FettersMoore via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Zach FettersMoore <zach.fetters@apollographql.com>
Subject: Re: [PATCH] subtree: fix split processing with multiple subtrees
 present
In-Reply-To: <pull.1587.git.1695067516192.gitgitgadget@gmail.com> (Zach
        FettersMoore via GitGitGadget's message of "Mon, 18 Sep 2023 20:05:16
        +0000")
References: <pull.1587.git.1695067516192.gitgitgadget@gmail.com>
Date:   Mon, 18 Sep 2023 16:31:34 -0700
Message-ID: <xmqq34zbjbxl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81A8017C-567B-11EE-9901-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Zach FettersMoore via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>  contrib/subtree/git-subtree.sh | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index e0c5d3b0de6..e9250dfb019 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -778,12 +778,29 @@ ensure_valid_ref_format () {
>  		die "fatal: '$1' does not look like a ref"
>  }
>  
> +# Usage: check if a commit from another subtree should be ignored from processing for splits
> +should_ignore_subtree_commit () {
> +  if [ "$(git log -1 --grep="git-subtree-dir:" $1)" ]
> +  then
> +    if [[ -z "$(git log -1 --grep="git-subtree-mainline:" $1)" && -z "$(git log -1 --grep="git-subtree-dir: $dir$" $1)" ]]
> +    then
> +      return 0
> +    fi
> +  fi
> +  return 1
> +}
>
>  # Usage: process_split_commit REV PARENTS
>  process_split_commit () {
>  	assert test $# = 2
>  	local rev="$1"
>  	local parents="$2"
>  
> +    if should_ignore_subtree_commit $rev
> +    then
> +	    return
> +    fi
> +

Please do not violate Documentation/CodingGuidelines for our shell
scripted Porcelain, even if it is a script in contrib/ and also
please avoid bash-isms.

Also doesn't "subtree" have its own test?  If this change is a fix
for some problem(s), can we have a test or two that demonstrate how
the current code without the patch is broken?

Thanks.

