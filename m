From: Jeff King <peff@peff.net>
Subject: Re: $PATH pollution and t9902-completion.sh
Date: Thu, 20 Dec 2012 16:04:47 -0500
Message-ID: <20121220210447.GA32032@sigill.intra.peff.net>
References: <20121217010538.GC3673@gmail.com>
 <20121220145519.GB27211@sigill.intra.peff.net>
 <7vk3sc606f.fsf@alter.siamese.dyndns.org>
 <7vobho4hxa.fsf@alter.siamese.dyndns.org>
 <20121220200109.GC21785@sigill.intra.peff.net>
 <50D37AB2.1040508@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Spiers <git@adamspiers.org>,
	git mailing list <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Dec 20 22:05:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlnIg-0005O2-QS
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 22:05:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355Ab2LTVEu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Dec 2012 16:04:50 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60077 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270Ab2LTVEt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 16:04:49 -0500
Received: (qmail 15292 invoked by uid 107); 20 Dec 2012 21:05:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Dec 2012 16:05:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Dec 2012 16:04:47 -0500
Content-Disposition: inline
In-Reply-To: <50D37AB2.1040508@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211930>

On Thu, Dec 20, 2012 at 09:53:06PM +0100, Torsten B=C3=B6gershausen wro=
te:

> (Good to learn about the comm command, thanks )
> What do we think about this:
>=20
>=20
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 3cd53f8..82eeba7 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -62,12 +62,16 @@ test_completion ()
>  {
>  	if test $# -gt 1
>  	then
> -		printf '%s\n' "$2" >expected
> +		printf '%s\n' "$2" | sort >expected.sorted
>  	else
> -		sed -e 's/Z$//' >expected
> +		sed -e 's/Z$//' | sort >expected.sorted
>  	fi &&
>  	run_completion "$1" &&
> -	test_cmp expected out
> +	sort <out >actual.sorted &&
> +	>empty &&
> +	comm -23 expected.sorted actual.sorted >actual &&
> +	test_cmp empty actual &&
> +	rm empty actual

I like test_* helpers that tell you what happened on error, but this
output will be kind of a weird diff (it is a diff showing things you
expected to have but did not get as additions, and no mention of things
you expected and got).

The output is human readable, so I think it is perfectly OK to print a
message about what is going on (we do this in test_expect_code, for
example). Something like:

  test_fully_contains() {
    sort "$1" >expect.sorted &&
    sort "$2" >actual.sorted &&
    comm -23 expect.sorted actual.sorted >missing
    test -f missing -a ! -s missing &&
    rm -f expect.sorted actual.sorted missing &&
    return 0

    {
      echo "test_fully_contains: some lines were missing"
      echo "expected:"
      sed 's/^/  /' <"$1"
      echo "actual:"
      sed 's/^/  /' <"$2"
      echo "missing:"
      sed 's/^/  /' <missing
    } >&2
    return 1
  }

Though come to think of it, just showing the diff between expect.sorted
and actual.sorted would probably be enough. It would show the missing
elements as deletions, the found elements as common lines, and the
"extra" elements as additions (which are not an error, but when you are
debugging, might be useful to know about).

-Peff
