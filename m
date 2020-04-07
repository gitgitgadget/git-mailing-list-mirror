Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2FBC2BA1A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 16:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8618C20719
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 16:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgDGQm4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:42:56 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:20295 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbgDGQm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 12:42:56 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 48xY9n52M8z5tlB;
        Tue,  7 Apr 2020 18:42:53 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C29F341B5;
        Tue,  7 Apr 2020 18:42:52 +0200 (CEST)
Subject: Re: [PATCH] gitk: add diff lines background colors
To:     Stefan Dotterweich <stefandotterweich@gmx.de>
Cc:     git@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>
Newsgroups: gmane.comp.version-control.git
References: <20200211212448.9288-1-stefandotterweich@gmx.de>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <8b5b8d89-59c2-7349-25c1-2529db13fa6e@kdbg.org>
Date:   Tue, 7 Apr 2020 18:42:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200211212448.9288-1-stefandotterweich@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.02.20 um 22:24 schrieb Stefan Dotterweich:
> Not using colored background for added and removed lines is a missed
> opportunity to make diff lines easier to grasp visually.
> 
> Use a subtle red/green background by default. Make the font slightly darker
> to improve contrast.

I've been using gitk with this patch for a while, and I find the new
appearance *very* pleasing! It gives gitk a fresh, modern look.

There is one major gripe, though: the new background color overrides the
selection background and makes the selection invisible. This is a
showstopper.

Note that the search result highlight does not become invisible.

-- Hannes

> 
> Signed-off-by: Stefan Dotterweich <stefandotterweich@gmx.de>
> ---
> The variable diffcolors seems like a fitting place for the two new colors.
> However, adding them to that list causes problems if diffcolors saved in
> .gitk then contains three instead of five colors. This could be solved by
> modifying the variable after loading .gitk. I'm not sure if that would be
> the preferred approach or where to implement a special case like that. To
> avoid the problem, I introduced a new variable diffbgcolors.
> 
>  gitk | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/gitk b/gitk
> index da84e22..66c237a 100755
> --- a/gitk
> +++ b/gitk
> @@ -2073,7 +2073,7 @@ proc makewindow {} {
>      global rowctxmenu fakerowmenu mergemax wrapcomment
>      global highlight_files gdttype
>      global searchstring sstring
> -    global bgcolor fgcolor bglist fglist diffcolors selectbgcolor
> +    global bgcolor fgcolor bglist fglist diffcolors diffbgcolors selectbgcolor
>      global uifgcolor uifgdisabledcolor
>      global filesepbgcolor filesepfgcolor
>      global mergecolors foundbgcolor currentsearchhitbgcolor
> @@ -2434,7 +2434,9 @@ proc makewindow {} {
>      $ctext tag conf filesep -font textfontbold -fore $filesepfgcolor -back $filesepbgcolor
>      $ctext tag conf hunksep -fore [lindex $diffcolors 2]
>      $ctext tag conf d0 -fore [lindex $diffcolors 0]
> +    $ctext tag conf d0 -back [lindex $diffbgcolors 0]
>      $ctext tag conf dresult -fore [lindex $diffcolors 1]
> +    $ctext tag conf dresult -back [lindex $diffbgcolors 1]
>      $ctext tag conf m0 -fore [lindex $mergecolors 0]
>      $ctext tag conf m1 -fore [lindex $mergecolors 1]
>      $ctext tag conf m2 -fore [lindex $mergecolors 2]
> @@ -11607,6 +11609,7 @@ proc prefspage_general {notebook} {
> 
>  proc prefspage_colors {notebook} {
>      global NS uicolor bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
> +    global diffbgcolors
> 
>      set page [create_prefs_page $notebook.colors]
> 
> @@ -11629,11 +11632,23 @@ proc prefspage_colors {notebook} {
>  	-command [list choosecolor diffcolors 0 $page.diffold [mc "diff old lines"] \
>  		      [list $ctext tag conf d0 -foreground]]
>      grid x $page.diffoldbut $page.diffold -sticky w
> +    label $page.diffoldbg -padx 40 -relief sunk -background [lindex $diffbgcolors 0]
> +    ${NS}::button $page.diffoldbgbut -text [mc "Diff: old lines bg"] \
> +	-command [list choosecolor diffbgcolors 0 $page.diffoldbg \
> +		      [mc "diff old lines bg"] \
> +		      [list $ctext tag conf d0 -background]]
> +    grid x $page.diffoldbgbut $page.diffoldbg -sticky w
>      label $page.diffnew -padx 40 -relief sunk -background [lindex $diffcolors 1]
>      ${NS}::button $page.diffnewbut -text [mc "Diff: new lines"] \
>  	-command [list choosecolor diffcolors 1 $page.diffnew [mc "diff new lines"] \
>  		      [list $ctext tag conf dresult -foreground]]
>      grid x $page.diffnewbut $page.diffnew -sticky w
> +    label $page.diffnewbg -padx 40 -relief sunk -background [lindex $diffbgcolors 1]
> +    ${NS}::button $page.diffnewbgbut -text [mc "Diff: new lines bg"] \
> +	-command [list choosecolor diffbgcolors 1 $page.diffnewbg \
> +		      [mc "diff new lines bg"] \
> +		      [list $ctext tag conf dresult -background]]
> +    grid x $page.diffnewbgbut $page.diffnewbg -sticky w
>      label $page.hunksep -padx 40 -relief sunk -background [lindex $diffcolors 2]
>      ${NS}::button $page.hunksepbut -text [mc "Diff: hunk header"] \
>  	-command [list choosecolor diffcolors 2 $page.hunksep \
> @@ -12377,7 +12392,8 @@ if {[tk windowingsystem] eq "win32"} {
>  	set web_browser "xdg-open"
>      }
>  }
> -set diffcolors {red "#00a000" blue}
> +set diffcolors {"#c30000" "#009800" blue}
> +set diffbgcolors {"#fff3f3" "#f0fff0"}
>  set diffcontext 3
>  set mergecolors {red blue "#00ff00" purple brown "#009090" magenta "#808000" "#009000" "#ff0080" cyan "#b07070" "#70b0f0" "#70f0b0" "#f0b070" "#ff70b0"}
>  set ignorespace 0
> @@ -12448,7 +12464,7 @@ set config_variables {
>      remotebgcolor tagbgcolor tagfgcolor tagoutlinecolor reflinecolor
>      filesepbgcolor filesepfgcolor linehoverbgcolor linehoverfgcolor
>      linehoveroutlinecolor mainheadcirclecolor workingfilescirclecolor
> -    indexcirclecolor circlecolors linkfgcolor circleoutlinecolor
> +    indexcirclecolor circlecolors linkfgcolor circleoutlinecolor diffbgcolors
>      web_browser
>  }
>  foreach var $config_variables {
> --
> 2.24.1
> 
> 

