From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] -C/--chdir command line option
Date: Sun, 19 Oct 2008 09:17:45 -0400
Message-ID: <20081019131745.GA8643@coredump.intra.peff.net>
References: <20081019000227.GA9423@charybdis.dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Maciej Pasternacki <maciej@pasternacki.net>
X-From: git-owner@vger.kernel.org Mon Oct 20 07:10:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrYBP-0003iP-Tp
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 15:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbYJSNRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 09:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbYJSNRs
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 09:17:48 -0400
Received: from peff.net ([208.65.91.99]:4189 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751280AbYJSNRr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 09:17:47 -0400
Received: (qmail 7490 invoked by uid 111); 19 Oct 2008 13:17:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 19 Oct 2008 09:17:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 19 Oct 2008 09:17:45 -0400
Content-Disposition: inline
In-Reply-To: <20081019000227.GA9423@charybdis.dreamhost.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98612>

On Sat, Oct 18, 2008 at 05:02:27PM -0700, Maciej Pasternacki wrote:

> In my project cl-librarian, which is a layer built upon different
> version control systems, I need to run git pull, but start it from
> outside of work tree; however, pull needs to be in work tree (as in
> getcwd()) in order to update said work tree.  --git-dir and
> --work-tree options don't work; I discussed it on #git yesterday,
> and it turned out that this issue is nontrivial:
> [...]
> the best workaround that occured to me was adding -C/--chdir option to
> main git binary, like one that Make accepts.  This fixed my problem, I
> paste the resulting patch below:

I'm not completely opposed to -C, as it does match some other tools,
but it does seem superfluous with --git-dir and --work-tree. Which makes
me feel like we are just papering over a bug instead of actually fixing
it (and to be honest, I always wondered what the point of "make -C" was
in the face of "cd dir && make").

I'm not sure if the actual problem is related to the oft-discussed,
unresolved work-tree startup woes, or is something much simpler to fix.
I'll try to look closer later today.

A few comments on your patch:

> From 4461cd1be99772c93a83bcdfe6e6a86e71abaa35 Mon Sep 17 00:00:00 2001
> From: Maciej Pasternacki <maciej@pasternacki.net>
> Date: Sun, 19 Oct 2008 01:33:49 +0200
> Subject: [PATCH] Add command line option --chdir/-C to allow setting git process work directory.
> 
> Signed-off-by: Maciej Pasternacki <maciej@pasternacki.net>

Please follow the usual list conventions; this stuff should be the
actual headers of your mail, not in the body of the message. And some of
the justification you gave above should be part of the commit message.

> +		} else if (!strcmp(cmd, "-C") || !strcmp(cmd, "--chdir")) {
> +                        chdir((*argv)[1]);

No error detection and reporting? I think I would be quite happy for
"git -C /some/path clean -dx" to bail out when it saw that it couldn't
change directory instead of just deleting the contents of wherever I
happened to be.

Also, the envchanged flag should probably be set, as for the git-dir and
work-tree options.

-Peff
