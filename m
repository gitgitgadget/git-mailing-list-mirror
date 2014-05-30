From: Jeff King <peff@peff.net>
Subject: Re: Bugreport: git push disobeys -c remote.xxx.url=...
Date: Thu, 29 May 2014 21:43:59 -0400
Message-ID: <20140530014359.GF28683@sigill.intra.peff.net>
References: <20140530000356.GA8033@fuz.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: fuz@fuz.su
X-From: git-owner@vger.kernel.org Fri May 30 03:44:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqBrb-0002ZT-8H
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 03:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952AbaE3BoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 21:44:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:33845 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751745AbaE3BoB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 21:44:01 -0400
Received: (qmail 2327 invoked by uid 102); 30 May 2014 01:44:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 May 2014 20:44:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 May 2014 21:43:59 -0400
Content-Disposition: inline
In-Reply-To: <20140530000356.GA8033@fuz.su>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250427>

On Fri, May 30, 2014 at 02:03:56AM +0200, fuz@fuz.su wrote:

> I've tried to changing the URL of a remote temporarily because of network
> issues. I tried something like this:
> 
>     git -c remote.foo.url=http://gitserver.example/repo.git push foo bar
> 
> Tracing shows that git push does not use the provided URL for the remote foo
> and instead uses the URL configured in the repository configuration as if the
> -c option was not present at all. This looks like a bug to me.

You are correct that this won't work, but the reason is a bit
complicated.

The remote.*.url config field is actually a "multivar", meaning that you
can specify it multiple times. In that case, "git push" will push to
each configured URL in order in which they appear in the config.

In the command above you are not overwriting remote.foo.url, but rather
adding an extra value to it. So we first try to push to the remote
defined in your actual config, and then to the one on the command-line.
You can see this in action like:

  $ git init --bare /tmp/foo
  $ git init --bare /tmp/bar
  $ git remote add foo /tmp/foo
  $ git -c remote.foo.url=/tmp/bar push foo HEAD

You should see pushes to both /tmp/foo and /tmp/bar.

Config multivars like this are rather hard to work with, as there is no
way to say "reset the multivar to empty, _then_ add this new value". So
there isn't a simple solution using remote.*.url from the command-line
like this.

Another way of doing what you want is to use url.*.insteadOf, like:

   git -c url./tmp/bar.insteadof=/tmp/foo push foo HEAD

-Peff
