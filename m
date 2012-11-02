From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Oct 2012, #09; Mon, 29)
Date: Fri, 2 Nov 2012 05:43:00 -0400
Message-ID: <20121102094259.GA28414@sigill.intra.peff.net>
References: <20121029102114.GA14497@sigill.intra.peff.net>
 <5092C234.9000307@ramsay1.demon.co.uk>
 <CAEUsAPb7hUViLn7V7v65r6mOqRHr+180ynRX8K9t3nuJVyePfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 10:43:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUDmd-0005xo-Ho
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 10:43:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760469Ab2KBJnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 05:43:09 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54193 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760435Ab2KBJnG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 05:43:06 -0400
Received: (qmail 2146 invoked by uid 107); 2 Nov 2012 09:43:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Nov 2012 05:43:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2012 05:43:00 -0400
Content-Disposition: inline
In-Reply-To: <CAEUsAPb7hUViLn7V7v65r6mOqRHr+180ynRX8K9t3nuJVyePfg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208914>

On Thu, Nov 01, 2012 at 08:12:20PM -0500, Chris Rorvick wrote:

> > Just FYI, t9604-cvsimport-timestamps.sh is still failing for me.
> >
> > I haven't spent too long on this yet, but I had hoped that setting
> > TZ would sidestep any DST issues. (I have downloaded new tzdata, but
> > have yet to install - actually I don't really want to!). It is not
> > clear from the tzset manpage what happens if you use the DST format
> > for TZ, but you don't provide the start/end date for DST, which is
> > what this test is doing.
> >
> > Perhaps the test should use the non-DST format? e.g. "TZ=CST6 git ..."
> > Does the test really care about DST? (*if* that is indeed the problem).
> 
> It actually looks like your TZ database is fine and the problem is
> with the conversion to a struct tm.  In each case, the time is
> localized to the previous TZ value while the offset for the current TZ
> value.  For example, look at the first commit in the first test.  It
> converted the timestamp to 18:00 (CST6) while all the rest came
> through as expected.    I suspect the previous version of cvsimport
> would exhibit similar behavior with the first imported commit.  What
> is your platform?

Yeah, I think that is it. IIRC, Ramsay is on cygwin, and I noticed this
in perl 5.16's POSIX.xs:

  #ifdef WIN32

  /*
   * (1) The CRT maintains its own copy of the environment, separate from
   * the Win32API copy.
   *
   * (2) CRT getenv() retrieves from this copy. CRT putenv() updates this
   * copy, and then calls SetEnvironmentVariableA() to update the Win32API
   * copy.
   *
   * (3) win32_getenv() and win32_putenv() call GetEnvironmentVariableA() and
   * SetEnvironmentVariableA() directly, bypassing the CRT copy of the
   * environment.
   *
   * (4) The CRT strftime() "%Z" implementation calls __tzset(). That
   * calls CRT tzset(), but only the first time it is called, and in turn
   * that uses CRT getenv("TZ") to retrieve the timezone info from the CRT
   * local copy of the environment and hence gets the original setting as
   * perl never updates the CRT copy when assigning to $ENV{TZ}.
   *
   * Therefore, we need to retrieve the value of $ENV{TZ} and call CRT
   * putenv() to update the CRT copy of the environment (if it is different)
   * whenever we're about to call tzset().
   [...]

I wonder if Ramsay has an older perl that does not do this special
hackery right. I'll see if I can dig up where it first appeared.

-Peff
