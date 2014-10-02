From: Jeff King <peff@peff.net>
Subject: Re: $GIT_CONFIG should either apply to all commands, or none at all
Date: Thu, 2 Oct 2014 11:59:19 -0400
Message-ID: <20141002155919.GA2505@peff.net>
References: <20141002001034.24160.11848.reportbug@fabul.fbriere.net>
 <20141002011546.GR1175@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 17:59:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZimr-0000uw-HS
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 17:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990AbaJBP7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2014 11:59:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:54149 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752560AbaJBP7U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2014 11:59:20 -0400
Received: (qmail 26875 invoked by uid 102); 2 Oct 2014 15:59:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Oct 2014 10:59:20 -0500
Received: (qmail 4823 invoked by uid 107); 2 Oct 2014 15:59:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Oct 2014 11:59:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Oct 2014 11:59:19 -0400
Content-Disposition: inline
In-Reply-To: <20141002011546.GR1175@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257810>

On Wed, Oct 01, 2014 at 06:15:46PM -0700, Jonathan Nieder wrote:

>  3) Warn when 'git config' is called with GIT_CONFIG set, explaining
>     that support will eventually be removed and that callers should
>     pass --file= instead.
> 
>  4) Once we're confident there are no scripts in the wild relying on
>     that envvar, remove support for it.

I think you could do just these two without worrying about the
I_AM_PORCELAIN setting. It's completely redundant with `git config
--file` these days.

> Another possibility (B):
> 
>  1) Teach git's commands in C to respect the GIT_CONFIG environment
>     variable.  Semantics: only configuration from that file would be
>     respected and all other configuration will be ignored.  Advertise
>     it in the git(1) manpage.

I think this is a bad idea. It originally _did_ impact each command, but
there were a lot of confusing corner cases to the semantics, and it led
to bugs and misbehavior. That's what led to dc87183. I wish we had just
dropped it for git-config then, too. We kept it for backwards
compatibility, but we probably should have deprecated it more clearly.

> Yet another possibility (C):
> 
>  1) Just skip to step (4) from plan (A).

I agree this is tempting. We have never deprecated it formally, but it
has been a little-used feature.

> C is kind of temping.  Do you know if there are scripts in the wild
> that rely on the GIT_CONFIG setting working?

Searching here:

  https://github.com/search?q=%22export+GIT_CONFIG%22&type=Code

reveals that some people do set it, but from the handful I investigated,
it is probably not doing what they want. For example, in:

  https://github.com/GNOME/sysadmin-bin/blob/8ef4165a4b38fd1488c194f0c562c7fe24545bca/git/gnome-post-receive

they are trying to use it as if it affects all git commands, but as we
just discussed, it does not. So their script is potentially buggy as-is.
Getting rid of GIT_CONFIG would make it _more_ buggy, so perhaps that is
not an excuse, but I think it points to actually doing something.

-Peff
