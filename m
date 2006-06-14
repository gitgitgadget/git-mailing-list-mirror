From: Eric Wong <normalperson@yhbt.net>
Subject: Re: oprofile on svn import
Date: Tue, 13 Jun 2006 20:02:58 -0700
Message-ID: <20060614030258.GA23077@hand.yhbt.net>
References: <9e4733910606131810ya6aa585m5d2349f651b01492@mail.gmail.com> <20060614020108.GB12083@hand.yhbt.net> <9e4733910606131939h35b2278bvaa296459ea061621@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Matthias Urlichs <smurf@smurf.noris.de>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Jun 14 05:03:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqLey-0004kd-92
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 05:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbWFNDDA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 23:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWFNDC7
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 23:02:59 -0400
Received: from hand.yhbt.net ([66.150.188.102]:4554 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S964960AbWFNDC7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jun 2006 23:02:59 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 6FF867DC005; Tue, 13 Jun 2006 20:02:58 -0700 (PDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910606131939h35b2278bvaa296459ea061621@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21825>

Linus: I hope I'm right on [1] (the stuff about fork).

Jon Smirl <jonsmirl@gmail.com> wrote:
> On 6/13/06, Eric Wong <normalperson@yhbt.net> wrote:
> >Jon Smirl <jonsmirl@gmail.com> wrote:
> >> I'm going back to cvsimport tomorrow. My svn import that had been
> >> running for five days got killed this morning when the city decided to
> >> move the telephone pole that provides my electricty.
> >>
> >> Some oprofile data, this doesn't make a lot of sense to me. Why is it
> >> in libcypto so much?
> >
> >The sha1 calculation is done in libcrypto, afaik.
> 
> That make sense, but it's eating up 14% of my CPU in a long sample.
> 
> >Anybody want to see how my latest patches to git-svn (and using SVN perl
> >libraries) stacks up against the mozilla repo?  Speedwise, I don't
> >expect git-svn to be too different than git-svnimport, but it should use
> >much less memory (I'll probably port the hacks to git-svnimport, too).
> 
> Can svnimport be rewritten to avoid calling fork? If I am reading the
> oprofiles correctly that fork is very expensive especially when the
> svnimport task grows to 600MB.

I think the problem is the process growing to 600MB, and not the fork :)
git-svn avoids process growth pretty well from my tests with the gcc
repo.

See the fetch_lib() function in this patch on how I avoid process
growth by _using_ fork():

Subject: [PATCH 12/13] git-svn: add support for Perl SVN::* libraries
	(<115022175180-git-send-email-normalperson@yhbt.net>)

Perl processes (at least on my machines (5.8.x, Linux x86) don't like to
release memory back to the OS when they're done using it (although it
can reuse the memory within the process itself).  This is why SVN::Pool
isn't very effective in many cases.

fork() will only duplicate memory for the pages that are changed by the
child, not the entire process[1].  So I fork children that run temporarily
to avoid accumulating memory usage inside the process.

This technique should probably be added to git-svnimport as well.

> I have an import running but post your code when it is ready and I can
> try it on the next run. They always seem to fail so there will
> probably be another run.

I've posted a two series of patches the past few days that have yet
to be merged by Junio:

Subject: [PATCH] git-svn: bug fixes (some resends)
	<11500094252972-git-send-email-normalperson@yhbt.net>
Subject: [PATCH 0/13] git-svn: better branch support, SVN:: lib usage, feature additions
	<11502217352245-git-send-email-normalperson@yhbt.net>

-- 
Eric Wong
