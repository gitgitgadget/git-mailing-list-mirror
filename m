From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/5] Internationalization of git-gui
Date: Sun, 22 Jul 2007 03:45:25 -0400
Message-ID: <20070722074525.GX32566@spearce.org>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com> <20070721080338.GT32566@spearce.org> <200707211433.29318.stimming@tuhh.de> <200707211434.56622.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Sun Jul 22 09:45:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICW8O-00058j-58
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 09:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309AbXGVHpc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 03:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753730AbXGVHpc
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 03:45:32 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41378 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182AbXGVHpb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 03:45:31 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1ICW86-0007Ed-R3; Sun, 22 Jul 2007 03:45:27 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 204A620FBAE; Sun, 22 Jul 2007 03:45:26 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200707211434.56622.stimming@tuhh.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53229>

Christian Stimming <stimming@tuhh.de> wrote:
> Subject: [PATCH] Mark strings for translation.
> 
> The procedure [mc ...] will translate the strings through msgcat.
...
> Here I marked much more strings than in the previous patch, and as discussed
> the procedure [mc ...] is used for translation. Actually I think this pretty much 
> caught all occurrences of user-visible strings in *this* file; there will be many
> more strings in all the other files, of course.

Almost.  I noticed two that you did miss, and its because they are
totally weird.  We may want to rewrite this block of code first...

> @@ -1673,7 +1673,7 @@ if {[is_enabled transport]} {
>  menu .mbar.repository
>  
>  .mbar.repository add command \
> -	-label {Browse Current Branch's Files} \
> +	-label [mc "Browse Current Branch's Files"] \
>  	-command {browser::new $current_branch}
>  trace add variable current_branch write ".mbar.repository entryconf [.mbar.repository index last] -label \"Browse \$current_branch's Files\" ;#"
>  .mbar.repository add command \
> @@ -1682,69 +1682,69 @@ trace add variable current_branch write ".mbar.repository entryconf [.mbar.repos
>  .mbar.repository add separator
>  
>  .mbar.repository add command \
> -	-label {Visualize Current Branch's History} \
> +	-label [mc "Visualize Current Branch's History"] \
>  	-command {do_gitk $current_branch}
>  trace add variable current_branch write ".mbar.repository entryconf [.mbar.repository index last] -label \"Visualize \$current_branch's History\" ;#"
>  .mbar.repository add command \

See those two trace lines?  These things are setting up hooks to
change the menu item's label on the fly, so that the current branch
name is shown in the item label.  These will also need to use mc to
translate the string.  But they are in a double quoted string and will
be eval'd later by Tcl, so we actually need something like:

- trace add variable current_branch write ".mbar.repository entryconf [.mbar.repository index last] -label \"Visualize \$current_branch's History\" ;#"
+ trace add variable current_branch write ".mbar.repository entryconf [.mbar.repository index last] -label \[mc \"Visualize \$current_branch's History\"\] ;#"

These are (I think) the only two places in all of git-gui where
this wierdness happens.  Converting this trace pair to a normal
procedure may make it easier to manage for translation.

> -	.mbar.apple add command -label "About [appname]" \
> +	.mbar.apple add command -label [mc "About %s" appname] \

Bug. This needs to be:

+	.mbar.apple add command -label [mc "About %s" [appname]] \

You lost one level of [] there when you did the replacement.
I only noticed this during a fast scan through while deleting text.
I'll have to reread this patch more carefully later, before I apply
(or merge) it, to make sure we don't have more such cases.

-- 
Shawn.
