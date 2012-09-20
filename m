From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] completion: fix shell expansion of items
Date: Thu, 20 Sep 2012 14:21:04 -0400
Message-ID: <20120920182104.GB19204@sigill.intra.peff.net>
References: <1348107315-25095-1-git-send-email-felipe.contreras@gmail.com>
 <20120920014608.GA27782@sigill.intra.peff.net>
 <20120920181152.GA4689@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Sep 20 20:21:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TElNJ-0003Mi-7N
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 20:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639Ab2ITSVI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Sep 2012 14:21:08 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51683 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753573Ab2ITSVH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 14:21:07 -0400
Received: (qmail 18485 invoked by uid 107); 20 Sep 2012 18:21:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Sep 2012 14:21:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Sep 2012 14:21:04 -0400
Content-Disposition: inline
In-Reply-To: <20120920181152.GA4689@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206068>

On Thu, Sep 20, 2012 at 08:11:52PM +0200, SZEDER G=C3=A1bor wrote:

> > > In order to achieve that I took bash-completion's quote() functio=
n,
> > > which is rather simple, and renamed it to __git_quote() as per Je=
ff
> > > King's suggestion.
> > >=20
> > > Solves the original problem for me.
> >=20
> > Me too. Thanks.
>=20
> While it solves the original problem, it seems to break refs
> completion, as demonstrated by the following POC test:
>=20
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 92d7eb47..fab63b95 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -228,4 +228,11 @@ test_expect_success 'general options plus comman=
d' '
>  	test_completion "git --no-replace-objects check" "checkout "
>  '
> =20
> +test_expect_success 'basic refs completion' '
> +	touch file &&
> +	git add file &&
> +	git commit -m initial &&
> +	test_completion "git branch m" "master "
> +'

Hmm.  I notice that Felipe's patch wraps the _whole_ input to
__gitcomp_nl in single quotes. So if there are multiple completions we
would end up with:

  'one
   two
   quo\'ted
   three'

I wonder if that is OK to feed to compgen -W, or if it wants to expand
it line-by-line. Just guessing at this point, though.

-Peff

> +
>  test_done
> --=20
> 1.7.12.1.438.g7dfa67b
>=20
>=20
> which fails with:
>=20
> --- expected    2012-09-20 18:05:23.857752925 +0000
> +++ out 2012-09-20 18:05:23.877752925 +0000
> @@ -1 +1 @@
> -master=20
> +
>=20
