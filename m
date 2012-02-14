From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4 useclientspec broken?
Date: Tue, 14 Feb 2012 07:36:32 -0500
Message-ID: <20120214123632.GA5285@padd.com>
References: <4F39AF04.5080607@promptu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Laurent =?iso-8859-1?Q?Charri=E8re?= <lcharriere@promptu.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 13:36:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxHcg-0005Gs-6u
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 13:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756213Ab2BNMgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 07:36:37 -0500
Received: from honk.padd.com ([74.3.171.149]:47477 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755369Ab2BNMgg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 07:36:36 -0500
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id 4F85FE8B;
	Tue, 14 Feb 2012 04:36:35 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id C8B3B313C6; Tue, 14 Feb 2012 07:36:32 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4F39AF04.5080607@promptu.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190720>

lcharriere@promptu.com wrote on Mon, 13 Feb 2012 16:47 -0800:
> Since I've upgraded to 1.7.9 (on OS X Lion, FWIW), git-p4 submit
> fails to apply any patches if I use useclientspec=true when cloning.
> 
> My p4 client is as follows:
> 
> Client:	malibu
> (...)
> Root:	/Users/lcharriere/Documents/Perforce/all
> (...)
> View:
> 	//sandbox/... //malibu/sandbox/...
> 	//depot/... //malibu/depot/...
> 
> Sequence of steps to reproduce:
> 
> $ git p4 clone //sandbox/lcharriere/foo --use-client-spec
> $ cd foo && find .
> ./.git
> (...)
> ./sandbox/lcharriere/foo/.gitignore
> ./sandbox/lcharriere/foo/foo.py
> 
> -- This is new behavior to me, BTW. Previously, I would have seen
> ./.git
> (...)
> ./.gitignore
> ./foo.py

I did try to clean up our handling of --use-client-spec.  This
behavior was done on purpose, but maybe I didn't the implications
on people who were relying on the old way.  In particular the
behavior of multi-line view specs and those with + and - was
largely unpredictable.

The client spec now has absolute control over what files get put
where in the git repo, just like in p4.  The argument
"//sandbox/lcharriere/foo" in your clone command limits the scope
of what is checked out, but does not affect where it is placed.

You can get the git layout you expect with this view:

    //sandbox/lcharriere/foo/... //malibu/...

or simply just don't use --use-client-spec at all:

    git p4 clone //sandbox/lcharriere/foo

Is this new behavior bad for you?  Suggestions welcome.

> $ cat "test" >> sandbox/lcharriere/foo/.gitignore
> $ git commit -a -m "test"
> git commit -a -m "test"
> [master 7398144] test
>  1 files changed, 1 insertions(+), 0 deletions(-)
> $ git p4 submit
> Perforce checkout for depot path //sandbox/lcharriere/foo/ located
> at /Users/lcharriere/Documents/Perforce/all/sandbox/lcharriere/foo/
> Synchronizing p4 checkout...
> ... - file(s) up-to-date.
> Applying 739814457a8faa84dc0bddd830f671569576b177 test
> 
> sandbox/lcharriere/foo/.gitignore - file(s) not on client.
> error: sandbox/lcharriere/foo/.gitignore: No such file or directory
> Unfortunately applying the change failed!
> What do you want to do?
> [s]kip this patch / [a]pply the patch forcibly and with .rej files /
> [w]rite the patch to a file (patch.txt)

This is definitely a bug.  I reproduced a similar problem.

> I tried to follow what's going on with pdb:
> * self.depotPath is //sandbox/lcharriere/foo, so git-p4 chdir's to
> /Users/lcharriere/Documents/Perforce/all/sandbox/lcharriere/foo/
> * In P4Submit.applyCommit, line 926 is:
> p4_edit(path)
> At this point path is 'sandbox/lcharriere/foo/.gitignore'

The path should be plain old ".gitignore", as you noticed.

> I'm guessing this is why the p4 executable doesn't find it. The path
> should be .gitignore. Is it possible that the new behavior I
> mentioned above of reproducing the depot hierarchy when
> useclientspec is true is having unintended side effects, or is a
> bug?

I'll get a patch out tonight or soon.  Need to do gobs of testing
on the submit path to make sure nothing else is broken.

		-- Pete
