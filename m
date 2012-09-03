From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH 1/2] Support for setitimer() on platforms lacking it
Date: Mon, 3 Sep 2012 11:31:01 +0200
Message-ID: <000d01cd89b6$d5ba6c30$812f4490$@schmitz-digital.de>
References: <003301cd81e4$cd68daa0$683a8fe0$@schmitz-digital.de> <7vr4qqzsbe.fsf@alter.siamese.dyndns.org> <002201cd86ce$285841b0$7908c510$@schmitz-digital.de> <7vfw74s3oy.fsf@alter.siamese.dyndns.org> <003d01cd8827$34e90180$9ebb0480$@schmitz-digital.de> <7vpq64f935.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "'Johannes Sixt'" <j6t@kdbg.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 11:31:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8T01-0004qL-UZ
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 11:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756174Ab2ICJbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 05:31:09 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:56095 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756085Ab2ICJbH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 05:31:07 -0400
Received: from DualCore (dsdf-4db54a60.pool.mediaWays.net [77.181.74.96])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0MG40o-1TL4S02uE2-00Etoq; Mon, 03 Sep 2012 11:31:03 +0200
In-Reply-To: <7vpq64f935.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIhsC26HFNXVNf5LMacgAbi0X2P9gIuBdH5AgQ1j9EAzDU6SAHd2fuOAzRbc6SWf1JQ8A==
Content-Language: de
X-Provags-ID: V02:K0:+PvlkfS/xNECqaZTypKtsh0C5u+gtZvUQseLOcjzoqj
 SLdT0VkmAhblRo7oRIBMdrgH1iAPEcA6IWC5P1d4055hdOl0e+
 a1I+C4aSIAwi8/BqCvpsGfXfBkEXBtrAk1IUahN2jKBhbxBxPl
 VhqWcU1nQ2uRKkQReDgf48POLHHHfjVeSiAGUqTd+kIxdd/e2f
 adLj061BHo6GSmQUw2bXccygGWKL2n+CwMVVQIbSPzQfHjjdGm
 WffZH53c/8pihksXWTLXq4yNaAybFBR99ZKAv/w6iwFclU7pkd
 39IMOIbUhUptGLyCwjBaCCDMi0yypof8j8BGuf5eJ98D3cl+EY
 wTO7WkTE1aPcIdEW8P+aOneWkFcWzs3HSU8ES3xzfT0x583eQo
 rrBOHb1WNqNOw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204683>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Sunday, September 02, 2012 10:44 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org; Johannes Sixt
> Subject: Re: [PATCH 1/2] Support for setitimer() on platforms lacking it
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> >> > > Should we leave tv_usec untouched then? That was we round up on
> >> > > the next (and subsequent?) round(s). Or just set to ENOTSUP in
> >> > > setitimer if ovalue is !NULL?
> >> >
> >> > I was alluding to the latter.
> >>
> >> OK, will do that then.
> 
> Thanks.
> 
> >> Unless I screwed up the operator precedence?
> 
> I think you did, but not in the version we see below.
> 
> > int git_setitimer(int which, const struct itimerval *value,
> > 				struct itimerval *ovalue)
> > {
> > 	int ret = 0;
> >
> > 	if (!value ) {
> 
> Style: space before ')'?

Will fix.
 
> > 		errno = EFAULT;
> > 		return -1;
> 
> EFAULT is good ;-)

That's what 'man setitimer()' on Linux says to happen if invalid value is found.
 
> The emulation in mingw.c 6072fc3 (Windows: Implement setitimer() and
> sigaction()., 2007-11-13) may want to be tightened in a similar way.


Hmm, I see that there the errors are handled differently, like this:

        if (ovalue != NULL)
                return errno = EINVAL,
                        error("setitimer param 3 != NULL not implemented");

Should this be done in my setitimer() too? Or rather be left to the caller?
I tend to the later.

> > 	}
> >
> > 	if ( value->it_value.tv_sec < 0
> 
> Style: space after ')'?

After '(', I guess? Will fix.
 
> > 	    || value->it_value.tv_usec > 1000000
> > 	    || value->it_value.tv_usec < 0) {
> > 		errno = EINVAL;
> > 		return -1;
> > 	}
> >
> > 	if ((ovalue) && (git_getitimer(which, ovalue) == -1))
> > 		return -1; /* errno set in git_getitimer() */
> 
> As nobody passes non-NULL ovalue to setitimer(), I think we should
> instead get rid of git_getitmier() implemenation, and change this to

True.
 
> 	if (ovalue) {
>         	errno = ENOTSUP;
>                 return -1;
> 	}
>
> which is how I understood what "the latter" in the paragraph I
> quoted from you above meant.

OK, will do this and then I'll rename the entire file into getitimer.c.
 
> > 	switch (which) {
> > 	case ITIMER_REAL:
> > 		 /* If tv_usec is > 0, round up to next full sec */
> > 		alarm(value->it_value.tv_sec + (value->it_value.tv_usec > 0));
> 
> OK.
> 
> > 		ret = 0; /* if alarm() fails, we get a SIGLIMIT */
> > 		break;
> > 	case ITIMER_VIRTUAL:
> > 		case ITIMER_PROF:
> > 		errno = ENOTSUP;
> > 		ret = -1;
> > 		break;
> > 	default:
> > 		errno = EINVAL;
> > 		ret = -1;
> > 		break;
> > 	}
> >
> > 	return ret;
> > }
> 
> Other than that, looks good.
> 
> Thanks.

I had a closer look at the places in git where setitimer() is used. It is in 2 files, progress.c and builtin/log.c.
In progress.c :
static void set_progress_signal(void)
{
        struct sigaction sa;
        struct itimerval v;

        progress_update = 0;

        memset(&sa, 0, sizeof(sa));
        sa.sa_handler = progress_interval;
        sigemptyset(&sa.sa_mask);
        sa.sa_flags = SA_RESTART;
        sigaction(SIGALRM, &sa, NULL);

        v.it_interval.tv_sec = 1;
        v.it_interval.tv_usec = 0;
        v.it_value = v.it_interval;
        setitimer(ITIMER_REAL, &v, NULL);
}

static void clear_progress_signal(void)
{
        struct itimerval v = {{0,},};
        setitimer(ITIMER_REAL, &v, NULL);
        signal(SIGALRM, SIG_IGN);
        progress_update = 0;
}

So it uses a 1 sec timeout, which is a good match to my implementation, but also uses it_interval, meant to 're-arm' the timer after
it expired.
My implementation doesn't do that at all, and I also don't see how it possibly could (short of installing a signal handler, which
then conflicts with the one use in progress.c).
On top here SA_RESTART is used, which is not available in HP NonStop (so I have a "-DSA_RESTART=0" in COMPAT_CFLAGS).

In builtin/log.c it doesn't use it_interval, which is a good match to my implementation, but uses 1/2 a sec and 1/10 sec, so here
would be a victim of a 1 sec upgrade. This is probably acceptable.
...
         * NOTE! We don't use "it_interval", because if the
         * reader isn't listening, we want our output to be
         * throttled by the writing, and not have the timer
         * trigger every second even if we're blocked on a
         * reader!
         */
        early_output_timer.it_value.tv_sec = 0;
        early_output_timer.it_value.tv_usec = 500000;
        setitimer(ITIMER_REAL, &early_output_timer, NULL);
...
static void setup_early_output(struct rev_info *rev)
{
        struct sigaction sa;

        /*
         * Set up the signal handler, minimally intrusively:
         * we only set a single volatile integer word (not
         * using sigatomic_t - trying to avoid unnecessary
         * system dependencies and headers), and using
         * SA_RESTART.
         */
        memset(&sa, 0, sizeof(sa));
        sa.sa_handler = early_output;
        sigemptyset(&sa.sa_mask);
        sa.sa_flags = SA_RESTART;
        sigaction(SIGALRM, &sa, NULL);

        /*
         * If we can get the whole output in less than a
         * tenth of a second, don't even bother doing the
         * early-output thing..
         *
         * This is a one-time-only trigger.
         */
        early_output_timer.it_value.tv_sec = 0;
        early_output_timer.it_value.tv_usec = 100000;
        setitimer(ITIMER_REAL, &early_output_timer, NULL);
}

static void finish_early_output(struct rev_info *rev)
{
        int n = estimate_commit_count(rev, rev->commits);
        signal(SIGALRM, SIG_IGN);
        show_early_header(rev, "done", n);
}

This means, however, at least to my understanding, that my setitimer() basically degrades to an 'alarm(1);' resp. 'alarm(0);', so
could possibly be simplified to:

#ifdef NO_SETITIMER /* poor man's setitimer() */
#define setitimer(w,v,o) alarm((v)->it_value.tv_sec+((v)->it_value.tv_usec>0))
#endif

in e.g. git-compat-util.h

Opinions?

Bye, Jojo
