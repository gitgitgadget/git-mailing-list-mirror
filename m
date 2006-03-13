From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Use explicit pointers for execl...() sentinels.
Date: Sun, 12 Mar 2006 22:31:21 -0500
Message-ID: <20060313033121.GA14601@coredump.intra.peff.net>
References: <20060311192954.GQ16135@artsapartment.org> <slrne17urp.fr9.mdw@metalzone.distorted.org.uk> <7v7j6zgaxx.fsf@assigned-by-dhcp.cox.net> <slrne18aae.fr9.mdw@metalzone.distorted.org.uk> <20060312171316.39d138f8.tihirvon@gmail.com> <slrne18mq3.fr9.mdw@metalzone.distorted.org.uk> <20060312200812.3fb04638.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Mar 13 04:34:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIdmR-0000dg-AE
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 04:31:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWCMDbY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 22:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWCMDbY
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 22:31:24 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:23289 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S1750712AbWCMDbY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Mar 2006 22:31:24 -0500
Received: (qmail 74325 invoked from network); 13 Mar 2006 03:31:21 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 13 Mar 2006 03:31:21 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Mar 2006 22:31:21 -0500
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060312200812.3fb04638.tihirvon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17540>

On Sun, Mar 12, 2006 at 08:08:12PM +0200, Timo Hirvonen wrote:

> NULL pointer does not point to any data, it just says it's 'empty'.  So
> it doesn't need to be same type pointer as specified in the function
> prototype.  Pointers are just addresses, it doesn't matter from to code
> generation point of view whether it is (char *)0 or (void *)0.

Sorry, but I think you're wrong according to the C standard. Pointers of 
different types do NOT have to share the same representation (e.g.,
there have been some platforms where char* and int* were different
sizes). A void pointer must be capable of representing any type of
pointer (for example, holding the largest possible type). However, if
sizeof(void *) == 8 and sizeof(char *) == 4, you have a problem with
variadic functions which are expecting to pull 4 byte off the stack. 

In a non-variadic function, the compiler would do the right implicit
casting. In a variadic function, it can't. 

The real question is, does git want to care about portability to such
platforms.

If you remain unconvinced, I can try to find chapter and verse of the
standard.

> sizeof(unsigned long) is sizeof(void *) in real world.

Are you saying that because it encompasses all of the platforms you've
worked on, or do you have some evidence that it is largely the case? It
certainly isn't guaranteed by the C standard.

> > Because, according to the C and POSIX specs, they're not wrong.
> They didn't think of 64-bit architectures back then, I suppose.

No, they did think of those issues; they intentionally left such sizing
up to the implementation to allow C to grow with the hardware. Mostly
you don't have to care, but as I said, typing with variadic functions is
a pain.

-Peff
