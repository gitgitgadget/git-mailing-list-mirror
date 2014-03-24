From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] log: do not segfault on gmtime errors
Date: Mon, 24 Mar 2014 17:33:43 -0400
Message-ID: <20140324213342.GE13728@sigill.intra.peff.net>
References: <20140224073348.GA20221@sigill.intra.peff.net>
 <20140224074905.GE9969@sigill.intra.peff.net>
 <532D58B5.1080309@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 22:33:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSCVC-0005jY-JF
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 22:33:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbaCXVdq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2014 17:33:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:46092 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751035AbaCXVdo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 17:33:44 -0400
Received: (qmail 8769 invoked by uid 102); 24 Mar 2014 21:33:44 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Mar 2014 16:33:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Mar 2014 17:33:43 -0400
Content-Disposition: inline
In-Reply-To: <532D58B5.1080309@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244876>

On Sat, Mar 22, 2014 at 10:32:37AM +0100, Ren=C3=A9 Scharfe wrote:

> >This test is of questionable portability, since we are depending on
> >gmtime's arbitrary point to decide that our input is crazy and retur=
n
> >NULL. The value is sufficiently large that I'd expect most to do so,
> >though, so it may be safe.
>=20
> Just came around to testing on FreeBSD 10 amd64; the new test in t421=
2 fails
> there:

Thanks for the report. I don't think the problem is in the test here,
but rather that we should do a more thorough job of detecting gmtime's
"I don't know what to do with this" response.

> >@@ -184,8 +184,10 @@ const char *show_date(unsigned long time, int t=
z, enum date_mode mode)
> >  		tz =3D local_tzoffset(time);
> >
> >  	tm =3D time_to_tm(time, tz);
> >-	if (!tm)
> >-		return NULL;
> >+	if (!tm) {
>=20
> Would it make sense to work around the FreeBSD issue by adding a chec=
k like
> this?
>=20
> 	if (!tm || tm->tm_year < 70) {

That feels like a bit of a maintenance headache.  Right now we do not
internally represent times prior to the epoch, since we mostly use
"unsigned long" through the code. So anything < 70 has to be an error.
But it would be nice one day to consistently use a 64-bit signed time_t
throughout git, and represent even ancient timestamps (e.g., for people
doing historical projects, like importing laws into git). This would se=
t
quite a trap for people working later on the code.

If the result is all-zeroes, can we check for that case instead? I
suppose that will eventually create a "trap" at midnight on January 1st
of the year 0 (though I am not sure such a date is even meaningful,
given the history of our calendars).

-Peff
