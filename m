From: Jeff King <peff@peff.net>
Subject: Re: git log -z doesn't separate commits with NULs
Date: Thu, 23 Feb 2012 05:24:26 -0500
Message-ID: <20120223102426.GB2912@sigill.intra.peff.net>
References: <4F46036F.3040406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nikolaj Shurkaev <snnicky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 11:24:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Vqk-0007N7-6i
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 11:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468Ab2BWKY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 05:24:29 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48655
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753086Ab2BWKY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 05:24:29 -0500
Received: (qmail 8547 invoked by uid 107); 23 Feb 2012 10:24:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Feb 2012 05:24:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2012 05:24:26 -0500
Content-Disposition: inline
In-Reply-To: <4F46036F.3040406@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191348>

On Thu, Feb 23, 2012 at 12:14:23PM +0300, Nikolaj Shurkaev wrote:

> I wanted to generate several files with some statistics using "git
> log -z" command.
> I did something like this:
> git log -z --patch HEAD~10..HEAD -- SomePathHere | xargs -0
> --max-chars=1000000 ~/1.sh

I'm not sure what "1.sh" is expecting to take as input, but that will
feed entire commits, including their commit message and entire diff, to
the script on its command line.

That seems like an awkward interface, but we don't really know what your
script intends to do. Maybe it is worth sharing the contents of the
script.

> If I put echo "started" into the file  ~/1.sh I see that the file is
> called only once instead of multiple times.

Yes. The point of xargs is usually to cram as many arguments into each
invocation of "1.sh" as possible, splitting into multiple invocations
only when we hit the argument-list memory limit that the OS imposes.

If you want xargs to give each argument its own invocation of the
script, use "xargs -n1".

> I'm newbie to xargs, thus I tested with and that worked as I expected.
> find . -type f -print0 | xargs -0  ./1.sh
> That produced a lost of "started" lines.

If you instrument your 1.sh more[1], you will find that is not executing
once per file, but rather getting a large chunk of files per invocation.

[1] Try adding: echo "got args: $*"

> Thus I suspect there is a but in git log -z command and that doesn't
> "Separate the commits with NULs instead of with new newlines." as
> promised in the documents.

You could verify that assertion by looking at the output. Try piping
your "git log" command through "cat -A | less". When I try it, I see a
NUL between each commit (cat -A will show it as "^@").

-Peff
