Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141DAC433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 01:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA56220801
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 01:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lQYxjf5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgFKBlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 21:41:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59334 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgFKBlY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 21:41:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 925B078EDE;
        Wed, 10 Jun 2020 21:41:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K5ekx8s0j9TXKGMV3LewP4+c/mA=; b=lQYxjf
        5h2pZdBjG5+T6hn4d6wJ7jgKtqv9GvTlDJoBKRt3if27x0jj2bvIY/5szauMLJK+
        uquzF9l88VNSSifS0BSxKI0o9gBBwY46CtBUVdonAtMOOhgdXPbYlM7rhp5BCPZT
        i8CB5hl0c9wLcvzU8GxtCaMyqNXw2nygP4wLI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tZYGVxJxgp3ulIHafvQXQDmmRnd8nQi5
        lvW8OxMfqXckfVTyiopXLASSMtshnfvwWCYxLRiEUyuFgLSI+oOOczA9YtDTcecg
        pavYbKonbEojZ6UVVEIvPXGij9Odv8jFZcP8UQH3kGk5scigevcvqd1oJTyp9hbe
        QZg7Xw0hYLk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 88FF878EDD;
        Wed, 10 Jun 2020 21:41:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D30C78EDC;
        Wed, 10 Jun 2020 21:41:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 8/9] fetch-pack: support more than one pack lockfile
References: <cover.1590789428.git.jonathantanmy@google.com>
        <cover.1591821067.git.jonathantanmy@google.com>
        <566419ae74348ad3f7b1e5d484cf986fea29af73.1591821067.git.jonathantanmy@google.com>
Date:   Wed, 10 Jun 2020 18:41:19 -0700
In-Reply-To: <566419ae74348ad3f7b1e5d484cf986fea29af73.1591821067.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Wed, 10 Jun 2020 13:57:22 -0700")
Message-ID: <xmqqk10ecrb4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A63E2052-AB84-11EA-A1D9-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index 4771100072..f66891b010 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -48,8 +48,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
>  	struct ref **sought = NULL;
>  	int nr_sought = 0, alloc_sought = 0;
>  	int fd[2];
> -	char *pack_lockfile = NULL;
> -	char **pack_lockfile_ptr = NULL;
> +	struct string_list pack_lockfiles = STRING_LIST_INIT_DUP;
> +	struct string_list *pack_lockfiles_ptr = NULL;
>  	struct child_process *conn;
>  	struct fetch_pack_args args;
>  	struct oid_array shallow = OID_ARRAY_INIT;
> @@ -134,7 +134,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
>  		}
>  		if (!strcmp("--lock-pack", arg)) {
>  			args.lock_pack = 1;
> +			pack_lockfiles_ptr = &pack_lockfiles;
>  			continue;
>  		}
>  		if (!strcmp("--check-self-contained-and-connected", arg)) {
> @@ -235,10 +235,15 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	ref = fetch_pack(&args, fd, ref, sought, nr_sought,
> +			 &shallow, pack_lockfiles_ptr, version);
> +	if (pack_lockfiles.nr) {

In other parts of this patch, "is the pack_lockfiles pointer NULL?"
is used and "does the pack_lockfiles actually have any element?" is
not checked, which was a bit hard to reason about, but the idea here
is that the presence of the list tells the callee to use lockfiles
and accumulate them in the string list and then this caller checks
if we ended up locking any, which makes sense.

> +		int i;
> +
> +		printf("lock %s\n", pack_lockfiles.items[0].string);
>  		fflush(stdout);
> +		for (i = 1; i < pack_lockfiles.nr; i++)
> +			warning(_("Lockfile created but not reported: %s"),
> +				pack_lockfiles.items[i].string);
>  	}
>  	if (args.check_self_contained_and_connected &&
>  	    args.self_contained_and_connected) {
> diff --git a/connected.c b/connected.c
> index 3135b71e19..937b4bae38 100644
> --- a/connected.c
> +++ b/connected.c
> @@ -43,10 +43,12 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>  
>  	if (transport && transport->smart_options &&
>  	    transport->smart_options->self_contained_and_connected &&
> -	    transport->pack_lockfile &&
> -	    strip_suffix(transport->pack_lockfile, ".keep", &base_len)) {
> +	    transport->pack_lockfiles.nr == 1 &&

Hmph, I can understand why "== 1" case must behave differently from
"== 0" case, but shouldn't the behavior in "> 1" cases be more similar
to the "== 1" case than "== 0" case?

> +	    strip_suffix(transport->pack_lockfiles.items[0].string,
> +			 ".keep", &base_len)) {
>  		struct strbuf idx_file = STRBUF_INIT;
> -		strbuf_add(&idx_file, transport->pack_lockfile, base_len);
> +		strbuf_add(&idx_file, transport->pack_lockfiles.items[0].string,
> +			   base_len);
>  		strbuf_addstr(&idx_file, ".idx");
>  		new_pack = add_packed_git(idx_file.buf, idx_file.len, 1);
>  		strbuf_release(&idx_file);
