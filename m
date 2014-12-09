From: Jeff King <peff@peff.net>
Subject: Re: Blobs not referenced by file (anymore) are not removed by GC
Date: Tue, 9 Dec 2014 09:14:57 -0500
Message-ID: <20141209141457.GA18544@peff.net>
References: <5485D03F.3060008@fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Martin Scherer <m.scherer@fu-berlin.de>
X-From: git-owner@vger.kernel.org Tue Dec 09 15:15:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyLZJ-0008Jp-Rl
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 15:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757429AbaLIOPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 09:15:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:50483 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753008AbaLIOPA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 09:15:00 -0500
Received: (qmail 1433 invoked by uid 102); 9 Dec 2014 14:14:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 08:14:59 -0600
Received: (qmail 370 invoked by uid 107); 9 Dec 2014 14:15:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 09:15:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Dec 2014 09:14:57 -0500
Content-Disposition: inline
In-Reply-To: <5485D03F.3060008@fu-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261126>

On Mon, Dec 08, 2014 at 05:22:23PM +0100, Martin Scherer wrote:

> # invoke bfg --delete-folders something multiple times with different
> pattern.
> 
> # try to cleanup
> 
> git gc --aggressive --prune=now # big blobs still in history
> git fsck # no results
> git fsck --full  --unreachable --dangling # no results

Might you still have reflogs pointing to the objects? Try:

  git reflog expire --expire-unreachable=now --all

I also don't know if BFG keeps backup refs around (filter-branch, for
example, writes a copy of the original refs into refs/original; you
would want to delete that if you're trying to slim down the repo).

In general, you can see the on-disk size of the objects required for a
particular ref with something like:

  size() {
    git rev-list --objects "$@" |
    cut -d' ' -f1 |
    git cat-file --batch-check='%(objectsize:disk)' |
    perl -lne '$t += $_; END { print $t }'
  }

  # size of master branch
  size master

  # size of each ref on top of what is in the master branch
  git for-each-ref --format='%(refname)' |
  while read ref; do
    echo "$(size master..$ref) $ref"
  done | sort -rn


Note that these sizes are somewhat approximate. We may store object X
needed by one ref as a delta against Y used by another ref. The
accounting shows X as tiny compared to Y. And then a repack may find the
delta in the opposite direction. But if you're talking about rewriting
history to drop a bunch of gigantic objects, the output of the final
loop is a good way to see which refs are still referring to the old
history.

-Peff
