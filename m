From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH 1/2] Support for setitimer() on platforms lacking it
Date: Mon, 3 Sep 2012 22:05:06 +0200
Message-ID: <003601cd8a0f$6a792840$3f6b78c0$@schmitz-digital.de>
References: <003301cd81e4$cd68daa0$683a8fe0$@schmitz-digital.de> <7vr4qqzsbe.fsf@alter.siamese.dyndns.org> <002201cd86ce$285841b0$7908c510$@schmitz-digital.de> <7vfw74s3oy.fsf@alter.siamese.dyndns.org> <003d01cd8827$34e90180$9ebb0480$@schmitz-digital.de> <7vpq64f935.fsf@alter.siamese.dyndns.org> <000d01cd89b6$d5ba6c30$812f4490$@schmitz-digital.de> <7v1uijexor.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "'Johannes Sixt'" <j6t@kdbg.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 22:05:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8ctd-0004dn-7T
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 22:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756519Ab2ICUFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 16:05:12 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:57154 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756395Ab2ICUFL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 16:05:11 -0400
Received: from DualCore (dsdf-4db54a60.pool.mediaWays.net [77.181.74.96])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MNQCL-1TExTw2AnZ-006cpX; Mon, 03 Sep 2012 22:05:09 +0200
In-Reply-To: <7v1uijexor.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIhsC26HFNXVNf5LMacgAbi0X2P9gIuBdH5AgQ1j9EAzDU6SAHd2fuOAzRbc6QCZvCE2AIPCL7WllyFsqA=
Content-Language: de
X-Provags-ID: V02:K0:x7ouT8sr8EUcfim3/yzWFTaRNrai+UrAKhIiD5jGlUM
 Ox5PLQOx2z6PUakCJttOFVBXSuSyoHDU9t6HBXaEWk+z7dVLCX
 YIUEHysXSGVSbJLgnh4bqgrilQye20baLxYwkxCDWd43Dbs0eo
 Dnf7fuyg8QzJpRMPNnhlUSNTLuoEdgfDUbt7FpR9EfgnTNwL1K
 We6/jCB2RY1EtSInRC/dLybEwT5DMcWFxYMVn+MsPwQz0Wkidd
 56kUeZjAJvCzI2ljqx6tBaUBPGPVCMlhhIWoYJBRPQO2KdcZD0
 jUKistN8jXJkTmxbH9S4C/bKvxbmsq/dFpY4Yia0ST6eta26HL
 ImvihRcy8l75WbvMTKaIni7KKMRF2N0uYRQtu36m3CmgDogEO0
 SY6UixrFTqKKA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204709>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Monday, September 03, 2012 9:03 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org; 'Johannes Sixt'
> Subject: Re: [PATCH 1/2] Support for setitimer() on platforms lacking it
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> >> > 	if (!value ) {
> >>
> >> Style: space before ')'?
> >
> > Will fix.
> >
> >> > 		errno = EFAULT;
> >> > 		return -1;
> >>
> >> EFAULT is good ;-)
> >
> > That's what 'man setitimer()' on Linux says to happen if invalid value is found.
> >
> >> The emulation in mingw.c 6072fc3 (Windows: Implement setitimer() and
> >> sigaction()., 2007-11-13) may want to be tightened in a similar way.
> >
> 
> > Hmm, I see that there the errors are handled differently, like this:
> >
> >         if (ovalue != NULL)
> >                 return errno = EINVAL,
> >                         error("setitimer param 3 != NULL not implemented");
> >
> > Should this be done in my setitimer() too? Or rather be left to the caller?
> > I tend to the later.
> 
> I don't care too deeply either way.  The above was not a comment
> meant for you, but was to point out the error checking when the
> newvalue is NULL---it is missing in mingw.c and I think the
> condition should be checked.

 Ah, OK. Guess Johannes and I misunderstood ;-)

> > On top here SA_RESTART is used, which is not available in HP
> > NonStop (so I have a "-DSA_RESTART=0" in COMPAT_CFLAGS).
> 
> If you cannot re-trigger the timer, then you will see "20%" shown
> after one second, silence for 4 seconds and then "done", for an
> operation that takes 5 seconds.  Which is not the end of the world,
> though.  It does not affect correctness.

That does seem to work, if I do e.g. a "git clone" on git itself (being a fairly large repository), I see it updating the % values
about once per second.

> The other use of itimer in our codebase is the early-output timer,
> but that also is about perceived latency, and not about correctness,
> so it is possible that you do not have to support anything (i.e. not
> even setting an alarm) at all.

OK, I'll go for that one-liner in git-compat-utils.h then

#ifdef NO_SETITIMER /* poor man's setitimer() */
#define setitimer(w,v,o) alarm((v)->it_value.tv_sec+((v)->it_value.tv_usec>0))
#endif

It certainly seems to work just fine for me.
Could as well be #ifdef __TANDEM, I won't mind.

Bye, Jojo
