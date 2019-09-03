Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2167F1F461
	for <e@80x24.org>; Tue,  3 Sep 2019 18:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbfICS3k (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 14:29:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55178 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfICS3j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 14:29:39 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3614F17BD5;
        Tue,  3 Sep 2019 14:29:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZY5DJP7aRsDenEXAMMmXvQSmN9Q=; b=yBysdY
        ZBI4HzWGDR3Q6WBrd4IllZL1T4QmH1ktZ5cVpEfTf233qMQeXVS/0HR8GpeEz2Zp
        R1+uX5rsg/f2xVtekQfpwwwFpHYzR7wjxaMbiqazkBsPG0ITBk6wdlZo+ppsQNfb
        eFGqaKzzOsG37NqcqHs9UwAaXYnHA51GRimyY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xAiSQYl7NgU3vcHAMmxrTjSLibK0w1um
        g0RAT1JRKaLKoex+FYkekQcNqyISJEsXnifw5wANtJME4zcIJ7PIK6RRse6RLOds
        SJH/6zPm7ocp+xQokOXupQy5nccA3YhS+rBAWPXGKrMb2RMgowoQm37Wza3zvauE
        3MOgHSOMjUY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D1F417BD4;
        Tue,  3 Sep 2019 14:29:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 82A1E17BD2;
        Tue,  3 Sep 2019 14:29:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Filippo Valsorda <filippo@ml.filippo.io>, git@vger.kernel.org,
        Brandon Williams <bwilliams.eng@gmail.com>
Subject: Re: [PATCH] push: disallow --all and refspecs when remote.<name>.mirror is set
References: <4d995a0b-0ac4-45a0-9ead-1bc76bd720c7@www.fastmail.com>
        <20190902180828.GC77876@cat>
Date:   Tue, 03 Sep 2019 11:29:34 -0700
In-Reply-To: <20190902180828.GC77876@cat> (Thomas Gummerer's message of "Mon,
        2 Sep 2019 19:08:28 +0100")
Message-ID: <xmqqimq9ter5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C7D49884-CE78-11E9-A584-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Here's a patch to fix it:
>
> --- >8 ---
> Pushes with --all, or refspecs are disallowed when --mirror is given
> to 'git push', or when 'remote.<name>.mirror' is set in the config of
> the repository, because they can have surprising
> effects. 800a4ab399 ("push: check for errors earlier", 2018-05-16)
> refactored this code to do that check earlier, so we can explicitly
> check for the presence of flags, instead of their sideeffects.
>
> However when 'remote.<name>.mirror' is set in the config, the
> TRANSPORT_PUSH_MIRROR flag would only be set after we calling
> 'do_push()', so the checks would miss it entirely.

Thanks.  Well explained.

> diff --git a/builtin/push.c b/builtin/push.c
> index 021dd3b1e4..3742daf7b0 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -385,30 +385,14 @@ static int push_with_options(struct transport *transport, struct refspec *rs,
>  }
>  
>  static int do_push(const char *repo, int flags,
> -		   const struct string_list *push_options)
> +		   const struct string_list *push_options,
> +		   struct remote *remote)
>  {
>  	int i, errs;
> -	struct remote *remote = pushremote_get(repo);
>  	const char **url;
>  	int url_nr;
>  	struct refspec *push_refspec = &rs;
>  
> -	if (!remote) {
> -		if (repo)
> -			die(_("bad repository '%s'"), repo);
> -		die(_("No configured push destination.\n"
> -		    "Either specify the URL from the command-line or configure a remote repository using\n"
> -		    "\n"
> -		    "    git remote add <name> <url>\n"
> -		    "\n"
> -		    "and then push using the remote name\n"
> -		    "\n"
> -		    "    git push <name>\n"));
> -	}
> -
> -	if (remote->mirror)
> -		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
> -

As you wrote in the proposed log message, this is done too late, so
the patch moves it below, running it a lot earlier, ...

> @@ -632,11 +603,43 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>  		set_refspecs(argv + 1, argc - 1, repo);
>  	}
>  
> +	remote = pushremote_get(repo);
> +	if (!remote) {
> +		if (repo)
> +			die(_("bad repository '%s'"), repo);
> +		die(_("No configured push destination.\n"
> +		    "Either specify the URL from the command-line or configure a remote repository using\n"
> +		    "\n"
> +		    "    git remote add <name> <url>\n"
> +		    "\n"
> +		    "and then push using the remote name\n"
> +		    "\n"
> +		    "    git push <name>\n"));
> +	}
> +
> +	if (remote->mirror)
> +		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);

... which happens here now.  The code to check has been moved below,
without changing anything, so let's make sure it is OK.

Between the old location these checks were done and the new
location, we may have added recurse-submodules related TRANSPORT_*
bits to the "flags" variable, added "refs/tags/*" to the "rs" refspec,
and called set_refspecs() on repo.  We didn't change the value of tags
or argc. So...

> +	if (flags & TRANSPORT_PUSH_ALL) {
> +		if (tags)
> +			die(_("--all and --tags are incompatible"));
> +		if (argc >= 2)
> +			die(_("--all can't be combined with refspecs"));
> +	}
> +	if (flags & TRANSPORT_PUSH_MIRROR) {
> +		if (tags)
> +			die(_("--mirror and --tags are incompatible"));
> +		if (argc >= 2)
> +			die(_("--mirror can't be combined with refspecs"));
> +	}
> +	if ((flags & TRANSPORT_PUSH_ALL) && (flags & TRANSPORT_PUSH_MIRROR))
> +		die(_("--all and --mirror are incompatible"));
> +

... these checks would still work as intended in the original
version.  Good.

>  	for_each_string_list_item(item, push_options)
>  		if (strchr(item->string, '\n'))
>  			die(_("push options must not have new line characters"));
>  
> -	rc = do_push(repo, flags, push_options);
> +	rc = do_push(repo, flags, push_options, remote);
>  	string_list_clear(&push_options_cmdline, 0);
>  	string_list_clear(&push_options_config, 0);
>  	if (rc == -1)
> diff --git a/t/t5517-push-mirror.sh b/t/t5517-push-mirror.sh
> index c05a661400..e4edd56404 100755
> --- a/t/t5517-push-mirror.sh
> +++ b/t/t5517-push-mirror.sh
> @@ -265,4 +265,14 @@ test_expect_success 'remote.foo.mirror=no has no effect' '
>  
>  '
>  
> +test_expect_success 'push to mirrored repository with refspec fails' '
> +	mk_repo_pair &&
> +	(
> +		cd master &&
> +		echo one >foo && git add foo && git commit -m one &&
> +		git config --add remote.up.mirror true &&
> +		test_must_fail git push up master
> +	)
> +'
> +
>  test_done
