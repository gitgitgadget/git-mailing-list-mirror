Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6250C433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 22:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238588AbiC2W4f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 18:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbiC2W4e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 18:56:34 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041B243EC9
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 15:54:46 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B5431976EE;
        Tue, 29 Mar 2022 18:54:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=A8aqBXiRAiJvvYe+qkU8QPR5WSZ10y0oBU1QZ9xfAWQ=; b=Kj8I
        MifFp19XY5dJ+ymN8v5hgMIWwjGLZsx/z+1Xz8++VzOv4JVjVyzVPfNwCW3LUHQc
        +vXINMlzxTQQYs2pJHaziH0wATD2V6aLk0PnCoee6y+UzCjoaB72DQSgSZ3K6Mz0
        Nccbp2MoAPp3X4EuhmxIoBMQa1rUOh6a/O6p19I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 92E691976EC;
        Tue, 29 Mar 2022 18:54:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 05C6D1976EB;
        Tue, 29 Mar 2022 18:54:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Subject: Re: [PATCH v3 1/3] fetch-pack: refactor packet writing and fetch
 options
References: <20220208235631.732466-1-calvinwan@google.com>
        <20220328191112.3092139-1-calvinwan@google.com>
        <20220328191112.3092139-2-calvinwan@google.com>
Date:   Tue, 29 Mar 2022 15:54:43 -0700
Message-ID: <xmqqfsn0qsi4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3980ED20-AFB3-11EC-9E60-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> -static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
> -						 const struct string_list *server_options)
> +static void write_command_and_capabilities(struct strbuf *req_buf,
> +						 const struct string_list *server_options, const char* command)

Reindent the second line to take advantage of the fact that the
function name is now slightly shorter?

It is named "command" and "capabilities", but the parameters it
takes has the "command" at the end.  We probably want to swap them,
i.e.

static void write_command_and_capabilities(struct strbuf *req_buf,
					   const char *command,
					   const struct string_list *server_options)
	
Note that asterisk sticks to identifier, not to type, in this code base.

>  {
>  	const char *hash_name;
>  
> -	if (server_supports_v2("fetch", 1))
> -		packet_buf_write(req_buf, "command=fetch");
> +	if (server_supports_v2(command, 1))
> +		packet_buf_write(req_buf, "command=%s", command);
>  	if (server_supports_v2("agent", 0))
>  		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
>  	if (advertise_sid && server_supports_v2("session-id", 0))
> @@ -1279,7 +1279,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
>  	int done_sent = 0;
>  	struct strbuf req_buf = STRBUF_INIT;
>  
> -	write_fetch_command_and_capabilities(&req_buf, args->server_options);
> +	write_command_and_capabilities(&req_buf, args->server_options, "fetch");
>  
>  	if (args->use_thin_pack)
>  		packet_buf_write(&req_buf, "thin-pack");

The above two hunks (and there is another one at the end) are
trivial no-op refactoring, and the first paragraph of the proposed
log message clearly explains it.

> @@ -1598,18 +1598,18 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  		reader.me = "fetch-pack";
>  	}
>  
> +	/* v2 supports these by default */
> +	allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
> +	use_sideband = 2;
> +	if (args->depth > 0 || args->deepen_since || args->deepen_not)
> +		args->deepen = 1;
> +
>  	while (state != FETCH_DONE) {
>  		switch (state) {
>  		case FETCH_CHECK_LOCAL:
>  			sort_ref_list(&ref, ref_compare_name);
>  			QSORT(sought, nr_sought, cmp_ref_by_name);
>  
> -			/* v2 supports these by default */
> -			allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
> -			use_sideband = 2;
> -			if (args->depth > 0 || args->deepen_since || args->deepen_not)
> -				args->deepen = 1;
> -
>  			/* Filter 'ref' by 'sought' and those that aren't local */
>  			mark_complete_and_common_ref(negotiator, args, &ref);
>  			filter_refs(args, &ref, sought, nr_sought);

The second paragraph of the proposed log message touched briefly
about the existence of this change.  It is a no-op for the current
code if two conditions are met: (1) the initial state is CHECK_LOCAL,
(2) we only enter CHECK_LOCAL once and never return to it.  And they
both hold true, so this is a no-op change.

But I am not sure if it is a good idea to have this in this patch.
Possibilities are (1) this patch as-is is OK, (2) move it in a
separate patch as it has nothing to do with the other refactoring,
or (3) do it as part of the change that wants this change.

I may form an opinion once I see the step that wants this change,
but not yet.

> @@ -2060,7 +2060,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
>  		int received_ready = 0;
>  
>  		strbuf_reset(&req_buf);
> -		write_fetch_command_and_capabilities(&req_buf, server_options);
> +		write_command_and_capabilities(&req_buf, server_options, "fetch");
>  
>  		packet_buf_write(&req_buf, "wait-for-done");
