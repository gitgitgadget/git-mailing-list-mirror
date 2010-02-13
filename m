From: Jeff King <peff@peff.net>
Subject: Re: 'git svn log' no longer uses the pager
Date: Sat, 13 Feb 2010 18:51:56 -0500
Message-ID: <20100213235156.GA9054@coredump.intra.peff.net>
References: <462027ff1002131314k62069160h63760fc8316aa43b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Sebastian Celis <sebastian@sebastiancelis.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 00:52:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgRmT-00085a-W6
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 00:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758232Ab0BMXvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 18:51:55 -0500
Received: from peff.net ([208.65.91.99]:53281 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758065Ab0BMXvy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 18:51:54 -0500
Received: (qmail 24149 invoked by uid 107); 13 Feb 2010 23:52:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 13 Feb 2010 18:52:04 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Feb 2010 18:51:56 -0500
Content-Disposition: inline
In-Reply-To: <462027ff1002131314k62069160h63760fc8316aa43b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139869>

On Sat, Feb 13, 2010 at 03:14:54PM -0600, Sebastian Celis wrote:

> Ever since upgrading to git 1.6.6.1 I have noticed that 'git svn log'
> no longer uses the pager. It definitely used to in git 1.6.5.X, but it
> no longer does.
> 
> Is this a recent bug that was introduced? Or was this changed on
> purpose? I definitely preferred the old behavior.

I think it's a bug. It bisects to Jonathan's dec543e (am -i, git-svn:
use "git var GIT_PAGER", 2009-10-30). But it seems to me that "git var
GIT_PAGER" is fundamentally broken. It calls git_pager, which in turns
checks isatty(1). But of course stdout _isn't_ a tty, because we are
piping it back to the perl process to read the result of "git var".
In other words, I don't see how this ever could have worked.

For git-config's colorbool support we have the caller pass in a
stdout-is-tty flag. I suspect we would need to do the same thing here.

-Peff
