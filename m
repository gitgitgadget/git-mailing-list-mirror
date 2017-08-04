Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E2622047F
	for <e@80x24.org>; Fri,  4 Aug 2017 16:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbdHDQHz (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 12:07:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59156 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752242AbdHDQHy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 12:07:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A3089D466;
        Fri,  4 Aug 2017 12:07:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JB5svLt4UMmdRFUw9zl3SV5H3xU=; b=Qia5Rs
        DxXZTxs0rrQLHXjq5co/r4JYRESx8pH7bZDqFKRVoU1auRnW8PKiYRlZtNdcHKKx
        cMkgxWv0/okW/+ZyYqP5rfbyubys4k4k4b/Pi0ac6XeGt6lSjLb63nofSsBgp7Zk
        VuEeNOgOn4wAFMDLkLUhkUeHWILoyoHmMugE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N/CjU8P+QbBfGDZMRkbaPSnZydLfTD2l
        rOAhg6rGiTctJte3RaC96JqRROZN+5E3aXkV2iGvzBCkyTFOYjLG5K09SPx5wVTY
        fDzG5AueoYaRAzmD2ZLpsZXOSW9c1AFi7BsHs8t4Pagd6G51eqzHHPwwAXtX6ITx
        VOcVrYw1t0s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 00C659D465;
        Fri,  4 Aug 2017 12:07:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 47B6C9D45D;
        Fri,  4 Aug 2017 12:07:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clone: teach recursive clones to respect -q
References: <20170803222544.17216-1-bmwill@google.com>
Date:   Fri, 04 Aug 2017 09:07:52 -0700
In-Reply-To: <20170803222544.17216-1-bmwill@google.com> (Brandon Williams's
        message of "Thu, 3 Aug 2017 15:25:44 -0700")
Message-ID: <xmqqvam3uxif.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 12274B62-792F-11E7-B946-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Teach 'git clone --recurse-submodules' to respect the '-q' option by
> passing down the quiet flag to the process which handles cloning of
> submodules.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  builtin/clone.c            | 3 +++
>  t/t7400-submodule-basic.sh | 6 ++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 08b5cc433..f7e17d229 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -768,6 +768,9 @@ static int checkout(int submodule_progress)
>  		if (submodule_progress)
>  			argv_array_push(&args, "--progress");
>  
> +		if (option_verbosity < 0)
> +			argv_array_push(&args, "--quiet");
> +
>  		err = run_command_v_opt(args.argv, RUN_GIT_CMD);
>  		argv_array_clear(&args);
>  	}

Good spotting.  Makes me wonder if there still are other options we
might have missed, but we can incrementally improve as bug report
comes in ;-)

Will queue.  Thanks.

> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index dcac364c5..e9c3335b7 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -1289,4 +1289,10 @@ test_expect_success 'init properly sets the config' '
>  	test_must_fail git -C multisuper_clone config --get submodule.sub1.active
>  '
>  
> +test_expect_success 'recursive clone respects -q' '
> +	test_when_finished "rm -rf multisuper_clone" &&
> +	git clone -q --recurse-submodules multisuper multisuper_clone >actual &&
> +	test_must_be_empty actual
> +'
> +
>  test_done
