From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-pack: don't send a thin pack to a server which
 doesn't support it
Date: Sun, 24 Nov 2013 01:07:46 -0500
Message-ID: <20131124060745.GA5289@sigill.intra.peff.net>
References: <1385222875-13369-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
	pclouds@gmail.com, spearce@spearce.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Sun Nov 24 07:07:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkSrI-0004UY-RQ
	for gcvg-git-2@plane.gmane.org; Sun, 24 Nov 2013 07:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901Ab3KXGHt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 01:07:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:44643 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750803Ab3KXGHs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 01:07:48 -0500
Received: (qmail 15975 invoked by uid 102); 24 Nov 2013 06:07:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 24 Nov 2013 00:07:48 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Nov 2013 01:07:46 -0500
Content-Disposition: inline
In-Reply-To: <1385222875-13369-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238249>

On Sat, Nov 23, 2013 at 05:07:55PM +0100, Carlos Mart=C3=ADn Nieto wrot=
e:

> Up to now git has assumed that all servers are able to fix thin
> packs. This is however not always the case.
>=20
> Document the 'no-thin' capability and prevent send-pack from generati=
ng
> a thin pack if the server advertises it.
> ---
>=20
> This is a re-roll of the series I sent earlier this month, switching
> it around by adding the "no-thin"

Thanks, I think this moves in the right direction.

I wonder if we want to call it "no-thin-pack" just for consistency with
the affirmative version in upload-pack.

> +The upload-pack server advertises 'thin-pack' when it can generate a=
nd
> +send a thin pack. The receive-pack server advertises 'no-thin' if
> +it does not know how to "thicken" the pack it receives.
> +
> +A client requests the 'thin-pack' capability when it understands how
> +to "thicken" it.
> =20
>  Client MUST NOT request 'thin-pack' capability if it cannot turn a t=
hin
>  pack into a self-contained pack.
> =20
> +Client MUST NOT send a thin pack if the server advertises the
> +'no-thin' capability.

As somebody who participated in the discussion, I know why one is in th=
e
affirmative and one is in the negative. But I think it might help a
reader of the spec to emphasize the difference, and to put the client
behavior for each alongside the server behavior, like:

  The upload-pack server advertises 'thin-pack' when it can generate an=
d
  send a thin pack. A client requests the 'thin-pack' capability when i=
t
  understands how to "thicken" it, notifying the server that it can
  receive such a pack. A client MUST NOT request the 'thin-pack'
  capability if it cannot turn a thin pack into a self-contained pack.

  Receive-pack, on the other hand, is assumed by default to be able to
  handle thin packs, but can ask the client not to use the feature by
  advertising the 'no-thin' capability. A client MUST NOT send a thin
  pack if the server advertises the 'no-thin' capability.

  The reasons for this asymmetry are historical. The receive-pack
  program did not exist until after the invention of thin packs, so
  historically the reference implementation of receive-pack always
  understood thin packs. Adding 'no-thin' later allowed receive-pack to
  disable the feature in a backwards-compatible manner.

-Peff
