From: Jeff King <peff@peff.net>
Subject: Re: [BUG] resolved deltas
Date: Fri, 29 Aug 2014 16:55:38 -0400
Message-ID: <20140829205538.GD29456@peff.net>
References: <53F5D98F.4040700@redhat.com>
 <53F79CE3.60803@gmx.net>
 <53F868F8.9080000@web.de>
 <20140823105640.GA6881@peff.net>
 <20140823110459.GA13087@peff.net>
 <20140823111804.GA17335@peff.net>
 <53FB66D1.709@web.de>
 <20140828220821.GA31545@peff.net>
 <20140828222227.GA30879@peff.net>
 <xmqq1ts08ax2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Shawn Pearce <spearce@spearce.org>,
	Martin von Gagern <Martin.vGagern@gmx.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 22:56:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNTDC-00089n-Pf
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 22:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbaH2Uzl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Aug 2014 16:55:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:33406 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750784AbaH2Uzk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 16:55:40 -0400
Received: (qmail 4442 invoked by uid 102); 29 Aug 2014 20:55:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Aug 2014 15:55:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Aug 2014 16:55:38 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1ts08ax2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256190>

On Thu, Aug 28, 2014 at 04:14:01PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>=20
> > On Thu, Aug 28, 2014 at 06:08:21PM -0400, Jeff King wrote:
> >
> >> Interesting. I couldn't convince Helgrind to catch such a case...
> >
> > Ugh. It helps if you actually helgrind the git binary, and not the
> > shell-script from bin-wrappers. I can easily replicate the problem =
now.
> > The patch I just posted seems to fix it (at least it has been runni=
ng in
> > a loop for over a minute with no failures, whereas before it took o=
nly a
> > few seconds to provoke a failure).
>=20
> Thanks for digging.  I'll pick it up and may comment on it in
> tomorrow's cycle (it is a bit too late for today's cycle,
> unfortunately).

Here's a proposed series.

  [1/2]: index-pack: fix race condition with duplicate bases
  [2/2]: index-pack: handle duplicate base objects gracefully

There are two big changes from what has been posted already:

  1. While writing up the commit message, I realized that this can't
     ever happen for OFS_DELTA (neither the race condition, nor the
     duplicate resolution) because offsets by definition point to a
     unique entry in our object_entry array. So even if we have multipl=
e
     copies of the base object in the pack, there's only one possible
     base for an OFS_DELTA.

  2. Ren=C3=A9's original patch just does nothing for a delta which has
     already been resolved, and continues through the function to try
     any OFS_DELTA objects. If there isn't one, we return NULL to say
     "nothing left to resolve". But that's not quite true. There may
     have been other REF_DELTA against the same base, but we never
     incremented our counter to find it.

     Instead, we need to actually increment our counter and loop again
     to see if there's another REF_DELTA to handle.

-Peff
