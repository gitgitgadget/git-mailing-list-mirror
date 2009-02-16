From: Jeff King <peff@peff.net>
Subject: Re: Improving CRLF error message; also, enabling autocrlf and
	safecrlf by default
Date: Sun, 15 Feb 2009 22:04:46 -0500
Message-ID: <20090216030446.GC18780@sigill.intra.peff.net>
References: <loom.20090216T022524-78@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jason Spiro <jasonspiro4@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 04:07:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYtpK-0003XP-Of
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 04:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755546AbZBPDEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 22:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755226AbZBPDEy
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 22:04:54 -0500
Received: from peff.net ([208.65.91.99]:40515 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752859AbZBPDEx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 22:04:53 -0500
Received: (qmail 12511 invoked by uid 107); 16 Feb 2009 03:05:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 15 Feb 2009 22:05:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Feb 2009 22:04:46 -0500
Content-Disposition: inline
In-Reply-To: <loom.20090216T022524-78@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110120>

On Mon, Feb 16, 2009 at 02:45:43AM +0000, Jason Spiro wrote:

> One of the pre-commit hooks detects trailing whitespace:
> 
> if (/\s$/) {
> bad_line("trailing whitespace", $_);
> }

Not since 03e2b63 (Update sample pre-commit hook to use "diff --check",
2008-06-26), when that line was removed.

I'm happy you want to improve git; but please, if you want to report
problems, check what the status is in a more recent version (or at least
tell us your version, which can help).

> Unfortunately, when I try to check in a file with DOS (CR+LF) line
> endings, this hook triggers on every line.  This happens on Cygwin.  I
> haven't checked, but I bet it happens on other platforms as well, as
> long as this hook runs.

Yes, I believe carriage returns are considered trailing whitespace. I
think (and I am not 100% sure here, because I have the good fortune not
to have to deal with line-ending conversions on any of my platforms)
that the general philosophy is that the "canonical" form in the
repository should be LF-only, and that conversions can optionally make
the worktree version CRLF (or whatever your platform desires it). But
it's important that the canonical version be the same across platforms
so that the blob sha-1's (and therefore the tree and commit sha-1's) all
match.

IOW, setting up core.autocrlf properly should make this go away.

> But the error message "trailing whitespace" doesn't clearly tell me
> what's wrong.

Modern versions use "diff --check", which should look like this (on my
LF-only box, at least):

  $ mkdir repo && cd repo && git init
  $ touch file && git add file && git commit -m one
  $ printf 'foo\r\n' >file
  $ git diff --check
  file:1: trailing whitespace.
  +foo^M

and if you use "git diff --color --check", the problem is highlighted.

> 1.  Could you please modify Git so that, when such a problem happens,
> it instead prints an message saying that the file has CR+LF line
> endings, and that Git does not allow this?

It might be worth splitting the trailing whitespace detection into
"spaces and tabs at the end" and "CRLF", and providing different
messages (though it is hopefully also obvious with the new output that
it is a CRLF issue).

> 2.  In addition, could you please enable the core.autocrlf and core.safecrlf 
> options by default in the next version of Git?

I think that is up to your platform packaging, I think. I think msysgit
is shipping with core.autocrlf on by default these days. But again, I
don't know very much about that area.

-Peff
