Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D49C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 16:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C6061053
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 16:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238964AbhIAQqr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 12:46:47 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61565 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhIAQqq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 12:46:46 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7A6C2148738;
        Wed,  1 Sep 2021 12:45:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZDXxpNq7nUYV7Isl0Y58Jrc5mTQmAu/l5L4rZw
        ZjTak=; b=Rg0DZ1RRS6EWgBrBGpx44ZXIPq7C49wiW7VIxqnI3avIDN8E69dF0H
        A7eT4IFvsQbsqk828bZNQ3tnHiLknFuZH2+xHl+ACFV7KnD49Tb4RIA86256go2m
        bBS+XOgL6zmRVAUFD1+gTBVD4rmPzSS7Cq2gmcsCYBpjjR3ouh06c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 71CB7148737;
        Wed,  1 Sep 2021 12:45:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D2EFF148736;
        Wed,  1 Sep 2021 12:45:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 08/15] scalar: implement the `clone` subcommand
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
        <2cbf0b611133df5fa7eed1bf38460f9d119d2a6e.1630359290.git.gitgitgadget@gmail.com>
Date:   Wed, 01 Sep 2021 09:45:45 -0700
In-Reply-To: <2cbf0b611133df5fa7eed1bf38460f9d119d2a6e.1630359290.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 30 Aug 2021
        21:34:43 +0000")
Message-ID: <xmqqsfyoqm6e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E64B5FE-0B44-11EC-8CEB-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +static char *remote_default_branch(const char *url)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	struct strbuf out = STRBUF_INIT;
> +
> +	cp.git_cmd = 1;
> +	strvec_pushl(&cp.args, "ls-remote", "--symref", url, "HEAD", NULL);
> +	strbuf_addstr(&out, "-\n");

Is this a workaround for the problem that the first "ref:" line
won't be found by looking for "\nref: " in the loop?  Cute, but the
extra "-" is a bit misleading.

> +	if (!pipe_command(&cp, NULL, 0, &out, 0, NULL, 0)) {
> +		char *ref = out.buf;
> +
> +		while ((ref = strstr(ref + 1, "\nref: "))) {
> +			const char *p;
> +			char *head, *branch;
> +
> +			ref += strlen("\nref: ");
> +			head = strstr(ref, "\tHEAD");
> +
> +			if (!head || memchr(ref, '\n', head - ref))
> +				continue;

OK.  We expect "ref: " <refname> "\t" <head> "\n" where <head> is
"HEAD" for their .git/HEAD and refs/remotes/<nick>/HEAD for their
remote-tracking branch for the remote they call <nick>, on a single
line.  We reject a line that is not of that shape, and we reject a
line that is about remote-tracking branch by only looking for
"\tHEAD". Makes sense.

The strstr() goes from "ref + 1", which feels sloppy.  When we
reject the line we found that begins with "ref :", I would have
expected that the next scan would start at the beginning of the next
line, not from the middle of this line at the first letter 'e' in
'refs/heads/' on the current line "ref: refs/heads/.....".  As long
as the current line is long enough, strstr() would not miss the
beginning of the next line, so it might be OK.

> +			if (skip_prefix(ref, "refs/heads/", &p)) {
> +				branch = xstrndup(p, head - p);
> +				strbuf_release(&out);
> +				return branch;
> +			}
> +
> +			error(_("remote HEAD is not a branch: '%.*s'"),
> +			      (int)(head - ref), ref);
> +			strbuf_release(&out);
> +			return NULL;

OK.  Any symref whose basename is HEAD in their remote-tracking
hierarchy would have been rejected earlier in the loop.

Is there a particular reason why we return early here, instead of
breaking out of hte loop and let the generic "failed to get" code
path below to handle this case?

> +		}
> +	}
> +	warning(_("failed to get default branch name from remote; "
> +		  "using local default"));
> +	strbuf_reset(&out);
> +
> +	child_process_init(&cp);
> +	cp.git_cmd = 1;
> +	strvec_pushl(&cp.args, "symbolic-ref", "--short", "HEAD", NULL);
> +	if (!pipe_command(&cp, NULL, 0, &out, 0, NULL, 0)) {
> +		strbuf_trim(&out);
> +		return strbuf_detach(&out, NULL);
> +	}
> +
> +	strbuf_release(&out);
> +	error(_("failed to get default branch name"));
> +	return NULL;
> +}

> +static int cmd_clone(int argc, const char **argv)
> +{
> +	const char *branch = NULL;
> +	int full_clone = 0;
> +	struct option clone_options[] = {
> +		OPT_STRING('b', "branch", &branch, N_("<branch>"),
> +			   N_("branch to checkout after clone")),
> +		OPT_BOOL(0, "full-clone", &full_clone,
> +			 N_("when cloning, create full working directory")),
> +		OPT_END(),
> +	};
> +	const char * const clone_usage[] = {
> +		N_("scalar clone [<options>] [--] <repo> [<dir>]"),
> +		NULL
> +	};
> +	const char *url;
> +	char *enlistment = NULL, *dir = NULL;
> +	struct strbuf buf = STRBUF_INIT;
> +	int res;
> +
> +	argc = parse_options(argc, argv, NULL, clone_options, clone_usage, 0);
> +
> +	if (argc == 2) {
> +		url = argv[0];
> +		enlistment = xstrdup(argv[1]);
> +	} else if (argc == 1) {
> +		url = argv[0];
> +
> +		strbuf_addstr(&buf, url);
> +		/* Strip trailing slashes, if any */
> +		while (buf.len > 0 && is_dir_sep(buf.buf[buf.len - 1]))
> +			strbuf_setlen(&buf, buf.len - 1);
> +		/* Strip suffix `.git`, if any */
> +		strbuf_strip_suffix(&buf, ".git");
> +
> +		enlistment = find_last_dir_sep(buf.buf);
> +		if (!enlistment) {
> +			die(_("cannot deduce worktree name from '%s'"), url);
> +		}
> +		enlistment = xstrdup(enlistment + 1);
> +	} else {
> +		usage_msg_opt(_("You must specify a repository to clone."),
> +			      clone_usage, clone_options);
> +	}
> +
> +	if (is_directory(enlistment))
> +		die(_("directory '%s' exists already"), enlistment);
> +
> +	dir = xstrfmt("%s/src", enlistment);
> +
> +	strbuf_reset(&buf);
> +	if (branch)
> +		strbuf_addf(&buf, "init.defaultBranch=%s", branch);
> +	else {
> +		char *b = repo_default_branch_name(the_repository, 1);
> +		strbuf_addf(&buf, "init.defaultBranch=%s", b);
> +		free(b);

Doesn't "git clone" already use their HEAD without having to make an
extra "git ls-remote" roundtrip?

Ahh, you do not do "git clone"; you do "git init", set things up,
and then "git fetch" and checkout, all manually.

Which is kind of shame.

I wonder if it is a cleaner implementation to give a new option to
"git clone" that gives a command sequence (not necessarily have to
be implemented as a shell script) that specifies necessary
pre-configuration steps to be done before the command starts the
transfer step.
