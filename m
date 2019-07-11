Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 068781F461
	for <e@80x24.org>; Thu, 11 Jul 2019 21:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfGKVXv (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 17:23:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63634 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfGKVXv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 17:23:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C705014A1A8;
        Thu, 11 Jul 2019 17:23:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SNd1S07O5Y1toPc+hwomZUnKR2I=; b=eWC9PO
        7IldLPw0M+bEjP/YVJ7iYtBqBVN99kWr2Qd2LiNZnHZXGeteBN1KX+X9xuXWBvZ1
        8wutFcvelZUAONTngn5JfBQAvIkN/gIi4qxzfp8HBdhaQS67FSfsKNvPBO24pxEK
        YBH1aJFwUtpPR6JeXOYgX6ByGzvnTfp3M9GbE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jGGfvB3t0HhBVjNhg9gRHfAS+mbPVKg/
        Xl3C5Y/lPArQz0pJBu2M6KEnHU0EAHEAZ5QjVIoxYDSB/SJX9MWJ2x9NnWM/Hrei
        Ux+VWSkcErdpIVanqOwjd4it8kEqbqKEkNMX0yPab3/jlHGbvhfq7cb1YVKhOJnd
        ewzk9KmlqJI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF6C114A1A7;
        Thu, 11 Jul 2019 17:23:45 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D5B914A1A5;
        Thu, 11 Jul 2019 17:23:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Martin Nicolay <m.nicolay@osm-ag.de>, git@vger.kernel.org
Subject: Re: [PATCH] stash: fix handling removed files with --keep-index
References: <alpine.LSU.2.20.1907111452560.3570@cpza.bfz-tzou.qr>
        <20190711174828.GF15477@hank.intra.tgummerer.com>
Date:   Thu, 11 Jul 2019 14:23:44 -0700
In-Reply-To: <20190711174828.GF15477@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Thu, 11 Jul 2019 18:48:28 +0100")
Message-ID: <xmqqims8qn8f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A0033AA-A422-11E9-88CF-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Fix that behaviour by using 'git restore' which can faithfully restore
> the index and working tree.  This also simplifies the code.

Hmph.  I would have preferred to see we stayed away from 'restore'
(and used 'checkout' instead, if you must use a Porcelain command),
so that the "fix" can go to maintenance tracks, if distro packagers
choose to backport it.

Isn't the machinery for "git status" (in wt-status.c) mature enough
to allow us to learn what got changed all in-core, without spawning
an external process these days, though?

>  		if (keep_index == 1 && !is_null_oid(&info.i_tree)) {
> -			struct child_process cp_ls = CHILD_PROCESS_INIT;
> -			struct child_process cp_checkout = CHILD_PROCESS_INIT;
> -			struct strbuf out = STRBUF_INIT;
> -
> -			if (reset_tree(&info.i_tree, 0, 1)) {
> -				ret = -1;
> -				goto done;
> -			}
> -
> -			cp_ls.git_cmd = 1;
> -			argv_array_pushl(&cp_ls.args, "ls-files", "-z",
> -					 "--modified", "--", NULL);
> -
> -			add_pathspecs(&cp_ls.args, ps);
> -			if (pipe_command(&cp_ls, NULL, 0, &out, 0, NULL, 0)) {
> -				ret = -1;
> -				goto done;
> -			}
> -
> -			cp_checkout.git_cmd = 1;
> -			argv_array_pushl(&cp_checkout.args, "checkout-index",
> -					 "-z", "--force", "--stdin", NULL);
> -			if (pipe_command(&cp_checkout, out.buf, out.len, NULL,
> -					 0, NULL, 0)) {
> +			struct child_process cp_restore = CHILD_PROCESS_INIT;
> +
> +			cp_restore.git_cmd = 1;
> +			argv_array_pushl(&cp_restore.args, "restore", "--source", oid_to_hex(&info.i_tree),
> +					 "--staged", "--worktree", NULL);
> +			if (!ps->nr)
> +				argv_array_push(&cp_restore.args, ".");
> +			else
> +				add_pathspecs(&cp_restore.args, ps);
> +			if (run_command(&cp_restore)) {
>  				ret = -1;
>  				goto done;
>  			}
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index b22e671608..b8e337893f 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -1234,4 +1234,11 @@ test_expect_success 'stash works when user.name and user.email are not set' '
>  	)
>  '
>  
> +test_expect_success 'stash --keep-index with file deleted in index does not resurrect it on disk' '
> +	test_commit to-remove to-remove &&
> +	git rm to-remove &&
> +	git stash --keep-index &&
> +	test_path_is_missing to-remove
> +'
> +
>  test_done
