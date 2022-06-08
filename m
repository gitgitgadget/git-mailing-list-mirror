Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC670C43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 22:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbiFHWdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 18:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiFHWdY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 18:33:24 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B7A13E25
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 15:33:22 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CF6E12FE60;
        Wed,  8 Jun 2022 18:33:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cffffNlqlAmv/dnin4GTp48HCPtKwS43ZH6Vm6
        qIrms=; b=QET3nfYmXgOVb59KY3bzOxqRwxJvgmVOmJRmDA4UeDSdcWp1yoK0EE
        Ky6NndhnX+v3h3ESIztpyyYQsfxue0Ho9C+UA4pJzCL4PwHHaQ/yHlw5naw/DShU
        S6Yab/tvXB6c5FFwHZdKabSz77AP4WzZpGxzZzC/Gxx7DNjaPtg2Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1403812FE5F;
        Wed,  8 Jun 2022 18:33:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7940512FE5E;
        Wed,  8 Jun 2022 18:33:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] connected: distinguish local/remote bad objects
References: <20220608210537.185094-1-jonathantanmy@google.com>
Date:   Wed, 08 Jun 2022 15:33:20 -0700
In-Reply-To: <20220608210537.185094-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 8 Jun 2022 14:05:37 -0700")
Message-ID: <xmqqh74upyz3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 006399DE-E77B-11EC-93D2-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index ac29c2b1ae..6f43b2bf8d 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1133,7 +1133,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  
>  		rm = ref_map;
>  		if (check_connected(iterate_ref_map, &rm, &opt)) {
> -			rc = error(_("%s did not send all necessary objects\n"), url);
> +			rc = error(_("connectivity check failed for %s\n"), url);
>  			goto abort;
>  		}
>  	}

Clever.

I was wondering how you are going to deal with the different exit
condition from the rev-list that is only expressed with the two
different messages.  You _could_ grep for "from local" vs "from
remote", but you just let the human user who is staring at the error
message to read it, and stop mentioning the details in this message.

OK.

> diff --git a/connected.c b/connected.c
> index ed3025e7a2..ea773f25db 100644
> --- a/connected.c
> +++ b/connected.c
> @@ -94,6 +94,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>  		strvec_push(&rev_list.args, opt->shallow_file);
>  	}
>  	strvec_push(&rev_list.args,"rev-list");
> +	strvec_push(&rev_list.args, "--detailed-bad-object");
>  	strvec_push(&rev_list.args, "--objects");
>  	strvec_push(&rev_list.args, "--stdin");
>  	if (has_promisor_remote())
> diff --git a/revision.c b/revision.c
> index 090a967bf4..777e762373 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -367,6 +367,16 @@ void add_head_to_pending(struct rev_info *revs)
>  	add_pending_object(revs, obj, "HEAD");
>  }
>  
> +static void NORETURN bad_object(struct rev_info *revs, const char *name,
> +				unsigned int flags)
> +{
> +	if (!revs->detailed_bad_object)
> +		die("bad object %s", name);
> +	if (flags & UNINTERESTING)
> +		die("bad object %s (from local object store)", name);
> +	die("bad object %s (from remote)", name);
> +}

If the missing object you found is reachable from existing tips
(i.e. local aka UNINTERESTING) and also from what they should have
sent (i.e. remote tips), when we discover that the object does not
exist locally (but we can have an in-core shell object whose object
name is already known because child objects that are closer to the
tips than the missing object do exist and point at it), does this
new heuristic work reliably?  

Do we always die and report bad_object() with UNINTERESTING in the
the flags variable, or only when we are lucky?

IOW, if our current branch pionts at A, while the other side says
they are updating it to B,

    X-----o-----A
     \
      x---B

we try to traverse "rev-list ^A B" and make sure everything exists.
If we find objects 'o' missing, it is clear that it was something we
were supposed to have on the local side even before we started the
fetch.  But if 'X' is missing, by the time we notice and report a
missing object, do we always reliably know that it ought to be
reachable from both?  Or do we have 50/50 chance that the traversal
comes from 'o' earlier than from 'x' (in which case X is found to be
missing when we try to see who is the parent of 'o', and flags have
UNINTERESTING bit), or later than from 'x' (in which case X is found
when trying to see who the parents of 'x' is, and we may not know
and we may not bother to find out if X is also a parent of 'o',
hence we'd still say 'You do not have X, and we were looking at 'x',
which we got from the other end, so they were supposed to have sent
it', which would be a misdiagnosis)?

Thanks.
