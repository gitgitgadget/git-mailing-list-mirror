From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] ignore memcmp() overreading in bsearch() callback
Date: Tue, 15 Jan 2013 09:18:44 -0800
Message-ID: <20130115171844.GA32227@sigill.intra.peff.net>
References: <7v38y38hhm.fsf@alter.siamese.dyndns.org>
 <20130115155043.GA21815@sigill.intra.peff.net>
 <7vmwwa4c8r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 18:19:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvAAG-0006nL-M1
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 18:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757140Ab3AORSs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jan 2013 12:18:48 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34209 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757098Ab3AORSr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 12:18:47 -0500
Received: (qmail 3077 invoked by uid 107); 15 Jan 2013 17:20:03 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 Jan 2013 12:20:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Jan 2013 09:18:44 -0800
Content-Disposition: inline
In-Reply-To: <7vmwwa4c8r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213653>

On Tue, Jan 15, 2013 at 08:55:32AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>=20
> > On Mon, Jan 14, 2013 at 03:36:21PM -0800, Junio C Hamano wrote:
> >
> >> It appears that memcmp() uses the usual "one word at a time"
> >> comparison and triggers valgrind in a callback of bsearch() used i=
n
> >> the refname search.  I can easily trigger problems in any script
> >> with test_commit (e.g. "sh t0101-at-syntax.sh --valgrind -i -v")
> >> without this suppression.
> >
> > Out of curiosity, what platform do you see this on? I can't reprodu=
ce on
> > glibc.
>=20
>     Debian GNU/Linux 6.0.6 (squeeze), on Linux 2.6.32-5-amd64.
>     libc-bin              2.11.3-4
>     valgrind-3.6.0.SVN-Debian
>     gcc                   4:4.4.5-1

Interesting. I can reproduce easily on my squeeze machine, but not my
wheezy. So presumably it is a false positive fixed either in libc (I
have 2.13-38 on the "good" box) or valgrind (1:3.8.1-1).

However, the error that valgrind reports is on the call to
"strlen(ent->name)", not memcmp (but it has suffered from the same SSE
issues in the past).

So I feel pretty confident that it really is a false positive; you may
want to double-check the offending call for the commit message (though =
I
would not be surprised if it is triggerable from both). I think it also
means that Ren=C3=A9's suggestion to use strncmp cannot be relied on to
silence the warning (though I am not opposed to doing it anyway if we
think it is more clear).

-Peff
