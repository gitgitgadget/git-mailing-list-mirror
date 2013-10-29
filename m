From: Jeff King <peff@peff.net>
Subject: Re: [PATCH V2] git clone: is an URL local or ssh
Date: Mon, 28 Oct 2013 21:48:06 -0400
Message-ID: <20131029014806.GB11861@sigill.intra.peff.net>
References: <201310282116.21551.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, sunshine@sunshineco.com, pclouds@gmail.com
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Oct 29 02:48:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VayQ9-0005dF-NQ
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 02:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757019Ab3J2BsK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Oct 2013 21:48:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:57430 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756852Ab3J2BsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 21:48:09 -0400
Received: (qmail 30259 invoked by uid 102); 29 Oct 2013 01:48:09 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Oct 2013 20:48:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Oct 2013 21:48:06 -0400
Content-Disposition: inline
In-Reply-To: <201310282116.21551.tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236885>

On Mon, Oct 28, 2013 at 09:16:19PM +0100, Torsten B=C3=B6gershausen wro=
te:

> Commit 8d3d28f5 added test cases for URLs which should be ssh.
>=20
> Add more tests testing all the combinations:
>  -IPv4 or IPv6
>  -path starting with "/" or with "/~"
>  -with and without the ssh:// scheme
>=20
> Add tests for ssh:// with port number.
>=20
> When a git repository "foo:bar" exist, git clone will call
> absolute_path() and git_connect() will be called with
> something like "/home/user/projects/foo:bar"
>=20
> Tighten the test and use "foo:bar" instead of "./foo:bar",
> refactor clear_ssh() and expect_ssh() into test_clone_url().
>=20
> "git clone foo/bar:baz" should not be ssh:
>   Make the rule
>   "if there is a slash before the first colon, it is not ssh"
>   more strict by using the same is_local() in both connect.c
>   and transport.c. Add a test case.
>=20
> Bug fixes for corner cases:
> - Handle clone of [::1]:/~repo correctly (2e7766655):
>   Git should call "ssh ::1 ~repo", not ssh ::1 /~repo
>   This was caused by looking at (host !=3D url), which never
>   worked for host names with literal IPv6 adresses, embedded by []
>   Support for the [] URLs was introduced in 356bece0a.
>=20
> - Do not tamper local URLs starting with '[' which have a ']'

IMHO, this would have been a little easier to follow as separate
patches, as there are a few things going on. I think the changes to the
code are fine, though.

> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 1d1c875..a126f08 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -294,39 +294,95 @@ test_expect_success 'setup ssh wrapper' '
>  	export TRASH_DIRECTORY
>  '
> =20
> -clear_ssh () {
> -	>"$TRASH_DIRECTORY/ssh-output"
> -}
> -
> -expect_ssh () {

I'd prefer if you left the expect_ssh interface intact, as it is
potentially useful outside of t5601 (but your patch ties it very closel=
y
to a particular set of clone tests). Can you call out to expect_ssh
instead from test_clone_url instead?

> +i5601=3D0

The name of this variable confused me for a bit. Maybe "counter" or
something would be a little more descriptive?

> +# $1 url
> +# $2 none|host
> +# $3 path
> +test_clone_url () {
> +	i5601=3D$(($i5601 + 1))
> +	>"$TRASH_DIRECTORY/ssh-output" &&
> +	test_might_fail git clone "$1" tmp$i5601 &&

Do we always want test_might_fail in these tests? I really would prefer
that the test actually accomplish the clone, as then we know that
nothing funny is going on (e.g., multiple invocations of ssh, one of
which is good and one of which is not). I think I gave more specific
examples in the last round of review.

> -	(cd "$TRASH_DIRECTORY" && test_cmp ssh-expect ssh-output)
> +	(
> +		cd "$TRASH_DIRECTORY" &&
> +		test_cmp ssh-expect ssh-output &&
> +		rm -rf ssh-expect ssh-output
> +	)

Here we clean up at the end of the test, which is a good improvement on
my existing functions. But I notice that you also clear ssh-output at
the beginning of the test, still (which you must do to not leave a
polluted state after a failing test). I think this might be better as:

  test_when_finished '
    (cd "$TRASH_DIRECTORY" && rm -f ssh-expect ssh-output)
  '

and then the "clear_ssh" can just go away (and your reset of ssh-output=
,
which is the analogous line), as tests can expect a clean state.

-Peff
