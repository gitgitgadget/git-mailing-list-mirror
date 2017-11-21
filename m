Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C59D6202F2
	for <e@80x24.org>; Tue, 21 Nov 2017 01:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbdKUBbm (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 20:31:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50737 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751389AbdKUBbl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 20:31:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 498DBBB801;
        Mon, 20 Nov 2017 20:31:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3CKiMgHYJav86sEOZUASrTpI/9E=; b=Oe09gl
        NsLGV+mpAjoctLxCKb238hamdG2U7A6UDcIO586cfyKW8gQxqc7vQcR7l2cuDNTB
        treUYKYqYhxQh+TO4aE76jlECeIoH7JRcOdMHEnnCb3MGVuWUEm6/0B9DCKAhhmD
        4DprtHSwp7SmoiQpPO9thmnMYz+4loLmGZGC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BrLDsndWIIUj6vEP6M3c76efJKbV6rU+
        oPy5cVF1skPaVYRWQg6Mcx4RwzeoZGhz9N/aRNaAlNUwH0rEt2bbzr2hudH4Dhdf
        Nl4AATGdUYk0a+xhi7yoagiyAEBD8wZ1f9JumWrWvvFHsl2qUbvdBmjCPjGpjvYA
        1g03mAawzbY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 400BABB800;
        Mon, 20 Nov 2017 20:31:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A9E68BB7FF;
        Mon, 20 Nov 2017 20:31:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Segev Finer <segev208@gmail.com>
Subject: Re: [PATCH 5/8] connect: split ssh option computation to its own function
References: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
        <20171120212619.nqtijn5ygypixmw6@aiede.mtv.corp.google.com>
Date:   Tue, 21 Nov 2017 10:31:39 +0900
In-Reply-To: <20171120212619.nqtijn5ygypixmw6@aiede.mtv.corp.google.com>
        (Jonathan Nieder's message of "Mon, 20 Nov 2017 13:26:19 -0800")
Message-ID: <xmqqpo8cju2s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B978B6E0-CE5B-11E7-8740-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> This puts the determination of options to pass to each ssh variant
> (see ssh.variant in git-config(1)) in one place.
>
> A follow-up patch will use this in an initial dry run to detect which
> variant to use when the ssh command is ambiguous.
>
> No functional change intended yet.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Split out to make patch 6 easier to read, as suggested at
> https://public-inbox.org/git/xmqq60b59toe.fsf@gitster.mtv.corp.google.com/.
>
> Added a function comment to make the purpose and API of this internal
> helper clearer.

The resulting fill-ssh-args reads a lot nicer.  Good.

>
>  connect.c | 65 ++++++++++++++++++++++++++++++++++++---------------------------
>  1 file changed, 37 insertions(+), 28 deletions(-)
>
> diff --git a/connect.c b/connect.c
> index a9dc493db2..d2fbb15cc5 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -919,6 +919,42 @@ static struct child_process *git_connect_git(int fd[2], char *hostandport,
>  	return conn;
>  }
>  
> +/*
> + * Append the appropriate environment variables to `env` and options to
> + * `args` for running ssh in Git's SSH-tunneled transport.
> + */
> +static void push_ssh_options(struct argv_array *args, struct argv_array *env,
> +			     enum ssh_variant variant, const char *port,
> +			     int flags)
> +{
> +	if (variant == VARIANT_SSH &&
> +	    get_protocol_version_config() > 0) {
> +		argv_array_push(args, "-o");
> +		argv_array_push(args, "SendEnv=" GIT_PROTOCOL_ENVIRONMENT);
> +		argv_array_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
> +				 get_protocol_version_config());
> +	}
> +
> +	if (variant != VARIANT_SIMPLE) {
> +		if (flags & CONNECT_IPV4)
> +			argv_array_push(args, "-4");
> +		else if (flags & CONNECT_IPV6)
> +			argv_array_push(args, "-6");
> +	}
> +
> +	if (variant == VARIANT_TORTOISEPLINK)
> +		argv_array_push(args, "-batch");
> +
> +	if (port && variant != VARIANT_SIMPLE) {
> +		if (variant == VARIANT_SSH)
> +			argv_array_push(args, "-p");
> +		else
> +			argv_array_push(args, "-P");
> +
> +		argv_array_push(args, port);
> +	}
> +}
> +
>  /* Prepare a child_process for use by Git's SSH-tunneled transport. */
>  static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
>  			  const char *port, int flags)
> @@ -947,34 +983,7 @@ static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
>  	}
>  
>  	argv_array_push(&conn->args, ssh);
> -
> -	if (variant == VARIANT_SSH &&
> -	    get_protocol_version_config() > 0) {
> -		argv_array_push(&conn->args, "-o");
> -		argv_array_push(&conn->args, "SendEnv=" GIT_PROTOCOL_ENVIRONMENT);
> -		argv_array_pushf(&conn->env_array, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
> -				 get_protocol_version_config());
> -	}
> -
> -	if (variant != VARIANT_SIMPLE) {
> -		if (flags & CONNECT_IPV4)
> -			argv_array_push(&conn->args, "-4");
> -		else if (flags & CONNECT_IPV6)
> -			argv_array_push(&conn->args, "-6");
> -	}
> -
> -	if (variant == VARIANT_TORTOISEPLINK)
> -		argv_array_push(&conn->args, "-batch");
> -
> -	if (port && variant != VARIANT_SIMPLE) {
> -		if (variant == VARIANT_SSH)
> -			argv_array_push(&conn->args, "-p");
> -		else
> -			argv_array_push(&conn->args, "-P");
> -
> -		argv_array_push(&conn->args, port);
> -	}
> -
> +	push_ssh_options(&conn->args, &conn->env_array, variant, port, flags);
>  	argv_array_push(&conn->args, ssh_host);
>  }
