From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Excruciatingly slow git-svn imports
Date: Mon, 5 May 2008 20:28:54 -0700
Message-ID: <20080506032846.GA15521@untitled>
References: <CC0F600D-71F3-493A-AA9C-AF901C1A58C4@adacore.com> <2C39C19D-0B81-4879-92DC-C0436DB6E84E@midwinter.com> <20080429071122.GG24171@muzzle> <2B9E6C04-69F1-42BD-AE60-AFCE401E093E@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Tue May 06 05:29:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtDsB-0007qx-UZ
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 05:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbYEFD25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 23:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752380AbYEFD25
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 23:28:57 -0400
Received: from hand.yhbt.net ([66.150.188.102]:43035 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751889AbYEFD24 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 23:28:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 8D6362DC08B;
	Mon,  5 May 2008 20:28:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2B9E6C04-69F1-42BD-AE60-AFCE401E093E@adacore.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81325>

Geert Bosch <bosch@adacore.com> wrote:
> On Apr 29, 2008, at 03:11, Eric Wong wrote:
> 
> >>I've found that git-svn gets slower as it runs. Try interrupting the
> >>clone and running "git svn fetch" -- it should pick up where it left
> >>off and will be MUCH faster if my experience is any indication.
> >>When I clone the big svn repository at work I usually restart it
> >>every 1000 revisions or so and it finishes in a fraction of the time
> >>it takes if I let it do everything in a single run.
> >
> >That's really strange to hear...  The git-svn process itself does not
> >store much state other than the current revision and the log
> >information for the next 100 or so revisions it needs to import.
> >
> >Are you packing the repository?  Which SVN protocol are you using?
> >Does memory usage of git-svn stay stable throughout the run?
> 
> I found the same. After about 5 days (with maybe 10 break/restarts), I
> had a converted repository with all 135K commits and a total size of
> just under 1 GB. The last 100K commits took (much?) less than a day,
> almost  all the time was spend in the earlier ones. These commits
> seemed all to have  thousands of files, even though most were probably
> the same. I'm sure this  repositor, which covers 15 years of
> development of a multi-million line project,  has a lot of tags and it
> seemed that it just had to chew through many copies of the complete
> set of files to find out that they're all the same.

Interesting.  By  "These commits seemed all to have thousands of files",
you mean the first 35K that took up most of the time?  If so, yes,
that's definitely a problem...

git-svn requests a log from SVN containing a list of all paths modified
in each revision.  By default, git-svn only requests log entries for up
to 100 revisions at a time to reduce memory usage.  However, having
thousands of files modified for each revision would still be
problematic, as would having insanely long commit messages.

Is this repository public by any chance?  I'd like to be able to take
a look at it in case I have time and have access to decent hardware.
Also, what command-line arguments did you use?

> It's great git-svn can be restarted so well and doesn't get confused
> by uncleanly terminated runs. My final repository is fast and small.
> I'm still struggling with how to properly synchronize branches, but
> that probably is mostly a matter of user education.
> 
> Thanks all for these great tools.

You're welcome, thanks for the feedback!  Restartability in git-svn
is one of the things I focused on from the beginning.

-- 
Eric Wong
