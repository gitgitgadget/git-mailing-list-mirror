From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4 out of memory for very large repository
Date: Thu, 29 Aug 2013 18:46:09 -0400
Message-ID: <20130829224609.GB25879@padd.com>
References: <20130823011245.GA7693@jerec>
 <52170C6A.4080708@diamand.org>
 <20130823114856.GA8182@jerec>
 <20130825155001.GA875@padd.com>
 <20130826134756.GA1335@jerec>
 <20130828154135.GA16921@jerec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: Corey Thompson <cmtptr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 00:46:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFAym-00023i-Un
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 00:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756161Ab3H2WqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 18:46:13 -0400
Received: from honk.padd.com ([74.3.171.149]:59184 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752585Ab3H2WqM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 18:46:12 -0400
Received: from arf.padd.com (unknown [50.105.10.190])
	by honk.padd.com (Postfix) with ESMTPSA id 5C3333052;
	Thu, 29 Aug 2013 15:46:11 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 8058922D03; Thu, 29 Aug 2013 18:46:09 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20130828154135.GA16921@jerec>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233379>

cmtptr@gmail.com wrote on Wed, 28 Aug 2013 11:41 -0400:
> On Mon, Aug 26, 2013 at 09:47:56AM -0400, Corey Thompson wrote:
> > You are correct that git-fast-import is killed by the OOM killer, but I
> > was unclear about which process was malloc()ing so much memory that the
> > OOM killer got invoked (as other completely unrelated processes usually
> > also get killed when this happens).
> > 
> > Unless there's one gigantic file in one change that gets removed by
> > another change, I don't think that's the problem; as I mentioned in
> > another email, the machine has 32GB physical memory and the largest
> > single file in the current head is only 118MB.  Even if there is a very
> > large transient file somewhere in the history, I seriously doubt it's
> > tens of gigabytes in size.
> > 
> > I have tried watching it with top before, but it takes several hours
> > before it dies.  I haven't been able to see any explosion of memory
> > usage, even within the final hour, but I've never caught it just before
> > it dies, either.  I suspect that whatever the issue is here, it happens
> > very quickly.
> > 
> > If I'm unable to get through this today using the incremental p4 sync
> > method you described, I'll try running a full-blown clone overnight with
> > top in batch mode writing to a log file to see whether it catches
> > anything.
> > 
> > Thanks again,
> > Corey
> 
> Unforunately I have not made much progress.  The incremental sync method
> fails with the output pasted below.  The change I specified is only one
> change number above where that repo was cloned...

I usually just do "git p4 sync @505859".  The error message below
crops up when things get confused.  Usually after a previous
error.  I tend to destroy the repo and try again.  Sorry I don't
can't explain better what's happening here.  It's not a memory
issue; it reports only 24 MB used.

> So I tried a 'git p4 rebase' overnight with top running, and as I feared
> I did not see anything out of the ordinary.  git, git-fast-import, and
> git-p4 all hovered under 1.5% MEM the entire time, right up until
> death.  The last entry in my log shows git-fast-import at 0.8%, with git
> and git-p4 at 0.0% and 0.1%, respectively.  I could try again with a
> more granular period, but I feel like this method is ultimately a goose
> chase.

Bizarre.  There is no good explanation why memory usage would go
up to 32 GB (?) within one top interval (3 sec ?).  My theory
about one gigantic object is debunked:  you have only the 118 MB
one.  Perhaps there's some container or process memory limit, as
Luke guessed, but it's not obvious here.

The other big hammer is "strace".  If you're still interested in
playing with this, you could do:

    strace -vf -tt -s 200 -o /tmp/strace.out git p4 clone ....

and hours later, see if something suggests itself toward the
end of that output file.

		-- Pete
