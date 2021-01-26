Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81007C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 05:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 543162070A
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 05:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbhA0D5a (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:57:30 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50844 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbhAZWY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 17:24:57 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3C01711679C;
        Tue, 26 Jan 2021 17:24:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YpMsLE7PTJR6zOwxhzgjcgZrJ+0=; b=CdP3+o
        8mhb29LxeOrzpE1ozLVdb5XgE3Xw+xCRryV8z6HQlJBas+uZe4ZO1LLXT0aKg1pv
        OCTUtEN+4bpVm3p7ooYSWh9fAVUnUvG5eot2T0wWeoakMVesud5jV1KMwWs65FFc
        Tm+jAjKmk92cfqxTGZ9CyJeJtESXW33kZhh28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Bb58hpUrUcuB/88d7iHDZRoBVAmlvysM
        TZKFwcskKZ+Q9fZPrSms+IjJ0vYRVDjFNh7RX8zoJlvqFkRwRSBjAGR+RZ8NZ/8U
        OGmqz+1R9xCPPDezV+dDBQY5VJN3hMcGun6o7ZLBLMC/wIwURp8HjjlC6+1cBlUF
        iUH8QmTc9Hc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 34C7511679B;
        Tue, 26 Jan 2021 17:24:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7B6C6116798;
        Tue, 26 Jan 2021 17:24:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 3/3] clone: respect remote unborn HEAD
References: <20201208013121.677494-1-jonathantanmy@google.com>
        <cover.1611686656.git.jonathantanmy@google.com>
        <922e8c229c359c15f1265876e6def87d7a18b763.1611686656.git.jonathantanmy@google.com>
Date:   Tue, 26 Jan 2021 14:24:07 -0800
In-Reply-To: <922e8c229c359c15f1265876e6def87d7a18b763.1611686656.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 26 Jan 2021 10:55:57 -0800")
Message-ID: <xmqqzh0vz69k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35A83D36-6025-11EB-8E3B-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>  init.defaultBranch::
>  	Allows overriding the default branch name e.g. when initializing
> -	a new repository or when cloning an empty repository.
> +	a new repository.

Looking good.

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 211d4f54b0..77fdc61f4d 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1330,10 +1330,21 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		remote_head = NULL;
>  		option_no_checkout = 1;
>  		if (!option_bare) {
> -			const char *branch = git_default_branch_name();
> -			char *ref = xstrfmt("refs/heads/%s", branch);
> +			const char *branch;
> +			char *ref;
> +
> +			if (transport_ls_refs_options.unborn_head_target &&
> +			    skip_prefix(transport_ls_refs_options.unborn_head_target,
> +					"refs/heads/", &branch)) {
> +				ref = transport_ls_refs_options.unborn_head_target;
> +				transport_ls_refs_options.unborn_head_target = NULL;
> +			} else {
> +				branch = git_default_branch_name();
> +				ref = xstrfmt("refs/heads/%s", branch);
> +			}
>  
>  			install_branch_config(0, branch, remote_name, ref);
> +			create_symref("HEAD", ref, "");
>  			free(ref);

OK, we used to say "point our HEAD always to the local default
name", and the code is still there in the else clause.  But when the
transport found what name the other side uses, we use that name
instead.

I presume that clearing transport_ls_ref_options.unborn_head_target
is to take ownership of this piece of memory ourselves?

We didn't call create_symref() in the original code, but now we do.
Is this a valid bugfix even if we did not have this "learn remote
symref even for unborn HEAD" feature?  Or is the original codepath
now somehow got broken with an extra create_symref() that we used
not to do, but now we do?

> @@ -1385,5 +1396,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	junk_mode = JUNK_LEAVE_ALL;
>  
>  	strvec_clear(&transport_ls_refs_options.ref_prefixes);
> +	free(transport_ls_refs_options.unborn_head_target);
>  	return err;
>  }
> diff --git a/connect.c b/connect.c
> index 328c279250..879669df93 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -376,7 +376,8 @@ struct ref **get_remote_heads(struct packet_reader *reader,
>  }
>  
>  /* Returns 1 when a valid ref has been added to `list`, 0 otherwise */
> -static int process_ref_v2(struct packet_reader *reader, struct ref ***list)
> +static int process_ref_v2(struct packet_reader *reader, struct ref ***list,
> +			  char **unborn_head_target)
>  {
>  	int ret = 1;
>  	int i = 0;
> @@ -397,6 +398,25 @@ static int process_ref_v2(struct packet_reader *reader, struct ref ***list)
>  		goto out;
>  	}
>  
> +	if (!strcmp("unborn", line_sections.items[i].string)) {
> +		i++;
> +		if (unborn_head_target &&
> +		    !strcmp("HEAD", line_sections.items[i++].string)) {
> +			/*
> +			 * Look for the symref target (if any). If found,
> +			 * return it to the caller.
> +			 */
> +			for (; i < line_sections.nr; i++) {
> +				const char *arg = line_sections.items[i].string;
> +
> +				if (skip_prefix(arg, "symref-target:", &arg)) {
> +					*unborn_head_target = xstrdup(arg);
> +					break;
> +				}
> +			}
> +		}
> +		goto out;
> +	}

We split the line and notice that the first token is "unborn"; if
the caller is not interested in the unborn head, we just skip the
rest, but otherwise, if it is about HEAD (i.e. we do not care if a
dangling symref that is not HEAD is reported), we notice the target
in unborn_head_target.

OK.  We already saw how this is used in cmd_clone().

> @@ -461,6 +481,8 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
>  	const char *hash_name;
>  	struct strvec *ref_prefixes = transport_options ?
>  		&transport_options->ref_prefixes : NULL;
> +	char **unborn_head_target = transport_options ?
> +		&transport_options->unborn_head_target : NULL;

So any caller that passes transport_options will get the unborn head
information for free?  The other callers are in fetch-pack.c and
transport.c, which presumably are about fetching and not cloning.

I recall discussions on filling a missing refs/remotes/X/HEAD when
we fetch from X and learn where X points at.  Such an extension can
be done on top of this mechanism to pass transport_options from the
fetch codepath, I presume?


Thanks.  I tried to follow the thought in the patches aloud, and it
was mostly a pleasant read.

