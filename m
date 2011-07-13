From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCHv2 2/6] add metadata-cache infrastructure
Date: Wed, 13 Jul 2011 04:31:39 -0400
Message-ID: <20110713083139.GA26838@sigill.intra.peff.net>
References: <20110713064709.GA18499@sigill.intra.peff.net>
 <20110713070405.GB18566@sigill.intra.peff.net>
 <CAKPyHN1FgK6NXqZFZ=OvMgouhfxnGF0aXU+--y-P1u9BcK9Z4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 10:31:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgurD-00033W-1C
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 10:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075Ab1GMIbm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jul 2011 04:31:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42728
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964995Ab1GMIbl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 04:31:41 -0400
Received: (qmail 22800 invoked by uid 107); 13 Jul 2011 08:32:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Jul 2011 04:32:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jul 2011 04:31:39 -0400
Content-Disposition: inline
In-Reply-To: <CAKPyHN1FgK6NXqZFZ=OvMgouhfxnGF0aXU+--y-P1u9BcK9Z4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177013>

On Wed, Jul 13, 2011 at 10:18:28AM +0200, Bert Wesarg wrote:

> > +static int record_size(const struct metadata_cache *c)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 /* a record is a 20-byte sha1 plus the width=
 of the value */
> > + =C2=A0 =C2=A0 =C2=A0 return c->mem.width + 20;
>=20
> You are circumventing your own API. Why do you don't use the
> decoration_width() accessor here? I don't see any check that
> METADATA_CACHE_INIT("frotz", 0, NULL) is invalid neither in the
> documentation nor in the code.

"struct decoration" has the "0 width means store a void pointer" rule
for compatibility with existing callers. But I never intended for
metadata-cache to have such an exception. Nor would it make sense to
store a void pointer. The pointer would be written to disk, and would
then be meaningless during the next run of the program.

I didn't figure anyone would assume the same special rule held for
metadata-cache; the fact that it is implemented using "struct
decoration" is not part of its public API. But I guess I was wrong.

It might make sense to put:

  if (!c->mem.width)
          die("BUG: zero-width metadata-cache");

into the initialization function to make it more clear, and make a note
in the API documentation.

I considered briefly that a zero-width cache might actually be useful
for storing a membership list (i.e., "is this sha1 in the list or not")=
=2E
But then you have no way of distinguishing "not in the list" from "have
no checked whether it should be in the list". You are probably better
off storing a single byte flag in such cases.

-Peff
