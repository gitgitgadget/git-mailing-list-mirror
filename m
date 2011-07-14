From: Jeff King <peff@peff.net>
Subject: Re: git-archive and tar options
Date: Wed, 13 Jul 2011 21:56:56 -0400
Message-ID: <20110714015656.GA20136@sigill.intra.peff.net>
References: <ivla29$liu$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Thu Jul 14 03:57:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhBAo-00008B-7A
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 03:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259Ab1GNB47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 21:56:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48038
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752102Ab1GNB47 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 21:56:59 -0400
Received: (qmail 32504 invoked by uid 107); 14 Jul 2011 01:57:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Jul 2011 21:57:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jul 2011 21:56:56 -0400
Content-Disposition: inline
In-Reply-To: <ivla29$liu$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177096>

On Wed, Jul 13, 2011 at 06:34:32PM -0500, Neal Kreitzinger wrote:

> the git-archive manpage states:
> 
> "git archive [--format=<fmt>] [--list] [--prefix=<prefix>/] [<extra>] [-o 
> | --output=<file>] [--worktree-attributes] [--remote=<repo> 
> [--exec=<git-upload-archive>]] <tree-ish>  [path\u2026]
> 
> <extra>
>     This can be any options that the archiver backend understands. See next 
> section."
>
> I have tar 1.23 and want to use the --transform option.  How can I feed 
> git-archive additional tar options?

Right. And the next section is "Backend Extra Options", which has:

   zip
       -0
           Store the files instead of deflating them.

       -9
           Highest and slowest compression level. You can specify any number from 1 to 9
           to adjust compression speed and ratio.

And nothing else. We don't actually call your system "tar" to generate
the tarball, which is what I assume you thought when you saw "backend".
A patch to make it more clear would be welcome.

> Working syntax starting points for git-archive and tar:
> 
> git archive --format=tar -o my.tar HEAD Web/Templates/
> tar -cvf my.tar --transform 's,^Web/Templates/,myPath/myWeb/Templates/,' 
> WebPortal/Templates/
> 
> Failed syntax attempts for feeding tar option to git-archive:
> 
> git archive --format=tar -o my.tar HEAD --transform 
> 's,^Web/Templates/,myPath/myWeb/Templates/,' WebPortal/Templates/
> error: unknown option `transform'
> 
> git archive --format=tar -o my.tar --transform 
> 's,^Web/Templates/,myPath/myWeb/Templates/,' HEAD WebPortal/Templates/
> error: unknown option `transform'

Yeah, that won't work, because there is no such option. We do have
"--prefix", but I suspect that's not flexible enough for what you want.

So you're probably stuck with extracting the results of "git archive" to
a temporary directory and then using GNU tar to re-archive them (or if
you have a checkout, you can just tar that up directly, feeding the list
from "git ls-files" into tar). It would be nice if GNU tar could act as
a post-processor, and do something like:

  git archive HEAD | tar --pipe-mode --transform=whatever >my.tar

But AFAIK, nothing like "--pipe-mode" exists.

It would probably not be a very hard feature to add to "git archive" if
you're interested in doing so.

-Peff
