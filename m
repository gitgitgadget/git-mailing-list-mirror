From: Jeff King <peff@peff.net>
Subject: Re: Bug: pull --rebase with =?utf-8?B?w6kg?= =?utf-8?Q?in?= name
Date: Mon, 5 Mar 2012 08:50:10 -0500
Message-ID: <20120305135010.GA17189@sigill.intra.peff.net>
References: <FECFDD4D-6EC3-4DE1-8A08-B4477345C4AA@habr.de>
 <20120305102657.GB29061@sigill.intra.peff.net>
 <87399nqqog.fsf@thomas.inf.ethz.ch>
 <F5A485EA-7EAD-4D8B-87C4-7185F713318C@habr.de>
 <20120305115815.GA4550@sigill.intra.peff.net>
 <0E2B8DE3-1ABD-453F-BCAA-0D693ECA5987@habr.de>
 <87ipijkxlm.fsf@thomas.inf.ethz.ch>
 <20120305132913.GA15004@sigill.intra.peff.net>
 <87r4x7jhd9.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Haber <rene@habr.de>, git@vger.kernel.org,
	Will Palmer <wmpalmer@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 05 14:50:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4YJ0-0005kI-BT
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 14:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292Ab2CENuS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Mar 2012 08:50:18 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37715
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932246Ab2CENuM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 08:50:12 -0500
Received: (qmail 30605 invoked by uid 107); 5 Mar 2012 13:50:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 05 Mar 2012 08:50:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Mar 2012 08:50:10 -0500
Content-Disposition: inline
In-Reply-To: <87r4x7jhd9.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192239>

On Mon, Mar 05, 2012 at 02:40:34PM +0100, Thomas Rast wrote:

> > It would be nice if the --pretty format placeholders had a "shell-q=
uote"
> > modifier, and we could just do:
> >
> >   git show --format=3D'GIT_AUTHOR_NAME=3D%(an:shell)'
> >
> > or something similar. for-each-ref knows about shell-quoting, but w=
e
> > can't use it here, because we are looking at arbitrary commits, not=
 just
> > ones pointed to by refs.
>=20
> Perhaps by using %an etc., line numbers and --sq-quote:
>=20
>   $ git rev-list --no-walk --date=3Draw --format=3D"%an%n%ae%n%ad" --=
encoding=3DUTF-8 HEAD |
>     while read -r s; do git rev-parse --sq-quote "$s"; done |
>     sed -n -e '2s/^ /GIT_AUTHOR_NAME=3D/p' -e '3s/^ /GIT_AUTHOR_EMAIL=
=3D/p' -e '4s/^ /GIT_AUTHOR_DATE=3D/p'
>   GIT_AUTHOR_NAME=3D'Thom'\''as R=C3=A0st'
>   GIT_AUTHOR_EMAIL=3D'trast@inf.ethz.ch'
>   GIT_AUTHOR_DATE=3D'1330935546 +0100'

Yeah, that works. It's a little harder to read than would be ideal, but
should produce the right results (I was initially hesitant to use "read=
"
because I was worried about newlines in the input. But of course, that'=
s
a non-issue since author ident by definition cannot have newlines in
it).

I think this is a good direction regardless of the sed issue. We end up
parsing ident lines like this in a lot of different places, and I would
not be surprised if they do not all behave exactly the same. Eliminatin=
g
one such parser in favor of the standard one in pretty.c seems like a
good thing.

-Peff

PS If you are going to turn that into a real patch, note that your date
   field accidentally drops the "@" specifier that unambiguously marks
   the number as an epoch timestamp.
