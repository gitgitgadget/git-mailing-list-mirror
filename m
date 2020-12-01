Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E88C64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 05:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31CF720715
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 05:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vBWQceLY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgLAFAr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 00:00:47 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55421 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgLAFAq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 00:00:46 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1CF9C10F70C;
        Tue,  1 Dec 2020 00:00:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=ipQYlCOCWxIqJdr0FWtVefJ4rTQ=; b=vBWQceLY3bE5cDh8zisy
        Lij7kV4mQ3Z8W72cdtLmwnu0mjFM66n1UAQ8NyUkyH9ebewgBOhnMpBIsFE3r1ss
        2L/zQM3VHIvqlUqT4XkEdllLDj0S+IznMTDN2CMThUVArTVqBGUe5IGfCMyMcpJq
        nezXDUwbmcr+C0jBy83qKac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=MHGUpVU4/cESb3fH4ifuIcWicIRCV4ljwxWRe4qIf3n2tA
        1Qbo8QYwCt5fOd0JJTLO+WIjWI7HjRqXnvt4EsR30XLtyregz+82t9QPvNz4RYTR
        clfnOr112ZDK0tYNEfo5mr7OF8glhVyLQYXJ8P61GnMhyegUzph6Ox6l90kwc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DFB0510F702;
        Tue,  1 Dec 2020 00:00:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1A56610F6E2;
        Mon, 30 Nov 2020 23:59:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] init-db: init the_repository->hash_algo early from
 GIT_DEFAULT_HASH
References: <pull.924.git.git.1606419582190.gitgitgadget@gmail.com>
Date:   Mon, 30 Nov 2020 20:59:57 -0800
Message-ID: <xmqq5z5mruia.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0FF9D4BA-3392-11EB-BE86-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> The reftable backend needs to know the hash algorithm for writing the
> initialization hash table.
>
> The initial reftable contains a symref HEAD => "main" (or "master"), which is
> agnostic to the size of hash value, but this is an exceptional circumstance, and
> the reftable library does not cater for this exception. It insists that all
> tables in the stack have a consistent format ID for the hash algorithm.
>
> Call set_repo_hash_algo directly after reading out GIT_DEFAULT_HASH.

Seeing that there is no mention of the_repository in the entire
init-db.c file, that the same information is in repo_fmt which is
passed to the init-db.c::create_default_files() function, and that
create_default_files() is where the initial set of refs is prepared
in the current system, it is not clear why this patch is needed
(i.e. why we consider the current code that has no mention of
the_repository is wrong).  Isn't it the matter of passing the hash
taken from repo_fmt to the refs API to initialize that part of the
repository, instead of relying on half-initialized state in
the_repository?  It's not like only the hash_algo member is yet to
be prepared in the_repository instance at that point in the code.
Most of the members are, except for a very few fields initialized by
initialize_the_repository(), not filled in the codepath, no?

So, this might have been the most convenient way to pass hash_algo
down but the patch does not convince me that it is the best way.  It
may be, but it does not answer questions like "what makes us sure
that hash-algo will stay to be the only thing we need to fill early
in this codepath?"

If the patch _were_ to fill many other members of the_repository to
make us pretend as if we did the setup_git_dir() in the repository
we just created, and the hash_algo is filled merely as part of it,
then it would have been much more convincing that we are moving in
the right direction.  It would for example mean gitdir/commondir
would be filled among other members, and the existing "mkdir()" to
manually prepare "refs/" for files backend in init-db.c can probably
be removed and instead would be done by calling a new entry-point
that initializes the initial set of refs in the refs API.  And that
entry-point would either rely on the_repository or take a repository
instance, and use hash_algo member of that structure to do its thing.

So, I dunno.

> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 01bc648d41..5c8c67fec6 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -391,6 +391,7 @@ static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash
>  			die(_("unknown hash algorithm '%s'"), env);
>  		repo_fmt->hash_algo = env_algo;
>  	}
> +	repo_set_hash_algo(the_repository, repo_fmt->hash_algo);
>  }
>  
>  int init_db(const char *git_dir, const char *real_git_dir,
>
> base-commit: faefdd61ec7c7f6f3c8c9907891465ac9a2a1475
