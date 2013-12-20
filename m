From: Jeff King <peff@peff.net>
Subject: Re: RLIMIT_NOFILE fallback
Date: Fri, 20 Dec 2013 04:12:33 -0500
Message-ID: <20131220091232.GA9637@sigill.intra.peff.net>
References: <xmqqy53ihwe4.fsf@gitster.dls.corp.google.com>
 <20131218191702.GA9083@sigill.intra.peff.net>
 <xmqq61qmhrb3.fsf@gitster.dls.corp.google.com>
 <20131218212847.GA13685@sigill.intra.peff.net>
 <xmqqd2kthmcr.fsf@gitster.dls.corp.google.com>
 <20131218214001.GA14354@sigill.intra.peff.net>
 <xmqqzjnxg3zz.fsf@gitster.dls.corp.google.com>
 <20131219001519.GB17420@sigill.intra.peff.net>
 <52B32D18.80400@web.de>
 <xmqqmwjwg2ok.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 20 10:12:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vtw8a-0000OL-T9
	for gcvg-git-2@plane.gmane.org; Fri, 20 Dec 2013 10:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755358Ab3LTJMr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Dec 2013 04:12:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:47787 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755022Ab3LTJMf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Dec 2013 04:12:35 -0500
Received: (qmail 12944 invoked by uid 102); 20 Dec 2013 09:12:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 20 Dec 2013 03:12:35 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Dec 2013 04:12:33 -0500
Content-Disposition: inline
In-Reply-To: <xmqqmwjwg2ok.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239566>

On Thu, Dec 19, 2013 at 09:39:55AM -0800, Junio C Hamano wrote:

> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
> > Thanks for an interesting reading,
> > please allow a side question:
> > Could it be, that "-1 =3D=3D unlimited" is Linux specific?
> > And therefore not 100% portable ?
> >
> > And doesn't "unlimited" number of files call for trouble,
> > having the risk to starve the machine ?
> >
> > BTW: cygwin returns 256.
>=20
> If you look at the caller, you will see that we do cap the value
> returned from this helper function down to a more reasonable and not
> so selfish maximum, exactly for the purpose of avoiding the risk of
> starving other processes.

I am not sure you are reading the capping in the right direction. We do
not cap at 25, but rather keep 25 open for "other stuff". So at
unlimited, we are consuming a mere UINT_MAX-25 descriptors. :)

I think that 25 is not for the benefit of the rest of the system, but
rather for _us_ to avoid running out of descriptors for normal
operations. I do not think we need to be careful about starving other
processes at all. That is the job of the ulimit in the first place, and
we respect it. If the sysadmin turns off the limit, then we are just
following their instructions.

In practice, I'd be shocked if git behaved reasonably above about 500
packs anyway, so that puts a practical cap on our fd use. :)

None of that impacts the patch under discussion, though. The only thing
I was trying to bring up earlier is that on a system with:

  1. No (or broken) getrlimit

  2. No OPEN_MAX defined

  3. sysconf that works, and returns -1 for unlimited

  4. a sysadmin who has set the descriptor limit to "unlimited"

We will end up at "1". Which is not great, but I am skeptical that a
system matching the above 4 constraints actually exists. So I think the
patch is fine in practice.

-Peff
