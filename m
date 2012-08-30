From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH 1/2] Support for setitimer() on platforms lacking it
Date: Thu, 30 Aug 2012 19:22:48 +0200
Message-ID: <003101cd86d4$14b494a0$3e1dbde0$@schmitz-digital.de>
References: <003301cd81e4$cd68daa0$683a8fe0$@schmitz-digital.de> <7vr4qqzsbe.fsf@alter.siamese.dyndns.org> <002201cd86ce$285841b0$7908c510$@schmitz-digital.de> <7vfw74s3oy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 19:23:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T78Sd-0005WJ-Eq
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 19:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244Ab2H3RXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 13:23:12 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:55578 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876Ab2H3RXK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 13:23:10 -0400
Received: from DualCore (dsdf-4db50202.pool.mediaWays.net [77.181.2.2])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MdWxQ-1TH8K01KCi-00Px6K; Thu, 30 Aug 2012 19:23:08 +0200
In-Reply-To: <7vfw74s3oy.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIhsC26HFNXVNf5LMacgAbi0X2P9gIuBdH5AgQ1j9EAzDU6SJaiUuww
Content-Language: de
X-Provags-ID: V02:K0:duNOULzvHNaE0hR5WeMHB4MHfqVWIOoEwlqNd5rLqaj
 0k3uF99y+R5xcL0FirU6fgLQX6JKx8V5BCcez50LIxdt5/OOj8
 ewQqPDU0n0bx4v598Ikhhmewbz4NsHsUgYAMCvDO6vrRRkWPjA
 sTTs1KuavgTDeVavCZZu2Ee0HVMrBUJQqbhgDOlmixhwBNezex
 Vbf5rPt/IRS6nT9ddlkM/yePZbR/sS40AkgmM4GWYlrjUt6Akr
 Gnq/XRSTGVhBpZHzRXWNaXnGp4t9BOtiXdM/cX3rHrWuDmthY3
 EEXukbmVkwIEk+1IdeUOLVfrDwj0YBSi85atY9E0oKeiLXRhKs
 AkgdpfoS+BEygjG3xbRUhz+Ej7N93iQxdFBjCkAYGo72kFCaHk
 fKm7Jq4yMP6og==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204551>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Thursday, August 30, 2012 7:14 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH 1/2] Support for setitimer() on platforms lacking it
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> >> I see no existing code calls setitimer() with non-NULL ovalue, and I
> >> do not think we would add a new caller that would do so in any time
> >> soon, so it may not be a bad idea to drop support of returning the
> >> remaining timer altogether from this emulation layer (just like
> >> giving anything other than ITIMER_REAL gives us ENOTSUP).  That
> >> would sidestep the whole "we cannot answer how many milliseconds are
> >> still remaining on the timer when using emulation based on alarm()".
> >
> > Should we leave tv_usec untouched then? That was we round up on
> > the next (and subsequent?) round(s). Or just set to ENOTSUP in
> > setitimer if ovalue is !NULL?
> 
> I was alluding to the latter.

OK, will do that then.

> >> > +	switch (which) {
> >> > +		case ITIMER_REAL:
> >> > +			alarm(value->it_value.tv_sec +
> >> > +				(value->it_value.tv_usec > 0) ? 1 : 0);
> >>
> >> Why is this capped to 1 second?  Is this because no existing code
> >> uses the timer for anything other than 1 second or shorter?  If that
> >> is the case, that needs at least some documenting (or a possibly
> >> support for longer expiration, if it is not too cumbersome to add).
> >
> > As you mention alarm() has only seconds resolution. It is tv_sec
> > plus 1 if there are tv_usecs > 0, it is rounding up, so we don't
> > cancel the alarm() if tv_sec is 0 but tv_usec is not. Looks OK to
> > me?
> 
> Can a caller use setitimer to be notified in 5 seconds?

Yes, by setting tv_sec to 5 and tv_usec to 0, or be setting tv_sec to 4 and tv_usec to something > 0.

Unless I screwed up the operator precedence?
To make it clearer (any possibly correct?):

	switch (which) {
		case ITIMER_REAL:
			alarm(value->it_value.tv_sec +
				((value->it_value.tv_usec > 0) ? 1 : 0));

Or even just
	switch (which) {
		case ITIMER_REAL:
			alarm(value->it_value.tv_sec + (value->it_value.tv_usec > 0));
