From: Pete Wyckoff <pw@padd.com>
Subject: Re: refs/replace advice
Date: Fri, 29 Jul 2011 18:46:33 -0400
Message-ID: <20110729224633.GA21355@arf.padd.com>
References: <20110729153122.GA4535@padd.com>
 <4E32D6A1.8020304@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Jul 30 00:46:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmvpJ-0000bb-UJ
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 00:46:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196Ab1G2Wqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 18:46:38 -0400
Received: from honk.padd.com ([74.3.171.149]:40359 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753191Ab1G2Wqh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 18:46:37 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id C850519D;
	Fri, 29 Jul 2011 15:46:36 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 2667431493; Fri, 29 Jul 2011 18:46:33 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4E32D6A1.8020304@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178171>

j.sixt@viscovery.net wrote on Fri, 29 Jul 2011 17:49 +0200:
> Am 7/29/2011 17:31, schrieb Pete Wyckoff:
> > I'm trying to use "git replace" to avoid cloning the entire set
> > of duplicate commits across a slow inter-site link.  Like this:
> > 
> >     ...---A----B----C   site1/top
> >                      \
> >                       D---E---F  site1/proj
> > 
> >     ...---A'---B'---C'  site2/top
> > 
> > It is true that "git diff C C'" is empty:  they are identical.
> ...
> > I thought maybe I could "git fetch --depth=N" where N would cover
> > the range A'..site2/top, then replace.  But testing with "git
> > fetch --depth=3" still wants to fetch 100k objects.
> 
> On site2, don't you want to 'git fetch --depth=N site1' such that F down
> to at least C (but not much more) is fetched, and then apply the graft or
> replacement on site2?

Yes, that makes sense, shallow clone needs to pull the entire tree.

On site1 (bare .git repo):

    $ du -sm .
    542     .
    $ git merge-base site1/proj site1/top
    ff016f956ccae7878a1b322ba950a0088c6e2ded  ;# this is A
    $ git rev-list ff016f956ccae7878a1b322ba950a0088c6e2ded | wc
	566     566   23206

On site2:

    $ du -sm .git
    649     .git
    $ git rev-parse :/1384557
    0f95d91c37bc870d610b7bd45b316ab219750d31  ;# this is A'
    $ git rev-list 0f95d91c37bc870d610b7bd45b316ab219750d31 | wc
	566     566   23206

Same number of commits all the way back to the beginning of time,
but the timestamp in the root commit is different, so all the SHA1s
are different.

On site2:

    $ time git fetch git://site1/repo
    warning: no common commits
    remote: Counting objects: 124166, done.
    remote: Compressing objects: 100% (64472/64472), done.
    remote: Total 124166 (delta 59815), reused 121350 (delta 57062)
    Receiving objects: 100% (124166/124166), 462.31 MiB | 5.31 MiB/s, done.
    Resolving deltas: 100% (59815/59815), done.
    From git://site1/repo
     * branch            HEAD       -> FETCH_HEAD
    0m56.25s user 0m5.18s sys 2m29.45s elapsed 41.11 %CPU

A brand new repo on site2, cloning this time with a teensy depth:

    $ time git fetch --depth=3 git://site1/repo
    warning: no common commits
    remote: Counting objects: 96440, done.
    remote: Compressing objects: 100% (58844/58844), done.
    remote: Total 96440 (delta 36454), reused 92650 (delta 35169)
    Receiving objects: 100% (96440/96440), 415.87 MiB | 7.38 MiB/s, done.
    Resolving deltas: 100% (36454/36454), done.
    From git://site1/repo
     * branch            HEAD       -> FETCH_HEAD
    0m40.40s user 0m5.27s sys 1m50.29s elapsed 41.41 %CPU

No savings in data transport.

Was hoping it would be possible to get just the changes, but walking
back to FETCH_HEAD~3 shows that it imports all the files.  That makes
sense given the use case for shallow clone.  But I want to tell the
fetch machinery that I already have one of the commits it is going to
see.

I'll just tell people to put up with the full copy, and try to fix
things so that only one site creates the git repo from p4 in the future.
Thanks for looking,

		-- Pete
