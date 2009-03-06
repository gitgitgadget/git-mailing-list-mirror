From: Josef Wolf <jw@raven.inka.de>
Subject: Re: git-svn and repository hierarchy?
Date: Fri, 6 Mar 2009 17:10:26 +0100
Message-ID: <20090306161026.GA14554@raven.wolf.lan>
References: <20090227220512.GC14187@raven.wolf.lan> <49A97B7A.8010005@drmicha.warpmail.net> <20090303185108.GA11278@raven.wolf.lan> <eaa105840903031135o4cf72ed0oe3fffed69cb7ce03@mail.gmail.com> <20090303223600.GB11278@raven.wolf.lan> <eaa105840903031618s5e0b6f24j64aade8d752fb11@mail.gmail.com> <20090304192752.GC11278@raven.wolf.lan> <eaa105840903041406k36088763w5a70fe1d7458dfb1@mail.gmail.com> <20090305180529.GD11278@raven.wolf.lan> <eaa105840903051148s3515e8b7x9d7b8f9be12da735@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 17:15:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfchm-0007z6-H0
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 17:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590AbZCFQNy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2009 11:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753162AbZCFQNy
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 11:13:54 -0500
Received: from quechua.inka.de ([193.197.184.2]:60117 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965AbZCFQNy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 11:13:54 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1LfcgJ-0001K5-6G; Fri, 06 Mar 2009 17:13:51 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 79AA62CBAD; Fri,  6 Mar 2009 17:10:26 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <eaa105840903051148s3515e8b7x9d7b8f9be12da735@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112459>

On Thu, Mar 05, 2009 at 02:48:14PM -0500, Peter Harris wrote:
> On Thu, Mar 5, 2009 at 1:05 PM, Josef Wolf wrote:
> >
> > Well, actually it allows the changes for a very limited user group =
(that
> > is: only me 8-). =A0While I agree that author/date should not be ch=
anged,
> > I like to be able to fix silly typos in the log. =A0After all, we a=
ll do
> > typos now and then ;-)
>=20
> True, but in my experience it happens considerably less often with
> git. I find and fix most of my typos when reviewing my change-set
> before doing a "git push" or "git svn dcommit".

So you are rewriting yourself but not accept rewrites by svn ;-)

> > Maybe there's room for more improvement: =A0Since the merge is done=
 on a
> > scratch branch anyway, why not letting the clones _push_ into branc=
hes
> > with random names: cloneX-`uuidgen` or something. =A0So the clones =
could
> > do the push whenever they have net access. =A0The actual merge can =
be done
> > completely decoupled from the push operation.
>=20
> Indeed. Or even not-so-random names, such as cloneX/topic-name if you
> prefer.

That would have the risk of multiple clones pushing to the same branch.
I am not sure I am prepared to resolve such conflicts (yet).  But you
are right, the branch name should contain the topic-name.  So here's my
current favorite of the workflow:


     # work on clone
     #
     (
       cd clone$clone

       # first move commits from subversion to clone
       #
       git checkout master
       git pull --rebase

       # do some work
       #
       git checkout -b topic-branch
       for commit in 1 2 3; do
         echo change $clone $commit >>test
         git commit -a -m "commit $clone $commit"
       done

       # push the work
       #
       git push ../git-svn-repos topic-branch:clone-topic-branch-`uuidg=
en`
       git checkout master
       git branch -D topic-branch
     )



     # Integrate commits from clones an move them to subversion
     #
     (
       cd git-svn-repos
       for scratch in `git branch | grep ' clone-'` ; do

         # merge client's work
         #
         git checkout $scratch
         git svn rebase trunk

         # resolve possible conflicts
         #
         grep change test >test.resolved
         if diff test test.resolved ; then
             rm test.resolved
         else
             mv test.resolved test
             git add test
             git commit -m "merge"
             git rebase --skip
         fi

         # sync with svn repository
         #
         git svn dcommit
         git checkout master
         git svn rebase -l     # fast-forward master to where scratch i=
s

         # clean up
         #
         git branch -d $scratch
       done
      )



Does that look sane?

The benefit is that work on clones and work on git-svn-repos is
decoupled.
