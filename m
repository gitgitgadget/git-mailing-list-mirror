From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH 1/2] Support for setitimer() on platforms lacking it
Date: Sat, 1 Sep 2012 11:50:22 +0200
Message-ID: <003d01cd8827$34e90180$9ebb0480$@schmitz-digital.de>
References: <003301cd81e4$cd68daa0$683a8fe0$@schmitz-digital.de> <7vr4qqzsbe.fsf@alter.siamese.dyndns.org> <002201cd86ce$285841b0$7908c510$@schmitz-digital.de> <7vfw74s3oy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 11:51:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7kMb-0001xw-67
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 11:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431Ab2IAJuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 05:50:50 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:50027 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247Ab2IAJut (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 05:50:49 -0400
Received: from DualCore (dsdf-4db55bf6.pool.mediaWays.net [77.181.91.246])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0LftFf-1TwUMT453D-00pazu; Sat, 01 Sep 2012 11:50:43 +0200
In-Reply-To: 
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIhsC26HFNXVNf5LMacgAbi0X2P9gIuBdH5AgQ1j9EAzDU6SJaiUuwwgAKeBoA=
Content-Language: de
X-Provags-ID: V02:K0:NteKbmZn3u905Z7mFP+nHf1uf1QbzcEFZ6MlcLCvJ9W
 UBU/GbFndnJLZyOzrDXlD8Gget3zyy4itRr+depupXPJb7UhjZ
 iIC3UyJJ7D6XLBDd9wZxIhMx9gUzGpvGJad4dBrJ7lavVCg5vu
 Hei56XZZ2LoSBcxIMDZMRM3JPGgYk/d4RMriFZBC4yhZM3tN6z
 yzhH87/n2mjYU7u2A2CwmjEY3NNoaeaNlyQI1C5+NnHnKXqjAN
 X6HWuqZ397JwyYfGRlJeZSff8awEaDxFoXrm1W67SPV6tUsdfx
 ZUbShcx9fqBE3pPbGXodzZ0sw7ErxGCkn+/ZNiy2u1yHn/eRxo
 SUHcqOlGaj5EzrWe6w+tjn2K0LWFgNcZ7wY9S2olYNUVAK1N9c
 O9nroyBezNwcQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204623>

> From: Joachim Schmitz [mailto:jojo@schmitz-digital.de]
> Sent: Thursday, August 30, 2012 7:23 PM
> To: 'Junio C Hamano'
> Cc: 'git@vger.kernel.org'
> Subject: RE: [PATCH 1/2] Support for setitimer() on platforms lacking it
> 
> > From: Junio C Hamano [mailto:gitster@pobox.com]
> > Sent: Thursday, August 30, 2012 7:14 PM
> > To: Joachim Schmitz
> > Cc: git@vger.kernel.org
> > Subject: Re: [PATCH 1/2] Support for setitimer() on platforms lacking it
> >
> > "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> >
> > >> I see no existing code calls setitimer() with non-NULL ovalue, and I
> > >> do not think we would add a new caller that would do so in any time
> > >> soon, so it may not be a bad idea to drop support of returning the
> > >> remaining timer altogether from this emulation layer (just like
> > >> giving anything other than ITIMER_REAL gives us ENOTSUP).  That
> > >> would sidestep the whole "we cannot answer how many milliseconds are
> > >> still remaining on the timer when using emulation based on alarm()".
> > >
> > > Should we leave tv_usec untouched then? That was we round up on
> > > the next (and subsequent?) round(s). Or just set to ENOTSUP in
> > > setitimer if ovalue is !NULL?
> >
> > I was alluding to the latter.
> 
> OK, will do that then.
> 
> > >> > +	switch (which) {
> > >> > +		case ITIMER_REAL:
> > >> > +			alarm(value->it_value.tv_sec +
> > >> > +				(value->it_value.tv_usec > 0) ? 1 : 0);
> > >>
> > >> Why is this capped to 1 second?  Is this because no existing code
> > >> uses the timer for anything other than 1 second or shorter?  If that
> > >> is the case, that needs at least some documenting (or a possibly
> > >> support for longer expiration, if it is not too cumbersome to add).
> > >
> > > As you mention alarm() has only seconds resolution. It is tv_sec
> > > plus 1 if there are tv_usecs > 0, it is rounding up, so we don't
> > > cancel the alarm() if tv_sec is 0 but tv_usec is not. Looks OK to
> > > me?
> >
> > Can a caller use setitimer to be notified in 5 seconds?
> 
> Yes, by setting tv_sec to 5 and tv_usec to 0, or be setting tv_sec to 4 and tv_usec to something > 0.
> 
> Unless I screwed up the operator precedence?
> To make it clearer (any possibly correct?):
> 
> 	switch (which) {
> 		case ITIMER_REAL:
> 			alarm(value->it_value.tv_sec +
> 				((value->it_value.tv_usec > 0) ? 1 : 0));
> 
> Or even just
> 	switch (which) {
> 		case ITIMER_REAL:
> 			alarm(value->it_value.tv_sec + (value->it_value.tv_usec > 0));

OK, here it goes again, not yet as a patch, just plain code for comment:

$ cat itimer.c
/* 
 * Rely on system headers (<sys/time.h>) to contain struct itimerval
 * and git-compat-util.h to have the prototype for git_getitimer().
 * As soon as there's a platform where that is not the case, we'd need
 * an itimer .h.
 */
#include "../git-compat-util.h"

#ifndef NO_GETITIMER /* not yet needed anywhere else in git */
static
#endif
int git_getitimer(int which, struct itimerval *value)
{
	int ret = 0;

	if (!value) {
		errno = EFAULT;
		return -1;
	}

	switch (which) {
	case ITIMER_REAL:
#if 0
		value->it_value.tv_usec = 0;
		value->it_value.tv_sec = alarm(0);
		ret = 0; /* if alarm() fails, we get a SIGLIMIT */
		break;
#else
		/*
		 * As an emulation via alarm(0) won't tell us how many
		 * usecs are left, we don't support it altogether.
		 */
#endif
	case ITIMER_VIRTUAL:
	case ITIMER_PROF:
		errno = ENOTSUP;
		ret = -1;
		break;
	default:
		errno = EINVAL;
		ret = -1;
		break;
	}
	return ret;
}

int git_setitimer(int which, const struct itimerval *value,
				struct itimerval *ovalue)
{
	int ret = 0;

	if (!value ) {
		errno = EFAULT;
		return -1;
	}

	if ( value->it_value.tv_sec < 0
	    || value->it_value.tv_usec > 1000000
	    || value->it_value.tv_usec < 0) {
		errno = EINVAL;
		return -1;
	}

	if ((ovalue) && (git_getitimer(which, ovalue) == -1))
		return -1; /* errno set in git_getitimer() */

	switch (which) {
	case ITIMER_REAL:
		 /* If tv_usec is > 0, round up to next full sec */
		alarm(value->it_value.tv_sec + (value->it_value.tv_usec > 0));
		ret = 0; /* if alarm() fails, we get a SIGLIMIT */
		break;
	case ITIMER_VIRTUAL:
		case ITIMER_PROF:
		errno = ENOTSUP;
		ret = -1;
		break;
	default:
		errno = EINVAL;
		ret = -1;
		break;
	}

	return ret;
}

Would this pass muster? The previous version had a bug too, of ovalue was !NULL the switch was never reached.

Bye, Jojo
