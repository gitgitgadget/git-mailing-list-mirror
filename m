Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0668CC2D0C3
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 19:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFD620722
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 19:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfL0TeZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 14:34:25 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:49563 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfL0TeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 14:34:25 -0500
X-Originating-IP: 157.36.251.170
Received: from localhost (unknown [157.36.251.170])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 7E535FF802;
        Fri, 27 Dec 2019 19:34:21 +0000 (UTC)
Date:   Sat, 28 Dec 2019 01:04:18 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Zoli =?utf-8?B?U3phYsOz?= via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Zoli =?utf-8?B?U3phYsOz?= <zoli.szabo@gmail.com>
Subject: Re: [PATCH 1/1] git-gui: add possibility to open currently selected
 file
Message-ID: <20191227193418.36uzeizs37nv7ywb@yadavpratyush.com>
References: <pull.499.git.1577386915.gitgitgadget@gmail.com>
 <fce80f1b95f83915076640ca0be01aa473744777.1577386915.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fce80f1b95f83915076640ca0be01aa473744777.1577386915.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Zoli,

Thanks for the patch.

On 26/12/19 07:01PM, Zoli Szabó via GitGitGadget wrote:
> From: =?UTF-8?q?Zoli=20Szab=C3=B3?= <zoli.szabo@gmail.com>
> 
> ...in the default associated app (e.g. in a text editor / IDE).
> 
> Many times there's the need to quickly open a source file (the one you're
> looking at in Git GUI) in the predefined text editor / IDE. Of course,
> the file can be searched for in your preferred file manager or directly
> in the text editor, but having the option to directly open the current
> file from Git GUI would be just faster. This change enables just that by:
>  - Diff header path context menu -> Open;

Would it be a better idea to have this option in the diff body context 
menu (.vpane.lower.diff.body.ctxm) instead? The problem I see with the 
way its currently done is visibility/discovery. It is not very likely 
for a user to try and click the file name which doesn't give any 
indication that it is clickable. So how will someone who hasn't read 
this commit message know that they can use this neat feature. The diff 
body context menu is much more "visible" IMO.

>  - or double-clicking the diff header path.

An alternative to the above suggestion would be to make this path 
underlined and blue in color (like a hyperlink in a web browser). This 
will give the indication that this is not just plain text.

I like the latter idea more, but I don't mind either.
 
> One "downside" of the approach is that executable files will be run
> and not opened for editing.

FWIW, I do not see it as a downside at all. The menu option is called 
"open" not "edit". So if you click it, you should expect the file to 
open. In case its a binary file, executing it is the correct outcome. In 
case its a text file, opening it in the editor is the correct outcome.
 
> Signed-off-by: Zoli Szabó <zoli.szabo@gmail.com>
> ---
>  git-gui.sh | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index c1be733e3e..705b97f7ab 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -2248,8 +2248,8 @@ proc do_git_gui {} {
>  	}
>  }
>  
> -proc do_explore {} {
> -	global _gitworktree
> +# Get the system-specific explorer app/command.
> +proc get_explorer {} {
>  	set explorer {}

Not exactly related to this patch, but this line is redundant. No point 
in clearing 'explorer' only to set it in the very next if-else chain.

>  	if {[is_Cygwin] || [is_Windows]} {
>  		set explorer "explorer.exe"
> @@ -2259,9 +2259,25 @@ proc do_explore {} {
>  		# freedesktop.org-conforming system is our best shot
>  		set explorer "xdg-open"
>  	}
> +	return $explorer
> +}
> +
> +proc do_explore {} {
> +	global _gitworktree
> +	set explorer [get_explorer]
>  	eval exec $explorer [list [file nativename $_gitworktree]] &
>  }
>  
> +# Trigger opening a file (relative to the working tree) by the default
> +# associated app of the OS (e.g. a text editor or IDE).

Nitpick: This comment doesn't really add a whole lot of information. The 
procedure name already make it pretty clear that it will open a file. 
And it is pretty easy to understand from reading the body of the 
procedure that it will be relative to the working tree. So, I think it 
can be removed altogether.

But even if you think it should stay, please at least make it more 
concise. Maybe something like:

  Open file relative to the working tree by the default associated app.

> +# FIXME: What about executables (will be run, not opened for editing)?

Again, I think running the executables is the correct behaviour. So I 
don't think this needs any fixing.

> +proc do_file_open {file} {
> +	global _gitworktree
> +	set explorer [get_explorer]
> +	set full_file_path [file join $_gitworktree $file]
> +	eval exec $explorer [list [file nativename $full_file_path]] &

This executes $explorer, which is 'explorer.exe' on Windows. I'm not a 
heavy Windows user but AFAIK it is a file manager. This makes it quite 
different from 'xdg-open' which is used to open _any_ file/URL in the 
user's default application. So it also happens to open _directories_ in 
the default file explorer which was the original intention of this 
procedure.

Have you tested it on Windows? Does 'explorer.exe' do the correct thing? 

Looking at MacOS's 'open' man page, I think it should also work like 
xdg-open and shouldn't be a problem.

> +}
> +
>  set is_quitting 0
>  set ret_code    1
>  
> @@ -3530,8 +3546,14 @@ $ctxm add command \
>  			-type STRING \
>  			-- $current_diff_path
>  	}
> +$ctxm add command \
> +	-label [mc Open] \
> +	-command {
> +		do_file_open $current_diff_path
> +	}

Nitpick: no need to make the command multi-line. So, change it to 
something like:

  -command {do_file_open $current_diff_path}

>  lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
>  bind_button3 .vpane.lower.diff.header.path "tk_popup $ctxm %X %Y"
> +bind .vpane.lower.diff.header.path <Double-1> {do_file_open $current_diff_path}
>  
>  # -- Diff Body
>  #

Tested on Linux. Works fine. Looking forward to the re-roll.

-- 
Regards,
Pratyush Yadav
