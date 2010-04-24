From: Eric Raymond <esr@thyrsus.com>
Subject: Re: ciabot scripts and merge flood prevention
Date: Sat, 24 Apr 2010 12:05:44 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100424160544.GB24165@thyrsus.com>
References: <20100424150511.GA7318@gnu.kitenet.net>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Sat Apr 24 18:05:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5hri-0001bv-Dt
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 18:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683Ab0DXQFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 12:05:46 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:59381
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591Ab0DXQFp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 12:05:45 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 6CBEF20CBC5; Sat, 24 Apr 2010 12:05:44 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20100424150511.GA7318@gnu.kitenet.net>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145685>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Joey Hess <joey@kitenet.net>:
> There's a problem with the old ciabot scripts, and I think also the v3
> versions, when two published branches are merged. In this case, ciabot
> reports all the changes twice, once when they're first committed to the
> first branch, and a second time when the first branch is merged into the
> second. This can unleash a flood of redundant commit messages that wipes
> out conversation in any poor irc channel that has CIA in it. I've
> generated floods that lasted up to 15 minutes.
>=20
> I document the problem and one solution here. There's also a link to=20
> the hook script Gnome is using, based on the same method.
> http://kitenet.net/~joey/blog/entry/lazyweb:_git_cia_hooks/
> Maybe this could be built into the ciabot scripts?

For the record, Joey suggests this:

while read oldrev newrev refname; do
    branchname=3D${refname#refs/heads/}
    [ "$branchname" =3D "master" ] && branchname=3D
    for merged in $(git rev-parse --symbolic-full-name --not --branches | e=
grep -v "^\^$refname$" | git rev-list --reverse --stdin $oldrev..$newrev); =
do
        ciabot_git.pl $merged $branchname
    done
done

with discussion that is short enough to reproduce here.

buxy writes:
>Dear Joey, we also had this problem for dpkg, that=E2=80=99s why I hacked =
the
>/usr/local/bin/git-commit-notice script that we=E2=80=99re using on Alioth=
 to
>do something like this instead: [gives the above script]
>
>It will stop git rev-list each time that it encounters a commit that
>is available in any of the other branches present in the repository
>and thus when you merge a branch, you only see the merge commit in
>CIA.
>
>You should also note that the script is smarter as it calls CIA only
>for branch updates, not for tag creation (and other kinds of updates)
>where it only leads to strange errors IIRC.

I had noticed the strange errors on tag creation and was planning to
do something about it.  What I see happening is that the existing=20
git rev-list call generates a list beginning with a commit ID consisting
of all zeros when the hook is called as the result of a tag push.

He also links to this:=20

http://git.gnome.org/cgit/gitadmin-bin/tree/post-receive-notify-cia

> (BTW, in both scripts, the example of git-rev-list ... | tac
> could perhaps more efficiently be written as git-rev-list --reverse ...)

I had noticed this. I didn't change it because (a) I wasn't sure how far
back the --reverse argument went, and (b) I've been thinking about implment=
ing
some switches to change the calling interface so that the rev list=20
expansion is dome internally. It needs to be smarter to banish the
tag-push problem.

I expect to be able to tackle this within the next four days.
--=20
		<a href=3D"http://www.catb.org/~esr/">Eric S. Raymond</a>

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFL0xbYrfUW04Qh8RwRAuG/AKD+HPcuSeDMavifln3kGclRIkZcdACguWip
yz1PYmTIdFem5HkWu/r9KqE=
=kWY2
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
