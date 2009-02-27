From: Josef Wolf <jw@raven.inka.de>
Subject: Re: git-svn and repository hierarchy?
Date: Fri, 27 Feb 2009 18:12:48 +0100
Message-ID: <20090227171248.GB14187@raven.wolf.lan>
References: <20090224223412.GA4573@raven.wolf.lan> <49A50EB2.80300@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 27 18:22:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld6PW-0004a2-6u
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 18:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754936AbZB0RUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 12:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755134AbZB0RUT
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 12:20:19 -0500
Received: from quechua.inka.de ([193.197.184.2]:39732 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751916AbZB0RUR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 12:20:17 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1Ld6Ni-0002uA-7Z; Fri, 27 Feb 2009 18:20:14 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 977912C909; Fri, 27 Feb 2009 18:12:48 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <49A50EB2.80300@drmicha.warpmail.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111684>

On Wed, Feb 25, 2009 at 10:26:10AM +0100, Michael J Gruber wrote:
> Josef Wolf venit, vidit, dixit 24.02.2009 23:34:

> > I have set up a repository hierarchy like this:
> > 
> > 
> >          subversion-repos
> >                 |
> >            git-svn-repos
> >           /     |     \
> >       clone1  clone2  clone3
>
> Recent enough git should even warn you against doing that, "that" being
> pushing into checked out branches.

I've now tried to synchronize via pull instead of push, but I still
get conflicts.

> Your diagram above is missing important info, namely which branches you
> are pushing into. But the problem indicates that you are pushing into a
> checked out branch.

In order to get a better understanding what's going on, I've written a
small script which can be copy-pasted into some terminal window:

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
  svn ci -m "commit 1" subversion-wc

  # create git-svn-repos
  #
  git svn init --stdlayout $SUBVERSION_REPOS git-svn-repos
  (cd git-svn-repos; git svn fetch)

  # create a clone and do some work on it
  #
  git clone git-svn-repos clone1
  for i in 2 3 4; do
    ( cd clone1; echo change$i >>test ; git commit -a -m "commit $i")
  done

  (cd git-svn-repos; git pull ../clone1)
  (cd git-svn-repos; git svn rebase)
  (cd git-svn-repos; git svn dcommit)
  (cd git-svn-repos; git pull ../clone1)  # if this line is executed,
  (cd git-svn-repos; git svn rebase)      # this command gives the conflict
)

When I comment out the second "git pull ../clone1", the conflict does
not happen on the last "git svn rebase", but on some later pull, rebase
or dcommit command.

Obviously, I'm doing something wrong.  But I can't figure what.  Any hints?
