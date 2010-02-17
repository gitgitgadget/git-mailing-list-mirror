From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fix threaded grep for machines with only one cpu
Date: Wed, 17 Feb 2010 02:01:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002170200370.20986@pacific.mpi-cbg.de>
References: <20100215225001.GA944@book.hvoigt.net> <7vwryet2cw.fsf@alter.siamese.dyndns.org> <7vocjpnc5v.fsf@alter.siamese.dyndns.org> <7vljetlx8r.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1002160914140.20986@pacific.mpi-cbg.de>
 <7viq9wzq8g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 01:54:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhYBU-0000ug-Bw
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 01:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933663Ab0BQAy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 19:54:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:34150 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933541Ab0BQAyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 19:54:25 -0500
Received: (qmail invoked by alias); 17 Feb 2010 00:54:23 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 17 Feb 2010 01:54:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+g46pCam6ga5OlCI6E9qxrzQipcyUpd2N55D4+LS
	hApa8gV6r52L67
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7viq9wzq8g.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53000000000000003
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140193>

Hi,

On Tue, 16 Feb 2010, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> diff --git a/builtin-grep.c b/builtin-grep.c
> >> index 26d4deb..5c1545e 100644
> >> --- a/builtin-grep.c
> >> +++ b/builtin-grep.c
> >> @@ -81,8 +81,8 @@ static pthread_mutex_t read_sha1_mutex;
> >>  
> >>  #define grep_lock() pthread_mutex_lock(&grep_mutex)
> >>  #define grep_unlock() pthread_mutex_unlock(&grep_mutex)
> >> -#define read_sha1_lock() pthread_mutex_lock(&read_sha1_mutex)
> >> -#define read_sha1_unlock() pthread_mutex_unlock(&read_sha1_mutex)
> >> +#define read_sha1_lock() do { if (use_threads) pthread_mutex_lock(&read_sha1_mutex); } while (0)
> >> +#define read_sha1_unlock() do { if (use_threads) pthread_mutex_unlock(&read_sha1_mutex); } while (0)
> >
> > This is inconsistent. Just look at the code above and tell me why it is so 
> > different.
> 
> It is because grep_mutex is protected by "use_threads" very high in the
> callchain and do not need nor want extra if().
> 
> But I think this is much cleaner.  The patch replaces the one you are
> replying to (i.e. read_sha1_{lock,unlock}() are unconditional).
> 
> -- >8 --
> Subject: Fix use of mutex in threaded grep
> 
> The program can decide at runtime not to use threading even if the support
> is compiled in.  In such a case, mutexes are not necessary and left
> uninitialized.  But the code incorrectly tried to take and release the
> read_sha1_mutex unconditionally.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Acked-by: Fredrik Kuivinen <frekui@gmail.com>
> ---

Yes, this one looks much, much nicer.

Ciao,
Dscho
