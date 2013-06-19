From: Jeff King <peff@peff.net>
Subject: Re: accessing oldest reflog entry with ref@{N}?
Date: Wed, 19 Jun 2013 15:41:16 -0400
Message-ID: <20130619194116.GB25160@sigill.intra.peff.net>
References: <20130619125059.GD20052@goldbirke>
 <7vk3lqym1q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 21:41:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpOFw-00080w-Et
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 21:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838Ab3FSTlU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Jun 2013 15:41:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:49535 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964798Ab3FSTlT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 15:41:19 -0400
Received: (qmail 32312 invoked by uid 102); 19 Jun 2013 19:42:17 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Jun 2013 14:42:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Jun 2013 15:41:16 -0400
Content-Disposition: inline
In-Reply-To: <7vk3lqym1q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228417>

On Wed, Jun 19, 2013 at 11:48:01AM -0700, Junio C Hamano wrote:

> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>=20
> > $ git log --oneline -1 master@{1}
> > fatal: Log for 'master' only has 1 entries.
> >
> > Annoyed, I just copy-pasted the sha and got the job done.
> >
> > However, I wonder why it didn't worked. 'git reflog' didn't print
> > master@{1} or any message for the oldest entry, but I can live with=
out
> > that.
>=20
> There lies your answer, no?
>=20
> Each of the log entry records "this was before, and this is after
> the change".  ref@{0} reads from the "after" field of 0-th (from the
> end) entry. ref@{1} reads from the "after" field of 1-st (again from
> the end) entry.  ref@{N} reads from the "after" field of N-th (again
> from the end) entry.
>=20
> Notice that nowhere in the above sequence we read from "before" field=
=2E

In general, the "before" from entry @{N} should be the same as the
"after" of @{N+1}. Of course this is not always the case for various
reasons, the most common of which I think are:

  1. Buggy scripts which do not provide a reflog reason for their call
     to git-update-ref, and therefore update the ref without writing a
     reflog entry.

  2. A git-gc will expire entries which point to unreachable objects
     much earlier, which can create "holes" in the reflog.

So it is certainly not correct to say "we do not have a master@{1}
entry, but we know that the 'before' entry of master@{0} must point to
the same thing". But it is very often a good guess. I wonder if there
should be some simple way to expose that value as an @{}-selector.
Perhaps "ref@{0.before}" or something?

-Peff
