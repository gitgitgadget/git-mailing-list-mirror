Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AF891F991
	for <e@80x24.org>; Thu,  3 Aug 2017 20:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbdHCUks (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 16:40:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52519 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751656AbdHCUkr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 16:40:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 49AB28B5E4;
        Thu,  3 Aug 2017 16:40:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yg9OnLsRH1ozLML31x+uQuxTtu0=; b=ttF9C6
        oDk1gXscAYhtR6pG1KPODLDm7iUocg3btZZHbEdlK1J486GGSyn4lXEKCK2QQov8
        FIeaKHq9MWIsOgT5/Q7HZdCvk+TZCnEbH2FbNjGsU3frjD0PCXpzE39L8tmZuWdN
        BP41zXInyS0+KjCxKkuP1El7i82nOrZVEo7fI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XInP2w+sCX67nepiN/vVpifBy9uBKh5T
        nIe5Iw/MQGMKkPO/b8Pdw/zI9wsFvtdi2QHwqHbQD9ApE1cXWkWMRE6eNNM3RC6S
        BYomxugmhyilNTN9JRLcRF3aOQ/j/EALW3MYNtQp2zkAVX3cZHKtoBquK4ujd3AU
        qfkwjZ7YUrQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4253D8B5E3;
        Thu,  3 Aug 2017 16:40:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A9438B5E1;
        Thu,  3 Aug 2017 16:40:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        Jens.Lehmann@web.de
Subject: Re: [PATCH v2 10/15] diff: stop allowing diff to have submodules configured in .git/config
References: <20170725213928.125998-1-bmwill@google.com>
        <20170803182000.179328-1-bmwill@google.com>
        <20170803182000.179328-11-bmwill@google.com>
Date:   Thu, 03 Aug 2017 13:40:38 -0700
In-Reply-To: <20170803182000.179328-11-bmwill@google.com> (Brandon Williams's
        message of "Thu, 3 Aug 2017 11:19:55 -0700")
Message-ID: <xmqqlgn0wfjt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02D749D0-788C-11E7-82CA-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Traditionally a submodule is comprised of a gitlink as well as a
> corresponding entry in the .gitmodules file.  Diff doesn't follow this
> paradigm as its config callback routine falls back to populating the
> submodule-config if a config entry starts with 'submodule.'.
>
> Remove this behavior in order to be consistent with how the
> submodule-config is populated, via calling 'gitmodules_config()' or
> 'repo_read_gitmodules()'.

I am all for dropping special cases deep in the diff machinery, even
though there may be submodule users who care about submodule.*.ignore

Does this change mean we can eventually get rid of the ugly
DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG hack and also need for a patch
like 03/15?

>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  diff.c                    |  3 ---
>  t/t4027-diff-submodule.sh | 67 -----------------------------------------------
>  2 files changed, 70 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 85e714f6c..e43519b88 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -346,9 +346,6 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
>  
> -	if (starts_with(var, "submodule."))
> -		return parse_submodule_config_option(var, value);
> -
>  	if (git_diff_heuristic_config(var, value, cb) < 0)
>  		return -1;
>  
> diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
> index 518bf9524..2ffd11a14 100755
> --- a/t/t4027-diff-submodule.sh
> +++ b/t/t4027-diff-submodule.sh
> @@ -113,35 +113,6 @@ test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match)'
>  	! test -s actual4
>  '
>  
> -test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match) [.git/config]' '
> -	git config diff.ignoreSubmodules all &&
> -	git diff HEAD >actual &&
> -	! test -s actual &&
> -	git config submodule.subname.ignore none &&
> -	git config submodule.subname.path sub &&
> -	git diff HEAD >actual &&
> -	sed -e "1,/^@@/d" actual >actual.body &&
> -	expect_from_to >expect.body $subprev $subprev-dirty &&
> -	test_cmp expect.body actual.body &&
> -	git config submodule.subname.ignore all &&
> -	git diff HEAD >actual2 &&
> -	! test -s actual2 &&
> -	git config submodule.subname.ignore untracked &&
> -	git diff HEAD >actual3 &&
> -	sed -e "1,/^@@/d" actual3 >actual3.body &&
> -	expect_from_to >expect.body $subprev $subprev-dirty &&
> -	test_cmp expect.body actual3.body &&
> -	git config submodule.subname.ignore dirty &&
> -	git diff HEAD >actual4 &&
> -	! test -s actual4 &&
> -	git diff HEAD --ignore-submodules=none >actual &&
> -	sed -e "1,/^@@/d" actual >actual.body &&
> -	expect_from_to >expect.body $subprev $subprev-dirty &&
> -	test_cmp expect.body actual.body &&
> -	git config --remove-section submodule.subname &&
> -	git config --unset diff.ignoreSubmodules
> -'
> -
>  test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match) [.gitmodules]' '
>  	git config diff.ignoreSubmodules dirty &&
>  	git diff HEAD >actual &&
> @@ -208,24 +179,6 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match)'
>  	! test -s actual4
>  '
>  
> -test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match) [.git/config]' '
> -	git config submodule.subname.ignore all &&
> -	git config submodule.subname.path sub &&
> -	git diff HEAD >actual2 &&
> -	! test -s actual2 &&
> -	git config submodule.subname.ignore untracked &&
> -	git diff HEAD >actual3 &&
> -	! test -s actual3 &&
> -	git config submodule.subname.ignore dirty &&
> -	git diff HEAD >actual4 &&
> -	! test -s actual4 &&
> -	git diff --ignore-submodules=none HEAD >actual &&
> -	sed -e "1,/^@@/d" actual >actual.body &&
> -	expect_from_to >expect.body $subprev $subprev-dirty &&
> -	test_cmp expect.body actual.body &&
> -	git config --remove-section submodule.subname
> -'
> -
>  test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match) [.gitmodules]' '
>  	git config --add -f .gitmodules submodule.subname.ignore all &&
>  	git config --add -f .gitmodules submodule.subname.path sub &&
> @@ -261,26 +214,6 @@ test_expect_success 'git diff between submodule commits' '
>  	! test -s actual
>  '
>  
> -test_expect_success 'git diff between submodule commits [.git/config]' '
> -	git diff HEAD^..HEAD >actual &&
> -	sed -e "1,/^@@/d" actual >actual.body &&
> -	expect_from_to >expect.body $subtip $subprev &&
> -	test_cmp expect.body actual.body &&
> -	git config submodule.subname.ignore dirty &&
> -	git config submodule.subname.path sub &&
> -	git diff HEAD^..HEAD >actual &&
> -	sed -e "1,/^@@/d" actual >actual.body &&
> -	expect_from_to >expect.body $subtip $subprev &&
> -	test_cmp expect.body actual.body &&
> -	git config submodule.subname.ignore all &&
> -	git diff HEAD^..HEAD >actual &&
> -	! test -s actual &&
> -	git diff --ignore-submodules=dirty HEAD^..HEAD >actual &&
> -	sed -e "1,/^@@/d" actual >actual.body &&
> -	expect_from_to >expect.body $subtip $subprev &&
> -	git config --remove-section submodule.subname
> -'
> -
>  test_expect_success 'git diff between submodule commits [.gitmodules]' '
>  	git diff HEAD^..HEAD >actual &&
>  	sed -e "1,/^@@/d" actual >actual.body &&
