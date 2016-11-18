Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3F821FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 22:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752771AbcKRWOp (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 17:14:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59789 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752578AbcKRWOo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 17:14:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66E5A50C0D;
        Fri, 18 Nov 2016 17:14:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qNcYdxaoDXq+G2H4KGt8ud4G4g8=; b=JgBuUd
        9m29ymws0T6LduBb1Rx8mugVSh1CsWuZmWpgVPjEOX1wrlFG6kvWWBvVLYJMfL3d
        PqR0IRsfuZE+jsyRvNXn3hEpX/VK3weKt0x6V4nI48zFn25psLGND6+lJwYNEawn
        RFbs8dqihRTSG2K6wCDHZJM82AQYxWfy22c+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R0IESeZPUysIzPBG+elJh0VG5ZKtJoTq
        sLk0unMSR8b00+pPvjOmTGb66gDm4mmnpp9rjuTCyKT9IcSN9O/fdWn9Hfj4p7/q
        grsW0rF4i7IspHGURR/IFOYzdmxPqJgUwUabOkVKpWbKtQ1aOKMovtM5jGhRvw8u
        3EArKn6PmFQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DB2B50C0C;
        Fri, 18 Nov 2016 17:14:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D1B2A50C0B;
        Fri, 18 Nov 2016 17:14:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 4/6] grep: optionally recurse into submodules
References: <1478908273-190166-1-git-send-email-bmwill@google.com>
        <1479499135-64269-1-git-send-email-bmwill@google.com>
        <1479499135-64269-5-git-send-email-bmwill@google.com>
Date:   Fri, 18 Nov 2016 14:14:41 -0800
In-Reply-To: <1479499135-64269-5-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Fri, 18 Nov 2016 11:58:53 -0800")
Message-ID: <xmqqlgwgl9ke.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67E32D10-ADDC-11E6-AB87-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> +static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec,
> +		      int cached)
>  {
>  	int hit = 0;
>  	int nr;
> +	struct strbuf name = STRBUF_INIT;
> +	int name_base_len = 0;
> +	if (super_prefix) {
> +		name_base_len = strlen(super_prefix);
> +		strbuf_addstr(&name, super_prefix);
> +	}
> +
>  	read_cache();
>  
>  	for (nr = 0; nr < active_nr; nr++) {
>  		const struct cache_entry *ce = active_cache[nr];
> -		if (!S_ISREG(ce->ce_mode))
> -			continue;
> -		if (!ce_path_match(ce, pathspec, NULL))
> -			continue;
> -		/*
> -		 * If CE_VALID is on, we assume worktree file and its cache entry
> -		 * are identical, even if worktree file has been modified, so use
> -		 * cache version instead
> -		 */
> -		if (cached || (ce->ce_flags & CE_VALID) || ce_skip_worktree(ce)) {
> -			if (ce_stage(ce) || ce_intent_to_add(ce))
> -				continue;
> -			hit |= grep_sha1(opt, ce->oid.hash, ce->name, 0,
> -					 ce->name);
> +		strbuf_setlen(&name, name_base_len);
> +		strbuf_addstr(&name, ce->name);
> +
> +		if (S_ISREG(ce->ce_mode) &&
> +		    match_pathspec(pathspec, name.buf, name.len, 0, NULL,
> +				   S_ISDIR(ce->ce_mode) ||
> +				   S_ISGITLINK(ce->ce_mode))) {
> +			/*
> +			 * If CE_VALID is on, we assume worktree file and its
> +			 * cache entry are identical, even if worktree file has
> +			 * been modified, so use cache version instead
> +			 */
> +			if (cached || (ce->ce_flags & CE_VALID) ||
> +			    ce_skip_worktree(ce)) {
> +				if (ce_stage(ce) || ce_intent_to_add(ce))
> +					continue;
> +				hit |= grep_sha1(opt, ce->oid.hash, ce->name,
> +						 0, ce->name);
> +			} else {
> +				hit |= grep_file(opt, ce->name);
> +			}
> +		} else if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
> +			   submodule_path_match(pathspec, name.buf, NULL)) {
> +			hit |= grep_submodule(opt, NULL, ce->name, ce->name);
>  		}
> -		else
> -			hit |= grep_file(opt, ce->name);

We used to reject anything other than S_ISREG() upfront in the loop,
and then either did grep_sha1() from the cache or from grep_file()
from the working tree.

Now, the guard upfront is removed, and we do the same in the first
part of this if/elseif.  The elseif part deals with a submodule that
could match the pathspec.

Don't we need a final else clause that would skip the remainder of
this loop?  What would happen to a S_ISREG() path that does *NOT*
match the given pathspec?  We used to just "continue", but it seems
to me that such a path will fall through the above if/elseif in the
new code.  Would that be a problem?
