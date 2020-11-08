Return-Path: <SRS0=1y/A=EO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D2BC388F9
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 19:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68D7206F4
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 19:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jKwKJNmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgKHTam (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 14:30:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60837 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgKHTam (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 14:30:42 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38C1788151;
        Sun,  8 Nov 2020 14:30:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5I7NkR7VKuSF5KC7YZnCEW61kSI=; b=jKwKJN
        mTcpidbUe1wW5KsHjbnYv7Q6jgoRR/1PjO6rMbAz9ash+4hYOwC+BWwT4S/a8iEx
        MNBdGUdn7SYM5VslCRcfcg4gRrK8ivxPTiWSzYzrNyDoW0aDuZsvdyk7D/1SxR42
        LfrEXYUNm34a+65AMeKQLs01c8tUQUX1FfRBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lis4mu9ZAXqyfW4vmJ9KG/DWziAayVMA
        2+q8jVtcYYqhSSinm5tXf2TFq/0x7nsJ7hw817LHkt6AkQ8gIOAgr37L+TdQifHD
        hIyXWJOIeiLAGAXskzTLeVeqmp4DZm0q+a9r3tDFNWBbnCOeSYts9500KrrbKyIa
        wLeuXOmJbMc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 306B888150;
        Sun,  8 Nov 2020 14:30:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 96BED8814F;
        Sun,  8 Nov 2020 14:30:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] push: teach --base for ssh:// and file://
References: <cover.1604362701.git.jonathantanmy@google.com>
        <148e39960a2185d2355cdfe34f8856e708fb1b80.1604362701.git.jonathantanmy@google.com>
Date:   Sun, 08 Nov 2020 11:30:36 -0800
In-Reply-To: <148e39960a2185d2355cdfe34f8856e708fb1b80.1604362701.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Mon, 2 Nov 2020 16:26:11 -0800")
Message-ID: <xmqq4klzejdv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E10EB166-21F8-11EB-A6C5-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>  static int do_push(int flags,
>  		   const struct string_list *push_options,
> -		   struct remote *remote)
> +		   struct remote *remote,
> +		   const char *push_base)
>  {
>  	int i, errs;
>  	const char **url;
> @@ -405,6 +406,8 @@ static int do_push(int flags,
>  				transport_get(remote, url[i]);
>  			if (flags & TRANSPORT_PUSH_OPTIONS)
>  				transport->push_options = push_options;
> +			if (push_base)
> +				transport_set_option(transport, TRANS_OPT_PUSH_BASE, push_base);
>  			if (push_with_options(transport, push_refspec, flags))
>  				errs++;
>  		}
> @@ -413,6 +416,8 @@ static int do_push(int flags,
>  			transport_get(remote, NULL);
>  		if (flags & TRANSPORT_PUSH_OPTIONS)
>  			transport->push_options = push_options;
> +		if (push_base)
> +			transport_set_option(transport, TRANS_OPT_PUSH_BASE, push_base);
>  		if (push_with_options(transport, push_refspec, flags))
>  			errs++;
>  	}

These just send push_base as-is.

> @@ -526,6 +531,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>  	struct string_list *push_options;
>  	const struct string_list_item *item;
>  	struct remote *remote;
> +	const char *push_base = NULL;
>  
>  	struct option options[] = {
>  		OPT__VERBOSITY(&verbosity),
> @@ -562,6 +568,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>  				TRANSPORT_FAMILY_IPV4),
>  		OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
>  				TRANSPORT_FAMILY_IPV6),
> +		OPT_STRING(0, "base", &push_base, N_("revision"),
> +			   N_("ancestor of commits to be pushed that is believed to be known by the server")),
>  		OPT_END()
>  	};

And this takes push_base as a string that is not even validated for
any constraints.

> @@ -629,7 +637,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>  		if (strchr(item->string, '\n'))
>  			die(_("push options must not have new line characters"));
>  
> -	rc = do_push(flags, push_options, remote);
> +	rc = do_push(flags, push_options, remote, push_base);


And passes that arbitrary cruft given by the user down to the
transport.

As the spirit of the "base" parameter is to tell the other side that
it is what the receiving end believes to be common, shouldn't we
make sure we do have it on our side after getting it from the user
with OPT_STRING() before passing it down to the transport layer and
have the transport layer convert it to an object name?  This patch
assumes that running get_oid_hex() at the transport layer and
assuming that the transport would keep working on the_repository
(hence when we say "We expect that the receiving end has 'master'",
the transport somehow knows that is 'master' in our repository, not
in a submodule repository, for example), but by converting it to
full object name early, we do not have to assume transport to stay
that way.
