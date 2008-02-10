From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [Feature Request] Better Subversion integration
Date: Sun, 10 Feb 2008 04:56:11 +0100
Message-ID: <20080210035611.GA2454@atjola.homenet>
References: <FC5B6F22-27A9-4F0F-85EE-0B72B94C69E2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users List <git@vger.kernel.org>
To: Sam Granieri Jr <sjgdev@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 04:56:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO3JE-0007dE-Dn
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 04:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755772AbYBJD4P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Feb 2008 22:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755774AbYBJD4P
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 22:56:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:37414 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755770AbYBJD4O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 22:56:14 -0500
Received: (qmail invoked by alias); 10 Feb 2008 03:56:13 -0000
Received: from i577B9D6C.versanet.de (EHLO atjola.local) [87.123.157.108]
  by mail.gmx.net (mp031) with SMTP; 10 Feb 2008 04:56:13 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/UrPQxIMnUgOaAh7bmSPUkGuFOhR/tUayN5N8QKq
	T+g68ylfegr1CB
Content-Disposition: inline
In-Reply-To: <FC5B6F22-27A9-4F0F-85EE-0B72B94C69E2@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73305>

On 2008.02.09 20:44:59 -0600, Sam Granieri Jr wrote:
> Right now, git-svn import (or clone) will convert tags and branches a=
s =20
> remote branches.
> I would like it if git could pick up subversion tags and translate th=
em=20
> as git tags upon importing

SVN tags aren't like git tags. A "tag" in SVN is just another directory=
,
which you can modify at will. Yeah, I know, you _should_ not commit any
changes to SVN "tags", but shit happens. And once you modify the "tag"
in SVN, you would have to invalidate the git tag, and finding a commit
that matches the SVN state of things is probably way too expensive to b=
e
practical. Maybe some --we-never-mess-up-svn-tag-alike-branches could
be added to allow git-svn to create teal git tags though? Dunno, I don'=
t
care much. Shouldn't be too hard to find some shell magic to create
tags, if one wants them.

> I also have some concerns with git-svn dcommit
>
> Would it be possible for git-svn dcommit to convert locally created g=
it=20
> tags to subversion tags? How about branches?

Didn't need to convert tags yet, but I have a small shell script that
does branching for me (see below). What it does, is to simply look at
the history and figure out the first commit that exists in SVN. Then it
invokes the svn program and creates a branch in SVN, starting at that
commit. Then you can just fetch that branch, rebase your work and commi=
t
away. Writing a similar hack for tags shouldn't be too hard.

=46or example (assuming that you saved the script as git-svn-branch):
git checkout -b my_branch remotes/trunk
// work work work
=2EoO( Hm, maybe I should put that into a SVN branch for foobar reason =
)
git-svn-branch my_branch
git svn fetch
git rebase --onto remotes/my_branch remotes/trunk my_branch
git svn dcommit -n # This should now (pretend to) dcommit to my_branch

One thing it gets wrong (probably, never tried) is that it will take th=
e
wrong starting point when you cherry-picked a commit from another SVN
branch and didn't remove the git-svn-id line. That is because it doesn'=
t
make use of the .rev_map files and thus cannot figure out if the
git-svn-id line is actually valid.

IIRC git-svn should handle such cherry-picks gracefully, so
integrating that thing with git-svn would have some benefits, but I
don't speak any perl. Maybe someone else wants to take the job?

HTH
Bj=F6rn


#!/bin/sh
if test "$1" =3D ''
then
	echo "Usage: git-svn-branch <branch_name>"
	exit 127
fi

CURRENT=3D$(git rev-list --first-parent --pretty=3Dformat:%b HEAD | gre=
p -m1 -o 'git-svn-id: [^ ]*' | sed -e 's/git-svn-id: //')

SRC=3D${CURRENT%@*}
REV=3D${CURRENT#*@}
URL=3D$(git config --get svn-remote.svn.url)

URL=3D$(echo -n "$URL" | sed -e 's!//.*@!//!')
DST=3D"$URL/$(git config --get svn-remote.svn.branches | grep -o '^[^:]=
*' | sed -e "s/\*/$1/")"

svn cp -r "$REV" "$SRC" "$DST" -m "Create branch $1"
