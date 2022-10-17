Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5BCC4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 13:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiJQN4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 09:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiJQN4u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 09:56:50 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D895F137
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:56:44 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 68B671CB14A;
        Mon, 17 Oct 2022 09:56:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=XRn/D/tBMpn1GBQS1th7NhYAwPpPnTNa4CJNuSj+h0k=; b=lyy8
        Yzznh5RluEGeaCIqF9nFWcpbit6GGSTykqxduReDrRiZq52IiGscxnu6+ERHUAL/
        NGQu6nr21HfdgwtPzqdSZMtbaRF1FAIcrDMeJXQoQJ/5XphwEYsLFtB97CLtxdz2
        LLwg94coTyxoga9aKZmbpjYaaGxmonpqZBsYSuM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 612851CB149;
        Mon, 17 Oct 2022 09:56:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 720CC1CB144;
        Mon, 17 Oct 2022 09:56:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heather Lapointe via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>
Subject: Re: [PATCH v3 4/9] tree: handle submodule case for read_tree_at
 properly
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
        <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
        <d3d1738e670d5dbf1378fc5c3209b2e98234a771.1665973401.git.gitgitgadget@gmail.com>
Date:   Mon, 17 Oct 2022 06:56:37 -0700
Message-ID: <xmqqsfjm1rl6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85418CF6-4E23-11ED-BA28-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heather Lapointe via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Heather Lapointe <alpha@alphaservcomputing.solutions>
>
> This supports traversal into an actual submodule for read_tree_at.
> The logic is blocked on pathspec->recurse_submodules now,
> but previously hadn't been executed due to all fn() cases
> returning early for submodules.
>
> Signed-off-by: Heather Lapointe <alpha@alphaservcomputing.solutions>
> ---
>  tree.c | 88 ++++++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 61 insertions(+), 27 deletions(-)
>
> diff --git a/tree.c b/tree.c
> index 13f9173d45e..2a087c010f9 100644
> --- a/tree.c
> +++ b/tree.c
> @@ -8,6 +8,7 @@
>  #include "alloc.h"
>  #include "tree-walk.h"
>  #include "repository.h"
> +#include "pathspec.h"
>  
>  const char *tree_type = "tree";
>  
> @@ -47,40 +48,73 @@ int read_tree_at(struct repository *r,
>  			return -1;
>  		}
>  
> -		if (S_ISDIR(entry.mode))
> +		if (S_ISDIR(entry.mode)) {
>  			oidcpy(&oid, &entry.oid);
> +			len = tree_entry_len(&entry);
> +			strbuf_add(base, entry.path, len);
> +			strbuf_addch(base, '/');
> +			retval = read_tree_at(r, lookup_tree(r, &oid),
> +						base, pathspec,
> +						fn, context);
> +			strbuf_setlen(base, oldlen);
> +			if (retval)
> +				return -1;

The diff output makes it appear as if we are now adding many extra
processing to a normal directory case, but it actually folds the
code that was originally outside the if/else if/ cascade here.  So
I think this is not breaking the normal directory case.

> +		} else if (pathspec->recurse_submodules && S_ISGITLINK(entry.mode)) {
> +			struct commit *commit;
> +			struct repository subrepo;
> +			struct repository* subrepo_p = &subrepo;
> +			struct tree* submodule_tree;

In our codebase, star/asterisk for a pointer declaration sticks to
the variable, not the type.

cf. Documentation/CodingGuidelines

> +			char *submodule_rel_path;

Funny that the new code sometimes gets it right ;-)

> +			int name_base_len = 0;
> +
> +			len = tree_entry_len(&entry);
> +			strbuf_add(base, entry.path, len);
> +			submodule_rel_path = base->buf;
> +			// repo_submodule_init expects a path relative to submodule_prefix

We avoid // comments.

> +			if (r->submodule_prefix) {
> +				name_base_len = strlen(r->submodule_prefix);
> +				// we should always expect to start with submodule_prefix
> +				assert(!strncmp(submodule_rel_path, r->submodule_prefix, name_base_len));
> +				// strip the prefix
> +				submodule_rel_path += name_base_len;
> +				// if submodule_prefix doesn't end with a /, we want to get rid of that too
> +				if (is_dir_sep(submodule_rel_path[0])) {
> +					submodule_rel_path++;
> +				}
> +			}
> +
> +			if (repo_submodule_init(subrepo_p, r, submodule_rel_path, null_oid()))
> +				die("couldn't init submodule %s", base->buf);
> +
> +			if (repo_read_index(subrepo_p) < 0)
> +				die("index file corrupt");

Why?  You are going to ask the object store of the submodule
repository, and to do so you do not need to have its index read into
the core.

> +			commit = lookup_commit(subrepo_p, &entry.oid);
>  			if (!commit)
> -				die("Commit %s in submodule path %s%s not found",
> +				die("Commit %s in submodule path %s not found",
>  				    oid_to_hex(&entry.oid),
> -				    base->buf, entry.path);
> -
> -			// FIXME: This is the wrong repo instance (it refers to the superproject)
> -			// it will always fail as is (will fix in later patch)
> -			// This current codepath isn't executed by any existing callbacks
> -			// so it wouldn't show up as an issue at this time.
> -			if (repo_parse_commit(r, commit))
> -				die("Invalid commit %s in submodule path %s%s",
> +				    base->buf);
> +
> +			if (repo_parse_commit(subrepo_p, commit))
> +				die("Invalid commit %s in submodule path %s",
>  				    oid_to_hex(&entry.oid),
> -				    base->buf, entry.path);
> +				    base->buf);
>  
> -			oidcpy(&oid, get_commit_tree_oid(commit));
> -		}
> -		else
> -			continue;
> +			submodule_tree = repo_get_commit_tree(subrepo_p, commit);
> +			oidcpy(&oid, submodule_tree ? &submodule_tree->object.oid : NULL);
>  
> -		len = tree_entry_len(&entry);
> -		strbuf_add(base, entry.path, len);
> -		strbuf_addch(base, '/');
> -		retval = read_tree_at(r, lookup_tree(r, &oid),
> -				      base, pathspec,
> -				      fn, context);
> -		strbuf_setlen(base, oldlen);
> -		if (retval)
> -			return -1;
> +			strbuf_addch(base, '/');
> +
> +			retval = read_tree_at(subrepo_p, lookup_tree(subrepo_p, &oid),
> +						base, pathspec,
> +						fn, context);
> +			if (retval)
> +			    die("failed to read tree for %s", base->buf);
> +			strbuf_setlen(base, oldlen);
> +			repo_clear(subrepo_p);

This is a lot of new code, which must be done correctly.  An easier
way out to use the add_submodule_odb() trick that the original code
assumed becomes somewhat tempting (I guess we would do that in fn()
that would tell us to recurse into this codepath upon seeing a gitlink
entry).  Then we wouldn't have had to touch any tree() calls that were
taught to take "struct repository *" in earlier steps in this series.

But at some point, we would need to bite the bullet and plumb the
repository pointer through the callchain of more APIs, and this may
be that point.  I dunno.

> +		}
> +		// else, this is a file (or a submodule, but no pathspec->recurse_submodules)
>  	}
>  	return 0;
>  }
