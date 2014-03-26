From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] log: do not segfault on gmtime errors
Date: Wed, 26 Mar 2014 14:21:03 -0400
Message-ID: <20140326182103.GB7087@sigill.intra.peff.net>
References: <20140224073348.GA20221@sigill.intra.peff.net>
 <20140224074905.GE9969@sigill.intra.peff.net>
 <20140326110559.GA32625@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Charles Bailey <cbailey32@bloomberg.net>
X-From: git-owner@vger.kernel.org Wed Mar 26 19:21:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSsRr-00089E-7N
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 19:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754369AbaCZSVG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 14:21:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:47725 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751580AbaCZSVF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 14:21:05 -0400
Received: (qmail 14653 invoked by uid 102); 26 Mar 2014 18:21:05 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Mar 2014 13:21:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Mar 2014 14:21:03 -0400
Content-Disposition: inline
In-Reply-To: <20140326110559.GA32625@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245202>

On Wed, Mar 26, 2014 at 11:05:59AM +0000, Charles Bailey wrote:

> On Mon, Feb 24, 2014 at 02:49:05AM -0500, Jeff King wrote:
> > +# date is within 2^63-1, but enough to choke glibc's gmtime
> > +test_expect_success 'absurdly far-in-future dates produce sentinel=
' '
> > +	commit=3D$(munge_author_date HEAD 999999999999999999) &&
> > +	echo "Thu Jan 1 00:00:00 1970 +0000" >expect &&
> > +	git log -1 --format=3D%ad $commit >actual &&
> > +	test_cmp expect actual
> > +'
>=20
> Git on AIX seems happy to convert this to Thu Oct 24 18:46:39
> 162396404 -0700. I don't know if this is correct for the given input
> but the test fails.

Ick. I am not sure that dates at that range are even meaningful (will
October really exist in the year 162396404? Did they account for all th=
e
leap-seconds between then and now?). But at the same time, I cannot
fault their gmtime for just extrapolating the current rules out as far
as we ask them to.

Unlike the FreeBSD thing that Ren=C3=A9 brought up, this is not a probl=
em in
the code, but just in the test. So I think our options are basically:

  1. Scrap the test as unportable.

  2. Hard-code a few expected values. I'd be unsurprised if some other
     system comes up with a slightly different date in 162396404, so we
     may end up needing several of these.

I think I'd lean towards (2), just because it is testing an actual
feature of the code, and I'd like to continue doing so. And while we ma=
y
end up with a handful of values, there's probably not _that_ many
independent implementations of gmtime in the wild.

-Peff
