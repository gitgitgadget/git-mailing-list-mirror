Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B7EC433F5
	for <git@archiver.kernel.org>; Mon, 16 May 2022 03:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239596AbiEPDRK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 May 2022 23:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239567AbiEPDRI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 May 2022 23:17:08 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC51911C0F
        for <git@vger.kernel.org>; Sun, 15 May 2022 20:17:07 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 68AD5128678;
        Sun, 15 May 2022 23:17:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=degiIEUJKjKrUDBwbjMWW4nymVgDKaeaspvXyAtpFCM=; b=L8lT
        tOR6aHYkmuwPAj9GDZBr/xi9Fcxsf3wexpBOk4smbPTGWQQsdz567vve+Ts55rdl
        5bMBKXIa+DXEn9dRng4shLna385Tcjkmkn7tmnlEa4nUE2vNJjQY3vzUbTJ5pPFL
        SKDvHy7hQG5fWrA5lzLoAlqvFVLzwCn/6H03RGg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E047128677;
        Sun, 15 May 2022 23:17:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C25CF128676;
        Sun, 15 May 2022 23:17:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Nadav Goldstein via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Nadav Goldstein <nadav.goldstein96@gmail.com>,
        Nadav Goldstein <nadav.goldstein@blazepod.co>
Subject: Re: [PATCH] stash: added safety flag for stash clear subcommand
References: <pull.1232.git.1652649537647.gitgitgadget@gmail.com>
Date:   Sun, 15 May 2022 20:17:04 -0700
Message-ID: <xmqqtu9q5fpr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9BF6034-D4C6-11EC-9419-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Nadav Goldstein via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Nadav Goldstein <nadav.goldstein@blazepod.co>
>
> Introduced a flag (git stash clear -i) when when used,
> instead of silently clearing the stash, will present a
> confirmation to the user regarding the action which he's
> about to perform. Took the inspiration from rm -rf -i flag.
> This flag also outputs extra logs (abort/success) to let
> the user know more "interactively" what is happening with
> the stash (hence the flag name).

Documentation/SubmittingPatches gives many helpful hints on how to
write log messages for the project.

If this were truly "interactive" modelled after "rm -i", I would
imagine that it would ask a question for each stash entry and allow
the user to selectively drop some entries while keeping others.

But that is not how the option behaves, as far as I can see.  It
only asks a single y/N question, without even knowing how many stash
entries there are.  Your user may say "Yes" and the command may then
find no stash entries that need to be cleared after all.

It is not taking any inspiration from "rm -i" at all.

I wonder if it is easier to model the "safety" after "git clean"
instead.  The "git clean" command by default does not do any removal
and you are required to say "clean -f" or "clean -n", unless the
"clean.requireforce" configuration variable is set to false.  The
resulting "git stash clear [--force|--dry-run]" would be fairly easy
to understand to new users, because "git clean [--force|--dry-run]"
already behaves in a similar way.

One caveat is that "git clean" by default requires "--force" on the
command line to do any damage, and it is OK because it was like so
for a long time.  But "git stash clear" has been with us for a very
long time without such requirement, so if you suddenly start
requiring "--force" and defaulting to "--dry-run", existing users
may be annoyed that they need to say

	$ git config --global stashClear.requireforce no

once to get back the original behaviour.

I personally think that such a one-time annoyance forced on all the
existing users may probably be worth it for added safety, but I am
not the only user of Git, so... ;-)

In any case, my recommendation would be

 * add "--force" and "--dry-run" to "git stash clear".

 * add stashClear.requireForce that defaults to "false".

 * document the above. mention the setting in ReleaseNotes.

 * monitor places like stackoverflow to see if folks give advice
   "set stashClear.requireForce to true for safety" to newbies
   often.  It would give us an excuse to proceed to the next step,
   i.e. propose to switch the default of stashClear.requireForce to
   "true".

 * The true "interactive" that lets your users pick and choose what
   to discard can come later as another improved form of additional
   safety.

The rest are minor comments that have already been outdated by all
ofhte above ;-)

> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 6e15f475257..a7ab5379779 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -17,7 +17,7 @@ SYNOPSIS
>  	     [-u|--include-untracked] [-a|--all] [-m|--message <message>]
>  	     [--pathspec-from-file=<file> [--pathspec-file-nul]]
>  	     [--] [<pathspec>...]]
> -'git stash' clear
> +'git stash' clear [-i|--interactive]

As I already said, calling the behaviour implemented by the patch
"interactive" is misleading; users will expect to be able to pick
and choose which entry to discard.

>  static int clear_stash(int argc, const char **argv, const char *prefix)
>  {
> +	int is_prompt;
>  	struct option options[] = {
> +		OPT_BOOL('i', "interactive", &is_prompt,
> +			 N_("confirm clearing stash")),
>  		OPT_END()
>  	};

"IS_prompt" is a strange phrasing to call the option.  

needs_prompt (we need to prompt the user before proceeding),
or do_prompt (literally, "do the prompting"), would be more
understanding, though.
