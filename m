From: Jeff King <peff@peff.net>
Subject: Re: Crashes while trying to show tag objects with bad timestamps
Date: Mon, 25 Feb 2013 13:21:01 -0500
Message-ID: <20130225182101.GA13912@sigill.intra.peff.net>
References: <kg8ri2$vjb$1@ger.gmane.org>
 <20130222224655.GB21579@sigill.intra.peff.net>
 <7vy5egark3.fsf@alter.siamese.dyndns.org>
 <20130222230418.GC21579@sigill.intra.peff.net>
 <CAPWNY8UMkxvLPk2TxCz+BAat1sNXitjhv=yqcdY0yZ1OLjgd0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 19:21:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA2g7-0001DX-RC
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 19:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758627Ab3BYSVG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2013 13:21:06 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60055 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754529Ab3BYSVF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 13:21:05 -0500
Received: (qmail 25372 invoked by uid 107); 25 Feb 2013 18:22:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Feb 2013 13:22:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Feb 2013 13:21:01 -0500
Content-Disposition: inline
In-Reply-To: <CAPWNY8UMkxvLPk2TxCz+BAat1sNXitjhv=yqcdY0yZ1OLjgd0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217072>

On Sat, Feb 23, 2013 at 01:14:40AM +0200, Mantas Mikul=C4=97nas wrote:

> > Then I think it would make sense to allow the very specific no-date=
 tag,
> > but not allow arbitrary crud. I wonder if there's an example in the
> > kernel or in git.git.
>=20
> I couldn't find any such examples. However, I did find several tags
> with no "tagger" line at all: git.git has "v0.99" and linux.git has
> many such tags starting with "v2.6.11" ending with "v2.6.13-rc3".

Yes, I think Junio was mis-remembering the exact condition. It looks
like we added tagger lines in c818566 ([PATCH] Update tags to record wh=
o
made them, 2005-07-14), which pulls the identity straight from "git var
GIT_COMMITTER_IDENT". I double-checked to be sure that we included the
date stamp at that time, and we did.

When parsing such a tag, we put a "0" in the date field of the "struct
tag", and I suspect that is what caused the memory confusion.

So I think we are fine to fsck tagger lines as we do ordinary
author/committer ident lines; the only exception is that we should not
complain if they do not exist.

> It seems that `git cat-file -p` doesn't like such tags too =E2=80=93 =
if there
> is no "tagger", it doesn't display *any* header lines. More bugs?

Yeah, I think we should just rid of that parser entirely. It is very
inconsistent with the pretty-printer used by "git show", as well as the
one used by "git for-each-ref", not to mention parse_tag (ugh, how many
tag parsers do we have?).

-Peff
