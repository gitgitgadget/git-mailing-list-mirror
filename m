Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBE8C2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 19:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244385AbiAZTMB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 14:12:01 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53921 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244362AbiAZTMA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 14:12:00 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AADA216A350;
        Wed, 26 Jan 2022 14:12:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TM2keVmDnjWc7OPK0ZenQkp07nBUFtzwhkiqxt
        41pXM=; b=QTAJs2/8VOCAQQq9kn0qjO1p5LalAMwD5qKWa/N82XyVaSplhCnVAw
        eGsbLE4Wmx0IcbXiliLDmPHEBNvO+FldJZ/RqVNbhY3zRajArFPl6sNBEBRRObBg
        O3oiqeMwCAdu4YgCNdZzbwRalj4YHoOOacfIByUSFH0t/1OZmbw4Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A37FC16A34F;
        Wed, 26 Jan 2022 14:12:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C506316A34C;
        Wed, 26 Jan 2022 14:11:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clone: support unusual remote ref configurations
References: <20220124180909.2437002-1-jonathantanmy@google.com>
Date:   Wed, 26 Jan 2022 11:11:55 -0800
In-Reply-To: <20220124180909.2437002-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 24 Jan 2022 10:09:09 -0800")
Message-ID: <xmqqfspas45g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D468EC06-7EDB-11EC-AFEB-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When cloning a branchless and tagless but not refless remote using
> protocol v0 or v1, Git calls transport_fetch_refs() with an empty ref
> list. This makes the clone fail with the message "remote transport
> reported error".
>
> Git should have refrained from calling transport_fetch_refs(), just like
> it does in the case that the remote is refless. Therefore, teach Git to
> do this.

Makes sense.

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 727e16e0ae..3df441eb71 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -862,7 +862,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	const struct ref *refs, *remote_head;
>  	struct ref *remote_head_points_at = NULL;
>  	const struct ref *our_head_points_at;
> -	struct ref *mapped_refs;
> +	struct ref *mapped_refs = NULL;
>  	const struct ref *ref;
>  	struct strbuf key = STRBUF_INIT;
>  	struct strbuf branch_top = STRBUF_INIT, reflog_msg = STRBUF_INIT;
> @@ -1184,7 +1184,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  
>  	refs = transport_get_remote_refs(transport, &transport_ls_refs_options);
>  
> -	if (refs) {
> +	if (refs)
> +		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
> +
> +	if (mapped_refs) {
>  		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));

OK, we used to decide on what they advertised and then filtered that
to what we are interested in inside the "true" side of the if/else.
If the result of filtering became empty, we declared a trouble.

Now we do the filtering first and decide on that.  No matter how
many uninteresting refs they advertise, if they show no refs of
interest to us, it is like they have an empty repository.

> @@ -1193,8 +1196,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		 */
>  		initialize_repository_version(hash_algo, 1);
>  		repo_set_hash_algo(the_repository, hash_algo);
> -
> -		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
>  		/*
>  		 * transport_get_remote_refs() may return refs with null sha-1
>  		 * in mapped_refs (see struct transport->get_refs_list

[start #leftoverbits]

I noticed these while reading outside the context of this patch.
None of them should be part of this patch, which deals only with the
case where mapped_refs becomes empty.

Here in the post-context of this hunk, there is a loop that iterates
over the original refs list, not the filtered mapped_refs list, to
compute "complete_refs_before_fetch".  Should we need to update the
loop to work on mapped_refs?

And after that, we compute remote_head using the original refs
list, not the mapped_refs list, when calling find_ref_by_name(),
but use mapped_refs when calling guess_remote_head().  The
inconsistency smells fishy.

[end #leftoverbits]


> @@ -1240,7 +1241,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  					option_branch, remote_name);
>  
>  		warning(_("You appear to have cloned an empty repository."));
> -		mapped_refs = NULL;

And we come here instead with the new code.  We claim "you appear to
have cloned an empty repository", which is much closer than
"reported an error".

> @@ -1271,7 +1271,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  
>  	if (is_local)
>  		clone_local(path, git_dir);
> -	else if (refs && complete_refs_before_fetch) {
> +	else if (mapped_refs && complete_refs_before_fetch) {
>  		if (transport_fetch_refs(transport, mapped_refs))
>  			die(_("remote transport reported error"));
>  	}

And this is the other crux of the fix.  As the root cause of the
problems is to decide with NULL-ness of refs if we do something that
uses mapped_refs, this fixes the inconsistency.

Looking good.

Will queue.  Thanks.

> diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
> index 468bd3e13e..6c8d4c6cf1 100755
> --- a/t/t5700-protocol-v1.sh
> +++ b/t/t5700-protocol-v1.sh
> @@ -149,6 +149,21 @@ test_expect_success 'push with file:// using protocol v1' '
>  	grep "push< version 1" log
>  '
>  
> +test_expect_success 'cloning branchless tagless but not refless remote' '
> +	rm -rf server client &&
> +
> +	git -c init.defaultbranch=main init server &&
> +	echo foo >server/foo.txt &&
> +	git -C server add foo.txt &&
> +	git -C server commit -m "message" &&
> +	git -C server update-ref refs/notbranch/alsonottag HEAD &&
> +	git -C server checkout --detach &&
> +	git -C server branch -D main &&
> +	git -C server symbolic-ref HEAD refs/heads/nonexistentbranch &&
> +
> +	git -c protocol.version=1 clone "file://$(pwd)/server" client
> +'
> +
>  # Test protocol v1 with 'ssh://' transport
>  #
>  test_expect_success 'setup ssh wrapper' '
