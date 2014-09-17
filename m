From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] unblock and unignore SIGPIPE
Date: Wed, 17 Sep 2014 04:11:49 -0400
Message-ID: <20140917081148.GB16200@peff.net>
References: <1408080565-33234-1-git-send-email-patrick.reynolds@github.com>
 <xmqqd2av1bsg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Patrick Reynolds <patrick.reynolds@github.com>,
	git@vger.kernel.org, Chris Packham <judge.packham@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 10:11:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUALF-0004jH-Uo
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 10:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbaIQILx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 04:11:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:49382 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751842AbaIQILv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2014 04:11:51 -0400
Received: (qmail 30369 invoked by uid 102); 17 Sep 2014 08:11:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Sep 2014 03:11:51 -0500
Received: (qmail 10474 invoked by uid 107); 17 Sep 2014 08:12:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Sep 2014 04:12:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Sep 2014 04:11:49 -0400
Content-Disposition: inline
In-Reply-To: <xmqqd2av1bsg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257216>

On Tue, Sep 16, 2014 at 02:43:43PM -0700, Junio C Hamano wrote:

> > +/* un-ignore and un-block SIGPIPE */
> > +void sanitize_signals(void)
> > +{
> > +	sigset_t unblock;
> > +
> > +	sigemptyset(&unblock);
> > +	sigaddset(&unblock, SIGPIPE);
> > +	sigprocmask(SIG_UNBLOCK, &unblock, NULL);
> > +	signal(SIGPIPE, SIG_DFL);
> 
> With the only caller in git.c, there is not a good reason that we
> would want to have this as a global in a different file (I think the
> patch merely follows the pattern of sanitize-fds, but that one has
> to be called from many places).

Would we want to call it from external C commands, too? For the most
part, git.c is the entry point for running git commands, and any
sanitizing it does will be inherited by sub-commands. But it _is_ still
legal to call dashed commands individually, and even required in some
cases (e.g., git-upload-pack for ssh clients).

> > diff --git a/t/t0012-sigpipe.sh b/t/t0012-sigpipe.sh
> > new file mode 100755
> > index 0000000..213cde3
> > --- /dev/null
> > +++ b/t/t0012-sigpipe.sh
> > @@ -0,0 +1,27 @@
> > +#!/bin/sh
> 
> Hmmm, do we really need to allocate a new test number just for these
> two tests, instead of folding it into an existing one?

I see in your proposed patch below you put them into t0000. I wonder if
t0005 would be a more obvious place.

-Peff
