From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Make gitk save and restore the user set window position.
Date: Wed, 7 Feb 2007 00:40:10 -0500
Message-ID: <20070207054010.GB7047@spearce.org>
References: <7v3b5ifyam.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mark Levedahl <mdl123@verizon.net>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 07 06:40:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEfXd-0004LR-F0
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 06:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbXBGFkT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 00:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752326AbXBGFkT
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 00:40:19 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42506 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbXBGFkS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 00:40:18 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HEfXP-00039Z-Qc; Wed, 07 Feb 2007 00:40:11 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1E51420FBAE; Wed,  7 Feb 2007 00:40:10 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v3b5ifyam.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38889>

Junio C Hamano <junkio@cox.net> wrote:
>    After seeing what this patch has to do, I feel dirty, but
>    that is not Mark's fault -- rather it is Tk's.
> 
>    I am tempted to suggest adding an explicit "Save window
>    configuration" action on the menubar and forget about
>    resurrecting the window configuration immediately before the
>    end of the last session.

Maybe take a look at what git-gui does here, because its slightly
saner and still saves the geometry on exit:

	set is_quitting 0
	proc do_quit {} {
		global is_quitting
		if {$is_quitting} return
		set is_quitting 1
		# save wm geometry
	}
	bind . <Destroy> do_quit

OK, its not that much saner.  But it does bypass needing to setup
some ugly bindings on every object in the UI.  Though I recently
took a slightly different approach in a dialog:

	proc do_quit {} {
		bind . <Destroy> {}
		# do cleanup
	}
	bind . <Destroy> do_quit

Yes the binding is firing in both cases for some arbitrary child
widget in the window, but it doesn't matter.  In the latter version
setting the binding to the empty string removes the do_quit binding,
allowing the other widgets to destroy without reinvoking do_quit
and whacking whatever geometry data you may have saved before the
widgets started to get deleted.


The only problem I seem to have in git-gui is the window position
opens about 10 pixels lower and 2 pixels to the right than the last
time it opened.  I think there's a bug in Tk on Windows where the
window position on the desktop doesn't include the titlebar when I
get it, but expects to include it when I attempt to set it on the
next start.

I should note I also see the same behavior with my day-time-job's
Java apps on Windows however, so I don't think its a specific Tk
or git-gui issue.

-- 
Shawn.
