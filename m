From: Jeff King <peff@peff.net>
Subject: Re: pull from stdin
Date: Thu, 7 Jul 2011 15:28:13 -0400
Message-ID: <20110707192813.GE12044@sigill.intra.peff.net>
References: <N1B-u7I8PJ0byN@Safe-mail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: miket99@Safe-mail.net
X-From: git-owner@vger.kernel.org Thu Jul 07 21:28:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeuFK-0007r5-UA
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 21:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579Ab1GGT2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 15:28:17 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51811
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150Ab1GGT2R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 15:28:17 -0400
Received: (qmail 1803 invoked by uid 107); 7 Jul 2011 19:28:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 07 Jul 2011 15:28:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Jul 2011 15:28:13 -0400
Content-Disposition: inline
In-Reply-To: <N1B-u7I8PJ0byN@Safe-mail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176774>

On Thu, Jul 07, 2011 at 11:23:04AM -0400, miket99@Safe-mail.net wrote:

> I am using a rather complicated distributed workflow to keep various
> git repositories in sync. Basically I am creating bundles, pushing
> them to a server, and pull them again using a special application
> which output the bundle content to stdin. Unfortunately git-fetch and
> friends do not like /dev/stdin as input. Is there any way to pass the
> bundle contents via stdin to git?
> [...]
> ~/test$ cat b | git pull -- /dev/stdin
> fatal: '/dev/stdin' does not appear to be a git repository
> fatal: The remote end hung up unexpectedly

I think the problem is that "git fetch" tests for a bundle by checking
whether the argument is a regular file, which /dev/stdin is not. We
could perhaps fix that, but I think it still wouldn't work. The
bundle-reading code calls lseek, and your pipe will not be seekable.

So this works:

  $ git bundle unbundle /dev/stdin <b
  1c0138bbb920cdbf8e80bea38c4f77b0d01c3763 refs/heads/master
  1c0138bbb920cdbf8e80bea38c4f77b0d01c3763 HEAD

but this doesn't:

  $ cat b | git bundle unbundle /dev/stdin
  fatal: early EOF
  error: index-pack died

I don't think the problem is in the bundle format. I think it is simply
an issue that we read the bundle header in one process via buffered I/O,
and then use seek to pass the rest on to index-pack in another process.
So you could solve it by either:

  1. Using unbuffered I/O and reading a character at a time from the
     bundle when the input is not seekable. This will involve many more
     syscalls, of course, but we would only have to do it for the list
     of refs, not for the actual pack data.

  2. Instead of passing the descriptor to index-pack, open a pipe to
     index-pack and pass the data through the original process. For
     the sake of efficiency, we could enable this only when the input
     isn't seekable.

-Peff
