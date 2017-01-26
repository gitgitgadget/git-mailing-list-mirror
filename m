Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DA6F1F794
	for <e@80x24.org>; Thu, 26 Jan 2017 23:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752896AbdAZX6l (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 18:58:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58291 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752811AbdAZX6j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 18:58:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 61602649FD;
        Thu, 26 Jan 2017 18:41:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dIqlrpCGqXDvROLe6DvX9TQUeNg=; b=bhHr3P
        tPKP2O9Z4RNa8BhXVSKFHgabNLJj9KbbctDftmpa3sNYX5+SN8nP41LSVb2bAgWL
        cap3raoYoyjLhq1OJqEMAMgP2cf+ibR696NyE4Mua8KotQmFaqTT6AldrRqDGSs+
        JDMhky1lcWjU8v8RDkxviI52lGRLiNu38B6bI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p2ctYiDVsgwMPmgx3MJm8CnFyl/z7KR0
        GKpMNlbe/1YMJNnCI1J3RoyFdVWDDS2oa6nS5z1mITRU7gc6MdJ+1RVqrKjMj+dP
        PBy/N9c4v/4jxfrwGvZHQlL92Igw/n6Mx7Kcr8IHG3+uBjsDVTgw5HtnXpE/tyYX
        HPqQQCk7CMI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 58DA2649FC;
        Thu, 26 Jan 2017 18:41:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9E624649F7;
        Thu, 26 Jan 2017 18:41:56 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     cornelius.weig@tngtech.com
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] update-ref: add test cases for bare repository
References: <20170126033547.7bszipvkpi2jb4ad@sigill.intra.peff.net>
        <20170126223159.16439-1-cornelius.weig@tngtech.com>
        <20170126223159.16439-3-cornelius.weig@tngtech.com>
Date:   Thu, 26 Jan 2017 15:41:55 -0800
In-Reply-To: <20170126223159.16439-3-cornelius.weig@tngtech.com> (cornelius
        weig's message of "Thu, 26 Jan 2017 23:31:59 +0100")
Message-ID: <xmqqmved1j98.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05F95C48-E421-11E6-A42F-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cornelius.weig@tngtech.com writes:

> From: Cornelius Weig <cornelius.weig@tngtech.com>
>
> The default behavior of update-ref to create reflogs differs in
> repositories with worktree and bare ones. The existing tests cover only
> the behavior of repositories with worktree.
>
> This commit adds tests that assert the correct behavior in bare
> repositories for update-ref. Two cases are covered:
>
>  - If core.logAllRefUpdates is not set, no reflogs should be created
>  - If core.logAllRefUpdates is true, reflogs should be created
>
> Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
> ---
>  t/t1400-update-ref.sh | 43 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 36 insertions(+), 7 deletions(-)
>
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index b9084ca..bad88c8 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -8,23 +8,33 @@ test_description='Test git update-ref and basic ref logging'
>  
>  Z=$_z40
>  
> -test_expect_success setup '
> +m=refs/heads/master
> +n_dir=refs/heads/gu
> +n=$n_dir/fixes
> +outside=refs/foo
> +bare=bare-repo
>  
> +create_test_objects ()
> +{
> +	local T, sha1, prfx="$1"

CodingGuidelines.  Do not use bash-ism "local" (besides, I do not
think you want to have comma here).

>  	for name in A B C D E F
>  	do
>  		test_tick &&
>  		T=$(git write-tree) &&
>  		sha1=$(echo $name | git commit-tree $T) &&
> -		eval $name=$sha1
> +		eval $prfx$name=$sha1
>  	done
> +}
