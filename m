From: Josef Wolf <jw@raven.inka.de>
Subject: Re: git-svn and repository hierarchy?
Date: Tue, 3 Mar 2009 19:51:08 +0100
Message-ID: <20090303185108.GA11278@raven.wolf.lan>
References: <20090224223412.GA4573@raven.wolf.lan> <49A50EB2.80300@drmicha.warpmail.net> <20090227171248.GB14187@raven.wolf.lan> <49A826C8.1060300@drmicha.warpmail.net> <20090227220512.GC14187@raven.wolf.lan> <49A97B7A.8010005@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 20:02:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeZsE-0002bZ-BR
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 20:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755547AbZCCTAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 14:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755150AbZCCTAU
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 14:00:20 -0500
Received: from quechua.inka.de ([193.197.184.2]:53585 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754641AbZCCTAS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 14:00:18 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1LeZqi-00083N-04; Tue, 03 Mar 2009 20:00:16 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 9CE832C90A; Tue,  3 Mar 2009 19:51:08 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <49A97B7A.8010005@drmicha.warpmail.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112149>

On Sat, Feb 28, 2009 at 06:59:22PM +0100, Michael J Gruber wrote:
> Josef Wolf venit, vidit, dixit 27.02.2009 23:05:
> > On Fri, Feb 27, 2009 at 06:45:44PM +0100, Michael J Gruber wrote:
> >> Josef Wolf venit, vidit, dixit 27.02.2009 18:12:
> >>> On Wed, Feb 25, 2009 at 10:26:10AM +0100, Michael J Gruber wrote:
> >>>> Josef Wolf venit, vidit, dixit 24.02.2009 23:34:
> > 
> > [ ... ]
> >>>   (cd git-svn-repos; git pull ../clone1)
> >> Gives you 1-2-3-4
> >>
> >>>   (cd git-svn-repos; git svn rebase)
> >> Does nothing here (but is good practice)
> >>
> >>>   (cd git-svn-repos; git svn dcommit)
> >> Creates 2-3-4 on the svn side. *Then rebases* your master, which creates
> >> 1-2'-3'-4' on master. Note that 2 is different from 2' (git-svn id).
> > 
> > So the sha1 is not preserved when it goes through svn?
> 
> No. Once your commits come back from svn through git-svn they have an
> additional line in the commit. Also, the commit time time will be
> different, and the author name might be depending on your name remapping.

But what prevents this new commit from being thrown back to svn again,
and looping over and over again?

For some reason, I keep getting conflicts.  And the most annoying
part is that even if I resolve the conflict in git-svn-repos, it
gets propagated as a (spurious) conflict down to all the clones.
Here's the recipe:

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

  # create some clones
  #
  git clone git-svn-repos clone1
  git clone git-svn-repos clone2
  git clone git-svn-repos clone3

  # work on clones, pull work into git-svn-repos when we're done
  #
  for clone in 1 2 3; do
    (
      cd clone$clone
      git pull --rebase
      for commit in 1 2 3; do
        echo change $clone $commit >>test
        git commit -a -m "commit $clone $commit"
      done
    )
    (cd git-svn-repos; git pull --rebase ../clone$clone)
  done

  # commit from svn
  #
  ( cd subversion-wc; echo change s >>test; svn ci -m "commit s")

  # git-svn-rebase gives us a conflict
  #
  ( cd git-svn-repos; git svn rebase )

  # which we immediately resolve
  #
  (
    cd git-svn-repos
    (
      echo change1
      echo change s
      echo change 1 1
    ) >test
    git add test
    git rebase --continue
  )

  (cd git-svn-repos; git svn dcommit)

  # Although we have resolved the conflict, spurious conflicts are
  # propagated to the clones
  #
  for clone in 1 2 3; do
    ( cd clone$clone ; git pull --rebase)
  done
)
