Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 802CF200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 22:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752675AbcL0WMv (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 17:12:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55761 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752978AbcL0WMu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 17:12:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8623D5A120;
        Tue, 27 Dec 2016 17:12:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+rxap3839iNA5+ntpvfz23gHTMo=; b=opuVvl
        dM2x9/7/1ggYkWJJnsGjzcBpzcQZuqUIhFR42a6lVxjMmoodaIRduH6r66xHjQGs
        ft+oc/gHP1TbBc0RqmqiY3tJhpIt4NR4Yzb5YZLkgU3HZsqhsEkZeeowWbniXTTD
        36Awovs5mG/XtqnOjg3ObZsa2yeNqH5C0d10w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GKWNGk6wpcGqOyGlvllP+fynw5Ug75jU
        IPAIf6q6hnrwaX+jP8opWbotyFu5CADjXgfiekLP8gmt/TxYMkawUYN5rtHwoO/m
        KopDheWLa+5o5Y8otI6G5V+MpuFGzd3Aw0LlVhWj/Du8PER1dfGYyZXg4KW1apE/
        lbfPzNctylw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D9725A11F;
        Tue, 27 Dec 2016 17:12:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F39615A11B;
        Tue, 27 Dec 2016 17:12:29 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     larsxschneider@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] worktree: initialize return value for submodule_uses_worktrees
References: <7E1C7387-4F37-423F-803D-3B5690B49D40@gmail.com>
        <20161227175013.12747-1-sbeller@google.com>
Date:   Tue, 27 Dec 2016 14:12:28 -0800
In-Reply-To: <20161227175013.12747-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 27 Dec 2016 09:50:13 -0800")
Message-ID: <xmqqa8bh6myb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8ECECA92-CC81-11E6-AFCF-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> When the worktrees directory is empty, the `ret` will be returned
> uninitialized. Fix it by initializing the value.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> This goes on top of 1a248cf (origin/sb/submodule-embed-gitdir);
> ideally to be squashed, but as it is in next already, as a separate
> patch.
>
> Thanks,
> Stefan

If you initialize it at the definition site, it would be more
consistent if these "return 0" we see earlier parts of the function
also returned "ret" instead of "0".  A better alternative would be
to initialize it to 0 before it starts to matter, i.e. immediately
before the

	while (readdir()) {
		if (is_dot_or_dotdot())
			continue;
		ret = 1;
                break;
	}		

loop.  I also wonder if that loop is easier to read 

	for (has_paths = 0; !has_paths && (d = readdir(dir)) != NULL; ) {
		if (is_dot_or_dotdot())
			continue;
		has_paths = 1;
	}                

or even make it a helper function "is_empty_directory(const char *)".

Having said that, I'll queue this as-is and will merge to 'master'
by the end of the day, as I'm planning to disappear until early next
year, so please do not "reroll" this to add yet another integration
cycle to my day.

Thanks.


>  worktree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/worktree.c b/worktree.c
> index d4606aa8cd..828fd7a0ad 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -387,7 +387,7 @@ int submodule_uses_worktrees(const char *path)
>  	struct strbuf sb = STRBUF_INIT;
>  	DIR *dir;
>  	struct dirent *d;
> -	int ret;
> +	int ret = 0;
>  	struct repository_format format;
>  
>  	submodule_gitdir = git_pathdup_submodule(path, "%s", "");
