From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add -p: import Term::ReadKey with 'require'
Date: Fri, 6 Feb 2009 15:30:37 -0500
Message-ID: <20090206203037.GB19959@coredump.intra.peff.net>
References: <20090206140126.GA18364@coredump.intra.peff.net> <1233948601-4828-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <junio@pobox.com>,
	Suraj Kurapati <sunaku@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Feb 06 21:32:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVXMt-0007OG-0W
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 21:32:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbZBFUak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 15:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbZBFUak
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 15:30:40 -0500
Received: from peff.net ([208.65.91.99]:51250 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200AbZBFUaj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 15:30:39 -0500
Received: (qmail 24641 invoked by uid 107); 6 Feb 2009 20:30:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 06 Feb 2009 15:30:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Feb 2009 15:30:37 -0500
Content-Disposition: inline
In-Reply-To: <1233948601-4828-1-git-send-email-trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108782>

On Fri, Feb 06, 2009 at 08:30:01PM +0100, Thomas Rast wrote:

> The code below _seems_ to work.  I have to say that beyond the
> 'require', it's all voodoo to me, so I'd appreciate an extra-careful
> check.
> [...]
> +sub ReadMode;
> +sub ReadKey;

I believe it is fine. The tricky thing is that perl's parsing is
dependent on what functions have been defined. So it is OK to say

  ReadKey 0;

if a subroutine ReadKey has been defined, but otherwise it generates a
warning about using the bareword as a function. However

  ReadKey(0);

parses unambiguously, so it is always OK, even if no subroutine has yet
been defined.

So with the "use" code, Term::ReadKey had already been loaded when
parsing the bit about ReadKey. But now it is loaded at run-time, so at
parse time we don't know about that subroutine yet. So your options are
to forward-declare the subroutines (which you did), or to change calls
to the obvious function-like form.

> -		use Term::ReadKey;
> +		require Term::ReadKey;
> +		Term::ReadKey->import;

And the two added lines are the exact runtime equivalent of the deleted
line (note that you could also skip the import and just call
Term::ReadKey::ReadKey by its full name).

-Peff
