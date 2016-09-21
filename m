Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 665421F935
	for <e@80x24.org>; Wed, 21 Sep 2016 22:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756124AbcIUWxq (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 18:53:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61721 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755672AbcIUWxp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 18:53:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AB32408CA;
        Wed, 21 Sep 2016 18:53:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eVLZILjyxg5yFSyNJqhgXbjoKcc=; b=YfPRE8
        OI39AsRJoNM2lDPOah07wzCdFMymScTyDgHWTqrc/2/dZd0J54Q1zJXhrC+SYiBw
        q/X16B6krJUPdc33XFr5tKuL9LDhMRkZIUSuaiUORF445ZdEZBbciV4oZz5Bkq9A
        FKkSWHzdr4HgWtr4Ep3cj127zAn3eRImEo2xQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hwSPlDl2DLCmk59NJMjpwcpt3arHuMs0
        njbv+JViqMuw2yhmVGdHvJEonf2PLNENUEZaF6Vc0V9+IVGXmkcD5w20JCF97kfO
        Fv3Z87xjWrgxlHc5ztO48uOHu4GNXcKvB7c2yAd4wbQHL7r1n/hn40Ot+XEq+3Ek
        YQrSjavjnEY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 029DD408C9;
        Wed, 21 Sep 2016 18:53:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7C28F408C8;
        Wed, 21 Sep 2016 18:53:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] ls-files: add pathspec matching for submodules
References: <1474495472-94190-1-git-send-email-bmwill@google.com>
        <1474495472-94190-2-git-send-email-bmwill@google.com>
Date:   Wed, 21 Sep 2016 15:53:41 -0700
In-Reply-To: <1474495472-94190-2-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Wed, 21 Sep 2016 15:04:32 -0700")
Message-ID: <xmqqtwd86f0q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F1019AE-804E-11E6-B460-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Pathspecs can be a bit tricky when trying to apply them to submodules.
> The main challenge is that the pathspecs will be with respect to the
> super module and not with respect to paths in the submodule.  The
> approach this patch takes is to pass in the identical pathspec from the
> super module to the submodule in addition to the submodule-prefix, which
> is the path from the root of the super module to the submodule, and then
> we can compare an entry in the submodule prepended with the
> submodule-prefix to the pathspec in order to determine if there is a
> match.
>
> This patch also permits the pathspec logic to perform a prefix match against
> submodules since a pathspec could refer to a file inside of a submodule.
> Due to limitations in the wildmatch logic, a prefix match is only done
> literally.  If any wildcard character is encountered we'll simply punt
> and produce a false positive match.  More accurate matching will be done
> once inside the submodule.  This is due to the super module not knowing
> what files could exist in the submodule.

Sounds sensible.  Just a minor nit in terminology, but I think we
fairly consistently say "a superproject contains submodules" (run
"git grep -E 'super *(module|project)'").

I'd suggest s/super module/superproject/ for consistency.

> diff --git a/dir.c b/dir.c
> index 0ea235f..9df6d36 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -207,8 +207,9 @@ int within_depth(const char *name, int namelen,
>  	return 1;
>  }
>  
> -#define DO_MATCH_EXCLUDE   1
> -#define DO_MATCH_DIRECTORY 2
> +#define DO_MATCH_EXCLUDE   (1<<0)
> +#define DO_MATCH_DIRECTORY (1<<1)
> +#define DO_MATCH_SUBMODULE (1<<2)
>  
>  /*
>   * Does 'match' match the given name?
> @@ -283,6 +284,29 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
>  			 item->nowildcard_len - prefix))
>  		return MATCHED_FNMATCH;
>  
> +	/* Perform checks to see if "name" is a super set of the pathspec */
> +	if (flags & DO_MATCH_SUBMODULE) {
> +		/* Check if the name is a literal prefix of the pathspec */
> +		if ((item->match[namelen] == '/') &&
> +		    !ps_strncmp(item, match, name, namelen))
> +			return MATCHED_RECURSIVELY;

An example of this test would be to match pathspec "sub/file" with
submodule path "sub"?

item->match[namelen] is accessed without checking if item->match[]
is long enough here; shouldn't item->len be checked before doing
that?

> +		/*
> +		 * Here is where we would perform a wildmatch to check if
> +		 * "name" can be matched as a directory (or a prefix) against
> +		 * the pathspec.  Since wildmatch doesn't have this capability
> +		 * at the present we have to punt and say that it is a match,
> +		 * esentially returning a false positive (as long as "name"
> +		 * matches upto the first wild character).
> +		 * The submodules themselves will be able to perform more
> +		 * accurate matching to determine if the pathspec matches.
> +		 */
> +		if (item->nowildcard_len < item->len &&
> +		    !ps_strncmp(item, match, name,
> +				item->nowildcard_len - prefix))
> +			return MATCHED_RECURSIVELY;

An example of this test would be to match pathspec "su?/file" with
submodule path "sub", where the substring up to nowildcard_len is
the leading literal string "su" that must match with the path (in
other words, a path "sib" will not match "su?/file").

> +	}
> +

Hmph, isn't this the one that is allowed produce false positive but
cannot afford to give any false negative?  It feels a bit strange
that the code checks two cases where we can positively say that it
is worth descending into, and falling through would give "no this
will never match".  That sounds like invitation for false negatives.

IOW, I would have expected

        if (flags & DO_MATCH_SUBMODULE) {
                if (may match in this case)
                        return MATCHED_RECURSIVE;
                if (may match in this other case)
                        return MATCHED_RECURSIVE;
                ...
                if (obviously cannot match in this case)
                        return 0;
                if (obviously cannot match in this other case)
                        return 0;
                /* otherwise we cannot say */
                return MATCHED_RECURSIVELY;
        }

as the general code structure.

Fully spelled out,

        if (flags & DO_MATCH_SUBMODULE) {
                /* Check if the name is a literal prefix of the pathspec */
                if (namelen < item->len &&
                    item->match[namelen] == '/' &&
                    !ps_strncmp(item, match, name, namelen))
                        return MATCHED_RECURSIVE;

                /* Does the literal leading part have chance of matching? */
                if (item->nowildcard_len < item->len &&
                    namelen <= item->nowildcard_len &&
                    ps_strncmp(item, match, name, namelen))
                        return 0; /* no way "su?/file" can match "sib" */

                /* Otherwise we cannot say */
                return MATCHED_RECURSIVELY;
        }

or something like that.  There may be other "obviously cannot match"
cases we may want to add further.

Thanks.
