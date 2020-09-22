Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B9CC2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 11:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD7CC20739
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 11:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgIVLEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 07:04:35 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:39095 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgIVLEf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 07:04:35 -0400
X-Greylist: delayed 4303 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 07:04:34 EDT
X-Originating-IP: 157.36.92.42
Received: from localhost (unknown [157.36.92.42])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 682DC40008;
        Tue, 22 Sep 2020 11:04:26 +0000 (UTC)
Date:   Tue, 22 Sep 2020 16:34:19 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Serg Tereshchenko <serg.partizan@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-gui: Basic dark mode support
Message-ID: <20200922110419.ymqj4ol76kg6qshf@yadavpratyush.com>
References: <20200824154835.160749-1-serg.partizan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824154835.160749-1-serg.partizan@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Serg,

Thanks for the patch and sorry for taking so long in getting to it.

On 24/08/20 06:48PM, Serg Tereshchenko wrote:
> Hi all.
> 
> I want to use dark themes with git citool, and here is my first attempt
> to do so.

Like I said in the previous email this part doesn't really belong in the 
commit message. In fact, while this entire text is a good description of 
the patch and your efforts, it is not a good commit message.
 
> I am new to tcl, so i happily accept any tips on how to improve code.
> 
> First things first: to properly support colors, would be nice to have
> them separated from app code, so i created new file lib/colored.tcl. Name
> is selected to be consistent with "lib/themed.tcl".

Wouldn't having the contents of colored.tcl in themed.tcl be a good 
idea? The way I see it, colors are part of the theming of the 
application.
 
> Then, i extract hardcoded colors from git-gui.sh into namespace Color.
> Then, if option use_ttk is true, i update default colors for
> background/foreground from current theme.
> 
> How it was looking before:
>  - Dark theme (awdark): https://i.imgur.com/0lrfHyq.png
>  - Light theme (clam): https://i.imgur.com/1fsfayJ.png
> 
> Now looks like this:
>  - Dark theme (awdark): https://i.imgur.com/BISllEH.png
>  - Light theme (clam): https://i.imgur.com/WclSTa4.png

This is quite an improvement :-)
 
> One problem that i can't yet fix: gray background for files in
> changelists. Any advice on this?

You can set that in the function `rmsel_tag` in git-gui.sh on the line

  $text tag conf in_sel -background lightgray
 
> I would be happy to move color definitions from git-gui.sh to
> themed.tcl, so we can set it once, and not for each ttext call. Do you
> think this is a good idea now or in the future?

Do you mean to put the `-foreground` and `-background` options in the 
function ttext in themed.tcl? If so how can a widget specify if it wants 
a dark text or light for example?
 
> I see some work is already done in that direction, like lib/themed.tcl:gold_frame.
> 
> 
> Kind Regards.
> 
> Signed-off-by: Serg Tereshchenko <serg.partizan@gmail.com>
> ---
>  git-gui.sh      | 33 +++++++++++++++++++--------------
>  lib/colored.tcl | 23 +++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 14 deletions(-)
>  create mode 100644 lib/colored.tcl
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index ca66a8e..cffd106 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -861,6 +861,7 @@ proc apply_config {} {
>  			set NS ttk
>  			bind [winfo class .] <<ThemeChanged>> [list InitTheme]
>  			pave_toplevel .
> +			Color::syncColorsWithTheme
>  		}
>  	}
>  }
> @@ -3273,9 +3274,13 @@ pack .vpane -anchor n -side top -fill both -expand 1
>  # -- Working Directory File List
>  
>  textframe .vpane.files.workdir -height 100 -width 200
> -tlabel .vpane.files.workdir.title -text [mc "Unstaged Changes"] \
> -	-background lightsalmon -foreground black
> -ttext $ui_workdir -background white -foreground black \
> +tlabel .vpane.files.workdir.title \
> +	-text [mc "Unstaged Changes"] \
> +	-background $Color::lightRed \
> +	-foreground $Color::textOnLight
> +ttext $ui_workdir \
> +	-background $Color::textBg \
> +	-foreground $Color::textColor \
>  	-borderwidth 0 \
>  	-width 20 -height 10 \
>  	-wrap none \
> @@ -3296,8 +3301,8 @@ pack $ui_workdir -side left -fill both -expand 1
>  textframe .vpane.files.index -height 100 -width 200
>  tlabel .vpane.files.index.title \
>  	-text [mc "Staged Changes (Will Commit)"] \
> -	-background lightgreen -foreground black
> -ttext $ui_index -background white -foreground black \
> +	-background $Color::lightGreen -foreground $Color::textOnLight
> +ttext $ui_index -background $Color::textBg -foreground $Color::textColor \
>  	-borderwidth 0 \
>  	-width 20 -height 10 \
>  	-wrap none \
> @@ -3432,7 +3437,7 @@ if {![is_enabled nocommit]} {
>  }
>  
>  textframe .vpane.lower.commarea.buffer.frame
> -ttext $ui_comm -background white -foreground black \
> +ttext $ui_comm -background $Color::textBg -foreground $Color::textColor \
>  	-borderwidth 1 \
>  	-undo true \
>  	-maxundo 20 \
> @@ -3519,19 +3524,19 @@ trace add variable current_diff_path write trace_current_diff_path
>  
>  gold_frame .vpane.lower.diff.header
>  tlabel .vpane.lower.diff.header.status \
> -	-background gold \
> -	-foreground black \
> +	-background $Color::lightGold \
> +	-foreground $Color::textOnLight \
>  	-width $max_status_desc \
>  	-anchor w \
>  	-justify left
>  tlabel .vpane.lower.diff.header.file \
> -	-background gold \
> -	-foreground black \
> +	-background $Color::lightGold \
> +	-foreground $Color::textOnLight \
>  	-anchor w \
>  	-justify left
>  tlabel .vpane.lower.diff.header.path \
> -	-background gold \
> -	-foreground blue \
> +	-background $Color::lightGold \
> +	-foreground $Color::lightBlue \
>  	-anchor w \
>  	-justify left \
>  	-font [eval font create [font configure font_ui] -underline 1] \
> @@ -3561,7 +3566,7 @@ bind .vpane.lower.diff.header.path <Button-1> {do_file_open $current_diff_path}
>  #
>  textframe .vpane.lower.diff.body
>  set ui_diff .vpane.lower.diff.body.t
> -ttext $ui_diff -background white -foreground black \
> +ttext $ui_diff -background $Color::textBg -foreground $Color::textColor \
>  	-borderwidth 0 \
>  	-width 80 -height 5 -wrap none \
>  	-font font_diff \
> @@ -3589,7 +3594,7 @@ foreach {n c} {0 black 1 red4 2 green4 3 yellow4 4 blue4 5 magenta4 6 cyan4 7 gr
>  $ui_diff tag configure clr1 -font font_diffbold
>  $ui_diff tag configure clr4 -underline 1
>  
> -$ui_diff tag conf d_info -foreground blue -font font_diffbold
> +$ui_diff tag conf d_info -foreground $Color::lightBlue -font font_diffbold
>  
>  $ui_diff tag conf d_cr -elide true
>  $ui_diff tag conf d_@ -font font_diffbold
> diff --git a/lib/colored.tcl b/lib/colored.tcl
> new file mode 100644
> index 0000000..fdb3f9c
> --- /dev/null
> +++ b/lib/colored.tcl
> @@ -0,0 +1,23 @@
> +# Color configuration support for git-gui.
> +
> +namespace eval Color {

FWIW I don't mind if you just put all this in the global namespace, but 
I'll leave it up to you.

> +	# static colors
> +	variable lightRed		lightsalmon
> +	variable lightGreen		green
> +	variable lightGold		gold
> +	variable lightBlue		blue
> +	variable textOnLight	black
> +	variable textOnDark		white

Why have `textOnLight`, `textOnDark` and `textColor` separately? My 
guess is that it is for when you want to force light colors regardless 
of the theme? Am I right?

> +	# theme colors
> +	variable interfaceBg	lightgray
> +	variable textBg			white
> +	variable textColor		black

Nitpick: please use snake_case for variable names like the rest of the 
code does. Same for the function name below and the namespace name 
above.

> +
> +	proc syncColorsWithTheme {} {
> +		set Color::interfaceBg	[ttk::style lookup Entry -background]
> +		set Color::textBg		[ttk::style lookup Treeview -background]
> +		set Color::textColor	[ttk::style lookup Treeview -foreground]
> +
> +		tk_setPalette $Color::interfaceBg
> +	}
> +}

Most of the patch looks good to me apart from my small suggestions. 
Thanks for working on this.

-- 
Regards,
Pratyush Yadav
