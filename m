Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61FCB20954
	for <e@80x24.org>; Mon, 27 Nov 2017 06:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751180AbdK0Ggi (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 01:36:38 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54430 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751045AbdK0Ggi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 01:36:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 760B9BCF8B;
        Mon, 27 Nov 2017 01:36:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2g0n+K9oKpLU/gs+OYpmlmCeZW0=; b=iPBCvW
        PYBP8eLTBBWLLAr5NpsFZF83DgKmvjOVp3vGcqOoqufYRyHhZH6gbJmsn94oCI+V
        PzFi0uPjsYmh3Rgh6SRKI+0pNpB2Wu1M/ebSPtJNDJ/aCVdnpKy/5EdzPjKxFOGT
        DFYl41Y3Yel2ETPf+qg6dF921S2FmSfYMk+PE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZsWZJAMyf2Zga1cc23uvX/X7ww52wJ2n
        mk+lt63xe/g88dExwmP8MVSp+sEN1Gtn5ZrXF6kYbcbb87ustqZnXgZog6vfHCuZ
        TgncoV0Ma8xPyoz1RxPmSxO/JTfXFgU9RmRmAg7NPF2sDjELDMJaMM2Op375B14f
        vJz8+bohHfs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C7A7BCF8A;
        Mon, 27 Nov 2017 01:36:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CFA9DBCF89;
        Mon, 27 Nov 2017 01:36:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Paul Smith <paul@mad-scientist.net>
Subject: Re: [PATCH v5 5/6] worktree: add --guess-remote flag to add subcommand
References: <20171122223020.2780-1-t.gummerer@gmail.com>
        <20171126194356.16187-1-t.gummerer@gmail.com>
        <20171126194356.16187-6-t.gummerer@gmail.com>
Date:   Mon, 27 Nov 2017 15:36:35 +0900
In-Reply-To: <20171126194356.16187-6-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sun, 26 Nov 2017 19:43:55 +0000")
Message-ID: <xmqqd144cjnw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 514E5E4E-D33D-11E7-9752-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Currently 'git worktree add <path>' creates a new branch named after the
> basename of the <path>, that matches the HEAD of whichever worktree we
> were on when calling "git worktree add <path>".
>
> It's sometimes useful to have 'git worktree add <path> behave more like
> the dwim machinery in 'git checkout <new-branch>', i.e. check if the new
> branch name uniquely matches the branch name of a remote-tracking
> branch, and if so check out that branch and set the upstream to the
> remote-tracking branch.

This paragraph was a bit hard to sympathize because it was not
obvious that the new feature still assumes how <path> is used to
compute the name of the new branch.  Perhaps if it were written like
so:

	check if the new branch name, derived from the basename of
	the <path>, uniquely matches the branch name of ...

I would not have had to read it twice to understand what was going
on.

> +--[no-]guess-remote::
> +	With `add`, instead of creating a new branch from HEAD when
> +	`<commit-ish>` is not given, if there exists a tracking branch
> +	in exactly one remote matching the basename of the path, base
> +	the new branch on the remote-tracking branch, and mark the
> +	remote-tracking branch as "upstream" from the new branch.
> +

Would

	git worktree add --guess-remote <path> <branch>

be an error?  It is allowed as long as <branch> and the basename of
the <path> matches?  The option is silently ignored?  Something
else?

I am reacting to "with `add`" part of this desciption.  I wouldn't
be asking if it said "With `worktree add <path>` without <branch>",
as that would make the scenario I am wondering about automatically
"undefined".  Yes, we should strive for leaving things undefined as
little as practically possible, but at least saying something like
"without <branch>" explicitly there would make sure that readers
know in what scenario this option is meant to be used a bit better.

> @@ -389,6 +392,13 @@ static int add(int ac, const char **av, const char *prefix)
>  		int n;
>  		const char *s = worktree_basename(path, &n);
>  		opts.new_branch = xstrndup(s, n);
> +		if (guess_remote) {
> +			struct object_id oid;
> +			const char *remote =
> +				unique_tracking_name(opts.new_branch, &oid);
> +			if (remote)
> +				branch = remote;
> +		}
>  	}

I think the answer is "silently ignored", as the above hunk is
inside "if (ac < 2 && !opts.new_branch && !opts.detach)".

