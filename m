From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: offer a list of recent repositories on startup
Date: Sun, 7 Oct 2007 19:30:23 -0400
Message-ID: <20071007233023.GE2137@spearce.org>
References: <11917925011987-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:30:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iefa3-000539-3T
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756212AbXJGXa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 19:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756082AbXJGXa1
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:30:27 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58743 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755937AbXJGXa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:30:26 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IefZf-0006Jk-21; Sun, 07 Oct 2007 19:30:15 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5DB1E20FBAE; Sun,  7 Oct 2007 19:30:23 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <11917925011987-git-send-email-prohaska@zib.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60259>

Steffen Prohaska <prohaska@zib.de> wrote:
> If git-gui is started outside a work tree the repository
> chooser will offer a list of recently opend repositories.
> Clicking on an entry directly opens the repository.
> 
> The list of recently opened repositories is stored in the
> config as gui.recentrepos. If the list grows beyond 10
> entries it will be truncated.
> 
> Note, only repositories that are opened through the
> repository chooser will get added to the recent list.
> Repositories opened from the shell will not yet be added.

I think that all makes a lot of sense.  Three comments below about
this patch in particular.
 
> I'd suggest to reduce the number of clicks needed to open or
> clone an existing directory that is not in the list of
> recent repositories. First choosing from the radiobuttons
> and then clicking next is one click to much. There are no
> options to combine. Choosing from the list should
> immediately trigger the action.
> 
> We could either put 'Create/Clone/Open New Repository' into
> the Repository menu and only present the recent repository
> list. Or we could offer push buttons for the other actions.

I agree entirely.  That "Next" button is stupid stupid stupid.
What was I smoking that day?  :-)

I'm concerned about putting them into the Repository menu only
as then the main window is competely void and users are sort of
wondering what they should do next.  I think we should actually
do both.  Put them into the menu and as push buttons on the window.

> +	label $w_body.space
> +	label $w_body.recentlabel \
> +		-anchor w \
> +		-text "Select Recent Repository:"

This string needs to be i18n'd with [mc ...].

> +	listbox $w_body.recentlist \

Please make a field in this class called say "w_recentlist"
so you can use that field name instead of $w_body.recentlist.
This simplifies the code if we ever have to change the actual path
that the widget resides at, such as to alter the layout.

> +proc _append_recentrepos {path} {
> +	set recent [get_config gui.recentrepos]
> +	if {[lsearch $recent $path] < 0} {
> +		lappend recent $path
> +	}
> +	if {[llength $recent] > 10} {
> +		set recent [lrange $recent 1 end]
> +	}
> +	regsub -all "\[{}\]" $recent {"} recent
> +	git config --global gui.recentrepos $recent
> +}

Why treat this as a Tcl list in a single value?  Why not make it
a true multi-value configuration entry in ~/.gitconfig, like how
remote.$name.fetch is a multi-value entry?  Does Windows allow
you to put " in a path name?  Because the above regex will make
a list of paths that contains " in one of the entries invalid.

I think you also want to have this function return back immediately
if [lsearch $recent $path] >= 0 as then you don't invoke git-config
to perform a no-op change in the configuration file.  As you well
know forking on Windows is a major cost.  We shouldn't run git-config
just because the user opened a recent repository.

-- 
Shawn.
