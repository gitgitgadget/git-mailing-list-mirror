Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9573C433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 21:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C435F2076A
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 21:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kuntwrwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgFHV3w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 17:29:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52647 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbgFHV3v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 17:29:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2F786CB763;
        Mon,  8 Jun 2020 17:29:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ytOtce5n/DU9bcJVhx5k6GASvIc=; b=kuntwr
        wXcTyVKdnCuoJtXNG3OjzQ/WGqNkPAY8Bd45AXwkZx31rF/g0oB/YGHAbLDzmAu4
        jbOooH2GBTw3aXtJ7wriLl8rUXPKUW0A4gHBHr3sKvo0O36x9DjSv57+41oXus9o
        0VnYc3KK7K+d8X9tVB3HwMFf6kKUxGi5ie75s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=r38butzFEUtdS+NiPrBuCtakxUYqSDnj
        hbVt05glmbRllo6lRPUiMGupOWeLuDK6esRQEqxMHs+P86MExxBNH7NI9BG0kEPf
        duvmynXSRLpO8S7D5OC6MGXG6hIng0KXGh5fonW4H7UMR7ZBw/HGdtXXKszPaolG
        TUZ8EdFcFog=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 27F63CB762;
        Mon,  8 Jun 2020 17:29:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6D04BCB761;
        Mon,  8 Jun 2020 17:29:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Jonathan =?utf-8?Q?M=C3=BCller?= <jonathanmueller.dev@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: [PATCH 4/8] worktree: make high-level pruning re-usable
References: <20200608062356.40264-1-sunshine@sunshineco.com>
        <20200608062356.40264-5-sunshine@sunshineco.com>
Date:   Mon, 08 Jun 2020 14:29:45 -0700
In-Reply-To: <20200608062356.40264-5-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Mon, 8 Jun 2020 02:23:52 -0400")
Message-ID: <xmqqr1upjlfa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D7BC7F2-A9CF-11EA-A6A1-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> The low-level logic for removing a worktree is well encapsulated in
> delete_git_dir(). However, high-level details related to pruning a
> worktree -- such as dealing with verbosity and dry-run mode -- are not
> encapsulated. Factor out this high-level logic into its own function so
> it can be re-used as new worktree corruption detectors are added.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  builtin/worktree.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 27681a1396..d0c046e885 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -133,6 +133,14 @@ static int should_prune_worktree(const char *id, struct strbuf *reason)
>  	return 0;
>  }
>  
> +static void prune_worktree(const char *id, const char *reason)
> +{
> +	if (show_only || verbose)
> +		printf_ln(_("Removing %s/%s: %s"), "worktrees", id, reason);
> +	if (!show_only)
> +		delete_git_dir(id);
> +}

Makes sense, and this sensible name can be used only because we've
cleaned up the other one in the previous step.

Good so far (except that I still do not know why 2/8 is a good move
after reading the series up to this point).

>  static void prune_worktrees(void)
>  {
>  	struct strbuf reason = STRBUF_INIT;
> @@ -146,12 +154,7 @@ static void prune_worktrees(void)
>  		strbuf_reset(&reason);
>  		if (!should_prune_worktree(d->d_name, &reason))
>  			continue;
> -		if (show_only || verbose)
> -			printf_ln(_("Removing %s/%s: %s"),
> -				  "worktrees", d->d_name, reason.buf);
> -		if (show_only)
> -			continue;
> -		delete_git_dir(d->d_name);
> +		prune_worktree(d->d_name, reason.buf);
>  	}
>  	closedir(dir);
>  	if (!show_only)
