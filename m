From: Jeff King <peff@peff.net>
Subject: Re: git log - crash and core dump
Date: Wed, 17 Apr 2013 02:39:42 -0400
Message-ID: <20130417063942.GA27703@sigill.intra.peff.net>
References: <CANKwXW1EXLiWgdVM4+k_11wu1Nyixp05PUXmQYP_gUXQKek_OA@mail.gmail.com>
 <516D93C4.1000100@lsrfire.ath.cx>
 <7v61zml0ow.fsf@alter.siamese.dyndns.org>
 <516DBE2E.4060201@lsrfire.ath.cx>
 <7vzjwyi0ba.fsf@alter.siamese.dyndns.org>
 <7vli8hhgmn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Ivan Lyapunov <dront78@gmail.com>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 08:39:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USM22-0000sS-B0
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 08:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755284Ab3DQGjq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Apr 2013 02:39:46 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49526 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752439Ab3DQGjp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 02:39:45 -0400
Received: (qmail 30298 invoked by uid 107); 17 Apr 2013 06:41:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 17 Apr 2013 02:41:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Apr 2013 02:39:42 -0400
Content-Disposition: inline
In-Reply-To: <7vli8hhgmn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221514>

On Tue, Apr 16, 2013 at 10:26:40PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
> >
> >> How about making split_ident_line() a bit friendlier be letting it
> >> provide the epoch as default time stamp instead of NULL? =20
> >
> > Two knee-jerk concerns I have without going back to the callers:
> >
> >  * Would that "0" ever be given to the approxidate parser, which
> >    rejects ancient dates in numbers-since-epoch format without @
> >    prefix?
> >
> >  * Does any existing caller use the NULL as a sign to see the input
> >    was without date and act on that information?
>=20
> I looked at all the callers (there aren't that many), and none of
> them did "Do this on a person-only ident, and do that on an ident
> with timestamp".  So for the callers that ignore timestamp, your
> patch will be a no-op, and for others that assume there is a
> timestamp, it will turn a crash/segv into output with funny
> timestamp.

What about sane_ident_split in builtin/commit.c? It explicitly rejects =
a
NULL date. The logic in determine_author_info is a little hard to follo=
w
(it assembles the ident line with fmt_ident and then reparses it), but =
I
believe it should be catching a bogus line from "commit -c", or from
GIT_AUTHOR_DATE in the environment.

As a side note, when determine_author_info sees a bogus ident, it
appears to just silently ignore it, which is probably a bad thing.
Shouldn't we by complaining?  Or am I mis-reading the code?

-Peff
