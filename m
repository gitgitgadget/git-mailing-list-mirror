From: Jeff King <peff@peff.net>
Subject: Re: [BUG] resolved deltas
Date: Thu, 28 Aug 2014 18:08:21 -0400
Message-ID: <20140828220821.GA31545@peff.net>
References: <53F5D98F.4040700@redhat.com>
 <53F79CE3.60803@gmx.net>
 <53F868F8.9080000@web.de>
 <20140823105640.GA6881@peff.net>
 <20140823110459.GA13087@peff.net>
 <20140823111804.GA17335@peff.net>
 <53FB66D1.709@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>,
	Martin von Gagern <Martin.vGagern@gmx.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Fri Aug 29 00:08:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN7rr-0005lD-16
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 00:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327AbaH1WIY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Aug 2014 18:08:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:32828 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752048AbaH1WIX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 18:08:23 -0400
Received: (qmail 906 invoked by uid 102); 28 Aug 2014 22:08:23 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Aug 2014 17:08:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Aug 2014 18:08:21 -0400
Content-Disposition: inline
In-Reply-To: <53FB66D1.709@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256127>

On Mon, Aug 25, 2014 at 06:39:45PM +0200, Ren=C3=A9 Scharfe wrote:

> Thanks, that looks good.  But while preparing the patch I noticed tha=
t
> the added test sometimes fails.  Helgrind pointed outet a race
> condition.  It is not caused by the patch to turn the asserts into
> regular ifs, however -- here's a Helgrind report for the original cod=
e
> with the new test:

Interesting. I couldn't convince Helgrind to catch such a case, but it
makes sense. We split the delta-resolving work by dividing up the base
objects. We then find any deltas that need that base object (which is
read-only). If there's only one instances of the base, then we'll be th=
e
only thread working on those delta. But if there are two such bases,
they're going to look at the same deltas.

So we need some kind of mutual exclusion so that only one thread
proceeds with resolving the delta. The "real_type" check sort-of
functions in that way (except of course it is not actually thread safe)=
=2E
So one obvious option is just a coarse-grained global lock to modify or
check real_type fields. That would probably perform badly (lots of
useless lock contention on unrelated objects), but at least it would
work.

If we accept pushing a lock into _each_ object_entry, then we would get
a lot less lock contention (i.e., none at all in the common case of no
duplicates). The cost is storing one lock per object, though. Not great=
,
but probably OK.

Is there some way we can make real_type itself more atomic? I.e., use i=
t
as the mutex with the rule that we do not "claim" the object_entry as
ours to work on until we atomically set delta_obj->real_type. I think
doing a compare-and-swap looking for OBJ_REF_DELTA and replacing it wit=
h
base->real_type would be enough there (and substitute OBJ_OFS_DELTA for
the second conditional, of course).

However, I'm not sure we can portably rely on having a compare-and-swap
primitive (or that we want to go through the hassle of conditionally
using it).

-Peff
