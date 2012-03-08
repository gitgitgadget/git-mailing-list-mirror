From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] remove #!interpreter line from shell libraries
Date: Thu, 8 Mar 2012 07:47:48 -0500
Message-ID: <20120308124748.GA2002@sigill.intra.peff.net>
References: <20120308121403.GA16493@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 13:47:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5cl9-0005jx-5J
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 13:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075Ab2CHMrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 07:47:51 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44590
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035Ab2CHMru (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 07:47:50 -0500
Received: (qmail 5718 invoked by uid 107); 8 Mar 2012 12:47:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Mar 2012 07:47:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Mar 2012 07:47:48 -0500
Content-Disposition: inline
In-Reply-To: <20120308121403.GA16493@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192587>

On Thu, Mar 08, 2012 at 06:14:04AM -0600, Jonathan Nieder wrote:

> As explained in v1.7.0-rc1~9 (2009-11-25), even when a script is
> expected to be sourced instead of executed on its own, a #!/bin/sh
> shebang line can provide useful documentation about what format the
> file is in.  However, it is even clearer to include a comment and no
> shebang at all, to avoid creating the illusion that the indicated
> choice of shell will have any effect at runtime.

I'm OK with this in principle, but I think there are some valgrind
fallouts.

One is that I'm slightly confused about why this works at all.  In
v1.7.0-rc1~9, we were having a problem because the valgrind code in
test-lib.sh was confused by the lack of #!-line. Without it, the
valgrind code thought the shell lib was not a script, and therefore
needed to be wrapped by valgrind.sh and run via valgrind.

You give the reasoning why this is OK here:

> Because these files are not marked executable, removing the #! lines
> would not confuse the valgrind support of our test scripts, so this
> should be safe.  Noticed by lintian.

and that makes sense looking at the valgrind setup code, which checks the
executable bit. But that code has always checked the executable bit, and
git-mergetool--lib.sh was never marked executable. Why did it fail
before v1.7.0-rc1~9 but not now? Were we simply wrong in diagnosing the
bug back then?

The second is that later, we tweaked the valgrind code with 36bfb0e
(tests: link shell libraries into valgrind directory, 2011-06-17), which
uses the shebang to detect those shell libraries. With your patch,
t2300 is broken with valgrind. You might not notice it, though, because
a previous valgrind run would leave the proper symlinks in place. But if
you "git clean" t/valgrind/bin and re-run the test, it will fail.

>  git-mergetool--lib.sh      |    3 +--
>  git-parse-remote.sh        |    4 +++-
>  git-rebase--am.sh          |    3 ++-
>  git-rebase--interactive.sh |    8 +++-----
>  git-rebase--merge.sh       |    4 +++-
>  git-sh-i18n.sh             |    5 ++---
>  git-sh-setup.sh            |    9 +++------

If we are interested in the aesthetic argument, then many shell
libraries in t/ could use the same treatment.

-Peff
