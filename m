From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-revert is a memory hog
Date: Sun, 27 Jan 2008 12:38:08 -0500
Message-ID: <20080127173808.GX24004@spearce.org>
References: <20080127172748.GD2558@does.not.exist>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 27 18:38:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJBSu-0002SL-8B
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 18:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbYA0RiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 12:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752039AbYA0RiN
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 12:38:13 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39280 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbYA0RiM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 12:38:12 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JJBSG-0002Hr-4E; Sun, 27 Jan 2008 12:38:04 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 04FFA20FBAE; Sun, 27 Jan 2008 12:38:08 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20080127172748.GD2558@does.not.exist>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71823>

Adrian Bunk <bunk@kernel.org> wrote:
> I'm not sure whether this is already known, but when recently working 
> for some time from a computer with "only" 512 MB RAM I ran into the huge 
> memory usage of git-revert when it tries to revert old commits.
> 
> Example (in Linus' kernel tree with git 1.5.3.8):
> 
> $ git-revert d19fbe8a7
...
> In top you can see that this took > 800 MB of RAM !
> 
> I don't know how easy it would be to implement, but shouldn't git-revert 
> be able to be as fast and less memory consuming as
>   git-show d19fbe8a7 | patch -p1 -R

Its more like:

	git-diff-tree -M d19fbe8a7^ d19fbe8a7 | git-apply -R --index

In other words its doing rename detection.  Its possible that the
rename detector fired for added/removed paths and it took some
significant amount of memory to figure out what was renamed.
Maybe we hung onto stuff for too long, but it has to do rename
detection and that takes memory to store the matrix and file
contents.  Once memory is allocated by git we don't give it back
to the kernel, even if we free'd it internally.

If you really are tight on memory and have to do a revert you can
use the above, but minus the -M, to setup the change, but you may
run into trouble if renames were involved.

-- 
Shawn.
