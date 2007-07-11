From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Work around a bad interaction between Tcl and cmd.exe with "^{tree}"
Date: Wed, 11 Jul 2007 04:03:33 -0400
Message-ID: <20070711080333.GP4436@spearce.org>
References: <4693AF6C.99DB933@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 10:03:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8XAq-0006uj-3i
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 10:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754375AbXGKIDl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 04:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753172AbXGKIDk
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 04:03:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42045 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbXGKIDh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 04:03:37 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I8XAb-0003Ex-MG; Wed, 11 Jul 2007 04:03:33 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 77AEE20FBAE; Wed, 11 Jul 2007 04:03:33 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4693AF6C.99DB933@eudaptics.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52141>

Johannes Sixt <J.Sixt@eudaptics.com> wrote:
> It seems that MSYS's wish does some quoting for Bourne shells, in
> particular, escape the first '{' of the "^{tree}" suffix, but then it uses
> cmd.exe to run "git rev-parse". However, cmd.exe does not remove the
> backslash, so that the resulting rev expression ends up in git's guts
> as unrecognizable garbage: rev-parse fails, and git-gui hickups in a way
> that it must be restarted.
> 
> Fortunately, recent versions of git can refer to the root tree object using
> the notation "$commit:", which avoids the problematic case.
> 
> Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
> ---
> This is a resend with a slightly improved commit message.
> The first version didn't get through for some reason anyway, it seems.

I did get your patch yesterday.  I just didn't finish my replacement
version.  Got busy with other things.

I have seen this { issue before.  And not just on MSYS.  It also
borked on Cygwin.  This is why git-gui formats the geometry and
font data the way it does in the .git/config file; by default it
wanted to use {} around strings with spaces in them and this got
all messed up going through the shell.  So we s/[{}]/"/g before we
call git-config.  Yea, it sucks.

Rather than relying on rev-parse to understand the : syntax here
I'm just going to parse the commit object and yank the first line
out of it.  We already do that for an amend to refetch the message
buffer.  Either way it is a fork.  And its roughly the same amount
of CPU time for both git-gui and C git.  :-|
 
> diff --git a/lib/commit.tcl b/lib/commit.tcl
> index dc7c88c..43a5aca 100644
> --- a/lib/commit.tcl
> +++ b/lib/commit.tcl
> @@ -258,7 +258,7 @@ proc commit_committree {fd_wt curHEAD msg} {
>  	# -- Verify this wasn't an empty change.
>  	#
>  	if {$commit_type eq {normal}} {
> -		set old_tree [git rev-parse "$PARENT^{tree}"]
> +		set old_tree [git rev-parse "$PARENT:"]
>  		if {$tree_id eq $old_tree} {
>  			info_popup {No changes to commit.

-- 
Shawn.
