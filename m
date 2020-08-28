Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D54C433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 22:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FA35207DA
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 22:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PYJHMo5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgH1WDq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 18:03:46 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62678 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgH1WDp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 18:03:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 50342DA27F;
        Fri, 28 Aug 2020 18:03:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L+S+WAiq56WaR2CPSSQ63Ud4j4U=; b=PYJHMo
        5YG6VDMRquE7DHRDssXERbYH/WwYGm3tfeRrKjHVxvkDjIDx0MZhjuz/iK44RpXa
        o0JcocmaqIGmeLHbyJLGNuyR4t3XtdWWDIORvVlVPGV6rr9+dncp5K/VHOpTitb0
        2N35NYgQ2F/GOdV9/kDLxPU9AXwTMxinC4obw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LGC54JViabKUKxaU9sTRlVNWVMpmExWI
        aXx5ICMNAMJ2PbIA+/YtFtINQbJnQN0+rL6nYi6Eytvl3Uy0TCHMAntCpYqFei32
        yMU5AwcVbozVxzZ9LqFt0ruWqH/PaJsPgzn9iVMhZNrCD7IEO6mfxD4jwCrsqPVp
        QgPvzEQJ7Vs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 48C70DA27E;
        Fri, 28 Aug 2020 18:03:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 836C5DA27D;
        Fri, 28 Aug 2020 18:03:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 3/3] git: catch an attempt to run "git-foo"
References: <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com>
        <20200826011718.3186597-1-gitster@pobox.com>
        <20200826011718.3186597-4-gitster@pobox.com>
        <nycvar.QRO.7.76.6.2008280412030.56@tvgsbejvaqbjf.bet>
Date:   Fri, 28 Aug 2020 15:03:38 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2008280412030.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 28 Aug 2020 04:13:15 +0200 (CEST)")
Message-ID: <xmqq1rjqo2bp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54C2ADD6-E97A-11EA-9C47-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This is needed to handle the case where `argv[0]` contains the full path
> (which is the case on Windows) and the suffix `.exe` (which is also the
> case on Windows).

Oy.  Yeah, I totally forgot about ".exe" thing.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  git.c  | 3 ++-
>  help.c | 5 ++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/git.c b/git.c
> index 71ef4835b20e..863fd0c58a66 100644
> --- a/git.c
> +++ b/git.c
> @@ -851,7 +851,8 @@ int cmd_main(int argc, const char **argv)
>  	 * that one cannot handle it.
>  	 */
>  	if (skip_prefix(cmd, "git-", &cmd)) {
> -		warn_on_dashed_git(argv[0]);
> +		strip_extension(&cmd);
> +		warn_on_dashed_git(cmd);

The argv[0] may have been NULL from the beginning of cmd_main(), and
cmd would be "git-help" in such a case.  We used to pass NULL to
warn_on_dashed_git() in such a case because "git-help" is not what
the user typed, but what we internally trigger, so we didn't want
warn_on_dashed_git() to do anything based on that internal string.

As there is no special casing of "help" in warn_on_dashed_git()
mechanism, it probably would start triggering a warning/die when
"git<ENTER>" is typed, no?

+	if (argv[0]) {
		strip_extension(&cmd);
		warn_on_dashed_git(cmd);

may be the minimum fix, but I would strongly prefer to keep the
interface into warn_on_dashed_git() (eh, the most important is the
interface into find_cmdname_help() helper function, which is
designed to be reused by other parts of help.c) to take the full
command name, not without "git-" prefix.  This is primarily because
the entirety of the help.c API is driven by full command names,
without removing "git-" prefix, and it has to, because the help.c
API needs to handle "gitk", from which you cannot remove any "git-"
prefix.

Perhaps

	if (starts_with(cmd, "git-")) {
               	strip_extension(&cmd);
		if (argv[0])
			warn_on_dashed_git(cmd);
		argv[0] = cmd + 4;
                handle_builtin(argc, argv);
		die(...);

How does your handle_builtin() work, by the way?  

The original code (even before we added warn_on_dashed_git() in this
codepath) did not do any strip_extension(), so handle_builtin() can
take commands with ".exe" suffix, but now we are feeding the result
of strip_extension() to it, so it can deal with both? 

Sounds convenient and sloppy (not the handle_builtin's
implementation, but its callers that sometimes feeds the full
executable name, and feeds only the basename some other times) at
the same time.

>  		argv[0] = cmd;
>  		handle_builtin(argc, argv);
> diff --git a/help.c b/help.c
> index c93a76944b00..27b1b26890be 100644
> --- a/help.c
> +++ b/help.c
> @@ -724,9 +724,12 @@ NORETURN void help_unknown_ref(const char *ref, const char *cmd,
>  static struct cmdname_help *find_cmdname_help(const char *name)
>  {
>  	int i;
> +	const char *p;
>
> +	skip_prefix(name, "git-", &name);
>  	for (i = 0; i < ARRAY_SIZE(command_list); i++) {
> -		if (!strcmp(command_list[i].name, name))
> +		if (skip_prefix(command_list[i].name, "git-", &p) &&
> +		    !strcmp(p, name))
>  			return &command_list[i];
>  	}
>  	return NULL;
> --
> 2.28.0.windows.1
