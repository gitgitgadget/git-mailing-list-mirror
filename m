Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD6FC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 22:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239610AbhKVW0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:26:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52549 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238083AbhKVW0J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 17:26:09 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6622DE97E1;
        Mon, 22 Nov 2021 17:23:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=xJepxZxzx9mYNR53Abu+HySNgpsoldDnE2Vgzm7c8ro=; b=Pmbb
        OJax3M2kVGk44NCXQR4mJbVbrXFu9WdJ822SKotwyfZcSnJ8oCUUwE0OXRIbc/QA
        9wpBHZijKSNWgOOtODIeSat9Iks7VKvw6C7Mg3LTiSHWjZHBlKy20qaM6SnSK8QG
        EBdrwNHW/fMTnQ9ai2wEgB+AMUuNxfu+Zwq9huE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4EDB7E97E0;
        Mon, 22 Nov 2021 17:23:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7FF79E97DF;
        Mon, 22 Nov 2021 17:23:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 1/4] show-branch: show reflog message
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
        <fd2595d370a8a257c44693fdc98194cd8447e22a.1637590855.git.gitgitgadget@gmail.com>
Date:   Mon, 22 Nov 2021 14:22:59 -0800
Message-ID: <xmqqee77de4c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0789862-4BE2-11EC-9C29-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Before, --reflog option would look for '\t' in the reflog message. As refs.c
> already parses the reflog line, the '\t' was never found, and show-branch
> --reflog would always say "(none)" as reflog message

Well spotted.  It may show that nobody pays attention to output from
"show-branch -g" (or nobody runs it in the first place), but it is
good to fix it anyway.

Thanks.

>
> Add test.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  builtin/show-branch.c  | 12 +++++++-----
>  t/t3202-show-branch.sh | 15 +++++++++++++++
>  2 files changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/show-branch.c b/builtin/show-branch.c
> index 082449293b5..f1e8318592c 100644
> --- a/builtin/show-branch.c
> +++ b/builtin/show-branch.c
> @@ -761,6 +761,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
>  			char *logmsg;
>  			char *nth_desc;
>  			const char *msg;
> +			char *end;
>  			timestamp_t timestamp;
>  			int tz;
>  
> @@ -770,11 +771,12 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
>  				reflog = i;
>  				break;
>  			}
> -			msg = strchr(logmsg, '\t');
> -			if (!msg)
> -				msg = "(none)";
> -			else
> -				msg++;
> +
> +			end = strchr(logmsg, '\n');
> +			if (end)
> +				*end = '\0';
> +
> +			msg = (*logmsg == '\0') ? "(none)" : logmsg;
>  			reflog_msg[i] = xstrfmt("(%s) %s",
>  						show_date(timestamp, tz,
>  							  DATE_MODE(RELATIVE)),
> diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
> index ad9902a06b9..d4d64401e4b 100755
> --- a/t/t3202-show-branch.sh
> +++ b/t/t3202-show-branch.sh
> @@ -4,6 +4,9 @@ test_description='test show-branch'
>  
>  . ./test-lib.sh
>  
> +# arbitrary reference time: 2009-08-30 19:20:00
> +GIT_TEST_DATE_NOW=1251660000; export GIT_TEST_DATE_NOW
> +
>  test_expect_success 'setup' '
>  	test_commit initial &&
>  	for i in $(test_seq 1 10)
> @@ -146,4 +149,16 @@ test_expect_success 'show branch --merge-base with N arguments' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'show branch --reflog=2' '
> +	sed "s/^>	//" >expect <<-\EOF &&
> +	>	! [refs/heads/branch10@{0}] (4 years, 5 months ago) commit: branch10
> +	>	 ! [refs/heads/branch10@{1}] (4 years, 5 months ago) commit: branch10
> +	>	--
> +	>	+  [refs/heads/branch10@{0}] branch10
> +	>	++ [refs/heads/branch10@{1}] initial
> +	EOF
> +	git show-branch --reflog=2 >actual &&
> +	test_cmp actual expect
> +'
> +
>  test_done
