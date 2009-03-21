From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] documentation: Makefile accounts for SHELL_PATH setting
Date: Fri, 20 Mar 2009 23:22:40 -0400
Message-ID: <20090321032240.GA31547@coredump.intra.peff.net>
References: <1237603220-22897-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Sat Mar 21 04:26:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkrrE-0000LF-H1
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 04:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884AbZCUDWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 23:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753670AbZCUDWy
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 23:22:54 -0400
Received: from peff.net ([208.65.91.99]:43220 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752974AbZCUDWx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 23:22:53 -0400
Received: (qmail 16246 invoked by uid 107); 21 Mar 2009 03:23:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 20 Mar 2009 23:23:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2009 23:22:40 -0400
Content-Disposition: inline
In-Reply-To: <1237603220-22897-1-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114025>

On Fri, Mar 20, 2009 at 10:40:20PM -0400, Ben Walton wrote:

> Take SHELL_PATH into account, if set, in Documentation/Makefile.  This
> allows the caller to provide a shell capable of running the install
> scripts on systems where sh is not bash.

Makes sense.

> +#retain original (but broken) behaviour if SHELL_PATH isn't overridden
> +ifndef SHELL_PATH
> +	SHELL_PATH = sh
> +endif

The Makefile in t/Makefile does:

  SHELL_PATH ?= $(SHELL)

which I think makes more sense (and yes, yours actually keeps the
existing behavior, but it's probably better to inherit from SHELL in
case it is set to something more useful).

>  install-html: html
> -	sh ./install-webdoc.sh $(DESTDIR)$(htmldir)
> +	$(SHELL_PATH) ./install-webdoc.sh $(DESTDIR)$(htmldir)

You need a SHELL_PATH_SQ to handle paths with spaces; see t/Makefile for
an example.

I wonder if both subdirs should simply be pulling from
GIT-BUILD-OPTIONS, though, which would allow this to use the specified
SHELL_PATH:

  $ make SHELL_PATH=whatever
  $ cd Documentation && make

but maybe it is not worth caring about (since it may complicate building
Documentation if you _haven't_ build the actual code).

-Peff
