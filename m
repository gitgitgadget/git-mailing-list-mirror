Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED68DC433EF
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 20:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240197AbiGHUeb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 16:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240192AbiGHUeP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 16:34:15 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6EEA0259
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 13:34:00 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1BAA91B6F00;
        Fri,  8 Jul 2022 16:33:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mjgGQw0Zn/8an/AoU3XvosIBjavku+fG53J84V
        vD4xQ=; b=TOuxNXS9NG1Jgd1M8//mXk/AMYoEGa0HlV31ZxBOlOIGO6lxOwy56+
        WiDX6Z8FVXRWyCzXASS1gAqkluDcAdaHk1ds4i9tZM9aDVjn3UqA4M9wWIbihyPf
        eUQIlfQ1lLGKSgFPj87KAZWJ+AGyNhRWAF762JqBHCWHMRrH3q7mA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 155321B6EFF;
        Fri,  8 Jul 2022 16:33:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AB9071B6EFE;
        Fri,  8 Jul 2022 16:33:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 3/3] clone: use remote branch if it matches default HEAD
References: <YsdyLS4UFzj0j/wB@coredump.intra.peff.net>
        <YsdzZxS48u8sk9QD@coredump.intra.peff.net>
        <xmqq8rp3wovj.fsf@gitster.g>
        <YsiF6+RjEsmwviuS@coredump.intra.peff.net>
Date:   Fri, 08 Jul 2022 13:33:51 -0700
In-Reply-To: <YsiF6+RjEsmwviuS@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 8 Jul 2022 15:30:51 -0400")
Message-ID: <xmqqlet3uyxc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47D86184-FEFD-11EC-A1E5-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> > +		if (!option_bare && !our_head_points_at)
>> >  			install_branch_config(0, branch, remote_name, ref);
>> 
>> I may be completely confused, but shouldn't the condition read "if
>> we are not bare, and we did find the 'branch' in their refs", i.e.
>> without "!" in front of our_head_points_at?
>
> No. That line is for setting up the branch config for an unborn head. If
> we actually set up our_head_points_at, then the later "usual checkout
> code" mentioned above will take care of it (actually it is
> update_head(), I think).

I did miss that other call to install_branch_config() in
update_head().

If "branch" came from "unborn" capability, we would have created the
HEAD that points to the unborn branch, and our_head_points_at is
NULL at this point, and the old code did not bother setting up the
branch by calling install_branch_config(), which is correctd here.
If it came from the local default, we did not bother setting it up
either, but if the local default "foo" is not among the branches
they have, then we pretend as if their HEAD were pointing at an
unborn branch "foo", and in order to do so, we'd do the same.

Makes sense.

The install_branch_config() call and create_symref() call in this
"ouch, we do not know what their head points at" else block do look
ugly, in that update_head() is where it happens to all the other
cases, but the "unborn" case used to be special and it probably is
OK to leave it that way.

> Your next thought may be: why does the unborn head code do its own
> branch config setup here, and not also rely on update_head()? I think
> it's just that update_head() is expecting to see an actual ref object,
> and we don't have one. It could probably be taught to handle this case,
> like the patch below. I'm not sure if that is more readable or not. On
> one hand, it is putting all of the HEAD symref creation and config in
> one spot. On the other, it is adding to the pile of widely scoped
> variables that have subtle precedence interactions later on in the
> function.

Thanks.  

The necessary change does not look all that bad, either ;-)

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 0912d268a1..a776563759 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -606,7 +606,7 @@ static void update_remote_refs(const struct ref *refs,
>  }
>  
>  static void update_head(const struct ref *our, const struct ref *remote,
> -			const char *msg)
> +			const char *unborn, const char *msg)
>  {
>  	const char *head;
>  	if (our && skip_prefix(our->name, "refs/heads/", &head)) {
> @@ -632,6 +632,14 @@ static void update_head(const struct ref *our, const struct ref *remote,
>  		 */
>  		update_ref(msg, "HEAD", &remote->old_oid, NULL, REF_NO_DEREF,
>  			   UPDATE_REFS_DIE_ON_ERR);
> +	} else if (unborn && skip_prefix(unborn, "refs/heads/", &head)) {
> +		/* yuck, cut and paste from the "our" block above, but we
> +		 * need to make sure that we come after those other options in
> +		 * the if/else chain */
> +		if (create_symref("HEAD", unborn, NULL) < 0)
> +			die(_("unable to update HEAD"));
> +		if (!option_bare)
> +			install_branch_config(0, head, remote_name, unborn);
>  	}
>  }
>  
> @@ -876,6 +884,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	const struct ref *refs, *remote_head;
>  	struct ref *remote_head_points_at = NULL;
>  	const struct ref *our_head_points_at;
> +	char *unborn_head = NULL;
>  	struct ref *mapped_refs = NULL;
>  	const struct ref *ref;
>  	struct strbuf key = STRBUF_INIT;
> @@ -1282,8 +1291,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		our_head_points_at = NULL;
>  	} else {
>  		const char *branch;
> -		const char *ref;
> -		char *ref_free = NULL;
>  
>  		if (!mapped_refs) {
>  			warning(_("You appear to have cloned an empty repository."));
> @@ -1293,12 +1300,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		if (transport_ls_refs_options.unborn_head_target &&
>  		    skip_prefix(transport_ls_refs_options.unborn_head_target,
>  				"refs/heads/", &branch)) {
> -			ref = transport_ls_refs_options.unborn_head_target;
> -			create_symref("HEAD", ref, reflog_msg.buf);
> +			unborn_head  = xstrdup(transport_ls_refs_options.unborn_head_target);
>  		} else {
>  			branch = git_default_branch_name(0);
> -			ref_free = xstrfmt("refs/heads/%s", branch);
> -			ref = ref_free;
> +			unborn_head = xstrfmt("refs/heads/%s", branch);
>  		}
>  
>  		/*
> @@ -1313,10 +1318,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		 * a match.
>  		 */
>  		our_head_points_at = find_remote_branch(mapped_refs, branch);
> -
> -		if (!option_bare && !our_head_points_at)
> -			install_branch_config(0, branch, remote_name, ref);
> -		free(ref_free);
>  	}
>  
>  	write_refspec_config(src_ref_prefix, our_head_points_at,
> @@ -1336,7 +1337,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  			   branch_top.buf, reflog_msg.buf, transport,
>  			   !is_local);
>  
> -	update_head(our_head_points_at, remote_head, reflog_msg.buf);
> +	update_head(our_head_points_at, remote_head, unborn_head, reflog_msg.buf);
>  
>  	/*
>  	 * We want to show progress for recursive submodule clones iff
> @@ -1363,6 +1364,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	strbuf_release(&key);
>  	free_refs(mapped_refs);
>  	free_refs(remote_head_points_at);
> +	free(unborn_head);
>  	free(dir);
>  	free(path);
>  	UNLEAK(repo);
