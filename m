From: Jeff King <peff@peff.net>
Subject: Re: .gitattributes glob matching broken
Date: Mon, 3 Nov 2008 04:09:33 -0500
Message-ID: <20081103090932.GA18424@coredump.intra.peff.net>
References: <83od0yaxzk.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Hannu Koivisto <azure@iki.fi>
X-From: git-owner@vger.kernel.org Mon Nov 03 10:11:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwvSr-0005y8-13
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 10:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754779AbYKCJJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 04:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754790AbYKCJJv
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 04:09:51 -0500
Received: from peff.net ([208.65.91.99]:4373 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754779AbYKCJJh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 04:09:37 -0500
Received: (qmail 29747 invoked by uid 111); 3 Nov 2008 09:09:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 03 Nov 2008 04:09:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Nov 2008 04:09:33 -0500
Content-Disposition: inline
In-Reply-To: <83od0yaxzk.fsf@kalahari.s2.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99915>

On Sun, Nov 02, 2008 at 06:33:51PM +0200, Hannu Koivisto wrote:

> It seems that, for example, glob pattern *.s matches files with .sh
> extension at least with checkout and reset --hard but git status
> thinks otherwise:

I think your analysis is incorrect. I will try to explain what is
happening.

> mkdir test
> cd test
> git init
> echo -e "*.sh -crlf\n*.s crlf" > .gitattributes
> echo -e "foobar\nfoobar\nfoobar" > kala.s
> echo -e "foobar\nfoobar\nfoobar" > kala.sh
> git add .gitattributes kala.s kala.sh
> git commit -m "Foo."

OK, so here we have two files, one of which we are telling git is text
and one of which we are telling git is not text. Since we don't have
autocrlf set at all, of course nothing happens here.

> git clone -n test test2

And here we clone without checking out, so there are no files yet.

> cd test2
> git config core.autocrlf true
> git checkout

And now we do check out the files, with autocrlf applied. But what are
we left with? When I run this, _both_ files were detected as text and
have CRLF line endings. So here I think is where git didn't do what you
expected: kala.sh should not have had CRLF conversion applied.

This is a known limitation of the attributes mechanism: it only reads
from .gitattributes in the filesystem (or from .git/info/attributes),
and not from the tree that is being checked out. This is something that
should be addressed, but nobody has stepped up with a patch yet (though
there has been some preliminary discussion).

> git status
> 
> # On branch master
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working
> # directory)
> #
> #       modified:   kala.sh
> #
> no changes added to commit (use "git add" and/or "git commit -a")

So yes, this status makes perfect sense, then. The file "kala.sh" has
CRLFs in the filesystem, but we have told git that it is not a file
which gets converted. So it looks like those CRs have been added.

The problem, again, is that we have inconsistently applied the
gitattributes. They were _not_ applied during checkout (because
.gitattributes did not exist yet), but they _are_ being applied here.

To "fix" this, you can then do a "git reset --hard" which will respect
your .gitattributes (since it is now checked out). And further file
creation and checkout should work OK.

-Peff
