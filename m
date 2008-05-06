From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Excruciatingly slow git-svn imports
Date: Mon, 5 May 2008 21:25:08 -0700
Message-ID: <20080506042508.GA23465@untitled>
References: <CC0F600D-71F3-493A-AA9C-AF901C1A58C4@adacore.com> <2C39C19D-0B81-4879-92DC-C0436DB6E84E@midwinter.com> <20080429071122.GG24171@muzzle> <2B9E6C04-69F1-42BD-AE60-AFCE401E093E@adacore.com> <20080506032846.GA15521@untitled> <32541b130805052056g450b69cfg46693bc3c0c5a1ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geert Bosch <bosch@adacore.com>,
	Steven Grimm <koreth@midwinter.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 06:26:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtEke-0004ua-Vi
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 06:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbYEFEZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 00:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbYEFEZN
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 00:25:13 -0400
Received: from hand.yhbt.net ([66.150.188.102]:43123 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833AbYEFEZK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 00:25:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id A08B32DC08B;
	Mon,  5 May 2008 21:25:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <32541b130805052056g450b69cfg46693bc3c0c5a1ed@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81327>

Avery Pennarun <apenwarr@gmail.com> wrote:
> On 5/5/08, Eric Wong <normalperson@yhbt.net> wrote:
> > Interesting.  By  "These commits seemed all to have thousands of files",
> >  you mean the first 35K that took up most of the time?  If so, yes,
> >  that's definitely a problem...
> >
> >  git-svn requests a log from SVN containing a list of all paths modified
> >  in each revision.  By default, git-svn only requests log entries for up
> >  to 100 revisions at a time to reduce memory usage.  However, having
> >  thousands of files modified for each revision would still be
> >  problematic, as would having insanely long commit messages.
> 
> On my system, any branch that was created using "svn cp" of a toplevel
> directory seems to cause git-svn to (rather slowly) download every
> single file in the entire branch for the first commit on that branch,
> giving a symptom that sounds a lot like the above "commits with
> thousands of files".  I assumed this was just an intentional design
> decision in git-svn, to be slow and safe instead of fast and loose.
> Is it actually supposed to do something smarter than that?

When using "svn cp" on a top-level directory, it *should*
just show up as a single file change in the log entry.
Something like:

  A /project/branch/my-new-branch (from /project/trunk:1234)

This would not take much memory at all.
However, I've also occasionally seen stuff like this:

  A /project/branch/my-new-branch
  A /project/branch/my-new-branch/file1 (from /project/trunk/file1:1234)
  A /project/branch/my-new-branch/file2 (from /project/trunk/file2:1234)
  A /project/branch/my-new-branch/file3 (from /project/trunk/file3:1234)
  .... many more files and directories along the same lines ...

This is what I suspect Geert is seeing in his repository and causing
problems.  Perhaps something caused by cvs2svn importing those tags into
SVN originally?


But the symptom you're seeing with git-svn downloading every file seems
to be the result of using a pre-1.4.3 version of the Perl SVN bindings
which lacked a working do_switch() function.  I fallback to using
do_update() and checking out a new tree for SVN 1.4.2 and before.
So yes, I'm definitely safe, slow and _lazy_ by falling back to
do_update() instead of doing something fancy to workaround something
that's already fixed in SVN :)

-- 
Eric Wong
