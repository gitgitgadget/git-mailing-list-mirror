Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99C8C4332F
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 12:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiKEMqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 08:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKEMqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 08:46:09 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6C923BFC
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 05:46:08 -0700 (PDT)
Received: (qmail 24610 invoked by uid 109); 5 Nov 2022 12:46:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 05 Nov 2022 12:46:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7227 invoked by uid 111); 5 Nov 2022 12:46:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 05 Nov 2022 08:46:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 5 Nov 2022 08:46:05 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 2/3] revision: add new parameter to specify all
 visible refs
Message-ID: <Y2ZbDXYb1jGqSfTj@coredump.intra.peff.net>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667485737.git.ps@pks.im>
 <3ccd8fc0e35407e5c9ff896165f122b10598e0e2.1667485737.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3ccd8fc0e35407e5c9ff896165f122b10598e0e2.1667485737.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 03, 2022 at 03:37:32PM +0100, Patrick Steinhardt wrote:

> Users can optionally hide refs from remote users in git-upload-pack(1),
> git-receive-pack(1) and others via the `transfer.hideRefs`, but there is
> not an easy way to obtain the list of all visible or hidden refs right
> now. We'll require just that though for a performance improvement in our
> connectivity check.
> 
> Add a new pseudo-ref `--visible-refs=` that pretends as if all refs have
> been added to the command line that are not hidden. The pseudo-ref
> requiers either one of "transfer", "uploadpack" or "receive" as argument
> to pay attention to `transfer.hideRefs`, `uploadpack.hideRefs` or
> `receive.hideRefs`, respectively.

Thanks for re-working this. I think it's a sensible path forward for the
problem you're facing.

There were two parts of the implementation that surprised me a bit.
These might just be nits, but because this is a new user-facing plumbing
option that will be hard to change later, we should make sure it fits in
with the adjacent features.

The two things I saw were:

  1. The mutual-exclusion selection between "transfer", "uploadpack",
     and "receive" is not how those options work in their respective
     programs. The "transfer.hideRefs" variable is respected for either
     program. So whichever program you are running, it will always look
     at both "transfer" and itself ("uploadpack" or "receive"). Another
     way to think of it is that the "section" argument to
     parse_hide_refs_config() is not a config section so much as a
     profile. And the profiles are:

       - uploadpack: respect transfer.hideRefs and uploadpack.hideRefs
       - receive: respect transfer.hideRefs and receive.hideRefs

     So it does not make sense to ask for "transfer" as a section; each
     of the modes is already looking at transfer.hideRefs.

     In theory if this option was "look just at $section.hideRefs", it
     could be more flexible to separate out the two. But that makes it
     more of a pain to use (for normal use, you have to specify both
     "transfer" and "receive"). And that is not what your patch
     implements anyway; because it relies on parse_hide_refs_config(),
     it is always adding in "transfer" under the hood (which is why your
     final patch is correct to just say "--visible-refs=receive" without
     specifying "transfer" as well).

  2. Your "--visible-refs" implies "--all", because it's really "all
     refs minus the hidden ones". That's convenient for the intended
     caller, but not as flexible as it could be. If it were instead
     treated the way "--exclude" is, as a modifier for the next
     iteration option, then you do a few extra things:

       a. Combine multiple exclusions in a single iteration:

            git rev-list --exclude-hidden=receive \
	                 --exclude-hidden=upload \
			 --all

          That excludes both types in a single iteration. Whereas if you
	  did:

	    git rev-list --visible-refs=receive \
	                 --visible-refs=upload

	  that will do _two_ iterations, and end up with the union of
	  the sets. Equivalent to:

	    git rev-list --exclude-hidden=receive --all \
	                 --exclude-hidden=upload  --all

       b. Do exclusions on smaller sets than --all:

            git rev-list --exclude-hidden=receive \
	                 --branches

	  which would show just the branches that we'd advertise.

     Now I don't have a particular use case for either of those things.
     But they're plausible things to want in the long run, and they fit
     in nicely with the existing ref-selection scheme of rev-list. They
     do make your call from check_connected() slightly longer, but it is
     pretty negligible. It's "--exclude-hidden=receive --all" instead of
     "--visible-refs=hidden".

So looking at the patch itself, if you wanted to take my suggestions:

> +--visible-refs=[transfer|receive|uploadpack]::
> +	Pretend as if all the refs that have not been hidden via either one of
> +	`transfer.hideRefs`, `receive.hideRefs` or `uploadpack.hideRefs` are
> +	listed on the command line.

This would drop "transfer" as a mode, and explain that the argument is
"hide the refs that receive-pack would use", etc.

Likewise, the name would switch and pick up explanation similar to
--exclude below about how it affects the next --all, etc.

> @@ -1542,11 +1545,13 @@ static int handle_one_ref(const char *path, const struct object_id *oid,
>  			  int flag UNUSED,
>  			  void *cb_data)
>  {
> +	const char *stripped_path = strip_namespace(path);
>  	struct all_refs_cb *cb = cb_data;
>  	struct object *object;
>  
> -	if (ref_excluded(cb->all_revs->ref_excludes, path))
> -	    return 0;
> +	if (ref_excluded(cb->all_revs->ref_excludes, path) ||
> +	    ref_is_hidden(stripped_path, path, &cb->hidden_refs))
> +		return 0;

This would stay the same. We'd still exclude hidden refs during the
iteration.

> @@ -2759,6 +2772,21 @@ static int handle_revision_pseudo_opt(struct rev_info *revs,
>  		parse_list_objects_filter(&revs->filter, arg);
>  	} else if (!strcmp(arg, ("--no-filter"))) {
>  		list_objects_filter_set_no_filter(&revs->filter);
> +	} else if (skip_prefix(arg, "--visible-refs=", &arg)) {
> +		struct all_refs_cb cb;
> +
> +		if (strcmp(arg, "transfer") && strcmp(arg, "receive") &&
> +		    strcmp(arg, "uploadpack"))
> +			die(_("unsupported section for --visible-refs: %s"), arg);
> +
> +		init_all_refs_cb(&cb, revs, *flags);
> +		cb.hidden_refs_section = arg;
> +		git_config(hide_refs_config, &cb);
> +
> +		refs_for_each_ref(refs, handle_one_ref, &cb);
> +
> +		string_list_clear(&cb.hidden_refs, 1);
> +		clear_ref_exclusion(&revs->ref_excludes);

And here we'd do the same git_config() call, but drop the
refs_for_each_ref() call. We'd clear the hidden_refs field in all the
places that call clear_ref_exclusion() now.

In fact, you could argue that all of this should just be folded into
clear_ref_exclusion() and ref_excluded(), since from the perspective of
the iterating code, they are all part of the same feature. I don't mind
leaving it separate from the perspective of rev-list, though I think
if you did so, it would all Just Work for "rev-parse", too (I doubt
anybody cares in practice, but it's probably better to keep it
consistent).

-Peff
