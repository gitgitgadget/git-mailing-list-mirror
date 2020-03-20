Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FD6C4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 22:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D5620714
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 22:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="esmtUvdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgCTWyp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 18:54:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54860 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTWyp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 18:54:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 937CA5E7A3;
        Fri, 20 Mar 2020 18:54:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VjV7FlcbrTSnblpWP7q+KO+UhYY=; b=esmtUv
        durdQ9JhKa2TzpCk1R0pPwY3CpTWZq6XqauCi6EvnSfdY+LwbjBlcNc7Jz8eY6hd
        cv4rP5l6BhtgIuKnQsgYbqbYc4M4Vpj8qyixG39i7jt+xlRrDEv3fm+C4fljd6sG
        XDC8+SnaHukjrHc06zvy5MWueIkDKe4xF1VZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TVpb2M2sPz6O2h19Gok3fTGZzNlbs8Cl
        j10SRqVNdUDOVuSHl5Le2/EVLvsvLPaVAbGSAenoAlYy9zhiRPwIUshu48hyARVP
        QyHUO8FvgiD9FRZ+FC0D+vKdULjXI7jH79tV892e7270hIgCyItdrSLu6YhKhvV3
        amozd2YHvXI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 899A75E7A2;
        Fri, 20 Mar 2020 18:54:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CBD705E7A0;
        Fri, 20 Mar 2020 18:54:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] connected: always use partial clone optimization
References: <20200320220045.258462-1-jonathantanmy@google.com>
Date:   Fri, 20 Mar 2020 15:54:41 -0700
In-Reply-To: <20200320220045.258462-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 20 Mar 2020 15:00:45 -0700")
Message-ID: <xmqq1rpmbpse.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C98656B4-6AFD-11EA-846E-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> The addition of the fast path might cause performance reductions in
> these cases:
>
>  - If a partial clone or a fetch into a partial clone fails, Git will
>    fruitlessly run rev-list (it is expected that everything fetched
>    would go into promisor packs, so if that didn't happen, it is most
>    likely that rev-list will fail too).

I agree that it is reasonable not to optimize the system for the
failure case---it is pointless to fail as quick as possible ;-)

>  - Any connectivity checks done by receive-pack, in the (in my opinion,
>    unlikely) event that a partial clone serves receive-pack.

Meaning "I created this repository by partially cloning, and now
I want to update it by pushing into it"?  I am not sure how rare
such a use case is, so I won't be a good judge on this one.

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 1ad26f4d8c..4b2b14ff61 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -672,8 +672,7 @@ static void update_remote_refs(const struct ref *refs,
>  			       const char *branch_top,
>  			       const char *msg,
>  			       struct transport *transport,
> -			       int check_connectivity,
> -			       int check_refs_are_promisor_objects_only)
> +			       int check_connectivity)
>  {
>  	const struct ref *rm = mapped_refs;
>  
> @@ -682,8 +681,6 @@ static void update_remote_refs(const struct ref *refs,
>  
>  		opt.transport = transport;
>  		opt.progress = transport->progress;
> -		opt.check_refs_are_promisor_objects_only =
> -			!!check_refs_are_promisor_objects_only;
>  
>  		if (check_connected(iterate_ref_map, &rm, &opt))
>  			die(_("remote did not send all necessary objects"));
> @@ -1275,7 +1272,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  
>  	update_remote_refs(refs, mapped_refs, remote_head_points_at,
>  			   branch_top.buf, reflog_msg.buf, transport,
> -			   !is_local, filter_options.choice);
> +			   !is_local);
>  
>  	update_head(our_head_points_at, remote_head, reflog_msg.buf);
>  
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index bf6bab80fa..1097e1e512 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -908,13 +908,6 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  	if (!connectivity_checked) {
>  		struct check_connected_options opt = CHECK_CONNECTED_INIT;
>  
> -		if (filter_options.choice)
> -			/*
> -			 * Since a filter is specified, objects indirectly
> -			 * referenced by refs are allowed to be absent.
> -			 */
> -			opt.check_refs_are_promisor_objects_only = 1;
> -
>  		rm = ref_map;
>  		if (check_connected(iterate_ref_map, &rm, &opt)) {
>  			rc = error(_("%s did not send all necessary objects\n"), url);
> diff --git a/connected.c b/connected.c
> index 7e9bd1bc62..846f2e4eef 100644
> --- a/connected.c
> +++ b/connected.c
> @@ -52,7 +52,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>  		strbuf_release(&idx_file);
>  	}
>  
> -	if (opt->check_refs_are_promisor_objects_only) {
> +	if (has_promisor_remote()) {

Earlier we would have this bit on only when filter_options.choice
was non-NULL but this allows us to take the branch as long as we
are lazily populated.  Makes sense.

> @@ -71,13 +71,18 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>  				if (find_pack_entry_one(oid.hash, p))
>  					goto promisor_pack_found;
>  			}
> -			return 1;
> +			/*
> +			 * Fallback to rev-list with oid and the rest of the
> +			 * object IDs provided by fn.
> +			 */
> +			goto no_promisor_pack_found;

OK.  This is the "fallback" thing you mentioned in the log message.
Makes sense.

>  promisor_pack_found:
>  			;
>  		} while (!fn(cb_data, &oid));
>  		return 0;
>  	}
>  
> +no_promisor_pack_found:
>  	if (opt->shallow_file) {
>  		argv_array_push(&rev_list.args, "--shallow-file");
>  		argv_array_push(&rev_list.args, opt->shallow_file);


