From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] textconv: support for blame
Date: Tue, 15 Jun 2010 05:54:53 -0400
Message-ID: <20100615095452.GA32624@sigill.intra.peff.net>
References: <1275921713-3277-1-git-send-email-axel.bonnet@ensimag.imag.fr>
 <1275924218-20154-1-git-send-email-axel.bonnet@ensimag.imag.fr>
 <1275924218-20154-2-git-send-email-axel.bonnet@ensimag.imag.fr>
 <7vfx0p9wlm.fsf@alter.siamese.dyndns.org>
 <0091febb4a3832a6680a0fbc2209f841@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?Q?Cl=C3=A9ment?= Poulain <clement.poulain@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 15 11:55:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOSrJ-0000yi-JG
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 11:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755032Ab0FOJy5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jun 2010 05:54:57 -0400
Received: from peff.net ([208.65.91.99]:47193 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780Ab0FOJy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 05:54:56 -0400
Received: (qmail 19935 invoked by uid 107); 15 Jun 2010 09:55:41 -0000
Received: from adsl-99-133-187-56.dsl.bltnin.sbcglobal.net (HELO sigill.intra.peff.net) (99.133.187.56)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 15 Jun 2010 05:55:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Jun 2010 05:54:53 -0400
Content-Disposition: inline
In-Reply-To: <0091febb4a3832a6680a0fbc2209f841@ensimag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149168>

On Tue, Jun 15, 2010 at 11:29:57AM +0200, Cl=C3=A9ment Poulain wrote:

> > The same issue exists in Cl=C3=A9ment's patch to builtin/cat-file.c=
=2E
>=20
> We did this way because we found a similar cast in prep_temp_blob(),
> diff.c:
>=20
> 	if (convert_to_working_tree(path,
> 			(const char *)blob, (size_t)size, &buf)) {
>=20
> where size is an unsigned long.
> Is it the same issue ? Or is it different because it's not a pointer =
cast?

Right. The compiler will handle conversion between integer types during
assignment itself, converting representations as necessary (in fact,
that cast looks useless to me, as implicit conversions are allowed in
C). The only problem is dereferencing a pointer to X as something other
than X.

> Otherwise, we thought of reversing the conversion. That is to say, in=
stead
> of casting "long *" in "size_t *" when calling textconv_object(), is =
it
> better to cast size_t in "unsigned long" in textconv_object():
>=20
> 	*buf_size =3D (unsigned long) fill_textconv(textconv, df, buf); ?

You shouldn't even have to cast there, for the same reason as above.
That is why I wrote fill_textconv to return the size parameter, rather
than writing to a passed-in pointer. It avoids the annoying
size_t / unsigned long casting caused by different usage (in an ideal
world, all of our sizes would be the same type, but the strbuf and diff
code obviously differ).

-Peff
