From: Jeff King <peff@peff.net>
Subject: Re: Git 2.7.0 gitignore behaviour regression
Date: Tue, 5 Jan 2016 10:06:02 -0500
Message-ID: <20160105150602.GA4130@sigill.intra.peff.net>
References: <4B0F686D-3DF9-4E5D-971D-DB106C6573FD@mikemcquaid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mike McQuaid <mike@mikemcquaid.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 16:06:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGTBa-0005qo-V4
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 16:06:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbcAEPGH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jan 2016 10:06:07 -0500
Received: from cloud.peff.net ([50.56.180.127]:48911 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751390AbcAEPGG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 10:06:06 -0500
Received: (qmail 15060 invoked by uid 102); 5 Jan 2016 15:06:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 05 Jan 2016 10:06:04 -0500
Received: (qmail 13571 invoked by uid 107); 5 Jan 2016 15:06:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 05 Jan 2016 10:06:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jan 2016 10:06:02 -0500
Content-Disposition: inline
In-Reply-To: <4B0F686D-3DF9-4E5D-971D-DB106C6573FD@mikemcquaid.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283379>

On Tue, Jan 05, 2016 at 02:40:16PM +0000, Mike McQuaid wrote:

> Homebrew has a series of convoluted .gitignore rules due to our
> special/weird use-case of wanting to ignore everything in a working
> directory except a select few files/directories. We experienced a bug
> with our .gitignore file for users using Git 2.7.0. This may well be =
a
> valid WONTFIX or intentional behaviour change but I wanted to flag it
> in case it wasn=E2=80=99t.
>=20
> Here=E2=80=99s a minimal test case:
>=20
> - Create an empty git repository in a directory with `git init`
> - Create a directory named =E2=80=98a' containing a file named =E2=80=
=98b' with `mkdir a && touch a/b`
> - Create a =E2=80=98gitignore=E2=80=99 file with the following conten=
ts:
> ```
> */
> /a
> !/a/*
> ```
> - Run `git status --short`.
>=20
> The output with Git 2.6.4 is:
> ```
> ?? .gitignore
> ```
>=20
> The output with Git 2.7.0 is:
> ```
> ?? .gitignore
> ?? a/
> ```

Thanks for giving a clear example. This bisects to Duy's 57534ee (dir.c=
:
don't exclude whole dir prematurely if neg pattern may match,
2015-09-21). AFAICT (and I don't recall looking over this patch
previously), what you are seeing is the intended effect of the patch.

Your final line unignores stuff inside of "a", so we're reporting it (i=
f you gave
"-uall", you'd see the actual file "a/b"). Older versions of git
generally optimized out looking inside "a/" at all. This created a
hassle when people wanted to do things like:

    a/
    !a/precious-file

in their .gitignore.

I'm sympathetic that in making that use-case work, we might have
regressed another one, but it's hard to tell from the small example. Ca=
n
you elaborate on your use case? Why are you both ignoring and unignorin=
g
everything in the directory?

-Peff
