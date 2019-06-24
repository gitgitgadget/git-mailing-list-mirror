Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CB341F461
	for <e@80x24.org>; Mon, 24 Jun 2019 18:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfFXSRC (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 14:17:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50739 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfFXSRC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 14:17:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E55F1164F1E;
        Mon, 24 Jun 2019 14:16:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GoMVwUbyNdoKnhbVFmmpo9RKahM=; b=nzCWo6
        YsEaeDzVnFzjpqfZOVM+ZhAQnYqcFGhv/9xSDmUrYRtYq8mQpvf+IzFRqxEgXrVH
        X6kWYSYTtnQajV+9TqLE6Q0W0mXWRva5z3Cl9Gd3HaJzrLMJVsQ7Zyb1/2idY81S
        3NYVhucIK4jL5sf/D1udf/Pmw7eu7Bs7JJc7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oLPRVlJ+Q0HHhK6Z4Nl/11XgjPE6LKNZ
        zSR1wRiZVO/jSllWJOuiwV05u36tLstRRmdQ6LC/VUfRAvR3kdQhKjs8K752hJkM
        BntBarTY1a9e4sm/AQg7Ydm8emrqDS1ZmMMPLJb1gVBUeAj+yZb6iHrtP9gplmBY
        uHkPkru36lY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DCA12164F1D;
        Mon, 24 Jun 2019 14:16:59 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4F626164F1C;
        Mon, 24 Jun 2019 14:16:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Morian Sonnet <moriansonnet@gmail.com>
Cc:     MorianSonnet@googlemail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, johannes.schindelin@gmx.de,
        sunshine@sunshineco.us
Subject: Re: [PATCH] submodule foreach: fix recursion of options
References: <20190624154050.9943-2-MorianSonnet@googlemail.com>
        <20190624154750.19842-2-MorianSonnet@googlemail.com>
Date:   Mon, 24 Jun 2019 11:16:58 -0700
In-Reply-To: <20190624154750.19842-2-MorianSonnet@googlemail.com> (Morian
        Sonnet's message of "Mon, 24 Jun 2019 17:47:52 +0200")
Message-ID: <xmqqsgryhmqt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41C41002-96AC-11E9-A752-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Morian Sonnet <moriansonnet@gmail.com> writes:

> Calling
>
>     git submodule foreach --recursive <subcommand> --<option>
>
> leads to an error stating that the option --<option> is unknown to
> submodule--helper. That is of course only, when <option> is not a valid
> option for git submodule foreach.
>
> The reason for this is, that above call is internally translated into a
> call to submodule--helper:
>
>     git submodule--helper foreach --recursive \
>         -- <subcommand> --<option>
>
> This call starts by executing the subcommand with its option inside the
> first first level submodule and continues by calling the next iteration

first first???

> of the submodule foreach call
>
>     git --super-prefix <submodulepath> submodule--helper \
>       foreach --recursive <subcommand> --<option>
>
> inside the first level submodule. Note that the double dash in front of
> the subcommand is missing.
>
> This problem starts to arise only recently, as the
> PARSE_OPT_KEEP_UNKNOWN flag for the argument parsing of git submodule
> foreach was removed in commit a282f5a906. Hence, the unknown option is
> complained about now, as the argument parsing is not properly ended by
> the double dash.
>
> This commit fixes the problem by adding the double dash in front of the
> subcommand during the recursion.
>
> Signed-off-by: Morian Sonnet <moriansonnet@googlemail.com>
> ---
>  builtin/submodule--helper.c  | 1 +
>  t/t7407-submodule-foreach.sh | 7 +++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 0bf4aa088e..afaf0819c9 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -540,6 +540,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
>  		if (info->quiet)
>  			argv_array_push(&cpr.args, "--quiet");
>  
> +		argv_array_push(&cpr.args, "--");
>  		argv_array_pushv(&cpr.args, info->argv);
>  
>  		if (run_command(&cpr))
> diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
> index 706ae762e0..43da184d40 100755
> --- a/t/t7407-submodule-foreach.sh
> +++ b/t/t7407-submodule-foreach.sh
> @@ -421,4 +421,11 @@ test_expect_success 'option-like arguments passed to foreach commands are not lo
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'option-like arguments passed to foreach recurse correctly' '
> +  git -C clone2 submodule foreach --recursive "echo be --an-option" > expected &&
> +  git -C clone2 submodule foreach --recursive echo be --an-option > actual &&
> +  grep -e "--an-option" expected &&
> +  test_cmp expected actual
> +'

Some shell style nits.

 - our shell scripts use HT for indentation, not two SPs.

 - there is one SP before a redirection operator (you did it
   correctly), and no SP after a redirection operator before the
   target filename.

 - mostly we prepare the right answer in 'expect' and take the
   output from tested command in 'actual' to compare.  There are a
   few 'expected' in this test file already, so you are not
   introducing a new inconsistency, but you are making things
   worse.  Don't.

Other than that, your fix looks quite nicely described and executed.

Thanks.


