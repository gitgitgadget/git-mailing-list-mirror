Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED200207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 17:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935023AbcIPRrw (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 13:47:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55380 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932715AbcIPRru (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 13:47:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 40CFF3E4B4;
        Fri, 16 Sep 2016 13:47:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=69lpU0XKFUNkSAmN0J2MPxsYZ8M=; b=Pnc9xD
        HJtBKnvJGOn0njtVlEe/bsXNEuzt9cGvu3yKwuDWgXRAZqUlqs/DKotM77PbR/Ay
        uaWKAPxrYkdQlyHRzRNeRMkiVrS/HyQQO9tZ19XjQTxrsIPlT6UMtdaLPQWj3amj
        wga6AL56YRPIwFsizxgeoQB2swVtZR7h513ic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t5bNmeB8a/skJZLzUo83hWDUw2dzPNGt
        3Fn2BKXechzzjz3SWWek1KK5X9QLiKaaJvzX1w279qfJP+40cbdOe4FrAcGAhBcu
        rHqxCWiQMD96b7A1hHvDNlpAVBzGoX+z6m3VI8hIGT2TFMz+WdSau6tjDU74iBU7
        wtp2EcO7vow=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3903B3E4B3;
        Fri, 16 Sep 2016 13:47:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AD2C13E4B2;
        Fri, 16 Sep 2016 13:47:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH 2/2] serialize collection of refs that contain submodule changes
References: <20160824173017.24782-1-sbeller@google.com>
        <20160824183112.ceekegpzavnbybxp@sigill.intra.peff.net>
        <xmqqh9aaot49.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYOBqQ0FF4J-+KbefSD8HRrUeMqpO27m_jprhm93aB+LA@mail.gmail.com>
        <20160824230115.jhmcr4r7wobj5ejb@sigill.intra.peff.net>
        <20160914175130.GB7613@sandbox>
Date:   Fri, 16 Sep 2016 10:47:46 -0700
In-Reply-To: <20160914175130.GB7613@sandbox> (Heiko Voigt's message of "Wed,
        14 Sep 2016 19:51:30 +0200")
Message-ID: <xmqqd1k3losd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AEB9612E-7C35-11E6-BD93-5D827B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

> diff --git a/submodule.c b/submodule.c
> index b04c066..a15e346 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -627,24 +627,31 @@ static void free_submodules_sha1s(struct string_list *submodules)
>  	string_list_clear(submodules, 1);
>  }
>  
> -int find_unpushed_submodules(unsigned char new_sha1[20],
> +static void append_hash_to_argv(const unsigned char sha1[20],
> +		void *data)
> +{
> +	struct argv_array *argv = (struct argv_array *) data;
> +	argv_array_push(argv, sha1_to_hex(sha1));
> +}
> +
> +int find_unpushed_submodules(struct sha1_array *hashes,
>  		const char *remotes_name, struct string_list *needs_pushing)
>  {
>  	struct rev_info rev;
>  	struct commit *commit;
> -	const char *argv[] = {NULL, NULL, "--not", "NULL", NULL};
> -	int argc = ARRAY_SIZE(argv) - 1, i;
> -	char *sha1_copy;
> +	int i;
>  	struct string_list submodules = STRING_LIST_INIT_DUP;
> +	struct argv_array argv = ARGV_ARRAY_INIT;
>  
> -	struct strbuf remotes_arg = STRBUF_INIT;
> -
> -	strbuf_addf(&remotes_arg, "--remotes=%s", remotes_name);
>  	init_revisions(&rev, NULL);
> -	sha1_copy = xstrdup(sha1_to_hex(new_sha1));
> -	argv[1] = sha1_copy;
> -	argv[3] = remotes_arg.buf;
> -	setup_revisions(argc, argv, &rev, NULL);
> +
> +	/* argv.argv[0] will be ignored by setup_revisions */
> +	argv_array_push(&argv, "find_unpushed_submodules");
> +	sha1_array_for_each_unique(hashes, append_hash_to_argv, &argv);
> +	argv_array_push(&argv, "--not");
> +	argv_array_pushf(&argv, "--remotes=%s", remotes_name);
> +
> +	setup_revisions(argv.argc, argv.argv, &rev, NULL);

Yes, its about time to for us to lose that fixed-size argv[] and
replace it with an argv-array ;-).

>  	if (prepare_revision_walk(&rev))
>  		die("revision walk setup failed");

So this one used to get a single commit at the tip of what we pushed
in the superproject and was asked "Look at the history we just
pushed leading to the tip commit, and tell me if any of the ones new
to the remote requires submodule commits the remote does not yet
have".  Now the caller collects all the tip commits and asks us
once: "Here are the new tips we just pushed; in the history leading
to them, is there a commit that the remote did not have that requires
submodule history the remote does not yet have?".

Makes sort-of sense.

I speculated that you would be doing the same kind of optimization
to feed all positive commits to rev-list at once in each submodule
repository in the review of the previous one, but you didn't do it
here.  You did the same for superproject in this step.  Perhaps 3 or
4 would do so in the submodule repository.

One thing that makes me worried is how the ref cache layer interacts
with this.  I see you first call push_unpushed_submodules() when
ON_DEMAND is set, which would result in pushes in submodule
repositories, updating their remote tracking branches.  At that
point, before you make another call to find_unpushed_submodules(),
is our cached ref layer knows that the remote tracking branches
are now up to date (otherwise, we would incorrectly judge that these
submodules need pushing based on stale information)?

> diff --git a/transport.c b/transport.c
> index 94d6dc3..76e1daf 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -903,23 +903,29 @@ int transport_push(struct transport *transport,
>  
>  		if ((flags & TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND) && !is_bare_repository()) {
>  			struct ref *ref = remote_refs;
> +			struct sha1_array hashes = SHA1_ARRAY_INIT;
> +
>  			for (; ref; ref = ref->next)
> -				if (!is_null_oid(&ref->new_oid) &&
> -				    !push_unpushed_submodules(ref->new_oid.hash,
> -					    transport->remote->name))
> -				    die ("Failed to push all needed submodules!");
> +				if (!is_null_oid(&ref->new_oid))
> +					sha1_array_append(&hashes, ref->new_oid.hash);
> +
> +			if (!push_unpushed_submodules(&hashes, transport->remote->name))
> +				die ("Failed to push all needed submodules!");

Do we leak the contents of hashes here?

>  		}
>  
>  		if ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
>  			      TRANSPORT_RECURSE_SUBMODULES_CHECK)) && !is_bare_repository()) {
>  			struct ref *ref = remote_refs;
>  			struct string_list needs_pushing = STRING_LIST_INIT_DUP;
> +			struct sha1_array hashes = SHA1_ARRAY_INIT;
>  
>  			for (; ref; ref = ref->next)
> -				if (!is_null_oid(&ref->new_oid) &&
> -				    find_unpushed_submodules(ref->new_oid.hash,
> -					    transport->remote->name, &needs_pushing))
> -					die_with_unpushed_submodules(&needs_pushing);
> +				if (!is_null_oid(&ref->new_oid))
> +					sha1_array_append(&hashes, ref->new_oid.hash);
> +
> +			if (find_unpushed_submodules(&hashes, transport->remote->name,
> +						&needs_pushing))
> +				die_with_unpushed_submodules(&needs_pushing);

Do we leak the contents of hashes here?  I do not think we need to
worry about needs_pushing leaking, as we will always die if it is
not empty, but it might be a better code hygiene to clear it as
well.

>  		}
>  
>  		push_ret = transport->push_refs(transport, remote_refs, flags);

Thanks.
