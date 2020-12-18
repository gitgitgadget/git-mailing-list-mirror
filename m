Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AFAC4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 12:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7C4A23A5B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 12:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgLRMvR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 07:51:17 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:41849 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgLRMvR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 07:51:17 -0500
X-Originating-IP: 103.82.80.101
Received: from localhost (unknown [103.82.80.101])
        (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 6C4512000C;
        Fri, 18 Dec 2020 12:50:34 +0000 (UTC)
Date:   Fri, 18 Dec 2020 18:20:25 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Stefan Haller <stefan@haller-berlin.de>
Cc:     serg.partizan@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v2] git-gui: use gray background for inactive text widgets
Message-ID: <20201218125025.gj277jwxrblqp45b@yadavpratyush.com>
References: <55348fbb-95bb-1dd2-4e17-4fc622ae7603@haller-berlin.de>
 <20201124212333.80040-1-stefan@haller-berlin.de>
 <20201217214912.ycp7bidcyqwzslxy@yadavpratyush.com>
 <63356203-8af0-64e5-4694-f47d31bcdee6@haller-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63356203-8af0-64e5-4694-f47d31bcdee6@haller-berlin.de>
X-GND-Spam-Score: 400
X-GND-Status: SPAM
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/12/20 11:14PM, Stefan Haller wrote:
> On 17.12.20 22:49, Pratyush Yadav wrote:
> > Hi,
> > 
> > On 24/11/20 10:23PM, Stefan Haller wrote:
> >> Second version; it simplifies the code to initialize and update the colors in
> >> the two file list views a bit, and it calculates a gray color for the inactive
> >> selection from the active selection. This looks a lot better in the themes I
> >> have tried.
> >>
> >> The bug with the inactive diff selection background on Mac is still there,
> >> however.
> >>
> >> --- 8< ---
> >>
> >> This makes it easier to see at a glance which of the four main views has the
> >> keyboard focus.
> > 
> > Missing Signed-off-by.
> 
> If you are willing to add this in yourself, that would be nice, I don't
> have time to send another patch today:
> 
> Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
> 
> >> ---
> >>  git-gui.sh     | 18 ++++++++++++------
> >>  lib/themed.tcl | 21 +++++++++++++++++----
> >>  2 files changed, 29 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/git-gui.sh b/git-gui.sh
> >> index 867b8ce..e818caa 100755
> >> --- a/git-gui.sh
> >> +++ b/git-gui.sh
> >> @@ -720,9 +720,6 @@ proc rmsel_tag {text} {
> >>  		-background [$text cget -background] \
> >>  		-foreground [$text cget -foreground] \
> >>  		-borderwidth 0
> >> -	$text tag conf in_sel\
> >> -		-background $color::select_bg \
> >> -		-foreground $color::select_fg
> >>  	bind $text <Motion> break
> >>  	return $text
> >>  }
> >> @@ -3322,11 +3319,20 @@ if {!$use_ttk} {
> >>  	.vpane.files paneconfigure .vpane.files.index -sticky news
> >>  }
> >>
> >> +proc set_selection_colors {w has_focus} {
> >> +	foreach tag [list in_diff in_sel] {
> >> +		$w tag conf $tag \
> >> +			-background [expr {$has_focus ? $color::select_bg : $color::inactive_select_bg}] \
> >> +			-foreground [expr {$has_focus ? $color::select_fg : $color::inactive_select_fg}]
> >> +	}
> >> +}
> >> +
> >>  foreach i [list $ui_index $ui_workdir] {
> >>  	rmsel_tag $i
> >> -	$i tag conf in_diff \
> >> -		-background $color::select_bg \
> >> -		-foreground $color::select_fg
> >> +
> >> +	set_selection_colors $i 0
> >> +	bind $i <FocusIn>	{ set_selection_colors %W 1 }
> >> +	bind $i <FocusOut>	{ set_selection_colors %W 0 }
> >>  }
> >>  unset i
> >>
> >> diff --git a/lib/themed.tcl b/lib/themed.tcl
> >> index eda5f8c..db49085 100644
> >> --- a/lib/themed.tcl
> >> +++ b/lib/themed.tcl
> >> @@ -6,8 +6,10 @@ namespace eval color {
> >>  	# Variable colors
> >>  	# Preffered way to set widget colors is using add_option.
> >>  	# In some cases, like with tags in_diff/in_sel, we use these colors.
> >> -	variable select_bg		lightgray
> >> -	variable select_fg		black
> >> +	variable select_bg				lightgray
> >> +	variable select_fg				black
> >> +	variable inactive_select_bg		lightgray
> >> +	variable inactive_select_fg		black
> >>
> >>  	proc sync_with_theme {} {
> >>  		set base_bg		[ttk::style lookup . -background]
> >> @@ -19,6 +21,8 @@ namespace eval color {
> >>
> >>  		set color::select_bg $select_bg
> >>  		set color::select_fg $select_fg
> >> +		set color::inactive_select_bg [convert_rgb_to_gray $select_bg]
> >> +		set color::inactive_select_fg $select_fg
> >>
> >>  		proc add_option {key val} {
> >>  			option add $key $val widgetDefault
> >> @@ -36,11 +40,20 @@ namespace eval color {
> >>  		add_option *Text.Foreground $text_fg
> >>  		add_option *Text.selectBackground $select_bg
> >>  		add_option *Text.selectForeground $select_fg
> >> -		add_option *Text.inactiveSelectBackground $select_bg
> >> -		add_option *Text.inactiveSelectForeground $select_fg
> >> +		add_option *Text.inactiveSelectBackground $color::inactive_select_bg
> >> +		add_option *Text.inactiveSelectForeground $color::inactive_select_fg
> > 
> > Nitpick: Do what is being done for select_bg and select_fg and create a 
> > local variable for it.
> > 
> >>  	}
> >>  }
> >>
> >> +proc convert_rgb_to_gray {rgb} {
> >> +	# Simply take the average of red, green and blue. This wouldn't be good
> >> +	# enough for, say, converting a photo to grayscale, but for this simple
> >> +	# purpose of approximating the brightness of a color it's good enough.
> >> +	lassign [winfo rgb . $rgb] r g b
> > 
> > Is there no simpler way to extract r, g, and b? This is a little cryptic 
> > to be honest.
> 
> Actually, I find this pretty elegant, and from what I have seen, it's
> idiomatic Tcl. A less cryptic way would be (untested):
> 
>   set components [winfo rgb . $rgb]
>   set r [lindex $components 0]
>   set g [lindex $components 1]
>   set b [lindex $components 2]
> 
> But I much prefer the one-line version.

I agree. Using lassign is much neater. But that is not my point. I am 
talking about the "[winfo rgb . $rgb]". This call generates the list 
that is then assigned to the 3 variables. This part is a little cryptic. 
Is there no simpler way to separate out the r, g, and b values?
 
> >> +	set gray [expr {($r / 256 + $g / 256 + $b / 256) / 3}]
> >> +	return [format "#%2.2X%2.2X%2.2X" $gray $gray $gray]
> >> +}
> >> +
> >>  proc ttk_get_current_theme {} {
> >>  	# Handle either current Tk or older versions of 8.5
> >>  	if {[catch {set theme [ttk::style theme use]}]} {
> > 
> > The patch looks good for the most part. I can fix the above nitpick 
> > locally and merge it in tomorrow if you send me your signoff by then. I 
> > don't want to hold off the PR to Junio too much longer. A simple reply 
> > containing your Signed-off-by should be fine. Thanks.
> 
> Awesome, thanks for that.
> 
> -Stefan

-- 
Regards,
Pratyush Yadav
