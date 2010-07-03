From: Jeff King <peff@peff.net>
Subject: Re: 'git commit --short' without touching index?
Date: Sat, 3 Jul 2010 05:17:48 -0400
Message-ID: <20100703091748.GA11714@sigill.intra.peff.net>
References: <loom.20100703T102242-536@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Daniel <friedan@muon.rutgers.edu>
X-From: git-owner@vger.kernel.org Sat Jul 03 11:17:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUyrE-0006Tx-07
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 11:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754233Ab0GCJRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jul 2010 05:17:51 -0400
Received: from peff.net ([208.65.91.99]:49645 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752491Ab0GCJRu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jul 2010 05:17:50 -0400
Received: (qmail 12829 invoked by uid 107); 3 Jul 2010 09:18:45 -0000
Received: from c-67-172-213-4.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.213.4)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 03 Jul 2010 05:18:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Jul 2010 05:17:48 -0400
Content-Disposition: inline
In-Reply-To: <loom.20100703T102242-536@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150184>

On Sat, Jul 03, 2010 at 08:30:31AM +0000, Daniel wrote:

> 'git commit --short' touches .git/index ('--short' implies '--dry-run').
> 
> Is there any equivalent command that does not touch .git/index?
> 
> I'm using 'git commit --short' in a script to check if the repository needs
> attention.  At present, it touches .git/index, which causes
> unnecessary activity in another script running rsync.

If you are just calling "git commit --short" without arguments (i.e.,
you care about the current state, not about "what would happen if I
commit with these arguments"), then you probably want "git status".
Also, you probably should use "git status --porcelain", which is the
same as --short but is guaranteed not to change in the future.

However, both "status" and "commit --dry-run" will opportunistically
refresh the index. If you don't want to touch the index at all, you can
use a combination of:

  # show changes between HEAD and index
  git diff-index HEAD

  # show changes between index and working tree
  git diff-files

  # show untracked files
  git ls-files --exclude-standard -o

One thing you will find, though, is that not refreshing the index means
that stat-dirty files (e.g., ones which have no content changed but
which have had their timestamps changed) will appear the diff-files
above.

I don't think there is a simple way to tell "git status" to refresh the
index internally, but not to write it out. It will do this if it doesn't
have write permissions, but chmod'ing your index before running the
script seems like an awful hack. You could refresh to a temporary index,
but that also seems like a hack.

It would be nice if the index-refreshing code only wrote to the index if
there was something worth writing. I'm not sure how hard that would be
to implement, though.

-Peff
