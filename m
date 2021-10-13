Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D20C433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 20:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A86036101D
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 20:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhJMUXn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 16:23:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53503 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhJMUXm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 16:23:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1AE4D8C2C;
        Wed, 13 Oct 2021 16:21:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t+s/eTqtJ3s9FUQohUz7eb8xn9IYsKpkFiMcSk
        IfNGg=; b=huSM6TQwICZsVAyn+94ztRnaeAEdMayDjMP45CrdAl57DZFL6b5ZSN
        hGjmURZV4ssczCTf8zG2QOYhuR3I3V1PfkzkMDWkOeQXnO9JTKKzQV30khUEm4Td
        RvqOe7V3cUzQa92SHGlBLRdo4uiFfUdWANYEZv2XidzOfgc4hYhqM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 99151D8C2B;
        Wed, 13 Oct 2021 16:21:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F398ED8C26;
        Wed, 13 Oct 2021 16:21:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] remote: move static variables into
 per-repository struct
References: <pull.1103.git.git.1633633635.gitgitgadget@gmail.com>
        <20211013193127.76537-1-chooglen@google.com>
        <20211013193127.76537-2-chooglen@google.com>
Date:   Wed, 13 Oct 2021 13:21:36 -0700
In-Reply-To: <20211013193127.76537-2-chooglen@google.com> (Glen Choo's message
        of "Wed, 13 Oct 2021 12:31:25 -0700")
Message-ID: <xmqqlf2wfzfz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B38C324-2C63-11EC-B829-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> remote.c does not work with non-the_repository because it stores its
> state as static variables. To support non-the_repository, we can use a
> per-repository struct for the remotes subsystem.
>
> Prepare for this change by defining a struct remote_state that holds
> the remotes subsystem state and move the static variables of remote.c
> into the_repository->remote_state.

That all sounds very sensible, but ...

> diff --git a/remote.h b/remote.h
> index 5a59198252..184d14af3d 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -23,6 +23,40 @@ enum {
>  	REMOTE_BRANCHES
>  };
>  
> +struct rewrite {
> +	const char *base;
> +	size_t baselen;
> +	struct counted_string *instead_of;
> +	int instead_of_nr;
> +	int instead_of_alloc;
> +};
> +struct rewrites {

Missing a blank line between two type decls.

> +	struct rewrite **rewrite;
> +	int rewrite_alloc;
> +	int rewrite_nr;
> +};

It is a bit sad that we still have to keep "struct rewrites"; if we
see how .remotes and .branches are handled, we probably should have
left the <array, alloc, nr> 3-tuple for "struct rewrite" without an
extra layer.  But this step is about moving things around and
wrapping the set of existing static file-scope-global variables into
a structure, so such a restructuring would not belong here.  OK.

> +struct remote_state {
> +	int config_loaded;
> +
> +	struct remote **remotes;
> +	int remotes_alloc;
> +	int remotes_nr;
> +	struct hashmap remotes_hash;
> +
> +	struct branch **branches;
> +	int branches_alloc;
> +	int branches_nr;
> +
> +	struct branch *current_branch;
> +	const char *pushremote_name;
> +
> +	struct rewrites rewrites;
> +	struct rewrites rewrites_push;
> +};
> +void remote_state_clear(struct remote_state *remote_state);

Missing a blank line after "struct" decl.

Thanks.
