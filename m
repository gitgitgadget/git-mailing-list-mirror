From: Jeff King <peff@peff.net>
Subject: Re: Filter-branch's "move tree to subdirectory" example fails with
 BSD sed?
Date: Mon, 16 Apr 2012 11:27:38 -0400
Message-ID: <20120416152737.GB14724@sigill.intra.peff.net>
References: <20120414160028.GD1012@gmail.com>
 <4F89CF11.7060309@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christopher Tiwald <christiwald@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 17:27:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJnqK-0002Rc-OC
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 17:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804Ab2DPP1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 11:27:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36263
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753794Ab2DPP1l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 11:27:41 -0400
Received: (qmail 24450 invoked by uid 107); 16 Apr 2012 15:27:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Apr 2012 11:27:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Apr 2012 11:27:38 -0400
Content-Disposition: inline
In-Reply-To: <4F89CF11.7060309@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195646>

On Sat, Apr 14, 2012 at 09:25:05PM +0200, Johannes Sixt wrote:

> Am 14.04.2012 18:00, schrieb Christopher Tiwald:
> > The "Move tree to subdirectory" example in the 'git filter-branch'
> > manpage fails on Mac OSX 10.7.3, but succeeds on Ubuntu 10.04.
> 
> > git init "test"
> > cd "test"
> > mkdir -p subdirA/subdirB
> > echo content > subdirA/subdirB/file
> > git add .
> > git commit -m "initial commit"
> > git ls-files -s | sed "s-\t\"*-&newsubdir/-"
> > 
> > On Mac 10.7.3 the final command outputs:
> > 100644 d95f3ad14dee633a758d2e331151e950dd13e4ed 0	subdirA/subdirB/file
> > 
> > On Ubuntu 10.04:
> > 100644 d95f3ad14dee633a758d2e331151e950dd13e4ed 0	newsubdir/subdirA/subdirB/file
> 
> Perhaps a literal TAB instead of \t makes the example work?

Yes, I suspect that is the problem, too.

> It would be difficult, though, to write this down in the manual in an
> unambiguous way.

Maybe it would be simpler to just use perl:

 git filter-branch --index-filter '
   git ls-files -s |
     perl -pe "s{\t\"?}{$&newsubdir/}" |
     GIT_INDEX_FILE=$GIT_INDEX_FILE.new git update-index --index-info &&
   mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE
 ' HEAD

I also think tweaking the indentation and line breaks as I did above
makes it a little more readable. If we are using perl, we could
also just use "-z" to get rid of the funny quote handling.

I wish we could also get rid of the temporary index. It exists solely
for the side effect of removing the existing entries (otherwise, you get
both "foo" and "newsubdir/foo" in the resulting history). It would be
nice if there was some flag to update-index to say "before you do
anything, clear the existing index" (or I guess, "don't bother reading
the existing index"). And then result could look like:

  git filter-branch --index-filter '
    git ls-files -sz |
    perl -0pe "s{\t}{\tnewsubdir/}" |
    git update-index --from-scratch -z --index-info
  ' HEAD

which is IMHO much easier to read and understand.

-Peff
