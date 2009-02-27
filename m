From: Josef Wolf <jw@raven.inka.de>
Subject: Re: git-svn and repository hierarchy?
Date: Fri, 27 Feb 2009 23:05:12 +0100
Message-ID: <20090227220512.GC14187@raven.wolf.lan>
References: <20090224223412.GA4573@raven.wolf.lan> <49A50EB2.80300@drmicha.warpmail.net> <20090227171248.GB14187@raven.wolf.lan> <49A826C8.1060300@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 27 23:12:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdAvv-0002VV-US
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 23:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756712AbZB0WKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 17:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760960AbZB0WKS
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 17:10:18 -0500
Received: from quechua.inka.de ([193.197.184.2]:39650 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761053AbZB0WKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 17:10:16 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1LdAuL-0001e8-9f; Fri, 27 Feb 2009 23:10:13 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 72DEA2C913; Fri, 27 Feb 2009 23:05:12 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <49A826C8.1060300@drmicha.warpmail.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111721>

Thanks for your patience, Michael!

On Fri, Feb 27, 2009 at 06:45:44PM +0100, Michael J Gruber wrote:
> Josef Wolf venit, vidit, dixit 27.02.2009 18:12:
> > On Wed, Feb 25, 2009 at 10:26:10AM +0100, Michael J Gruber wrote:
> >> Josef Wolf venit, vidit, dixit 24.02.2009 23:34:

[ ... ]
> >   (cd git-svn-repos; git pull ../clone1)
> 
> Gives you 1-2-3-4
> 
> >   (cd git-svn-repos; git svn rebase)
> 
> Does nothing here (but is good practice)
> 
> >   (cd git-svn-repos; git svn dcommit)
> 
> Creates 2-3-4 on the svn side. *Then rebases* your master, which creates
> 1-2'-3'-4' on master. Note that 2 is different from 2' (git-svn id).

So the sha1 is not preserved when it goes through svn?

> >   (cd git-svn-repos; git pull ../clone1)  # if this line is executed,
> 
> That's the problem. This creates a merge after which you 1-2-3-4 and
> 1-2'-3'-4' plus the merge of 4 and 4'.

--verbosity=on please ;-)

> Instead, use git pull --rebase here. You don't want merges in the branch
> from which you dcommit.

Yeah, "pull --rebase" seems to help a lot.  So I've come up with the next
version of my workflow-test-script:

(
  set -ex

  # create test directory
  #
  TESTDIR=`mktemp --tmpdir=. git-svn-hierarchy-test-XXXXXXXX`
  rm -rf $TESTDIR
  mkdir -p $TESTDIR
  cd $TESTDIR

  SUBVERSION_REPOS=file://`pwd`/subversion-repos

  # create subversion repos with some history
  #
  svnadmin create subversion-repos
  svn -m "create standard layout" mkdir \
      $SUBVERSION_REPOS/trunk \
      $SUBVERSION_REPOS/branches \
      $SUBVERSION_REPOS/tags
  svn co $SUBVERSION_REPOS/trunk subversion-wc
  echo change1 >>subversion-wc/test
  svn add subversion-wc/test
  svn ci -m "commit 0" subversion-wc

  # create git-svn-repos
  #
  git svn init --stdlayout $SUBVERSION_REPOS git-svn-repos
  (cd git-svn-repos; git svn fetch)

  # create clones
  #
  git clone git-svn-repos clone1
  git clone git-svn-repos clone2
  git clone git-svn-repos clone3

  # now go several times to every clone, do some work on it, and sync
  # the results
  #
  for cycle in 1 2 3; do
    for clone in 1 2 3; do
      for commit in 1 2 3; do
        (
          cd clone$clone
          git pull --rebase
          echo change $clone $commit >>test
          git commit -a -m "commit $clone $commit"
        )
      done
      (cd git-svn-repos; git pull --rebase ../clone$clone)
      (cd git-svn-repos; git svn rebase)
      (cd git-svn-repos; git svn dcommit)
    done
  done
)

At least, this seems to not creating collisions any more.  But I'm still
not sure I fully understand what's going on here.  Guess, I'll have to
get into the learning-by-doing mode :)

> Borrowing from some other vcs:
> 
> Repeat the soothing mantra: a merge is no merge is no merge - it it's in
> svn ;)

Huh?

> > Obviously, I'm doing something wrong.  But I can't figure what.  Any hints?
> 
> I guess when we said integrated we should have said rebase. Haven't we?

You like to talk in riddles? Aren't you?

Thanks a lot.
