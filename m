From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 14:00:37 -0400
Message-ID: <20080911180037.GH5082@mit.edu>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org> <20080911062242.GA23070@cuci.nl> <200809111020.55115.jnareb@gmail.com> <20080911123148.GA2056@cuci.nl> <20080911135146.GE5082@mit.edu> <20080911153202.GD2056@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Sep 11 20:02:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdqUf-0001tm-O6
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 20:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835AbYIKSBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 14:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752724AbYIKSBF
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 14:01:05 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:57290 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752722AbYIKSBE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Sep 2008 14:01:04 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8BI0evi024340;
	Thu, 11 Sep 2008 14:00:40 -0400 (EDT)
Received: from closure.thunk.org (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8BI0cav009214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 11 Sep 2008 14:00:39 -0400 (EDT)
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KdqT8-0001eR-0S; Thu, 11 Sep 2008 14:00:38 -0400
Content-Disposition: inline
In-Reply-To: <20080911153202.GD2056@cuci.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95626>

On Thu, Sep 11, 2008 at 05:32:02PM +0200, Stephen R. van den Berg wrote:
> gc will preserve the commits the origin links point to once they are
> reachable.  I.e. if the developer doesn't care about the commits the
> origin links point to (i.e. if the branches are not reachable) then gc
> just skips them, if the developer *does* care, the origin links are used
> to keep those objects alive (and, of course, all their parenthood).

This seems wrong.  OK, suppose you have branches A, B, C, and D, while
you are on branch C, you cherry pick commit 'p' from branch B, so that
there is a new commit q on branch C which has an origin link
containing the commit ID's p^ and 'p.    

Now suppose branch B gets deleted, and you do a "git gc".  All of the
commits that were part of branch B will vanish except for p^ and p,
which in your model will stick around because they are origin links
commit q on branch C.  But what good is are these two commits?  They
represent two snapshots in time, with no context now that branch B has
been deleted.  99% of the time, the diff between p^ and p will result
in the equivalent of the diff between q^ and q.  But even if they
aren't, what use are these isolated, disconnected commits?  So having
"git gc" retain them commits that are pointed to be this proposed
origin link doesn't seem to make any sense, and doesn't seem to be
well thought through.

Oh, BTW, suppose you then further do a "git cherry-pick -o" of commit
q while you are on branch D.  Presumably this will create a new
commit, r.  But will the origin-link of commit r be p^ and p, or q^
and q?  And will this change depending on whether or not -o is
specified?

> >I'll also note that having a ***local*** database to cache the origin
> >link is a great way of short-circuiting the performance difficulties.
> >If it works, then it will be a lot easier to convince people that
> >perhaps it should be done git-core, and by modifying core git functions.
> 
> Creating local databases for these kinds of structures feels kludgy
> somehow, since the git hash objects essentially *are* a working
> database.  I have not checked yet if git already has some kind of
> ready-to-use local database lib inside which I could reuse for that.

Gitk already keeps a cache (.git/gitk.cache) to speed up some of its
operations.  And in some ways the index file is a cache, although it
does far more than that.

     	      	       	 		    - Ted
