From: Joey Hess <joey@kitenet.net>
Subject: Re: Fwd: Git and Large Binaries: A Proposed Solution
Date: Fri, 21 Jan 2011 20:07:12 -0400
Message-ID: <20110122000712.GA7931@gnu.kitenet.net>
References: <AANLkTin=UySutWLS0Y7OmuvkE=T=+YB8G8aUCxLH=GKa@mail.gmail.com>
 <AANLkTimPua_kz2w33BRPeTtOEWOKDCsJzf0sqxm=db68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 22 01:17:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgRAE-0003q6-Dw
	for gcvg-git-2@lo.gmane.org; Sat, 22 Jan 2011 01:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755153Ab1AVARE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 19:17:04 -0500
Received: from wren.kitenet.net ([80.68.85.49]:47477 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754894Ab1AVARC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 19:17:02 -0500
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Jan 2011 19:17:01 EST
Received: from gnu.kitenet.net (unknown [206.74.132.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 933F21180A8
	for <git@vger.kernel.org>; Fri, 21 Jan 2011 19:07:13 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 6203A466C9; Fri, 21 Jan 2011 19:07:12 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <AANLkTimPua_kz2w33BRPeTtOEWOKDCsJzf0sqxm=db68@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165402>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, I wrote git-annex, and pristine-tar, and etckeeper. I enjoy making
git do things that I'm told it shouldn't be used for. :) I should have
probably talked more about git-annex here, before.

Eric Montellese wrote:
> 2. zipped tarballs of source code (that I will never need to modify)
> -- I could unpack these and then use git to track the source code.
> However, I prefer to track these deliverables as the tarballs
> themselves because it makes my customer happier to see the exact
> tarball that they delivered being used when I repackage updates.
> (Let's not discuss problems with this model - I understand that this
> is non-ideal).

In this specific case, you can use pristine-tar to recreate the
original, exact tarballs from unpacked source files that you check into
git. It accomplishes this without the overhead of duplicating compressed
data in tarballs. I feel in this case, this is a better approach than
generic large file support, since it stores all the data in git, just in a
much more compressed form, and so fits in nicely with standard git-based
source code management.

> The short version:
> ***Don't track binaries in git. =A0Track their hashes.***

That was my principle with git-annex. Although slightly generalized to:
"Don't track large file contents in git. Track unique keys that
an arbitrary backend can use to obtain the file contents."

Now, you mention in a followup that git-annex does not default to keeping
a local copy of every binary referenced by a file in master.
This is true, for the simple reason that a copy of every file in some of
my git repos master would sum to multiple terabytes of data. :) I think
that practically, anything that supports large files in git needs to
support partial checkouts too.

But, git-annex can be run in eg, a post-merge hook, and asked to
retrieve all current file contents, and drop outdated contents.

> First the layout:
> my_git_project/binrepo/
> -- binaries/
> -- hashes/
> -- symlink_to_hashes_file
> -- symlink_to_another_hashes_file
> within the "binrepo" (binary repository) there is a subdirectory for
> binaries, and a subdirectory for hashes. =A0In the root of the 'binrepo'
> all of the files stored have a symlink to the current version of the
> hash.

Very similar to git-annex in the use of versioned symlinks here.
It stores the binaries in .git/annex/objects to avoid needing to
gitignore them.

> 3. In my setup, all of the binary files are in a single "binrepo"
> directory. =A0If done from within git, we would need a non-kludgey way
> to allow large binaries to exist anywhere within the git tree.

git-annex allows the symlinks to be mixed with regular git managed
content throughout the repository. (This means that when symlinks
are moved, they may need to be fixed, which is done at commit time.)

> 5. Command to purge all binaries in your "binrepo" that are not needed
> for the current revision (if you're running out of disk space
> locally).

Safely dropping data is really one of the complexities of this
approach. Git-annex stores location tracking information in git,
so it can know where it can retrieve file data *from*. I chose to make
it very cautious about removing data, as location tracking data can=20
fall out of date (if for example, a remote had the data, had dropped it,
and has not pushed that information out). So it actively confirms that
enough other copies of the data currently exist before dropping it.
(Of course, these checks can be disabled.)

> 6. Automatically upload new versions of files to the "binrepo" (rather
> than needing to do this manually)

In git-annex, data transfer is done using rsync, so that interrupted
transfers of large files can be resumed. I recently added a git-annex-shell
to support locked-down access, similar to git-shell.


BTW, I have been meaning to look into using smudge filters with git-annex.
I'm a bit worried about some of the potential overhead associated with
smudge filters, and I'm not sure how a partial checkout would work with
them.

--=20
see shy jo

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBTTofrckQ2SIlEuPHAQgblg/9ECJt82Vh3zbmgQs8gJHnjjIz61UnHrfH
uuxnNxC9JXUet1ahFEiUq6DLkMMl+nEly6paYE2bhDvQTOUwl0yxr+9TVgaRaK6c
7fyIWCnm5OWMSVbA6kcnyQsJ0uL6OWics3Brezvvz8xV6on174mSzWQpfAwzAXBu
2/EdYVK0qIK1QBaGmcGPVhOxDB8xRHWXxRtypePTA54ETKSr0qvAzROM27tWRIf8
V0rkCzTY5W0NQepU/OWJi4qi4dGfp+s4ph2se/xnS9e36FrsgwSHajPLXfOxzuUP
x1bD9St/9MyG3CxhCgZPducAJJU0sCgi9RcQy4u/9ybsA1ihHerPGR+iETEMxbEJ
PXI5rHcyZFD/8tOwhpeb9wQ8YKpj6uS+YZ6AL9fPItC3A3UxmDxUjNni9Fi6deLq
BeFtpk/jFTQo7isPGvKt7cq9xmE9A7YrVe+zK87MERMCpidYnlN5DcesLlDmjhf8
LQ4maZlN7LG5EmwP6fDZ8FC0tVuFe+HoNxmzQfkm3QB4OVVyaN2SCxXH8ewPdZ0r
HM5Q4b5o0wpd2QyTTpzM+ehB45E9/LbYqoDgjt4GA1nxN+ncOYVzalDU8AaJxfrh
iUZX9pbhrDPmlprQA9SoExebTo4AYL658KXXOI25sIPZOWCyTzg9BxUZuYKF9+Rj
IujT24RCGuY=
=5CL0
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
