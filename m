From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] run-command: introduce CHILD_PROCESS_INIT
Date: Sun, 17 Aug 2014 04:48:32 -0400
Message-ID: <20140817084832.GL23808@peff.net>
References: <53EFE15B.7030805@web.de>
 <53F05DE2.5080806@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Aug 17 10:48:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIw8k-0005KY-Cb
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 10:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbaHQIse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2014 04:48:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:53601 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751159AbaHQIsd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2014 04:48:33 -0400
Received: (qmail 11211 invoked by uid 102); 17 Aug 2014 08:48:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Aug 2014 03:48:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Aug 2014 04:48:32 -0400
Content-Disposition: inline
In-Reply-To: <53F05DE2.5080806@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255361>

On Sun, Aug 17, 2014 at 09:46:42AM +0200, Johannes Sixt wrote:

> This is a step in the right direction, IMO. This way to initialize the
> struct feels mucth better because it does not depend on that the bit
> pattern of the NULL pointer is all zeros.

I think platforms with NULL as something besides all-bits-zero are a
lost cause with git. There are so many struct memsets that depend on
this (and it's probably not actually worth caring about).

> > +#define CHILD_PROCESS_INIT { NULL }
> 
> I would have expected this to read
> 
> #define CHILD_PROCESS_INIT { NULL, ARGV_ARRAY_INIT }
> 
> It does change the bit pattern of the initialized struct child_process
> because ARGV_ARRAY_INIT uses a non-NULL address. But IMHO
> ARGV_ARRAY_INIT should be used here as a defensive measure.

I'd be OK with that.  The argv_array code is specifically OK with an
all-bits-zero initialization. The only thing you don't get is that an
empty array is non-NULL, but that should never matter here (true, we'd
segfault if you didn't add anything to the array, but that is clearly a
bug that needs to be fixed either way).

I'm a little worried, though, that use sites without initializers would
be left behind. For example, git_proxy_connect uses xcalloc to allocate
the child_process, which results in all-bits-zero. If we want to start
caring about the initialization, we probably need to provide a
child_process_init() function and use it consistently.

-Peff
