From: Josef Wolf <jw@raven.inka.de>
Subject: Re: git-svn and repository hierarchy?
Date: Tue, 3 Mar 2009 23:36:00 +0100
Message-ID: <20090303223600.GB11278@raven.wolf.lan>
References: <20090224223412.GA4573@raven.wolf.lan> <49A50EB2.80300@drmicha.warpmail.net> <20090227171248.GB14187@raven.wolf.lan> <49A826C8.1060300@drmicha.warpmail.net> <20090227220512.GC14187@raven.wolf.lan> <49A97B7A.8010005@drmicha.warpmail.net> <20090303185108.GA11278@raven.wolf.lan> <eaa105840903031135o4cf72ed0oe3fffed69cb7ce03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 23:42:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LedJV-00068h-9D
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 23:42:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759572AbZCCWkf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 17:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759529AbZCCWke
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 17:40:34 -0500
Received: from quechua.inka.de ([193.197.184.2]:46774 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759442AbZCCWkd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 17:40:33 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1LedHp-0005yj-VE; Tue, 03 Mar 2009 23:40:29 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id EE9232C91A; Tue,  3 Mar 2009 23:36:00 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <eaa105840903031135o4cf72ed0oe3fffed69cb7ce03@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112172>

Thanks for your answer, Peter!

On Tue, Mar 03, 2009 at 02:35:28PM -0500, Peter Harris wrote:
> On Tue, Mar 3, 2009 at 1:51 PM, Josef Wolf wrote:
> > =A0# work on clones, pull work into git-svn-repos when we're done
> > =A0#
> > =A0for clone in 1 2 3; do
> > =A0 =A0(
> > =A0 =A0 =A0cd clone$clone
> > =A0 =A0 =A0git pull --rebase
> > =A0 =A0 =A0for commit in 1 2 3; do
> > =A0 =A0 =A0 =A0echo change $clone $commit >>test
> > =A0 =A0 =A0 =A0git commit -a -m "commit $clone $commit"
> > =A0 =A0 =A0done
> > =A0 =A0)
> > =A0 =A0(cd git-svn-repos; git pull --rebase ../clone$clone)
> > =A0done
>=20
> Um. This has each clone basing their commits on the work of some othe=
r
> clone. This line, specifically:
>=20
> >    (cd git-svn-repos; git pull --rebase ../clone$clone)
>=20
> breaks the "git-svn-repos only ever pulls from subversion" model I
> suggested elsewhere.

I'd rather not let every clone talk to subversion for several reasons.
One of them is that it is very inconvenient (e.g. the password has to
be entered several times for every commit).  After all, the whole point
for having git-svn-repos is for the clone to avoid working directly
against the subversion repos.  If every clone works against subversion
anyway, I can get rid of git-svn-repos as well.

> Also, this line says "rebase my changes onto those of ../clone$clone"=
,
> which isn't what you want. It will end up rebasing svn commits that
> the client didn't have on top of the client's commits, and will break
> git-svn's index. Don't use --rebase here.

Hmm, I must have misunderstood Michael, then.  Wasn't he suggesting
to rebase here?  Here's the citation:

|>   (cd git-svn-repos; git pull ../clone1)  # if this line is executed=
,
|
|That's the problem. This creates a merge after which you 1-2-3-4 and
|1-2'-3'-4' plus the merge of 4 and 4'.
|
|Instead, use git pull --rebase here. You don't want merges in the bran=
ch
|from which you dcommit.

> > =A0# Although we have resolved the conflict, spurious conflicts are
> > =A0# propagated to the clones
>=20
> ...and this is because you had clones all merge from each other (via
> git-svn-repos) *before* the changes were in svn.

Does that mean that the conflicts would disappear if I do
git-svn-rebase + git-svn-dcommit after every pull from a clone?

> Worse, since the git clients don't know that their work has been
> rebased, they can wind up conflicting with themselves too. Which is
> why I suggested "git svn dcommit" from each client, not from the
> central repository.
>=20
> This can be made work if you do something more like (untested):
>     (cd git-svn-repos; git pull ../clone$clone topic-branch;
>     git svn dcommit)
>     (cd clone$clone; git checkout master; git pull;
>     have a human verify that changes to master are correct;
>     git branch -D topic-branch)
>=20
> instead of
>=20
> >    (cd git-svn-repos; git pull --rebase ../clone$clone)
>=20
> ie. throw away each topic branch as you push it to git-svn-repos, and
> take the changes that have gone through git-svn back via a pull of
> master.
>=20
> But that starts to look to me like more work for each clone than "git
> svn dcommit" - YMMV, of course.

It might be more work.  But at least, I have the impression that I
understand this workflow. ;-)
