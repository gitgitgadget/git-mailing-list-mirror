Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA43C2BA12
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 17:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjIPR3X (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Sep 2023 13:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjIPR24 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2023 13:28:56 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ED01BD
        for <git@vger.kernel.org>; Sat, 16 Sep 2023 10:28:51 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D141D1A3A7A;
        Sat, 16 Sep 2023 13:28:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=F3qJt2+12/RR1Cyrc29DG2ie5SEsy585JD8mFA
        l6scY=; b=lqVnTpkXjBHuHshpi+n39cW6OS/rHYy6mguJR0h3DH5fgVLXPMkMfT
        3PVkOxzr5GMVQ7XLiXfoPL/SY/Oyjz8+5FL4UFSMep0DFs99vQJXCMJaw/5MM46h
        bWII/1Mu0CWM+sy9FOUWojNO+/4gjU9u1pl2zhejpiuPMUKbA1yXI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C738C1A3A79;
        Sat, 16 Sep 2023 13:28:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 332C81A3A78;
        Sat, 16 Sep 2023 13:28:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mark Levedahl <mlevedahl@gmail.com>
Cc:     johannes.schindelin@gmx.de, me@yadavpratyush.com,
        git@vger.kernel.org
Subject: Re: [PATCH] git-gui - re-enable use of hook scripts
In-Reply-To: <20230916003516.51053-1-mlevedahl@gmail.com> (Mark Levedahl's
        message of "Fri, 15 Sep 2023 20:35:16 -0400")
References: <454d8b7b-96df-ec8f-2285-e022de66c66c@gmail.com>
        <20230916003516.51053-1-mlevedahl@gmail.com>
Date:   Sat, 16 Sep 2023 10:28:48 -0700
Message-ID: <xmqqy1h6auy7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7FEFAFAE-54B6-11EE-9CA4-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark Levedahl <mlevedahl@gmail.com> writes:

> Commit aae9560a introduced search in $PATH to find executables before
> running them, avoiding an issue where on Windows a same named file in
> the current directory can be executed in preference to anything on the
> path. The updated search excludes files given with an absolute path (e.g.,
> /bin/sh). However this change precludes operation of hook scripts as these
> are named with a relative path (.git/hooks/$HOOK), while a search on $PATH
> can succeed only for bare file names, not relative paths. Furthermore,
> the current repository's .git/hooks directory is in general not listed
> in PATH.
>
> Fix this by changing the "absolute" check to a check for more than one
> component in the pathname, thereby avoiding the PATH check for anything
> given with a relative path as well. Bare "git" has one component, "/sh"
> has two components, and .git/hooks/$HOOK has more than two, so relative
> and absolute pathnames avoid the check.
>
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---

With your experiments in the other thread, I think this is quite a
reasonable fix to the problem.  I'd prefer a few updates to the
proposed log message above, though.

 * Refer the older commit like so:

        Earlier, aae9560a (Work around Tcl's default `PATH` lookup,
        2022-11-23) introduced ...

 * It would help readers if you clarify that "The updated search
   excludes ..." and the rest of that paragraph of the log gives a
   bug/problem/undesirable behaviour of the current code introduced
   by the earlier change.  Perhaps something along the lines of ...

	The updated search excludes commands given as an absolute
	path (e.g., /bin/sh), which is good, but it also tries to
	find commands given as a path relative to the current
	directory with directory separator (e.g.,
	.git/hooks/pre-commit), which makes the hooks from running
	at all.  We only want to apply the $PATH logic to a token
	without any directory separator in it.

 * Mention that we already know the new logic works for absolute
   paths even on Windows by tweaking the sentence starting with
   "Bare 'git' has ...".  Something like:

	Bare "git" has one component (which we want to use $PATH),
	"/bin/sh", "C:\some\command", and ".git/hooks/$HOOK" all
	split into 2 or more (which we want to use as-is).  The only
	case we want to use $PATH is when result of [file split] has
	only one element.

But other than that it looks good.

Dscho?

>  git-gui.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-gui.sh b/git-gui.sh
> index 8bc8892..8603437 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -118,7 +118,7 @@ proc sanitize_command_line {command_line from_index} {
>  	set i $from_index
>  	while {$i < [llength $command_line]} {
>  		set cmd [lindex $command_line $i]
> -		if {[file pathtype $cmd] ne "absolute"} {
> +		if {[llength [file split $cmd]] < 2} {
>  			set fullpath [_which $cmd]
>  			if {$fullpath eq ""} {
>  				throw {NOT-FOUND} "$cmd not found in PATH"
