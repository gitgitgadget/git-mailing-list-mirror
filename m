From: Jeff King <peff@peff.net>
Subject: Re: Pretty date option for git tag?
Date: Mon, 18 May 2009 17:27:31 -0400
Message-ID: <20090518212731.GA14050@coredump.intra.peff.net>
References: <20090518151440.GA10536@andros.its.yale.edu> <alpine.LFD.2.01.0905181015080.3301@localhost.localdomain> <20090518174547.GA14509@sigill.intra.peff.net> <200905182311.41876.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	dloewenherz@gmail.com, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon May 18 23:27:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6AN4-0006Ls-3r
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 23:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647AbZERV1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 17:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753283AbZERV1c
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 17:27:32 -0400
Received: from peff.net ([208.65.91.99]:46100 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752753AbZERV1c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 17:27:32 -0400
Received: (qmail 19724 invoked by uid 107); 18 May 2009 21:27:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 18 May 2009 17:27:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 18 May 2009 17:27:31 -0400
Content-Disposition: inline
In-Reply-To: <200905182311.41876.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119465>

On Mon, May 18, 2009 at 11:11:37PM +0200, Thomas Rast wrote:

> Jeff King wrote:
> > It seems like you should be able to script around for-each-ref and
> > remain efficient, but I don't think there is a way to convince it to
> > dereference tags.
> 
> Actually there's the * operator.  For example
> 
>   git$ git for-each-ref --format="%(objecttype) %(*objecttype)" refs/tags/v1.6.0
>   tag commit
> 
> Does that solve the problem at hand?

Oh, right, thanks. I missed that when reading the manual (I was looking
for "dereference" or "peel", but those words are never used). So you can
do:

  git for-each-ref --format='%(refname)
  Tag: %(taggername) %(taggeremail) %(taggerdate)
  Commit: %(*authorname) %(*authoremail) %(*authordate)
  ' refs/tags

to show both.

That could go in an alias, though it isn't exactly what the original
poster asked for. Besides not being a one-line format, it has refs/tags/
cruft at the beginning of each ref. I think what the OP asked for
exactly is:

  eval "`git for-each-ref --shell --format='
    r=%(refname)
    d=%(taggerdate)
    T=${r#refs/tags/}
    echo "$T $d"
    ' refs/tags`"

Though as Linus said, I think the actual commit date is also interesting
(and you could expand that shell snippet to show it instead, in addition
to, or whatever).

And before anyone says anything, yes, I think building a shell script
and eval'ing it is a little ugly compared to a "--show-date" option to
"git tag". If this is something a lot of people want to do, it wouldn't
be that hard an option to add (in fact, it would be really nice to unify
the show-ref and pretty=format substitutions, and extend them into "git
tag --format='%r %td'" or whatever).

-Peff
