Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65DBC433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 23:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99E2D208A7
	for <git@archiver.kernel.org>; Fri, 29 May 2020 23:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DNyqGFvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgE2X0D (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 19:26:03 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60674 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbgE2X0D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 19:26:03 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E4A8DB926A;
        Fri, 29 May 2020 19:25:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xYU4oUmWq3uBtXD2bcExBZgRJvg=; b=DNyqGF
        vs2cGX/3zeu/3sPDiYHAT0QT3/5OZvN/E4fCAd7cHzujDvZq89jtzIO9COLzrgUr
        qvHIL0rPCDm4B3jrbLsLuCLYznwaZepQ2tGYYGOoiyBcfikJBlJSBTSCC6x5Ds4E
        lv06+kN09NQ7yvj21Ab/DHriTcKnMIdlL+l20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZlhTXyX+JJdoN7bhTxLxMzJEDLPQKS4k
        7CmJ0f6SKMngQk+IqAOF+558+NJZ8oZ3WriuG0EvfvDen/EPSqT0lcZBeTXMCrfF
        nau8FPXBlvrGk6UoZb4eHy5lxwqvL4iKo9nuuTY3HnxbIxZ6LwNAx++gw8zi/qJS
        lJ+sHhvIEbg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DCD6EB9268;
        Fri, 29 May 2020 19:25:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2D1B0B9265;
        Fri, 29 May 2020 19:25:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/8] http-fetch: support fetching packfiles by URL
References: <cover.1590789428.git.jonathantanmy@google.com>
        <6b3a628719e0593893e537de0220a5e0d5460232.1590789428.git.jonathantanmy@google.com>
Date:   Fri, 29 May 2020 16:25:52 -0700
In-Reply-To: <6b3a628719e0593893e537de0220a5e0d5460232.1590789428.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 29 May 2020 15:30:15 -0700")
Message-ID: <xmqqeer2xr0f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDDA0968-A203-11EA-8DF9-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> +'git http-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [--stdin | --packfile | <commit>] <url>
> ...
> +--packfile::
> +	Instead of a commit id on the command line (which is not expected in
> +	this case), 'git http-fetch' fetches the packfile directly at the given
> +	URL and uses index-pack to generate corresponding .idx and .keep files.
> +	The output of index-pack is printed to stdout.

This makes sense as an external interface, I guess.

How should this interact with --stdin option, which is more like
"instead of getting a single <dest filename, object name> pair from
the command line, handle many pairs read from the standard input"
batch mode operation.  Would it be beneficial to allow unbounded
number of packfiles, not just a single one, to be fetched and
indexed by a single invocation of the command?  I suspect that given
the relatively large size of a single request for fetching a
packfile, one invocation of the command per packfile won't be too
heavy an overhead, so lack of such an orthogonality may only hurt
conceptual cleanliness, but not performance.  OK.

> -	if (argc != arg + 2 - commits_on_stdin)
> +	if (argc != arg + 2 - (commits_on_stdin || packfile))
>  		usage(http_fetch_usage);
>  	if (commits_on_stdin) {
>  		commits = walker_targets_stdin(&commit_id, &write_ref);
> +	} else if (packfile) {
> +		/* URL will be set later */

Prefer to see an empty statement spelled more explicitly, like this:

		; /* URL will be set later */

Otherwise reader would be left wondering if a line was (or lines
were) accidentally lost after this comment.

>  	} else {
>  		commit_id = (char **) &argv[arg++];
>  		commits = 1;
>  	}
>  
> +	if (packfile) {
> +		url = xstrdup(argv[arg]);
> +	} else {
> +		if (argv[arg])
> +			str_end_url_with_slash(argv[arg], &url);
> +	}
>  
>  	setup_git_directory();
>  
>  	git_config(git_default_config, NULL);
>  
>  	http_init(NULL, url, 0);
> +	if (packfile) {
> +		struct http_pack_request *preq;
> +		struct slot_results results;
> +		int ret;
> +
> +		preq = new_http_pack_request(NULL, url);
> +		if (preq == NULL)
> +			die("couldn't create http pack request");
> +		preq->slot->results = &results;
> +		preq->generate_keep = 1;
> +
> +		if (start_active_slot(preq->slot)) {
> +			run_active_slot(preq->slot);
> +			if (results.curl_result != CURLE_OK) {
> +				die("Unable to get pack file %s\n%s", preq->url,
> +				    curl_errorstr);
> +			}
> +		} else {
> +			die("Unable to start request");
> +		}
> +
> +		if ((ret = finish_http_pack_request(preq)))
> +			die("finish_http_pack_request gave result %d", ret);
> +		release_http_pack_request(preq);
> +		rc = 0;

The above probably want to be a single helper function.

The other side of if/else may also become another helper function.

That way, the flow of control would become clearer.  After all,
these two branches do not share all that much.  Only http-init and
http-cleanup and nothing else.

For that matter, even before introducing this new mode of operation,
another patch to make a preparatory move of the original logic in
this function to a helper function that would be called from the
"else" side may make it easier to see what is going on.

> diff --git a/http.c b/http.c
> index 130e9d6259..ac66215ee6 100644
> --- a/http.c
> +++ b/http.c
> @@ -2280,15 +2280,18 @@ int finish_http_pack_request(struct http_pack_request *preq)
>  	int tmpfile_fd;
>  	int ret = 0;
>  
> -	close_pack_index(p);
> +	if (p)
> +		close_pack_index(p);
>  
>  	fclose(preq->packfile);
>  	preq->packfile = NULL;
>  
> -	lst = preq->lst;
> -	while (*lst != p)
> -		lst = &((*lst)->next);
> -	*lst = (*lst)->next;
> +	if (p) {
> +		lst = preq->lst;
> +		while (*lst != p)
> +			lst = &((*lst)->next);
> +		*lst = (*lst)->next;
> +	}

This is quite ugly.  What is the original meaning of the target
field of the pack_request structure again?  A packed_git structure
that will be filled when we are done fetching the packfile from the
other side and installed in our repository?  When we are (ab)using
http_fetch code to fetch a single packfile, we do not install the
packfile into the running process, because we are only (re)using the
existing machinery as a poor-man's "curl | git index-pack --stdin"?

I do not think it is a bad idea to roll "curl | git index-pack
--stdin" our own, but I do find this an ugly way to do so.  Perhaps
a set of lower-level helper functions can be isolated out of the
existing code before this new feature is added, and then a new "just
fetch and pipe it to the index-pack" feature should be written using
these helpers but with a separate set of entry points?  Would it be
a good way to make the resulting code cleaner than this patch does?
I dunno.

> diff --git a/http.h b/http.h
> index a5b082f3ae..709dfa4c19 100644
> --- a/http.h
> +++ b/http.h
> @@ -223,12 +223,21 @@ struct http_pack_request {
>  	struct active_request_slot *slot;
>  
>  	/*
> -	 * After calling new_http_pack_request(), point lst to the head of the
> +	 * After calling new_http_pack_request(), if fetching a pack that
> +	 * http_get_info_packs() told us about, point lst to the head of the
>  	 * pack list that target is in. finish_http_pack_request() will remove
>  	 * target from lst and call install_packed_git() on target.
>  	 */
>  	struct packed_git **lst;
>  
> +	/*
> +	 * If this is true, finish_http_pack_request() will pass "--keep" to
> +	 * index-pack, resulting in the creation of a keep file, and will not
> +	 * suppress its stdout (that is, the "keep\t<hash>\n" line will be
> +	 * printed to stdout).
> +	 */
> +	unsigned generate_keep : 1;
> +

I suspect that this is a sign that this single patch is trying to
do too many things at the same time.

 - Whether we are fetching a single packfile from a URL, or walking
   to fetch all the packfiles in the repository at a given URL

 - Whether packfiles taken from outer space are marked with the
   "keep" bit

 - Whether the obtained packfile(s) are internally "installed"
   to the running process

are conceptually independent choices, but somehow mixed up, it
seems.

Thanks.

