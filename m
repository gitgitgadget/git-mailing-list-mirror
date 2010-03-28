From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] fast textconv
Date: Sun, 28 Mar 2010 12:56:47 -0400
Message-ID: <20100328165646.GA10293@coredump.intra.peff.net>
References: <20100328145301.GA26213@coredump.intra.peff.net>
 <4BAF7F3F.5020604@drmicha.warpmail.net>
 <20100328161728.GA2828@coredump.intra.peff.net>
 <20100328161921.GA3435@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Mar 28 18:57:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvvnN-0001UK-0l
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 18:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754812Ab0C1Q46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 12:56:58 -0400
Received: from peff.net ([208.65.91.99]:55864 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754800Ab0C1Q45 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 12:56:57 -0400
Received: (qmail 26026 invoked by uid 107); 28 Mar 2010 16:57:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 28 Mar 2010 12:57:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Mar 2010 12:56:47 -0400
Content-Disposition: inline
In-Reply-To: <20100328161921.GA3435@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143402>

On Sun, Mar 28, 2010 at 12:19:21PM -0400, Jeff King wrote:

> On Sun, Mar 28, 2010 at 12:17:28PM -0400, Jeff King wrote:
> 
> > If I understand you right, you are proposing a separate program
> > that you would pass as a fasttextconv helper, and that would look in a
> > notes tree. So you would still have a per-diff fork/exec, and pipe all
> > the data.
> > 
> > I was thinking of actually doing it in-core, so cache hits would be as
> > lightweight as a notes lookup (and cache misses obviously would still
> > fork/exec a helper, but we don't care too much since the helper's time
> > to convert will dominate in that path).
> 
> Side note: I think I might prototype it as a separate program and see
> what kind of speed I can get.

Better, but not perfect. My script is below. I get:

  $ time git show >/dev/null
  real    0m1.036s
  user    0m0.412s
  sys     0m0.672s

which is still a 2.5x speedup (versus my other fast-textconv solution
earlier in the thread), but I suspect we can do better. The notes
mechanism does some up-front work to get very fast lookups, but because
we invoke git-notes repeatedly, we never get the amortized benefit of
that up-front work.  Doing it in-core would fix that.

My script was:

-- >8 --
#!/bin/sh

type=$1; shift
program=$1; shift
sha1=$1; shift
filename=$1; shift

GIT_NOTES_REF=refs/notes/textconv/$type; export GIT_NOTES_REF

# try the cache
git notes show $sha1 2>/dev/null && exit 0

# otherwise, insert the cache entry.
# We can be as slow as we like.
ext=`echo "$filename" | sed 's/.*\.//'`
tmp=`mktemp notes-textconv-XXXXXX.$ext`
git cat-file blob $sha1 >$tmp
$program $tmp | git notes add -f -F - $sha1
git notes show $sha1
rm -f $tmp
-- 8< --

and my config is:

  $ git config diff.mfo.textconv /home/peff/fast mfo mfo-tags

where "mfo-tags" is the program to display metadata and "mfo" is a
user-selected shorthand name for it.

-Peff
