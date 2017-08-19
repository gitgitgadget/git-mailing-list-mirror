Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAE0F208CD
	for <e@80x24.org>; Sat, 19 Aug 2017 06:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751003AbdHSGZA (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 02:25:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61710 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750852AbdHSGY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 02:24:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11CC9A725E;
        Sat, 19 Aug 2017 02:24:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xUdDfOwaHw2llwBK4Oq6Buhr0P0=; b=vA+87o
        g0y5IF9SgMpWRKGaiLNEHzCgUiEAXOUdspLLcpW+QkFOjvLBWOBAOsxG0vsTSN3Z
        kH8wsz5JRJRw0HRmNCKMLyHFbjwrFOGqJjkFbJDr9KNywipQ4YMq5KDR2aSgqprF
        qHku+kay4m0N7OmcXoy4biSNegvPOAbp1gLjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XQi1npY5iQ6IemauiMWJeodHbWBJpxmC
        oDbGUBhfScpJ3RsOLkHdx9OlAOZhQkAmPlqo4YqJbZnYzMVSII/OR3WsIHwAOQ2F
        ZRQ55eORxpY2A+5F65SOFTARqRM2u14t64NwLlK2RM0mQR76WeLgtlVKYZUmY+Gd
        M5wqW/oAUGM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 07B29A725D;
        Sat, 19 Aug 2017 02:24:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 66D78A725C;
        Sat, 19 Aug 2017 02:24:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, larsxschneider@gmail.com
Subject: Re: [PATCH] pull: respect submodule update configuration
References: <xmqqpobsbsk1.fsf@gitster.mtv.corp.google.com>
        <20170818220431.22157-1-sbeller@google.com>
Date:   Fri, 18 Aug 2017 23:24:47 -0700
In-Reply-To: <20170818220431.22157-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 18 Aug 2017 15:04:31 -0700")
Message-ID: <xmqqvalk9is0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19BD8FC0-84A7-11E7-9412-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> Do not override the submodule configuration in the call to update
> the submodules, but give a weaker default.
>
> Reported-by: Lars Schneider <larsxschneider@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>   
> Personally I dislike this patch, but I have no better idea for the time
> being.

The patch text from a cursory look seems reasonable to me.

It's not like you have 47 different codepaths that need to pay
attention to the .update config and they all have to pass the new
--default-update option, this is merely to fix one of them that
relates to the problem reported by Lars, and you need a similar fix
to other 46, right?

If you want the "--recurse-submodules" thing to always do the
"weaker default" thing in your project, you can choose not to set
.update to custom values in any of your submodules, so I do not
think the reason why you dislike this change is because it would
affect your use of submodules.

So I am a bit curious to learn which part of this change you dislike
and why.


>  builtin/pull.c             |  6 ++++--
>  git-submodule.sh           |  7 ++++++-
>  t/t7400-submodule-basic.sh | 22 ++++++++++++++++++++++
>  3 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 9b86e519b1..be4f74d764 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -553,7 +553,8 @@ static int rebase_submodules(void)
>  	cp.git_cmd = 1;
>  	cp.no_stdin = 1;
>  	argv_array_pushl(&cp.args, "submodule", "update",
> -				   "--recursive", "--rebase", NULL);
> +				   "--recursive", "--default-update",
> +				   "rebase", NULL);
>  
>  	return run_command(&cp);
>  }
> @@ -565,7 +566,8 @@ static int update_submodules(void)
>  	cp.git_cmd = 1;
>  	cp.no_stdin = 1;
>  	argv_array_pushl(&cp.args, "submodule", "update",
> -				   "--recursive", "--checkout", NULL);
> +				   "--recursive", "--default-update",
> +				   "checkout", NULL);
>  
>  	return run_command(&cp);
>  }
> diff --git a/git-submodule.sh b/git-submodule.sh
> index e131760eec..6dbc32e686 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -511,6 +511,7 @@ fetch_in_submodule () (
>  cmd_update()
>  {
>  	# parse $args after "submodule ... update".
> +	default_update="checkout"
>  	while test $# -ne 0
>  	do
>  		case "$1" in
> @@ -552,6 +553,10 @@ cmd_update()
>  		--checkout)
>  			update="checkout"
>  			;;
> +		--default-update)
> +			default_update="$2"
> +			shift
> +			;;
>  		--recommend-shallow)
>  			recommend_shallow="--recommend-shallow"
>  			;;
> @@ -619,7 +624,7 @@ cmd_update()
>  			update_module=$(git config submodule."$name".update)
>  			if test -z "$update_module"
>  			then
> -				update_module="checkout"
> +				update_module="$default_update"
>  			fi
>  		fi
>  
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index dcac364c5f..ff64bf8528 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -1289,4 +1289,26 @@ test_expect_success 'init properly sets the config' '
>  	test_must_fail git -C multisuper_clone config --get submodule.sub1.active
>  '
>  
> +test_expect_success 'submodule update and git pull with disabled submodule' '
> +	test_when_finished "rm -rf multisuper_clone" &&
> +	pwd=$(pwd) &&
> +	cat <<-\EOF >expect &&
> +	-sub0
> +	 sub1 (test2)
> +	 sub2 (test2)
> +	 sub3 (test2)
> +	 sub4 (test2)
> +	 sub5 (test2)
> +	EOF
> +	git clone file://"$pwd"/multisuper multisuper_clone &&
> +	(
> +		cd multisuper_clone &&
> +		git config --local submodule.sub0.update none &&
> +		git submodule update --init --recursive &&
> +		git pull --recurse-submodules &&
> +		git submodule status | cut -c 1,43- >actual
> +	) &&
> +	test_cmp expect multisuper_clone/actual
> +'
> +
>  test_done
