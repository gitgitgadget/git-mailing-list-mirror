Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D2A120986
	for <e@80x24.org>; Sat, 22 Oct 2016 16:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935712AbcJVQhL (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 12:37:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57098 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934425AbcJVQhL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 12:37:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BBAB243F25;
        Sat, 22 Oct 2016 12:37:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/JndrbRwgQcNl5o0WNcr6BpEVVM=; b=hK7v6u
        JChWkYVajTeGQ/1TBktrQdSGgIQ/IX6jVY2m2RVpXYQwdOQqGor8bjiL91eotnvc
        +SQ2tSv8f9sY4IPxRBm9KTYcgtJ4XzrsnyVaNzjAL3Ww75Zakc8mEHs2cOFXyxK/
        1xt3/QIyfzwWTTDax3epApR9+8D4dUNbiyMYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QruJoMS1g57TNl7EYLuxCJpY7h017j6K
        GkYNdSRYXh0+GZzW9zRWYYqEI0AF1g3H6WFKw9YNVKig12Aah5KCKAGWfYp1NeRi
        esemBJhNUjVpX1iaM4k7VGg0TLlbFIK1UEEfx63Wt7Td4+80za2/tjUZLOpmy/QB
        y+SVNxjQaVA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B4FF243F24;
        Sat, 22 Oct 2016 12:37:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3717843F23;
        Sat, 22 Oct 2016 12:37:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] daemon: detect and reject too-long paths
References: <20161022045938.h3xa3yapzlg427vy@sigill.intra.peff.net>
Date:   Sat, 22 Oct 2016 09:37:07 -0700
In-Reply-To: <20161022045938.h3xa3yapzlg427vy@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 22 Oct 2016 00:59:38 -0400")
Message-ID: <xmqqzilw8hn0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6A0F944-9875-11E6-AAE2-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> When we are checking the path via path_ok(), we use some
> fixed PATH_MAX buffers. We write into them via snprintf(),
> so there's no possibility of overflow, but it does mean we
> may silently truncate the path, leading to potentially
> confusing errors when the partial path does not exist.
>
> We're better off to reject the path explicitly.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Sounds sensible.

> Another option would be to switch to strbufs here. That potentially
> introduces cases where a client can convince us to just keep allocating
> memory, but I don't think so in practice; the paths and interpolated
> data items all have to come in 64K pkt-lines, which places a hard
> limit. This is a much more minimal change, though, and I don't hear
> anybody complaining about the inability to use large paths.

The alternative version did not look bad, either; in fact, the end
result may even be conceptually simpler.

But I agree that this one with the same hard-limit we always had is
a much more minimal change and is sufficient.

Thanks.

>  daemon.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/daemon.c b/daemon.c
> index 425aad0507..ff0fa583b0 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -160,6 +160,7 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
>  {
>  	static char rpath[PATH_MAX];
>  	static char interp_path[PATH_MAX];
> +	size_t rlen;
>  	const char *path;
>  	const char *dir;
>  
> @@ -187,8 +188,12 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
>  			namlen = slash - dir;
>  			restlen -= namlen;
>  			loginfo("userpath <%s>, request <%s>, namlen %d, restlen %d, slash <%s>", user_path, dir, namlen, restlen, slash);
> -			snprintf(rpath, PATH_MAX, "%.*s/%s%.*s",
> -				 namlen, dir, user_path, restlen, slash);
> +			rlen = snprintf(rpath, sizeof(rpath), "%.*s/%s%.*s",
> +					namlen, dir, user_path, restlen, slash);
> +			if (rlen >= sizeof(rpath)) {
> +				logerror("user-path too large: %s", rpath);
> +				return NULL;
> +			}
>  			dir = rpath;
>  		}
>  	}
> @@ -207,7 +212,15 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
>  
>  		strbuf_expand(&expanded_path, interpolated_path,
>  			      expand_path, &context);
> -		strlcpy(interp_path, expanded_path.buf, PATH_MAX);
> +
> +		rlen = strlcpy(interp_path, expanded_path.buf,
> +			       sizeof(interp_path));
> +		if (rlen >= sizeof(interp_path)) {
> +			logerror("interpolated path too large: %s",
> +				 interp_path);
> +			return NULL;
> +		}
> +
>  		strbuf_release(&expanded_path);
>  		loginfo("Interpolated dir '%s'", interp_path);
>  
> @@ -219,7 +232,11 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
>  			logerror("'%s': Non-absolute path denied (base-path active)", dir);
>  			return NULL;
>  		}
> -		snprintf(rpath, PATH_MAX, "%s%s", base_path, dir);
> +		rlen = snprintf(rpath, sizeof(rpath), "%s%s", base_path, dir);
> +		if (rlen >= sizeof(rpath)) {
> +			logerror("base-path too large: %s", rpath);
> +			return NULL;
> +		}
>  		dir = rpath;
>  	}
