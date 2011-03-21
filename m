From: Jeff King <peff@peff.net>
Subject: Re: Weird behavior of shell variables in git aliases
Date: Mon, 21 Mar 2011 17:53:10 -0400
Message-ID: <20110321215310.GA2122@sigill.intra.peff.net>
References: <d9c38309-c433-476c-bba3-f2c5b7e94a89@k15g2000prk.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 22:53:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1n2O-0004ll-1k
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 22:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506Ab1CUVxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 17:53:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57500
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753564Ab1CUVxO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 17:53:14 -0400
Received: (qmail 18727 invoked by uid 107); 21 Mar 2011 21:53:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 Mar 2011 17:53:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Mar 2011 17:53:10 -0400
Content-Disposition: inline
In-Reply-To: <d9c38309-c433-476c-bba3-f2c5b7e94a89@k15g2000prk.googlegroups.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169675>

On Mon, Mar 21, 2011 at 09:39:43AM -0700, Dun Peal wrote:

> It seems that a variable is available only once?!  How can the
> following shell session be explained:
> 
>     $ git config alias.test0
>     !echo $1
>     $ git test0 foo
>     foo
>     $ git config alias.test1
>     !echo $1 && echo $1
>     $ git test1 foo
> 
>     foo
>     $ git config alias.test2
>     !BRANCH=$1 && echo $BRANCH && echo $BRANCH
>     $ git test2 foo
> 
>     foo

Because in v1.7.4 and earlier, we literally just tack the arguments
(shell-quoted) onto the end of the string. So your alias ends up
expanding to:

  /bin/sh -c "!echo $1 && echo $1 'foo'"

So the first echo is empty, and then the second one echos foo. And what
you are trying to do doesn't work with a straight alias (at the bottom
I'll show you what you want).

But interestingly, that's _not_ the behavior as of Erik's 7f51f8b
(alias: use run_command api to execute aliases, 2011-01-07), which is in
master but not yet released. With that, we end up executing:

  sh -c 'echo $1 && echo $1 "$@"' 'echo $1 && echo $1' 'foo'

which prints "foo foo". So it is technically a regression. I don't know
how much we care; using positional parameters like this was already
nonsensical, as shown above.

For reference, what you actually want (in either system) is:

  $ git config alias.test1
  !sh -c 'echo $1 && echo $1' -
  $ git test1 foo
  foo
  foo

Make sure to include the "-" (or some other string) which ends up as $0.

-Peff
