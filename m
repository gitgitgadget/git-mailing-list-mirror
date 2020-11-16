Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE7DC5519F
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 23:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F513241A3
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 23:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hcno9sgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgKPX3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 18:29:12 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51239 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgKPX3M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 18:29:12 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D972E97867;
        Mon, 16 Nov 2020 18:29:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cUfh9FD+VoerD4NnEvx/g60ARD8=; b=hcno9s
        gmYE6NNKG1aq7UKxa8krHOWDO8qxYppsaRG9SrIf5OzIYSxjz3BYxZjqmkpKcXAj
        ddhn2Nr2YR1hRtyCR58hfpBRvp2mNzzHN6pCiGXuKppD1zmR1QUWN4bfiPezF4Cr
        KvYvC7E1nFRq9zTvTDB9+mFlrp+d8gXMEPJWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uW14LQ0TUdK08JwPCJfFgSm2og4nhmZU
        Bs87+cZTQzHFxVTb2TpFnJqv8jmiOpEsuiarWeM7D6qhGU22coYzWZSa8Kgxtebu
        NXUkjkojg8/iH2R4KeBaAY8Xv/51kOYEmihGuRCr2G7UkLv3U+ae1kedvHAMemSc
        mNyQ4rlcLgQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C3AD497866;
        Mon, 16 Nov 2020 18:29:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 31B3097864;
        Mon, 16 Nov 2020 18:29:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 3/3] builtin/repack.c: don't move existing packs out of
 the way
References: <cover.1605552016.git.me@ttaylorr.com>
        <d4e73aad14189a00621da9e000d2c6a5fe776d84.1605552016.git.me@ttaylorr.com>
Date:   Mon, 16 Nov 2020 15:29:05 -0800
In-Reply-To: <d4e73aad14189a00621da9e000d2c6a5fe776d84.1605552016.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 16 Nov 2020 13:41:21 -0500")
Message-ID: <xmqqpn4c7uf2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84F1634E-2863-11EB-A257-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> This behavior dates all the way back to 2ad47d6 (git-repack: Be
> careful when updating the same pack as an existing one., 2006-06-25).
> 2ad47d6 is mainly concerned about a case where a newly written pack
> would have a different structure than its index. This used to be
> possible when the pack name was a hash of the set of objects. Under this
> naming scheme, two packs that store the same set of objects could differ
> in delta selection, object positioning, or both. If this happened, then
> any such packs would be unreadable in the instant between copying the
> new pack and new index (i.e., either the index or pack will be stale
> depending on the order that they were copied).

True.  So the idea is that we can now pretend that we never wrote
the new packfile and leave the existing one as-is?

> This patch is mostly limited to removing code paths that deal with the
> 'old' prefixing, with the exception of pack metadata.

... "pack metadata" meaning?  We do not remove and replace the file,
but we update their mtime to keep these packfiles more fresh than
other packfiles, or something?

> t7700.14 ensures
> that 'git repack' will, for example, remove existing bitmaps even if the
> pack written is verbatim the same (when repacking without '-b' in a
> repository unchanged from the time 'git repack -b' was run). So, we have
> to handle metadata that we didn't write, by unlinking any existing
> metadata that our invocation of pack-objects didn't generate itself.

Hmph, t7700.14 wants it that way because?

If we were told to generate a packfile, and we ended up regenerating
the exactly the same one, it appears to me that we can just pretend
nothing happened and leave things as they were?  Puzzled...

> @@ -463,109 +463,34 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  
>  	/*
>  	 * Ok we have prepared all new packfiles.
>  	 */
>  	for_each_string_list_item(item, &names) {
>  		for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
>  			char *fname, *fname_old;
>  
>  			fname = mkpathdup("%s/pack-%s%s",
>  					packdir, item->string, exts[ext].name);
>  			fname_old = mkpathdup("%s-%s%s",
>  					packtmp, item->string, exts[ext].name);
> +
> +			if (((uintptr_t)item->util) & (1 << ext)) {
> +				struct stat statbuffer;
> +				if (!stat(fname_old, &statbuffer)) {
> +					statbuffer.st_mode &= ~(S_IWUSR | S_IWGRP | S_IWOTH);
> +					chmod(fname_old, statbuffer.st_mode);
> +				}
> +
>  				if (rename(fname_old, fname))
>  					die_errno(_("renaming '%s' failed"), fname_old);

OK, so this is where the previous step matters.  We do the same as
before (i.e. stat+chmod and rename) only for paths we have created.

We don't reuse the old one because we have already written a new
file so we won't save anything by doing so, and checking if the
target of rename exists already before deciding not to rename cannot
be made atomic, so just relying on rename() to do the right thing is
a good idea anyway.

> +			} else if (!exts[ext].optional)
> +				die(_("missing required file: %s"), fname_old);

If one branch of if/else if.../else requires multi-statement block,
use {} on all of them, for consistency.

So, if we wrote a few .$ext for a packfile but not some .$ext, if
the one we didn't write is among the necessary one, we are in
trouble?  OK.

> +			else if (unlink(fname) < 0 && errno != ENOENT)
> +				die_errno(_("could not unlink: %s"), fname);

And if we wrote .pack and .idx but not .bitmap, the old .bitmpa that
has the same pack hash may be stale and we discard it for safety?
That sounds "prudent" but it is not immdiately clear from what
danger we are protecting ourselves.

In any case, much of what I speculated while reading the proposed
log message turned out to be false, which may be a sign that the log
message did not explain the approach clearly enough.  I thought that
a newly created file that happened to be identical to existing ones
would be discarded without getting renamed to their final location,
but the code does not do such special casing.  I thought the
'metadata' it talks about were to compensate for side effects of
reusing the old files, but that was not what the 'metadata' was even
about.

Other than that, the change in [2/3] and [3/3] look quite sensible
(I am not saying [1/3] is bad---I haven't looked at it yet).

Thanks.

>  			free(fname);
>  			free(fname_old);
>  		}
>  	}
>  	/* End of pack replacement. */
>  
>  	reprepare_packed_git(the_repository);
