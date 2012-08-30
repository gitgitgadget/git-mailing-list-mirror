From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH 1/2] Support for setitimer() on platforms lacking it
Date: Thu, 30 Aug 2012 18:40:25 +0200
Message-ID: <002201cd86ce$285841b0$7908c510$@schmitz-digital.de>
References: <003301cd81e4$cd68daa0$683a8fe0$@schmitz-digital.de> <7vr4qqzsbe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 18:41:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T77nc-0004mw-CR
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 18:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754307Ab2H3Qkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 12:40:49 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:57645 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058Ab2H3Qks (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 12:40:48 -0400
Received: from DualCore (dsdf-4db50202.pool.mediaWays.net [77.181.2.2])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0LfSYr-1TQXFl2cTh-00p3df; Thu, 30 Aug 2012 18:40:44 +0200
In-Reply-To: <7vr4qqzsbe.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIhsC26HFNXVNf5LMacgAbi0X2P9gIuBdH5lrjK11A=
Content-Language: de
X-Provags-ID: V02:K0:XesN8qZi+zt17/K3i//ftea5BMXxOW4VZF2wc88sqcd
 KlJMj2fDKffZCQAF7J4vCQMN79HsSOKt12j17GCe/2j79mmKzH
 e4pg9GRn8qtZcwv/DsWpLkPL6nDgCVakSGY4MQCoglaHQboAau
 pXp5I4+cvIY57q/Rrot9LzkokeTlFETa4nmR1G/BOB6lxIOiAD
 MVgobS5wrX/1p1SUZNBFdSjLsQHACwYrJ1WLe2ELD2q9rj0HHa
 Fb5RUd+KHS5uEMBQkqUYtavFI3+TbQbQGgxYeCGe6VIdmTnwB6
 M8NN1+s6zPGBtKX9YQO0lz0eq5N9HinGem9OslO4B+eWDdFslj
 isfWPvx5HCmMhind8iBEm+5wleXD0tSd83DAgN271+3aIFtj9T
 QHN34UMyn7DDQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204548>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Tuesday, August 28, 2012 10:16 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH 1/2] Support for setitimer() on platforms lacking it
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> > Implementation includes getitimer(), but for now it is static.
> > Supports ITIMER_REAL only.
> >
> > Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
> > ---
> > May need a header file for ITIMER_*, struct itimerval and the prototypes,
> > But for now, and the HP NonStop platform this isn't needed, here
> > <sys/time> has ITIMER_* and struct timeval, and the prototypes can
> > vo into git-compat-util.h for now (Patch 2/2)
> >
> >  compat/itimer.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >  create mode 100644 compat/itimer.c
> >
> > diff --git a/compat/itimer.c b/compat/itimer.c
> > new file mode 100644
> > index 0000000..713f1ff
> > --- /dev/null
> > +++ b/compat/itimer.c
> > @@ -0,0 +1,50 @@
> > +#include "../git-compat-util.h"
> > +
> > +static int git_getitimer(int which, struct itimerval *value)
> > +{
> > +	int ret = 0;
> > +
> > +	switch (which) {
> > +		case ITIMER_REAL:
> > +			value->it_value.tv_usec = 0;
> > +			value->it_value.tv_sec = alarm(0);
> > +			ret = 0; /* if alarm() fails, we get a SIGLIMIT */
> > +			break;
> > +		case ITIMER_VIRTUAL: /* FALLTHRU */
> > +		case ITIMER_PROF: errno = ENOTSUP; ret = -1; break;
> > +		default: errno = EINVAL; ret = -1;
> > +	}
> 
> Just a style thing, but we align case arms and switch statements,
> like this:
> 
> 	switch (which) {
>         case ...:
>         	stmt;
>                 break;
> 	default:
>         	stmt;
>                 break;
> 	}

OK, I'll fix the syle

> Because alarm() runs in integral seconds granularity, this could
> return 0.0 sec (i.e. "do not re-trigger this alarm any more") in
> ovalue after setting alarm(1) (via git_setitimer()) and calling this
> function (via git_setitimer() again) before the timer expires, no?
> Is it a desired behaviour?

Unintentional, never really thought about this.
 
> What I am most worried about is that callers _might_ take this
> emulation too seriously, grab the remainder from getitimer(), and
> drives a future call to getitimer() with the returned value, and
> accidentally cause the "recurring" nature of the request to be
> disabled.
> 
> I see no existing code calls setitimer() with non-NULL ovalue, and I
> do not think we would add a new caller that would do so in any time
> soon, so it may not be a bad idea to drop support of returning the
> remaining timer altogether from this emulation layer (just like
> giving anything other than ITIMER_REAL gives us ENOTSUP).  That
> would sidestep the whole "we cannot answer how many milliseconds are
> still remaining on the timer when using emulation based on alarm()".

Should we leave tv_usec untouched then? That was we round up on the next (and subsequent?) round(s). Or just set to ENOTSUP in
setitimer if ovalue is !NULL?

> > +int git_setitimer(int which, const struct itimerval *value,
> > +				struct itimerval *ovalue)
> > +{
> > +	int ret = 0;
> > +
> > +	if (!value
> > +		|| value->it_value.tv_usec < 0
> > +		|| value->it_value.tv_usec > 1000000
> > +		|| value->it_value.tv_sec < 0) {
> > +		errno = EINVAL;
> > +		return -1;
> > +	}
> > +
> > +	else if (ovalue)
> > +		if (!git_getitimer(which, ovalue))
> > +			return -1; /* errno set in git_getitimer() */
> > +
> > +	else
> > +	switch (which) {
> > +		case ITIMER_REAL:
> > +			alarm(value->it_value.tv_sec +
> > +				(value->it_value.tv_usec > 0) ? 1 : 0);
> 
> Why is this capped to 1 second?  Is this because no existing code
> uses the timer for anything other than 1 second or shorter?  If that
> is the case, that needs at least some documenting (or a possibly
> support for longer expiration, if it is not too cumbersome to add).

As you mention alarm() has only seconds resolution. It is tv_sec plus 1 if there are tv_usecs > 0, it is rounding up, so we don't
cancel the alarm() if tv_sec is 0 but tv_usec is not. Looks OK to me?
 
> > +			ret = 0; /* if alarm() fails, we get a SIGLIMIT */
> > +			break;
> > +		case ITIMER_VIRTUAL: /* FALLTHRU */
> > +		case ITIMER_PROF: errno = ENOTSUP; ret = -1; break;
> 
> Please don't add a misleading "fallthru" label here.  We do not say
> "fallthru" when "two case arms do _exactly_ the same thing".  Only
> when the one arm does some pre-action before the common action, i.e.
> 
> 	switch (which) {
>         case one:
>         	do some thing specific to one;
>                 /* fallthru */
> 	case two:
> 		do some thing common between one and two;
> 		break;
> 	}
> 
> we label it "fallthru" to make it clear to the readers that it is
> not "missing a break" but is deliberate.

I'll fix those too.

> > +		default: errno = EINVAL; ret = -1;
> > +	}
> > +
> > +	return ret;
> > +}
> 
> Thanks.

Bye, Jojo
