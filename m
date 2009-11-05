From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] MSVC: Windows-native implementation for subset of Pthreads
 API
Date: Wed, 04 Nov 2009 21:10:46 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911042039200.10340@xanadu.home>
References: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
 <1257350100-29281-1-git-send-email-ahaczewski@gmail.com>
 <alpine.LFD.2.00.0911041247250.10340@xanadu.home>
 <16cee31f0911041316n20fc9f12s6595dadc813d8f46@mail.gmail.com>
 <4AF21283.3080407@gmail.com> <4AF214D5.6050202@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 03:14:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5rrT-00037K-Dg
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 03:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820AbZKECKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 21:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754427AbZKECKm
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 21:10:42 -0500
Received: from relais.videotron.ca ([24.201.245.36]:18956 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754436AbZKECKl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 21:10:41 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KSM00KUJ61YC2C0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 04 Nov 2009 21:10:46 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <4AF214D5.6050202@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132191>

On Thu, 5 Nov 2009, Andrzej K. Haczewski wrote:

> +static inline int pthread_cond_init(pthread_cond_t *cond, const void *unused)
> +{
> +	cond->waiters = 0;
> +
> +	InitializeCriticalSection(&cond->waiters_lock);
> +
> +	cond->sema = CreateSemaphore(NULL, 0, LONG_MAX, NULL);
> +	if (!cond->sema)
> +		return 0; /* POSIX do not allow pthread_cond_init to fail */
> +	return 0;
> +}

Please use die("CreateSemaphore() failed") in the failure case instead 
of returning success.

However, my pthread_cond_init man page says:

[[[
RETURN VALUE
       If successful, the pthread_cond_destroy() and pthread_cond_init() func-
       tions  shall  return zero; otherwise, an error number shall be returned
       to indicate the error.

       The [EBUSY] and [EINVAL] error checks, if implemented, shall act as  if
       they  were performed immediately at the beginning of processing for the
       function and caused an error return prior to modifying the state of the
       condition variable specified by cond.

ERRORS
       The pthread_cond_destroy() function may fail if:

       EBUSY  The implementation has detected an attempt to destroy the object
              referenced by cond while it is referenced  (for  example,  while
              being used in a pthread_cond_wait() or pthread_cond_timedwait())
              by another thread.

       EINVAL The value specified by cond is invalid.

       The pthread_cond_init() function shall fail if:

       EAGAIN The system lacked the necessary resources (other than memory) to
              initialize another condition variable.

       ENOMEM Insufficient memory exists to initialize the condition variable.

       The pthread_cond_init() function may fail if:

       EBUSY  The implementation has detected an attempt to  reinitialize  the
              object referenced by cond, a previously initialized, but not yet
              destroyed, condition variable.

       EINVAL The value specified by attr is invalid.
]]]

I'm not advocating that you implement detailed error codes as we don't 
really care about specific errors.  This is just to disagree with the 
"POSIX do not allow pthread_cond_init to fail" assertion. In any case, 
using die() to keep it simple is certainly better than blindly returning 
0 on failure.  However you could simply return ENOMEM and use the die() 
in init_threaded_search() instead.


Nicolas
