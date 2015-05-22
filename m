From: Jeff King <peff@peff.net>
Subject: Re: [BUG] "git commit --date" format parsing
Date: Fri, 22 May 2015 18:06:10 -0400
Message-ID: <20150522220610.GA21848@peff.net>
References: <555F2CBD.8050501@esrevart.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bastien Traverse <bt@esrevart.net>
X-From: git-owner@vger.kernel.org Sat May 23 00:06:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvv58-0006G5-RW
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 00:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756927AbbEVWGN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 May 2015 18:06:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:35015 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756757AbbEVWGM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 18:06:12 -0400
Received: (qmail 1385 invoked by uid 102); 22 May 2015 22:06:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 May 2015 17:06:12 -0500
Received: (qmail 21404 invoked by uid 107); 22 May 2015 22:06:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 May 2015 18:06:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 May 2015 18:06:10 -0400
Content-Disposition: inline
In-Reply-To: <555F2CBD.8050501@esrevart.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269766>

On Fri, May 22, 2015 at 03:18:53PM +0200, Bastien Traverse wrote:

> $ git --version
> git version 2.4.1
>=20
> $ uname -a
> Linux arch-clevo 4.0.4-1-ARCH #1 SMP PREEMPT Mon May 18 06:43:19 CEST
> 2015 x86_64 GNU/Linux
>=20
> $ mkdir test && cd test/
> $ git init
> $ touch test
> $ git add test
>=20
> 1. ISO 8601 (strict)
>=20
> $ git commit --date=3D"2015-05-21T16=E2=88=B631+02:00" -m "Test commi=
t to check
> date format parsing"
> [master (root commit) fed9ae6] Test commit to check date format parsi=
ng
>  Date: Thu May 21 02:00:00 2015 +0200
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 test
>=20
>   --> gets the date right but confuses the timezone for the time

OK, this is weird. When I tried to reproduce, I couldn't. But I had
typed in the date string myself while reading your email in another
window.  And though I was sure that I had typed it correctly, just to b=
e
double-plus-sure I copied and pasted your string. And it failed!

The date string in your email looks like this (using cut and paste):

  $ echo 2015-05-21T16=E2=88=B631+02:00 | xxd
  00000000: 3230 3135 2d30 352d 3231 5431 36e2 88b6  2015-05-21T16...
  00000010: 3331 2b30 323a 3030 0a                   31+02:00.

Your "colon" is actually UTF-8 for code point U+2236 ("RATIO"). So git'=
s
date parser does not recognize it, and punts to approxidate(), which
does all manner of crazy guessing trying to figure out what you meant.

-Peff
