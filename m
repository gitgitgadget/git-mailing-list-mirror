From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/22] Refactor to accept NUL in commit messages
Date: Thu, 27 Oct 2011 11:13:03 -0700
Message-ID: <20111027181303.GF1967@sigill.intra.peff.net>
References: <7vobx863v3.fsf@alter.siamese.dyndns.org>
 <CACsJy8B=TsC4A=R6b3jyYBCvorEDBYHQ8uA864WrB0-3pgNyKA@mail.gmail.com>
 <7vipng5k80.fsf@alter.siamese.dyndns.org>
 <CACsJy8CA2cqJqt7cUN1CdnOb3=qE6B2XTd1oQKZ7osVz09kSGg@mail.gmail.com>
 <7vehy459bg.fsf@alter.siamese.dyndns.org>
 <20111023160744.GA22444@sigill.intra.peff.net>
 <7v39ej5uqb.fsf@alter.siamese.dyndns.org>
 <7vy5wb3sto.fsf@alter.siamese.dyndns.org>
 <20111024224558.GB10481@sigill.intra.peff.net>
 <7vvcrd411x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 27 20:13:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJUS2-0001Ws-0u
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 20:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532Ab1J0SNI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Oct 2011 14:13:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56770
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754348Ab1J0SNH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 14:13:07 -0400
Received: (qmail 4080 invoked by uid 107); 27 Oct 2011 18:18:54 -0000
Received: from c-67-169-41-183.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.41.183)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Oct 2011 14:18:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Oct 2011 11:13:03 -0700
Content-Disposition: inline
In-Reply-To: <7vvcrd411x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184312>

On Tue, Oct 25, 2011 at 07:07:38AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>=20
> > I mean, besides the obvious that UTF-16 is ...
>=20
> Yes, you could, besides the obvious. But that obvious reason makes it
> sufficiently different that it may not be so outrageous to draw the l=
ine
> between it and all the others.

Yeah, and I'm OK with that. It's just not a satisfying answer to give
Windows people who think UTF-16 is a good idea. But at the very least,
it's still unicode. It should be lossless for them to convert to utf8
and back if they want.

Speaking of which, I've been looking at handling diffing of utf-16
files. Right now we generally just consider them binary, which sucks.
It's easy to identify them by BOM in the is_buffer_binary() code, but
that's only part of it. We do an OK job of diffing them, except that:

  1. The BOM makes some diffs a little noisier.

  2. We split lines on 0x0a. But this byte can appear in other code
     points, like 0x010a (=C4=8A), or the entire entire 0x0a* code poin=
t (the
     entire Gurmukhi charset).

I'm tempted to detect the UTF-{16,32}{LE,BE} by their BOM, reencode the=
m
to utf8, and then display them in utf8. Is that too gross for us to
consider?

You can kind-of implement this outside of git using textconv. But you
have to manually mark each file as utf-16, as there's no way to trigger
an alternative diff driver on something like a BOM.

I'm really not clear on how people with utf-16 files work. Even if we
did treat utf-16 like text, the _rest_ of git is outputting ascii, so
it's not like their terminals are utf-16. But we do have projects on
github with utf-16 and utf-32 encodings.

-Peff
