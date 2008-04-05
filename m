From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git repository size vs. subversion repository size
Date: Fri, 4 Apr 2008 23:11:50 -0400
Message-ID: <20080405031150.GQ10274@spearce.org>
References: <1086fb5f0804041502s7ab12202y3b0ec3640425eff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sean Brown <seanmichaelbrown@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 05 05:12:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jhypb-0005hV-6C
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 05:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbYDEDLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 23:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbYDEDLy
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 23:11:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41802 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbYDEDLx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 23:11:53 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jhyod-0003W0-Lw; Fri, 04 Apr 2008 23:11:39 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6E43420FBAE; Fri,  4 Apr 2008 23:11:50 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1086fb5f0804041502s7ab12202y3b0ec3640425eff@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78833>

Sean Brown <seanmichaelbrown@gmail.com> wrote:
> 
> Here are the steps I took (locally):
> 
> mkdir git-samplesite-tmp
> cd git-samplesite-tmp
> git-svn init http://subversion.myco.com/my_sample_website --no-metadata
> git config svn.authorsfile ~/Desktop/users.txt   # mapped svn users to git users
> git-svn fetch
> git clone git-samplesite-tmp git-samplesite
> 
> I did this based on reading the documents in the git wiki, so I
> assumed they were "best practice."  Did I do something wrong?

The last command there didn't get you the most efficiently packed
repository possible.  More recent versions of git-clone will prefer
to hardlink all of the loose objects and packs from the source to
the destination, so the clone can occur more quickly when they are
on the same filesystem.

Really what you want to do here is repack the cloned directory
(cd git-samplesite && git repack -a -d -f) and maybe include
some aggressive --depth and --window options (e.g. 100/100)
if you have some CPU time to burn and are reasonably certain
you will be keeping the result.  You only have to spend that
CPU time once when converting from SVN, and all future clones
from this one will benefit.

But your really major disk usage was due to what someone else
pointed out, which was missing the "-s" flag to git-svn.  So the
Git working directory was huge, as we created working files for
every single branch and every single tag.  Ouch.

-- 
Shawn.
