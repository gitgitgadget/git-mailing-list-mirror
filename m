From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Migrating a git repository to subversion
Date: Fri, 16 May 2008 01:47:31 +0200
Message-ID: <20080515234731.GA17897@atjola.homenet>
References: <42dc968d0805151608q2ed89fc8madcd8d341a4ed1df@mail.gmail.com> <32541b130805151619y7dcb3812i1440ebbb0def98ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alf Mikula <amikula@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 01:48:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwnBR-0001uM-Ds
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 01:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756024AbYEOXrf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 May 2008 19:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755460AbYEOXrf
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 19:47:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:60288 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753126AbYEOXre (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 19:47:34 -0400
Received: (qmail invoked by alias); 15 May 2008 23:47:32 -0000
Received: from i577AFC80.versanet.de (EHLO atjola.local) [87.122.252.128]
  by mail.gmx.net (mp043) with SMTP; 16 May 2008 01:47:32 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX190axEZg8d0+4zNp1TCAoikPlBXcm6ylW1ffIK8w+
	XQaxL6r5eW8c7O
Content-Disposition: inline
In-Reply-To: <32541b130805151619y7dcb3812i1440ebbb0def98ad@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82245>

On 2008.05.15 19:19:13 -0400, Avery Pennarun wrote:
> On 5/15/08, Alf Mikula <amikula@gmail.com> wrote:
> >  1. Create a new, empty subversion project with trunk/tags/branches=
 subdirs.
> >  2. git svn clone http://myhost.com/path/to/project --stdlayout
> >  3. git pull ../git_project
> >  4. git svn dcommit
> >
> >  This put all my files into Subversion, but under a single commit. =
[...]
>=20
> Step 3 created a "merge commit", which connected the (presumably, but
> not necessarily, empty) repository from step 2 to the other one in
> step 3.  git-svn doesn't know how to break apart a merge into its
> parts (mostly because it's theoretically impossible to do in the
> general case :)) so it just makes a single svn commit.
>=20
> The way people usually deal with this when using git-svn is they use
> "git rebase" to simplify their history and eliminate the need for
> merge commits.  This makes git-svn much happier, but unfortunately
> makes future git merging a bit more complicated.
>=20
> Anyway, to answer your question: add a new step 3.5 that's something =
like:
>=20
>   git rebase WHATEVER
>=20
> Where WHATEVER is the name of the last commit git-svn created in step=
 2.

In this case, "git svn rebase" handles figuring out what WHATEVER shoul=
d
be. That said, I'd suggest something different/bigger to show off git's
power. Creating a linear history is not really impressive, especially
when you go on and compare the svn and git repos afterwards.

I'd create a svn repo with trunk, tags, branches like you have done,
import that via git-svn. Then add a few commits to trunk, dcommit them.
Then create a branch in _svn_ [1]. Use "git svn fetch" to get that into
your git repo, do some commits on that branch, dcommit them, do some
commits on trunk, dcommit them. Then checkout trunk, merge the other
branch, and dcommit the result. Then repeat that, so you got two merges
on trunk.

If you then look at your history in gitk (for example), you'll see the
merges just fine, while the svn history has no clue about it, except fo=
r
the commit message. If you do that "live", you can also show off the
history after the first merge, and show that the second merge needs no
crappy -r123:154 option to figure out what exactly needs to be merged
like svn does, because git actually records merges.

The results on the svn side of things are the same as if you had done
the merges there, and being able to compare that quite directly to how
git does it is nice.

Bj=F6rn

[1] Here's a small script that creates a branch in the svn repo (using
the svn executable) from the most recent svn commit that is in your
current git branch (yeah, it's rather ugly):

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
