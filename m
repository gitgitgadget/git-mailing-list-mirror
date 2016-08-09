Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16D951F859
	for <e@80x24.org>; Tue,  9 Aug 2016 16:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbcHIQh1 (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 12:37:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55876 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752375AbcHIQhY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 12:37:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E08E316A3;
	Tue,  9 Aug 2016 12:37:22 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4m3ES+W1ArtETat1r5MuMU26vfg=; b=hSry26
	XvfA1muTlrhg9DkZo+QgCSYLZcMYeFZ5Knf0dTTLVVwOxB9wcDt4Ao1lSH+anNjw
	Q96P1dXgqbyKMjgI7ZYGMcglQahiD6hby4qQN3B35z+kOhNm1olefZthDkdH0egn
	X2xm9tMyOLXhN3Bm08qfh/iZ6iKssGUmhmPUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JD7KP/X5zXmujrSqveQn6ZscK8Wgf7hF
	D+0A7cN5V4ehP4dzasXug7nJcYduaNHDTn3/0g8e43L8/UT26BrZKdf3NwBqL/v1
	PHeaTxybkvizk3hw8GOX8rIeQVAoCyrKQJl41OAdnl63ysZSEaeAhU2Bueo/rBQZ
	5j8ZMF7UYLQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 74D59316A2;
	Tue,  9 Aug 2016 12:37:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EAB873169F;
	Tue,  9 Aug 2016 12:37:21 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, mst@redhat.com
Subject: Re: [PATCHv3 6/9] clone: implement optional references
References: <20160809040811.21408-1-sbeller@google.com>
	<20160809040811.21408-8-sbeller@google.com>
Date:	Tue, 09 Aug 2016 09:37:19 -0700
In-Reply-To: <20160809040811.21408-8-sbeller@google.com> (Stefan Beller's
	message of "Mon, 8 Aug 2016 21:08:07 -0700")
Message-ID: <xmqq7fbpdhkw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8BA7369C-5E4F-11E6-BF0F-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> @@ -283,11 +286,22 @@ static void strip_trailing_slashes(char *dir)
>  static int add_one_reference(struct string_list_item *item, void *cb_data)
>  {
>  	char *ref_git;
> -	const char *repo;
> +	const char *repo, *ref_git_s;
> +	int *required = cb_data;
>  	struct strbuf alternate = STRBUF_INIT;
>  
> -	/* Beware: read_gitfile(), real_path() and mkpath() return static buffer */
> -	ref_git = xstrdup(real_path(item->string));
> +	ref_git_s = *required ?
> +			real_path(item->string) :
> +			real_path_if_valid(item->string);
> +	if (!ref_git_s) {
> +		warning(_("Not using proposed alternate %s"), item->string);

If I am reading the implementation of real_path_internal()
correctly, the most relevant reason that an "if-able" repository
cannot be used causes real_path_if_valid() to return NULL.

Let's say your superproject borrows from ~/w/super, whose submodule
repositories (if cloned) are directly in "~/w/super/.git/modules/".
When you clone a submodule X for your superproject, you allow it to
borrow from "~/w/super/.git/modules/X" if there is one available.

I think both real_path() and real_path_if_valid() happily returns
the real path to "~/w/super/.git/modules/" with "X" concatenated at
the end, as long as that 'modules' directory exists, even when there
is no X inside.

Using if_valid() is still necessary to avoid a totally bogus path to
cause real_path() to barf.  I am just saying that this warning is
not so interesting, and a real check, "do we have a repository
there?  If not, don't add it as an alternate" must be somewhere
else.

> +		return 0;
> +	} else
> +		/*
> +		 * Beware: read_gitfile(), real_path() and mkpath()
> +		 * return static buffer
> +		 */
> +		ref_git = xstrdup(ref_git_s);
>  
>  	repo = read_gitfile(ref_git);
>  	if (!repo)
> @@ -304,7 +318,8 @@ static int add_one_reference(struct string_list_item *item, void *cb_data)
>  	} else if (!is_directory(mkpath("%s/objects", ref_git))) {
>  		struct strbuf sb = STRBUF_INIT;
>  		if (get_common_dir(&sb, ref_git))
> -			die(_("reference repository '%s' as a linked checkout is not supported yet."),
> +			die(_("reference repository '%s' as a "
> +			      "linked checkout is not supported yet."),
>  			    item->string);

And curiously, this is not such a check.  This is an unrelated change.

>  		die(_("reference repository '%s' is not a local repository."),
>  		    item->string);

You need to arrange this die() not to trigger when you are asked to
borrow from there if there is one to borrow from.  I see a few other
die() following this check to avoid using shallow repositories and
repositories with grafts, but I think they all should turn into a
"Nah, this is unusable, and I was asked to borrow _only_ if the
repository is usable, so I won't use it."

