From: "W. Trevor King" <wking@drexel.edu>
Subject: Re: [PATCH v3] Isolate If-Modified-Since handling in gitweb
Date: Wed, 21 Mar 2012 10:04:30 -0400
Message-ID: <20120321140429.GA28721@odin.tremily.us>
References: <m3sjh2ay6j.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=45Z9DzgjV8m4Oswq
To: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 16:15:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SANFu-0002yu-BM
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 16:15:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757624Ab2CUPPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 11:15:13 -0400
Received: from vms173017pub.verizon.net ([206.46.173.17]:57834 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757568Ab2CUPPL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 11:15:11 -0400
Received: from odin.tremily.us ([unknown] [72.68.85.198])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M1800FY2OSL0E50@vms173017.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 21 Mar 2012 09:42:48 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 7B537427A40; Wed,
 21 Mar 2012 10:04:31 -0400 (EDT)
Content-disposition: inline
In-reply-to: <m3sjh2ay6j.fsf@localhost.localdomain>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193582>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 21, 2012 at 06:19:51AM -0700, Jakub Narebski wrote:
> By the way, it is custom on this mailing list to usually Cc (send a
> copy) to all people participating in discussion, and not only to git
> mailing list.

Ah, sorry.  I figured that if you got the original email to the list,
I'd just be doubling up in your inbox by Cc-ing you directly.

> Though trouble with coming up with a short but fairly complete
> one-line summary might mean that this patch would be better split in
> two: refactoring and adding support for If-Modified-Since to
> snapshots.

Agreed.

> >                                  where it is appropriate
>                                    ^^^^^^^^^^^^^^^^^^^^^^^
> This doesn't add any information.  I think it the commit message would
> be better if you either remove this, or expand (in a separate
> paragraph) where support for If-Modified-Since might make sense, and
> where it could not.

I'll expand it in the refactoring patch.

> BTW. what happened to diffstat?

My local branch has sequential commits for each patch version (e.g.,
commits for v1, v2, ...).  When it's time to email the list, I'm
supposed to send logical patches against the trunk (e.g., patches for
refactoring, git_snapshot, ...).  For v2 I just used `git diff
origin/master` to generate the patch, and it doesn't include the
diffstat.  Now that I'm splitting into two patches, I'll probably use
`git rebase -i origin/master` and just keep track of the changes by
hand ;).  If there's a better way that I'm overlooking, feel free to
point me in the right direction.

> Tests (to be put, I think, in t/t9501-gitweb-standalone-http-status.sh)?
> We could use test_tick() and $test_tick for that (or extract formatted
> committer date from a commit).

I'll try to set that up.  Should it be bundled into the git_snapshot
patch, or should there be three patches:

1: gitweb: Refactor If-Modified-Since handling
2: gitweb: Add If-Modified-Since tests for git_snapshot
3: gitweb: Add If-Modified-Since support for git_snapshot

> > @@ -7029,6 +7051,10 @@ sub git_snapshot {
> > =20
> >  	my ($name, $prefix) =3D snapshot_name($project, $hash);
> >  	my $filename =3D "$name$known_snapshot_formats{$format}{'suffix'}";
> > +
> > +	my %co =3D parse_commit($hash) or die_error(404, "Unknown commit obje=
ct");
> > +	die_if_unmodified($co{'committer_epoch'});
> > +
>=20
> That unexplainably changes behavior of 'snapshot' action.  Before we
> would accept snapshot of a tree given by its SHA-1, now we do not.
>=20
> This might be a good idea from a security point of view wrt. leaking
> information (c.f. "git archive --remote" behavior), but it at least
> needs to be explained in commit message, and perhaps even in a comment
> above this line.
>=20
> Alternative solution would be to skip If-Modified-Since handling if we
> request snapshot by tree id:
>=20
>   +
>   +	my %co =3D parse_commit($hash);
>   +	die_if_unmodified($co{'committer_epoch'}) if %co;
>   +

I'm still not understanding the problem here.  The following all work
in my testing:

  http://.../gitweb.cgi?p=3Da/.git;a=3Dsnapshot;h=3D1d545cab4a8dc894fae2c26=
34a74993ea62b054d;sf=3Dtgz
  http://.../gitweb.cgi?p=3Da/.git;a=3Dsnapshot;h=3D1d5;sf=3Dtgz
  http://.../gitweb.cgi?p=3Da/.git;a=3Dsnapshot;h=3DHEAD;sf=3Dtgz

Can you give me an example of a hash that you expect to not work?

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJPad/sAAoJEPe7CdOcrcTZVSoH/2u8tKts0Wis537ts3NJWbuB
0Xg7zXD6eNV5vNj6PhRKnqq8gMcJ2vSzOpqx6T4JsbJRwniVTKSgChR3QSU2P6jR
zo2QOcJd6HC5ycUTlfEHadwkpKdKHC1+ClZ5jaQTgSH+AI9fZPtWxjyXemdvjSGr
c/E2MGyJgPmTrSZhOsuC+zwxcROYK/p1HWwy+fCPKSiFyQpYmHe5KtFX+MebcaUG
N8ASxEYpIs8z4NEndC06saO4IWPaF77g2WVI1rWcNaqgh9uYwNNlIQW++CFHOcgD
Ky9xoppVmi00iYqJbnRC/WjOJQZxv6uYH1aWKwkC6CIce0G69EQXSLm9u2v990Y=
=cnBA
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
