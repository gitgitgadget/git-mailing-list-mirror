Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6221F207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 20:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933284AbcJFU0E (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 16:26:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64643 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752087AbcJFU0C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 16:26:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B75C445CB;
        Thu,  6 Oct 2016 16:26:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EK4CGWhz7FAc07Vx6FQ3wlHurZM=; b=og4pvb
        7I58XbsbgzxY9zNZVRW1QQ5Xl2GWZRjksmYjyIupBdnZ3ethA5dII3KGV2xMTu8N
        +84vZLs3Z/Fhx/5Wz6xu9XP5srYcZToNnpmweeo4G6spnXAPKkmGXsjxE0p0x6hE
        jFgOpu8jnB49xfnEcclV4DJ/+rBY0DzziYktY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pwvzoACv78irP7uMhKP3lKae88f/bcyH
        Yrz7X8ldLiFnC/BgWxbTeKHUqfuzL8VEWRXXPqdsl6HqAPyqZzBOiWISPkb5jtIb
        4WsxzQPet8sBqOwWwta1fpxxGHUbqi4Se3a5SRNWWA3V1BPKQ7twS06C9VBlvcYd
        yKPtoquPms0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3DF4A445CA;
        Thu,  6 Oct 2016 16:26:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 65A31445C8;
        Thu,  6 Oct 2016 16:26:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, hvoigt@hvoigt.net,
        torvalds@linux-foundation.org, peff@peff.net
Subject: Re: [PATCHv4 2/2] push: change submodule default to check when submodules exist
References: <20161006193725.31553-1-sbeller@google.com>
        <20161006193725.31553-3-sbeller@google.com>
Date:   Thu, 06 Oct 2016 13:25:58 -0700
In-Reply-To: <20161006193725.31553-3-sbeller@google.com> (Stefan Beller's
        message of "Thu, 6 Oct 2016 12:37:25 -0700")
Message-ID: <xmqqoa2xi5rd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 187BE67C-8C03-11E6-9193-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> When working with submodules, it is easy to forget to push the submodules.
> The setting 'check', which checks if any existing submodule is present on
> at least one remote of the submodule remotes, is designed to prevent this
> mistake.
>
> Flipping the default to check for submodules is safer than the current
> default of ignoring submodules while pushing.
>
> However checking for submodules requires additional work[1], which annoys
> users that do not use submodules, so we turn on the check for submodules
> based on a cheap heuristic, the existence of the .git/modules directory.

... and other things like .gitmodules, submodule stuff in
.git/config, etc.?

> +	} else if (starts_with(k, "submodule.") && ends_with(k, ".url"))
> +		has_submodules_configured = 1;

An in-code comment to explain why ".url" is so special would be
helpful.  Documentation/config.txt says .path and .url are both
initially populated by 'git submodule init', which might be outdated
information that confuses readers of the above code.

> @@ -552,6 +564,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>  	};
>  
>  	packet_trace_identity("push");
> +	preset_submodule_default();
>  	git_config(git_push_config, &flags);
>  	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
>  	set_push_cert_flags(&flags, push_cert);
> diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
> index 198ce84..e690749 100755
> --- a/t/t5531-deep-submodule-push.sh
> +++ b/t/t5531-deep-submodule-push.sh
> @@ -65,7 +65,11 @@ test_expect_success 'push fails if submodule commit not on remote' '
>  		git add gar/bage &&
>  		git commit -m "Third commit for gar/bage" &&
>  		# the push should fail with --recurse-submodules=check
> -		# on the command line...
> +		# on the command line. "check" is the default for repos in
> +		# which submodules are detected by existence of config,
> +		# .gitmodules file or an internal .git/modules/<submodule-repo>
> +		git submodule add -f ../submodule.git gar/bage &&
> +		test_must_fail git push ../pub.git master &&
>  		test_must_fail git push --recurse-submodules=check ../pub.git master &&
>  
>  		# ...or if specified in the configuration..
