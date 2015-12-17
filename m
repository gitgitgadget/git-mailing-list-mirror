From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mingw: emulate write(2) that fails with a EPIPE
Date: Thu, 17 Dec 2015 10:39:43 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1512171037310.6483@virtualbox>
References: <01da36219c18373f8507e19035e141d7e56b2d18.1450267413.git.johannes.schindelin@gmx.de> <xmqq7fkedyx7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 10:39:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9V2Q-0003k3-Me
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 10:39:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903AbbLQJju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 04:39:50 -0500
Received: from mout.gmx.net ([212.227.17.22]:49877 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571AbbLQJjs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 04:39:48 -0500
Received: from virtualbox ([37.24.143.114]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lxu7U-1aEzA42L2q-015LBr; Thu, 17 Dec 2015 10:39:44
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq7fkedyx7.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:cudnBedpsPIdbKrHj7rggldYXfyRGa83cSTckwg/9v71bKHZR/r
 vL05qL5XgEzD+eEqF9bZ849xFtDGSOn9rX/v0fLvUyRVWNzg75sWf7gVkc302tOcQ7BFqa3
 FUbYZPFnEfeoXO0b3Ir0izOwGOOGsV+BaxebADRb6t2ac8RndEEDZRqa0qOuuL/3iLAzi9v
 Vr0DzxTxNZidHGgLd/OFg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MNgOXbZaAy8=:y75c8r5Y9FhXh4+JprguUg
 J7VACcE9mATWkOQBRW1fDX7PI+v9yJjjmXZ+JYkalpU2wgJoZU+8oEUfjyCDTUi+u07Xoyv+z
 uY5TF2ZE91uh8PzA5x694tDtOEdIaXd0U8UkSR37hqJopDFBQVpxfdBErbwsqhBbYEEFGg+zw
 KL4rf0mQPJ0ejtaoIBxOY/tBBm6w7TiVJcDaTrF+OEF2gOzxIWkD8nmiswi6fbJNIbXAJqvSU
 AXfd3mhBiU/aDw3yZdZXXHUdBsxjtGHKCjivBFS95SzngDVU5ThQ9y4OotmFibWyEGyobDqCN
 PNaOe93GjrNwwVsglM2gHP9sTcLZj3TeYnLzHIxoHH1DuP6fCoBgAKOvWNe0VNqm/K7l/Le5Y
 BcWp9UZthT9euxf6evaGcXvZ9MFN5bKnptipzBTBcq+gAvd+0fl7k+9ZltGtQje6GXB36p45r
 CqiJHpvRKAEg71vbapNTefq2Y+XCYPoG5iYTrd/9N9kb4VRaUp4Cdj0ysqLsd9q4Qkoyu0wZC
 iCIqciGXB7tcULAh3vJZ9X5nsRATb2RK5Y0tTOoP2Ri19uCpb/KaIi+aeiMGvlb5Z+RayR/PV
 DK/8GX+Ljnnsustrpp/wRq5lxGJvVlTng91p7hs8QFxPZn9n62JP9zRtM9Q0CK8RYKausdGJv
 nc3aVShfK0Y4YiQGLU7YnmEWQ3e+WcZh/qu8q7vtarYXWkqg2G4h82PuWTfpg3d5UYVCKhw+q
 Nj/EyS1DRDvXpdIHqlvre4zTbf9qzQBFVTNTE8IYzcpvg+rYRQDOnpBFkz4E5SjTK+/z7Od/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282646>

Hi Junio,

On Wed, 16 Dec 2015, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> >  int mingw_fflush(FILE *stream);
> >  #define fflush mingw_fflush
> >  
> > +static inline ssize_t mingw_write(int fd, const void *buf, size_t len)
> > +{
> > +	ssize_t result = write(fd, buf, len);
> > +
> > +	if (result < 0 && errno == EINVAL && buf) {
> > +		/* check if fd is a pipe */
> > +		HANDLE h = (HANDLE) _get_osfhandle(fd);
> > +		if (GetFileType(h) == FILE_TYPE_PIPE)
> > +			errno = EPIPE;
> > +		else
> > +			errno = EINVAL;
> > +	}
> > +
> > +	return result;
> > +}
> > +
> > +#define write mingw_write
> > +
> 
> It strikes me a bit strange to see this inlined compared to what
> appears in the context.  Shouldn't the implementation be done in
> compat/mingw.c like all others?

My intuition (which I honestly did not verify using performance tests) was
that write() is called *much* more often than, say, open(), and therefore
I wanted to interfere as little as possible with the performance penalty.
Hence the choice of an inlined function as opposed to a non-optimizable
increment of the call chain.

If it bothers you a lot I will set aside time to perform performance
tests.

Ciao,
Dscho
