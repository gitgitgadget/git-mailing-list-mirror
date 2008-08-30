From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 0/2] 'git svn info' fixes
Date: Fri, 29 Aug 2008 18:03:19 -0700
Message-ID: <20080830010319.GA2940@untitled>
References: <20080829081654.GA6680@yp-box.dyndns.org> <1220017369-32637-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Aug 30 03:15:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZF3a-0002dw-Nx
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 03:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbYH3BDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 21:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752765AbYH3BDW
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 21:03:22 -0400
Received: from hand.yhbt.net ([66.150.188.102]:60217 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752673AbYH3BDV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 21:03:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id A65562DC01B;
	Fri, 29 Aug 2008 18:03:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1220017369-32637-1-git-send-email-trast@student.ethz.ch>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94353>

Thomas Rast <trast@student.ethz.ch> wrote:
> Eric Wong wrote.
> > > So should we just change all "unknown foo" tests to verify that 'git
> > > svn info' errors out too?
> >
> > Yes, I see no reason to differ from plain svn here.
> 
> This starts getting more complicated at every turn.  The included
> mini-series (probably textually depends on the other 6 patches though)
> "fixes" this.
> 
> HOWEVER: Subversion itself broke compatibility here.  In 1.4:
> 
>   $ svn info new; echo $?
>   new:  (Not a versioned resource)
> 
>   0
> 
> Note the extra linebreak and successful exit.  Current git-svn
> precisely matches this output.  In 1.5, it's different:
> 
>   $ svn info new; echo $?
>   svn: 'new' is not under version control
>   1
> 
> While it is of course up to you what you would like to do (and modulo
> test_must_fail, 2/2 can still be used to fix the tests if you decide
> to reject 1/2), I suggest changing to 1.5 behaviour.  exit(1) is the
> sane thing to do in this case, and that is already breaking
> bit-for-bit compatibility with SVN 1.4, so we might as well adopt the
> new error message.  Of course this prevents us from comparing the
> output literally in the tests, so I settled for a slightly weaker
> check: failure status and mention of the filename.

Yes.  Please maintain compatibility with svn 1.5.  The current version
of git-svn should strive to maintain compatibility with the current
version of svn whenever possible.

> Unfortunately this does raise the question whether the URL-encoding
> issue treated in the other series is in fact a similar incompatibility
> between 1.4 and 1.5, not a (minor but long-standing) bug in git-svn.

It should match svn 1.5 for "git svn info".

Since "git svn info --url" is a git-svn-only thing, whatever makes the
most sense from a command-line scripting perspective (I don't have time
to check against a real repo right now):

For git-svn info --url, just want things like:

	svn log -v `git svn info --url`

	svn cp `git svn info --url` \
               `git svn info --url | sed -e 's,/trunk,/tags/1.0,'`

	svn rm `git svn info --url`

to just work.

I seem to recall the rules being slightly different for http(s):// and
(file://|svn://) URLs with the command-line client; but my memory may
just be fuzzy...

Thanks for looking into this!

-- 
Eric Wong
