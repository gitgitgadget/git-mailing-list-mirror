Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A745207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 17:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935051AbcIPR7n (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 13:59:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63659 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934625AbcIPR7l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 13:59:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 13BD53F210;
        Fri, 16 Sep 2016 13:59:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3d3nPpq3HS9lEH6ygqhB66X53p8=; b=BLT3Wt
        OSRKCZbieGnZu5jSSOEpUgOzXehMcRi7njEfbcxaQBfo5C+wWy829pr9nRXQZMQu
        o5NNZYF43OW1TDl3Vske0PMQN6cXZTYM0NjDvdWYDgYj4Bo14bVPNYMhTJWd/267
        ZNigJxrBm2BebDBCRRdkrrdG3RGHW8FEQaNyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HJ9to9bBJfzgxHV1ZDoPgWAD0F/CQeT/
        pfkQYp4SFZF+qy9bOEkQAajfs95LZXgQaFAtC2K0+5n8OT2xrHgBFZPRgNu45+3C
        ydHxyB0v/dc3o2icBBp8TYjQYyHxJUUY07Y8k2L+NoHdkw+6Pxfo6sR4YprsTvlC
        TtYrX0Ued9o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0BA9A3F20F;
        Fri, 16 Sep 2016 13:59:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8331B3F20E;
        Fri, 16 Sep 2016 13:59:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH 3/2] batch check whether submodule needs pushing into one call
References: <20160824173017.24782-1-sbeller@google.com>
        <20160824183112.ceekegpzavnbybxp@sigill.intra.peff.net>
        <xmqqh9aaot49.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYOBqQ0FF4J-+KbefSD8HRrUeMqpO27m_jprhm93aB+LA@mail.gmail.com>
        <20160824230115.jhmcr4r7wobj5ejb@sigill.intra.peff.net>
        <20160914173124.GA7613@sandbox>
        <xmqqwpiep10i.fsf@gitster.mtv.corp.google.com>
        <20160915121044.GA96648@book.hvoigt.net>
Date:   Fri, 16 Sep 2016 10:59:37 -0700
In-Reply-To: <20160915121044.GA96648@book.hvoigt.net> (Heiko Voigt's message
        of "Thu, 15 Sep 2016 14:10:44 +0200")
Message-ID: <xmqq8turlo8m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5668DCFA-7C37-11E6-8B5F-096F12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

> +static void append_hash_to_argv(const unsigned char sha1[20], void *data)
>  {
> -	if (add_submodule_odb(path) || !lookup_commit_reference(sha1))
> +	struct argv_array *argv = (struct argv_array *) data;
> +	argv_array_push(argv, sha1_to_hex(sha1));
> +}

Hmph, why do I think I've seen this before in the previous patch?

    ... scans through this patch and finds that a similar one is
    removed ;-)

OK.  This makes sense.

> +static void check_has_hash(const unsigned char sha1[20], void *data)
> +{
> +	int *has_hash = (int *) data;
> +
> +	if (!lookup_commit_reference(sha1))
> +		*has_hash = 0;
> +}
> +
> +static int submodule_has_hashes(const char *path, struct sha1_array *hashes)
> +{
> +	int has_hash = 1;
> +
> +	if (add_submodule_odb(path))
> +		return 0;
> +
> +	sha1_array_for_each_unique(hashes, check_has_hash, &has_hash);
> +	return has_hash;
> +}
> +
> +static int submodule_needs_pushing(const char *path, struct sha1_array *hashes)
> +{
> +	if (!submodule_has_hashes(path, hashes))
>  		return 0;

I think you meant well, but this optimization is wrong.  A mere
presence of an object does not mean that the current tip can reach
that object.  Imagine you pushed commit A earlier to them at the
tip, then pushed commit A~ to them at the tip, which is the current
state of the remote of the submodule, and since them they may have
GC'ed.  They no longer have the commit A.

For that matter, because you are doing this check by pretending as
if all the submodule objects are in the object store of the current
superproject you are working in, and saying "it exists there in the
submodule repository" when the only thing you know is it exists in
an object store of either the submodule repository, the superproject
repository, or any of the other submodule repositories, you really
cannot tell much from a mere presence of an object.  Not just the
remote of the submodule repository you are interested in, but the
submodule repository you are interested in itself, may not have that
object.

Drop the previous two helper functions and this short-cut.

>  	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
>  		struct child_process cp = CHILD_PROCESS_INIT;
> -		const char *argv[] = {"rev-list", NULL, "--not", "--remotes", "-n", "1" , NULL};
> +
> +		argv_array_push(&cp.args, "rev-list");
> +		sha1_array_for_each_unique(hashes, append_hash_to_argv, &cp.args);
> +		argv_array_pushl(&cp.args, "--not", "--remotes", "-n", "1" , NULL);
> +
>  		struct strbuf buf = STRBUF_INIT;
>  		int needs_pushing = 0;
>  
> -		argv[1] = sha1_to_hex(sha1);
> -		cp.argv = argv;
>  		prepare_submodule_repo_env(&cp.env_array);
>  		cp.git_cmd = 1;
>  		cp.no_stdin = 1;
>  		cp.out = -1;
>  		cp.dir = path;
>  		if (start_command(&cp))
> -			die("Could not run 'git rev-list %s --not --remotes -n 1' command in submodule %s",
> -				sha1_to_hex(sha1), path);
> +			die("Could not run 'git rev-list <hashes> --not --remotes -n 1' command in submodule %s",
> +					path);
>  		if (strbuf_read(&buf, cp.out, 41))
>  			needs_pushing = 1;
>  		finish_command(&cp);
> @@ -601,21 +628,6 @@ static void find_unpushed_submodule_commits(struct commit *commit,
>  	diff_tree_combined_merge(commit, 1, &rev);
>  }

Good.  This is the optimization I alluded to in the review of the
first one in the series.
