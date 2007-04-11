From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Wed, 11 Apr 2007 10:06:41 +0200
Message-ID: <20070411080641.GF21701@admingilde.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 15:06:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbXqr-0007RV-Fm
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 10:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbXDKIGp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 04:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbXDKIGp
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 04:06:45 -0400
Received: from mail.admingilde.org ([213.95.32.147]:46239 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbXDKIGn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 04:06:43 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HbXqj-000752-HO; Wed, 11 Apr 2007 10:06:41 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44218>


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

thanks Linus for your nice implementation.  Your core code is so much
nicer than my hacked-up prototype :-).

I only had little time to actually have a look at it but the core is
very similiar to my approach and I'll try to rebase some of my code on
top of yours in the following days.

The only thing I disagree with you is in using HEAD of the submodule:

On Mon, Apr 09, 2007 at 09:20:29PM -0700, Linus Torvalds wrote:
> +static int ce_compare_gitlink(struct cache_entry *ce)
> +{
> +	unsigned char sha1[20];
> +
> +	/*
> +	 * We don't actually require that the .git directory
> +	 * under DIRLNK directory be a valid git directory. It
> +	 * might even be missing (in case nobody populated that
> +	 * sub-project).
> +	 *
> +	 * If so, we consider it always to match.
> +	 */
> +	if (resolve_gitlink_ref(ce->name, "HEAD", sha1) < 0)
> +		return 0;
> +	return hashcmp(sha1, ce->sha1);
> +}


> @@ -2332,6 +2333,8 @@ int index_path(unsigned char *sha1, const char *pat=
h, struct stat *st, int write
>  				     path);
>  		free(target);
>  		break;
> +	case S_IFDIR:
> +		return resolve_gitlink_ref(path, "HEAD", sha1);
>  	default:
>  		return error("%s: unsupported file type", path);
>  	}

Always using HEAD of the submodule makes branches in the submodule
useless.

Whenever you do a checkout in the supermodule you also have to update
the submodule and this update has to change the same thing which is read
above.
Updating the branch which HEAD points to is dangerous.  You could
overwrite some unrelated branch just because the user forgot to switch
back to his supermodule-tracking-branch.  The user would always have to
make sure that all the submodules are in the correct state for an update
of the supermodule.
Updating HEAD directly is possible now and may make some sense, but you
still get problems when you want to switch to some temporary branch in
the submodule.  You have no chance to get back to the original supermodule
version and now your temporary submodule branch gets shown as the new
submodule version which should be part of the supermodule.
The submodule version which is stored in the supermodules tree is kind
of a hidden/remote reference/branch.  When working on a remote branch
we first create a local working branch and then sync it with the remote
one.  I think that it makes sense to use the same model for submodules:
have one local branch in the submodule which is used for all work that
is done in the supermodule context.

So my advice is:
Always read and write one dedicated branch (hardcoded "master" or
configurable) when the supermodule wants to access a submodule.

Then you have two type of branches:
You can branch the supermodule and have you own branch of the entire
project with all submodules.  Use this if you want to commit your
work on the submodule into the supermodule.
You can also branch the submodule to effectively disconnect the
submodule from the supermodule temporarily.  You can use this to
do some experimental/debugging stuff which should not yet go into
the supermodule.  Once you want this branch to show up in the
supermodule, just merge it to "master" and commit it to the supermodule
(and now its in the supermodule branch, the submodule branch is not
needed any more).


See also the discussion about it in the messages around
http://marc.info/?l=3Dgit&m=3D116636334226668&w=3D2

--=20
Martin Waitz

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGHJcRj/Eaxd/oD7IRApfCAJ9T3wW+ORqb+TCD+Qme4E3UL0KGwQCeLhy/
RrgbwbyzbG5SPUy2HwI1P88=
=GdpT
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
