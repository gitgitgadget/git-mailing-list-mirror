Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBE501FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 22:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933242AbdCGWnA (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 17:43:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63969 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756493AbdCGWmo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 17:42:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 329427F0D4;
        Tue,  7 Mar 2017 17:42:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=KEews8hWiiLUVY+1PIMKWqsWDW0=; b=o/I4EW0X5sy/OKP6y9s3
        8eKyLpMFrOsgVnZEg79KqzH/RY7zwHUIF5T/23cqccYL6zKbk1qLLH1zonKxGGv1
        B/7ivG5nKhP1CtRo5jf5bvK31gCMMDOjFO44Qdxo4qVO4H0L9LptLgyPD1QRJ0V7
        wpfNN/3sbiiw467KihgBmwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=jdIvHT28dakBz2PMYcRqMz0IlCy5NhJ8Zmnb0IAYuLnyJm
        YGlgK72KkVhnA055JLpOnin+9rpk04GGfFtRqusJwNj+2141ZYIJKTl40xqnDQo8
        Qfe3ahoL0dv5IaUANjEpCoE2Cg05vRFrriU/uywiWmg0phThXT818XVaZM1yY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B3E17F0D3;
        Tue,  7 Mar 2017 17:42:29 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7F3667F0D1;
        Tue,  7 Mar 2017 17:42:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH 16/18] entry.c: update submodules when interesting
References: <20170302004759.27852-1-sbeller@google.com>
        <20170306205919.9713-1-sbeller@google.com>
        <20170306205919.9713-17-sbeller@google.com>
Date:   Tue, 07 Mar 2017 14:42:27 -0800
Message-ID: <xmqqtw746758.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 57C410CE-0387-11E7-832F-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  entry.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/entry.c b/entry.c
> index c6eea240b6..d2b512da90 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -2,6 +2,7 @@
>  #include "blob.h"
>  #include "dir.h"
>  #include "streaming.h"
> +#include "submodule.h"
>  
>  static void create_directories(const char *path, int path_len,
>  			       const struct checkout *state)
> @@ -146,6 +147,7 @@ static int write_entry(struct cache_entry *ce,
>  	unsigned long size;
>  	size_t wrote, newsize = 0;
>  	struct stat st;
> +	const struct submodule *sub;
>  
>  	if (ce_mode_s_ifmt == S_IFREG) {
>  		struct stream_filter *filter = get_stream_filter(ce->name,
> @@ -203,6 +205,10 @@ static int write_entry(struct cache_entry *ce,
>  			return error("cannot create temporary submodule %s", path);
>  		if (mkdir(path, 0777) < 0)
>  			return error("cannot create submodule directory %s", path);
> +		sub = submodule_from_ce(ce);
> +		if (sub)
> +			return submodule_move_head(ce->name,
> +				NULL, oid_to_hex(&ce->oid), SUBMODULE_MOVE_HEAD_FORCE);
>  		break;
>  	default:
>  		return error("unknown file mode for %s in index", path);
> @@ -259,7 +265,31 @@ int checkout_entry(struct cache_entry *ce,
>  	strbuf_add(&path, ce->name, ce_namelen(ce));
>  
>  	if (!check_path(path.buf, path.len, &st, state->base_dir_len)) {
> +		const struct submodule *sub;
>  		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
> +		/*
> +		 * Needs to be checked before !changed returns early,
> +		 * as the possibly empty directory was not changed
> +		 */
> +		sub = submodule_from_ce(ce);
> +		if (sub) {
> +			int err;
> +			if (!is_submodule_populated_gently(ce->name, &err)) {
> +				struct stat sb;
> +				if (lstat(ce->name, &sb))
> +					die(_("could not stat file '%s'"), ce->name);
> +				if (!(st.st_mode & S_IFDIR))
> +					unlink_or_warn(ce->name);

We found that the path ce->name is supposed to be a submodule that
is checked out, we found that the submodule is not yet populated, we
tried to make sure what is on that path, and its failure would cause
us to die().  All that is sensible.

Then we want to make sure the filesystem entity at the path
currently is a directory and otherwise unlink (i.e. we may have an
unrelated file that is not tracked there, or perhaps the user earlier
decided that replacing the submodule with a single file is a good
idea, but then getting rid of the change with "checkout -f" before
doing "git add" on that file).  That is also sensible.

But if that unlink fails, shouldn't we die, just like the case where
we cannot tell what is at the path ce->name?

And if that unlink succeeds, instead of having an empty directory,
we start the "move-head" call to switch from NULL to ce->oid without
having any directory.  Wouldn't we want to mkdir() here (and remove
mkdir() in submodule_move_head() if there is one---if there isn't
then I do not think this codepath would work)?

If we had a directory here, but if that directory is not empty,
should we proceed?  I am assuming (I haven't carefully read
"move-head") that it is OK because the "run an equivalent of
'checkout --detach ce->oid'" done by "move-head" would notice a
possible information loss to overwrite an untracked path (everything
is "untracked" as the head moves from NULL to ce->oid in this case),
and prevent it from happening.

Am I reading the design correctly?

> +				return submodule_move_head(ce->name,
> +					NULL, oid_to_hex(&ce->oid),
> +					SUBMODULE_MOVE_HEAD_FORCE);
> +			} else
> +				return submodule_move_head(ce->name,
> +					"HEAD", oid_to_hex(&ce->oid),
> +					SUBMODULE_MOVE_HEAD_FORCE);
> +		}
> +
>  		if (!changed)
>  			return 0;
>  		if (!state->force) {
