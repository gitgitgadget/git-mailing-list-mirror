Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F48ECE79D0
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 13:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbjITN2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 09:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbjITN2K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 09:28:10 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D094D122
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 06:28:00 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0111540002;
        Wed, 20 Sep 2023 13:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadavpratyush.com;
        s=gm1; t=1695216479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yaQ+0TYGdIo6UVPWfe+klfjWqhsk6IuglqdRslkiTwo=;
        b=H1Ofz1Ta2MW+qx2C9N6mrE6rFwnbEIivjr7x9I+ggRAcJn7uxFIp8MiQkvH9qDXa4yPOD0
        Yea7h0+vAOsMRJxs+ooyADOw1TpzByQlLbbW9TCmyOE8TBoyupVPKHfhpjonrR6aoKdfyQ
        QF4Wc/NPis2mo69GNNOk6/MZQpR83tPDfcm5Vde80MCGH1NO0RpcfD2+CpC/XIVihojCDX
        CIiZK26ySR/LzACeHRwguMOxNrWdg/cbtuVNR6Lnz6aMFLgSPizk3TDUAu/lYtIUZbGNah
        TQJiuWOIg2o1ktQSLTg5S8ABAzU00LzIhskE6mPDYCIeywXongQZmMz3A7u5zw==
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Mark Levedahl <mlevedahl@gmail.com>
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        me@yadavpratyush.com, git@vger.kernel.org
Subject: Re: [PATCH v2] git-gui - re-enable use of hook scripts
In-Reply-To: <20230916210131.78593-1-mlevedahl@gmail.com> (Mark Levedahl's
        message of "Sat, 16 Sep 2023 17:01:31 -0400")
References: <xmqqy1h6auy7.fsf@gitster.g>
        <20230916210131.78593-1-mlevedahl@gmail.com>
Date:   Wed, 20 Sep 2023 15:27:57 +0200
Message-ID: <mafs0wmwlotya.fsf@yadavpratyush.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: me@yadavpratyush.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi,

On Sat, Sep 16 2023, Mark Levedahl wrote:

> Earlier, commit aae9560a introduced search in $PATH to find executables
> before running them, avoiding an issue where on Windows a same named
> file in the current directory can be executed in preference to anything
> in a directory in $PATH. This search is intended to find an absolute
> path for a bare executable ( e.g, a function "foo") by finding the first
> instance of "foo" in a directory given in $PATH, and this search works
> correctly.  The search is explicitly avoided for an executable named
> with an absolute path (e.g., /bin/sh), and that works as well.
>
> Unfortunately, the search is also applied to commands named with a
> relative path. A hook script (or executable) $HOOK is usually located
> relative to the project directory as .git/hooks/$HOOK. The search for
> this will generally fail as that relative path will (probably) not exist
> on any directory in $PATH. This means that git hooks in general now fail
> to run. Considerable mayhem could occur should a directory on $PATH be
> git controlled. If such a directory includes .git/hooks/$HOOK, that
> repository's $HOOK will be substituted for the one in the current
> project, with unknown consequences.
>
> This lookup failure also occurs in worktrees linked to a remote .git
> directory using git-new-workdir. However, a worktree using a .git file
> pointing to a separate git directory apparently avoids this: in that
> case the hook command is resolved to an absolute path before being
> passed down to the code introduced in aae9560a.
>
> Fix this by replacing the test for an "absolute" pathname to a check for
> a command name having more than one pathname component. This limits the
> search and absolute pathname resolution to bare commands. The new test
> uses tcl's "file split" command. Experiments on Linux and Windows, using
> tclsh, show that command names with relative and absolute paths always
> give at least two components, while a bare command gives only one.
>
> 	  Linux:   puts [file split {foo}]       ==>  foo
> 	  Linux:   puts [file split {/foo}]      ==>  / foo
> 	  Linux:   puts [file split {.git/foo}]  ==> .git foo
> 	  Windows: puts [file split {foo}]       ==>  foo
> 	  Windows: puts [file split {c:\foo}]    ==>  c:/ foo
> 	  Windows: puts [file split {.git\foo}]  ==> .git foo
>
> The above results show the new test limits search and replacement
> to bare commands on both Linux and Windows.
>
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>

Looks good. Thanks.

Reviewed-by: Pratyush Yadav <me@yadavpratyush.com>

> ---
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

-- 
Regards,
Pratyush Yadav
