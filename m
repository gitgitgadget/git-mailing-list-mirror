From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git grep: be careful to use mutices only when they are
 initialized
Date: Thu, 27 Oct 2011 11:02:51 -0700
Message-ID: <20111027180251.GE1967@sigill.intra.peff.net>
References: <alpine.DEB.1.00.1110251223500.32316@s15462909.onlinehome-server.info>
 <7v39ef34in.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 27 20:03:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJUIT-00056R-IA
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 20:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223Ab1J0SCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 14:02:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56761
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753891Ab1J0SCz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 14:02:55 -0400
Received: (qmail 3969 invoked by uid 107); 27 Oct 2011 18:08:42 -0000
Received: from c-67-169-41-183.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.41.183)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Oct 2011 14:08:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Oct 2011 11:02:51 -0700
Content-Disposition: inline
In-Reply-To: <7v39ef34in.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184310>

On Wed, Oct 26, 2011 at 01:02:40PM -0700, Junio C Hamano wrote:

>  - Could we lose "#ifndef NO_PTHREADS" inside grep_sha1(), grep_file(),
>    and possibly cmd_grep() functions and let the compiler optimize things
>    away under NO_PTHREADS compilation?

I don't think so. If NO_PTHREADS is set, we might not have pthread
functions at all. Sure, many compilers will optimize:

  if (0)
          pthread_mutex_lock(...);

to remove the call completely. But would a compiler be wrong to complain
that pthread_mutex_lock is not defined, or to include reference to it
for the linker? gcc, both with and without optimizations, will complain
about:

  echo 'int main() { if (0) does_not_exist(); return 0; }' >foo.c
  gcc -Wall -c foo.c

though it does actually remove the dead code and link properly. I
wouldn't be surprised if some other compilers don't work, though (and of
course the warning is ugly).

I think you would have to do something like this in thread-utils.h:

  #ifndef NO_PTHREADS
  #include <pthread.h>
  #else
  #define pthread_mutex_t int
  #define pthread_mutex_init(m, a) do {} while(0)
  #define pthread_mutex_lock(m) do {} while(0)
  #define pthread_mutex_unlock(m) do {} while (0)
  /* and so forth for every pthread function */
  #endif

-Peff
