Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 466EF20281
	for <e@80x24.org>; Wed,  4 Oct 2017 09:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751966AbdJDJMv (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 05:12:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59307 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751925AbdJDJMt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 05:12:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F087A372F;
        Wed,  4 Oct 2017 05:12:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a2vGUNq9bvgPIsrQMei5tDcHxpI=; b=dGbnm+
        TAsEsYnlquDppGkuUh2c2f09nPvvV/pCdJtUpWOpZmAIrRPEFF1MO2JfCVxJFsku
        N/+/ef+7JDe/mPcgrvI/cKevcy5cEmsVQ499I4f9klg2xR5Kt3pQN4av2ZKpCf84
        z41MV09eJ1+KdWPQlUci2zZu/ohAZqF1aL5sY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i75wqaat9WL8rO/vNKGMq5SkLn6t5jZb
        MaZIQ6Rz6Sr8/xgeHt7C8naUbkuGslGWHCBB7z5D6uB1lzbYdelnrc9JnU9x/IV0
        E/uweTUzJPEnH+g9NUp5UHJFvOJxkDy4tzskRP2GT/FBWaIz0Ui9CJhDMucGwgig
        bgfxCogoVos=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 157DCA372E;
        Wed,  4 Oct 2017 05:12:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6F20CA372A;
        Wed,  4 Oct 2017 05:12:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, J Wyman <jwyman@microsoft.com>
Subject: Re: [PATCH 2/3] for-each-ref: let upstream/push optionally report merge name.
References: <cover.1506952571.git.johannes.schindelin@gmx.de>
        <f615fcc05fa358b4c7e3531cbdbd91661be321aa.1506952571.git.johannes.schindelin@gmx.de>
Date:   Wed, 04 Oct 2017 18:12:47 +0900
In-Reply-To: <f615fcc05fa358b4c7e3531cbdbd91661be321aa.1506952571.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Mon, 2 Oct 2017 15:57:46 +0200
        (CEST)")
Message-ID: <xmqq4lrfb7jk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30E9B6A4-A8E4-11E7-8836-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> From: J Wyman <jwyman@microsoft.com>
>
> There are times when scripts want to know not only the name of the
> push branch on the remote, but also the name of the branch as known
> by the remote repository.
>
> A useful example of this is with the push command where
> `branch.<name>.merge` is useful as the <to> value. Example:
>
> 	$ git push <remote> <from>:<to>
>
> This patch offers the new suffix :merge for the push atom, allowing to
> show exactly that. Example:
>
> 	$ cat .git/config
> 	...
> 	[remote "origin"]
> 		url = https://where.do.we.come/from
> 		fetch = refs/heads/*:refs/remote/origin/*
> 	[branch "master"]
> 		remote = origin
> 		merge = refs/heads/master
> 	[branch "develop/with/topics"]
> 		remote = origin
> 		merge = refs/heads/develop/with/topics
> 	...
>
> 	$ git for-each-ref \
> 		--format='%(push) %(push:remote-ref)' \
> 		refs/heads
> 	refs/remotes/origin/master refs/heads/master
> 	refs/remotes/origin/develop/with/topics refs/heads/develop/with/topics

Ah, now it is clear that we _need_ to figure out how to spell
"multi-word" modifier to the format specifiers, as "push:remote"
would not let us differenciate the products of 1/3 and 2/3 X-<.

> ---

We need two Signed-off-by: lines at the end, one by Wyman and then
another by you in this order.

> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt

Changes to this file in this patch looks sane.

> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1260,6 +1262,14 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
>  			*s = xstrdup(remote);
>  		else
>  			*s = "";
> +	} else if (atom->u.remote_ref.option == RR_REMOTE_REF) {
> +		int explicit, for_push = starts_with(atom->name, "push");
> +		const char *merge = remote_ref_for_branch(branch, for_push,
> +							  &explicit);

Having multiple variables defined like this _and_ initialized with
anything other than a trivial constant, is somewhat hard to follow.
Can we split the above more like:

		int explicit;
		int for_push = starts_with(...);
		const char *merge = remote_ref_for_branch(...);

Actually, if you did it this way, you do not even need "for_push":

		int explicit;
		const char *merge;

		merge = remote_ref_for_branch(branch,
					      starts_with(atom->name, "push"),
					      &explicit);

which may be a lot easier to follow.

By the way, the spirit of parsing used atoms first before the "learn
what we care about this single ref" function like the above are
called repeatedly for each ref is because we want to hoist the
overhead of doing the constant computation like "does the atom's
name begins with 'push'?" out of the latter.  

Can we add a field in atom->u.remote_ref to precompute this bit so
that we do not even have to say "Are we doing this for push?  Let's
see if the atom's name begins with 'push'" each time this function
is called for a ref?  That makes this function a lot more in line
with the spirit of the design of the subsystem, I would think.

This comment probably applies equally to both 1/3 and this one.

> +		if (explicit)
> +			*s = xstrdup(merge);
> +		else
> +			*s = "";

Here is the same "who are we trying to help---users who want to know
where their push goes, or users who are debugging where the push
destination is defined?" question.  I do not have a strong opinion
either way, but I think giving the end result with fallback (i.e.
not nullifying when the result is not explicit) may be easier to use
by "push" users.

> diff --git a/remote.c b/remote.c
> index b220f0dfc61..2bdcfc280cd 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -675,6 +675,36 @@ const char *pushremote_for_branch(struct branch *branch, int *explicit)
>  	return remote_for_branch(branch, explicit);
>  }
>  
> +const char *remote_ref_for_branch(struct branch *branch, int for_push,
> +				  int *explicit)
> +{
> +	if (branch) {
> +		if (!for_push) {
> +			if (branch->merge_nr) {
> +				if (explicit)
> +					*explicit = 1;
> +				return branch->merge_name[0];
> +			}
> +		} else {
> +			const char *dst, *remote_name =
> +				pushremote_for_branch(branch, NULL);
> +			struct remote *remote = remote_get(remote_name);

Again,

			const char *dst, *remote_name;
                        struct remote *remote;

			remote_name = pushremote_for_branch(branch, NULL);
                        remote = remote_get(remote_name);

may be easier to follow, if only that it allows eyes to scan without
having to be distracted by jagged lines.

> +			if (remote && remote->push_refspec_nr &&
> +			    (dst = apply_refspecs(remote->push,
> +						  remote->push_refspec_nr,
> +						  branch->refname))) {
> +				if (explicit)
> +					*explicit = 1;
> +				return dst;
> +			}
> +		}
> +	}
> +	if (explicit)
> +		*explicit = 0;
> +	return "";
> +}

What the function does looks reasonable; the assignment in if()
condition looks a bit unfortunate, though.
