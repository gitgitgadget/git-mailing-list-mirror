From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-add--interactive: Preserve diff heading when
 splitting hunks
Date: Mon, 12 May 2014 16:09:52 -0400
Message-ID: <20140512200952.GA2329@sigill.intra.peff.net>
References: <1399824596-4670-1-git-send-email-avarab@gmail.com>
 <20140512183955.GB31164@sigill.intra.peff.net>
 <CACBZZX4W=1jPGcuBYstQkBDaT_wu38Fhxu642qwaFtCCqBdnyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 22:10:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjwXv-0000se-UP
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 22:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbaELUJz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 May 2014 16:09:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:50152 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751509AbaELUJz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 16:09:55 -0400
Received: (qmail 22067 invoked by uid 102); 12 May 2014 20:09:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 May 2014 15:09:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 May 2014 16:09:52 -0400
Content-Disposition: inline
In-Reply-To: <CACBZZX4W=1jPGcuBYstQkBDaT_wu38Fhxu642qwaFtCCqBdnyQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248728>

On Mon, May 12, 2014 at 09:42:56PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> Good suggestion, but tricky as you point out. Another thing I've
> wanted many times is to make it smart enough that when you edit code
> like:
>=20
>   A()
>   B();
>=20
> And change it to:
>=20
>   X();
>=20
>   Y();
>=20
> The change from A->X and B->Y may be completely unrelated and just
> made in code where the author didn't add whitespace between unrelated
> statements.
>=20
> But because you change all the lines the tool can't split them up, it
> could try harder and split hunks like that if you add a whitespace
> boundary, or just go all the way down to adding/removing individual
> lines, so you wouldn't have to fall down to "edit" mode and do so
> manually.

Yeah, I frequently run into this, too, and have just gotten good at
editing the patch. :)

I think splitting line-by-line, as you suggest, would be more general.
However, working within a single cluster of lines is difficult (both
line-by-line and in your whitespace example), because you have to
correlate removed and added lines. E.g., the diff for your change above
might look like:

  @@ ... @@
   context
   -A();
   -B();
   +X();
   +
   +Y();
   more context

We would want to end up with three hunks:

  -A();
  +X();

  +

  -B();
  +Y();

but how do we know which preimage lines correspond with which postimage
lines? You can probably come up with heuristics for this case (e.g.,
introduced whitespace gets its own hunk, and then count postimage lines
from each end), but there are many harder cases.

> > I didn't prepare a commit message because I think it should probabl=
y
> > just be squashed in.
>=20
> Well spotted, indeed, that should be squashed in.

If you do (or Junio does), I think the commit message needs a slight
update.

> On a related note I thought by doing color.ui=3Dauto I was turning on
> all the colors, it would be nice if there was a built-in colorscheme
> that added more coloring to items like these across our tools, it's
> useful to have the hunk headers colored differently so they stand out
> more.

I don't set color.diff.func myself, but having just looked at it when
playing with your patch, I think it looks nice (I did "yellow").

I also set color.diff.meta to "magenta", which I think makes the hunk
header stand out a bit more.

So yeah, I'd be fine with proposing changes to the default color scheme=
,
though I do not envy you the inevitable bikeshed war. :)

-Peff
