From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tests: Introduce test_seq
Date: Fri, 3 Aug 2012 16:02:01 -0400
Message-ID: <20120803200201.GA10344@sigill.intra.peff.net>
References: <20120803160229.GA13094@sigill.intra.peff.net>
 <1344023835-8947-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 22:02:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxO4Z-0007Qv-GM
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 22:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676Ab2HCUCF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Aug 2012 16:02:05 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50887 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752496Ab2HCUCD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 16:02:03 -0400
Received: (qmail 27843 invoked by uid 107); 3 Aug 2012 20:02:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Aug 2012 16:02:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Aug 2012 16:02:01 -0400
Content-Disposition: inline
In-Reply-To: <1344023835-8947-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202855>

On Fri, Aug 03, 2012 at 09:57:15PM +0200, Micha=C5=82 Kiedrowicz wrote:

> Jeff King wrote:
>=20
> 	The seq command is GNU-ism, and is missing at least in older BSD
> 	releases and their derivatives, not to mention antique
> 	commercial Unixes.
>=20
> 	We already purged it in b3431bc (Don't use seq in tests, not
> 	everyone has it, 2007-05-02), but a few new instances have crept
> 	in. They went unnoticed because they are in scripts that are not
> 	run by default.
>=20
> This commit replaces them with test_seq that is implemented with a Pe=
rl
> snippet (proposed by Jeff).  This is better than inlining this snippe=
t
> everywhere it's needed because it's easier to read and it's easier to
> change the implementation (e.g. to C) if we ever decide to remove Per=
l
> from the test suite.
>=20
> Note that test_seq is not a complete replacement for seq(1).  It just
> has what we need now.
>=20
> There are also many places that do `for i in 1 2 3 ...` but I'm not s=
ure
> if it's worth converting them to test_seq.  That would introduce runn=
ing
> more processes of Perl during the tests and might increase the total
> time tests take.
>=20
> Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>

=46ine explanation, but...

> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> index 5580c22..a1361e5 100644
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -163,7 +163,7 @@ test_perf () {
>  		else
>  			echo "perf $test_count - $1:"
>  		fi
> -		for i in $(seq 1 $GIT_PERF_REPEAT_COUNT); do
> +		for i in $(test_seq 1 $GIT_PERF_REPEAT_COUNT); do

Two args to test_seq, but...

> +# test_seq is a portable replacement for seq(1).
> +# It may be used like:
> +#
> +#	for i in `test_seq 100`; do
> +#		echo $i
> +#	done
> +
> +test_seq () {
> +	test $# =3D 1 ||
> +	error "bug in the test script: not 1 parameter to test_seq"
> +	last=3D$1
> +	"$PERL_PATH" -le "print for 1..$last"
> +}

it wants only one.

I think you would want:

  test $# =3D 1 && set -- 1 "$@"
  "$PERL_PATH" -le "print for $1..$2"

It might also be worth quoting the parameters like this:

  "$PERL_PATH" -le "print for '$1'..'$2'"

so that "test_seq a f" works, too.

-Peff
