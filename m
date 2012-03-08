From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] archive: fix archive generation for empty trees
Date: Thu, 8 Mar 2012 00:55:20 -0500
Message-ID: <20120308055520.GB7643@sigill.intra.peff.net>
References: <1331165362-78065-1-git-send-email-brodie@sf.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Brodie Rao <brodie@sf.io>
X-From: git-owner@vger.kernel.org Thu Mar 08 06:55:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5WJz-0008Vh-Jj
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 06:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688Ab2CHFzY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 00:55:24 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44311
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752673Ab2CHFzW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 00:55:22 -0500
Received: (qmail 32672 invoked by uid 107); 8 Mar 2012 05:55:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Mar 2012 00:55:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Mar 2012 00:55:20 -0500
Content-Disposition: inline
In-Reply-To: <1331165362-78065-1-git-send-email-brodie@sf.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192522>

[+cc Ren=C3=A9, as this is his code;
 +cc Duy, for pathspec questions]

On Wed, Mar 07, 2012 at 04:09:22PM -0800, Brodie Rao wrote:

> Prior to this change, git-archive would try to verify path arguments =
-
> even if none were provided. It used get_pathspec("", pathspec), which
> would return a pathspec of "" instead of NULL.
>=20
> Then it would try to verify if the tree contained any paths matching
> "". This is fine in the normal case where the tree contains anything
> (every entry would match), but for an empty tree, it wouldn't match,
> and you'd get this error:
>=20
>   fatal: path not found:
>=20
> Now, instead of "", we use a pathspec prefix of NULL. If no path
> arguments were provided, get_pathspec() will return NULL, and we won'=
t
> try to verify the existence of any paths in the tree.

Yeah, this looks like the right thing to do. The get_pathspec code
treats a NULL prefix specially as "no prefix", and I think that is what
we are trying to say here (i.e., we are interpreting pathspecs from the
root).

Though the main function of get_pathspec seems to be to call
prefix_pathspec on each element of the pathspec. And we have no prefix
here. However, prefix_pathspec does a lot of magic parsing; it's unclea=
r
to me whether this is all in support of properly adding the prefix, or
if its side effects are important. But if it is purely about prefixing,
can't we just get rid of the call to get_pathspec entirely?

There is also a comment above prefix_pathspec regarding moving things
over to the new "struct pathspec" interface. But that leaves me more
confused, since init_pathspec does not handle prefixes at all (so it
looks like you would need to call get_pathspec first to get a
prefixed list, and then feed the result to init_pathspec. Should we be
doing something with "struct pathspec" here? Confused...

-Peff

PS The patch itself is quoted below without further comment for the
   benefit of those who were cc'd.

> ---
>  archive.c           |    2 +-
>  t/t5000-tar-tree.sh |   16 ++++++++++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/archive.c b/archive.c
> index 1ee837d..6e23896 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -236,7 +236,7 @@ static int path_exists(struct tree *tree, const c=
har *path)
>  static void parse_pathspec_arg(const char **pathspec,
>  		struct archiver_args *ar_args)
>  {
> -	ar_args->pathspec =3D pathspec =3D get_pathspec("", pathspec);
> +	ar_args->pathspec =3D pathspec =3D get_pathspec(NULL, pathspec);
>  	if (pathspec) {
>  		while (*pathspec) {
>  			if (!path_exists(ar_args->tree, *pathspec))
> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index 527c9e7..404786f 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -360,4 +360,20 @@ test_expect_success GZIP 'remote tar.gz can be d=
isabled' '
>  		>remote.tar.gz
>  '
> =20
> +test_expect_success \
> +    'git archive with an empty tree and a prefix' \
> +    'git rm -r . &&
> +     git commit -m empty &&
> +     git archive --format=3Dtar --prefix=3Dempty/ HEAD > e1.tar &&
> +     "$TAR" tf e1.tar'
> +
> +test_expect_success \
> +    'git archive with an empty tree and no prefix' \
> +    'git archive --format=3Dtar HEAD > e2.tar &&
> +     test_must_fail "$TAR" tf e2.tar'
> +
> +test_expect_success \
> +    'git archive on specific paths with an empty tree' \
> +    'test_must_fail git archive --format=3Dtar --prefix=3Dempty/ HEA=
D foo'
> +
>  test_done
> --=20
> 1.7.9.2
>=20
