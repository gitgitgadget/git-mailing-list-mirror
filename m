Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DF8B20756
	for <e@80x24.org>; Fri, 13 Jan 2017 23:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751541AbdAMXmt (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 18:42:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52819 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751347AbdAMXms (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 18:42:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 658E25FBA5;
        Fri, 13 Jan 2017 18:42:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rmicULu2jh77n11d3R3MYiZT7Jg=; b=g0LLdj
        2ZOZZE9rS6Mwtmezv1gzXttQi0ARNWGybX0n47QRCGM2yQXJ/9cmpIahY/7+lB6p
        I60ArKVEidQerd8RFYvMYQDFBTj3IZRFK+cP02leaUKJoYb8nIQAfb4b+YR7visR
        3ezlxXjrtF/KVh9KrbzNkjj0bk5umCAiaMnnE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FezAreOshux6l4PR4cqHr0rO9Ja+E732
        6GbGAy5zd/OJ++jxGebHXLmrOfZnEkxZtFNVw2kfbQkpkuNb5DyAB+DHuRtcjaKh
        cIUWQBcpUJCK8J+irPzNUF/OYzhi8yTvN0k/qyrZHXKMlRw+UUTYN/wSUrnkKSQT
        4a1gungMuHU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B1025FBA4;
        Fri, 13 Jan 2017 18:42:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 823E25FBA3;
        Fri, 13 Jan 2017 18:42:46 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, judge.packham@gmail.com, olsonse@umich.edu,
        git@vger.kernel.org
Subject: Re: [PATCH] submodule update: run custom update script for initial populating as well
References: <20170113194326.13950-1-sbeller@google.com>
Date:   Fri, 13 Jan 2017 15:42:45 -0800
In-Reply-To: <20170113194326.13950-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 13 Jan 2017 11:43:26 -0800")
Message-ID: <xmqqfukmedca.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC5FEADA-D9E9-11E6-96A5-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> In 1b4735d9f3 (submodule: no [--merge|--rebase] when newly cloned,
> 2011-02-17), all actions were defaulted to checkout for populating
> a submodule initially, because merging or rebasing makes no sense
> in that situation.
>
> Other commands however do make sense, such as the custom command
> that was added later (6cb5728c43, submodule update: allow custom
> command to update submodule working tree, 2013-07-03).

Makes sense.

> I am unsure about the "none" command, as I can see an initial
> checkout there as a useful thing. On the other hand going strictly
> by our own documentation, we should do nothing in case of "none"
> as well, because the user asked for it.

I think "none" is "I'll decide which revision of the submodule
should be there---do not decide it for me".  If the user is
explicitly saying with "git submodule init" to have "some" version,
and if the user did not have any (because the user didn't show
interest in any checkout of the submodule before), then I think it
probably makes more sense to checkout the version bound to the
superproject, than leaving the directory empty.

> Reported-by: Han-Wen Nienhuys <hanwen@google.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  git-submodule.sh            |  7 ++++++-
>  t/t7406-submodule-update.sh | 15 +++++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 554bd1c494..aeb721ab7e 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -606,7 +606,12 @@ cmd_update()
>  		if test $just_cloned -eq 1
>  		then
>  			subsha1=
> -			update_module=checkout
> +			if test "$update_module" = "merge" ||
> +			   test "$update_module" = "rebase" ||
> +			   test "$update_module" = "none"
> +			then
> +				update_module=checkout
> +			fi

... which seems to be what you did.  Do we need a documentation
update, or does this just make the behaviour of this corner case
consistent with what is already documented?

Thanks.
