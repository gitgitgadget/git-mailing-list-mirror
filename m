From: Jeff King <peff@peff.net>
Subject: Re: What does "modified" in git status mean?
Date: Tue, 24 Jan 2012 13:57:16 -0500
Message-ID: <20120124185716.GA5546@sigill.intra.peff.net>
References: <loom.20120122T174204-274@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mikolas <mikolas.janota@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 24 19:57:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RplYa-0003Sl-Qa
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 19:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756197Ab2AXS5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 13:57:20 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43489
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752401Ab2AXS5T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 13:57:19 -0500
Received: (qmail 11817 invoked by uid 107); 24 Jan 2012 19:04:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Jan 2012 14:04:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jan 2012 13:57:16 -0500
Content-Disposition: inline
In-Reply-To: <loom.20120122T174204-274@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189056>

On Sun, Jan 22, 2012 at 04:57:52PM +0000, Mikolas wrote:

> So it looks something like this:
> $ git status
> # On branch master
> nothing to commit (working directory clean)
> 
> $ cd foo
> $ git status
> # On branch master
> # Changes not staged for commit:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working directory)
> #
> #       modified:   ../foo/bar

Modified files appearing only in some calls to status is definitely odd,
and may be a bug. How close is this to your actual invocation?

In particular, if "foo/bar" is modified, and you do "cd foo && git
status", then the relative path shown by "git status" should be simply
"bar", not "../foo/bar". If you did "cd other && git status", then I
would expect it to say "../foo/bar".

So was the directory you entered the same as the one that contains the
(supposedly) modified file, yielding the output above?

If that is the case, then I might suspect it has to do with path
normalization and case sensitivity. It might be worth seeing if you can
reproduce the problem with a more recent version of git. In particular,
v1.7.8 and later shipped with my 2548183 (fix phantom untracked files
when core.ignorecase is set, 2011-10-06), which fixes some weird bugs
surrounding case-insensitive file lookup.

(Actually, even if that is not the case, it would be worth upgrading and
seeing if the bug is reproducible).

> So my questions are 
> 1) Is there some way how to tell status to tell me *why* the files are marked 
> as modified?

Typically you would ask "diff" for more details. But since "diff" is not
reporting anything, that isn't helpful (and is probably indicative of a
bug).

> 2) Is it normal that git status behaves differently in different directories?

No.

-Peff
