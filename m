From: Jeff King <jrk@wrek.org>
Subject: Re: [PATCH] git commit: Repaint the output format bikeshed (again)
Date: Wed, 1 Oct 2008 18:06:04 -0400
Message-ID: <20081001220604.GB18058@coredump.intra.peff.net>
References: <20081001154425.GE21310@spearce.org> <48E3E66E.7020501@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Oct 02 00:14:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl9xH-0004ZF-Tx
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 00:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbYJAWMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 18:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753386AbYJAWMs
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 18:12:48 -0400
Received: from peff.net ([208.65.91.99]:4791 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753369AbYJAWMs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 18:12:48 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Oct 2008 18:12:47 EDT
Received: (qmail 22193 invoked by uid 111); 1 Oct 2008 22:06:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 01 Oct 2008 18:06:05 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Oct 2008 18:06:04 -0400
Content-Disposition: inline
In-Reply-To: <48E3E66E.7020501@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97276>

On Wed, Oct 01, 2008 at 11:06:54PM +0200, Andreas Ericsson wrote:

> of the commit result output. To make it read properly
> we get rid of "Created", which I just can't fit into
> a sentence without putting the branch-name last.

All of the other proposals indicate the hash and subject as the object
of creation. IOW, "created: <hash>: subject" or similar.

> Having taken inspiration from the "git reset" command,
> output for the three conceivable cases now look thus:
>
>  normal commit
>  <branch> is now at b930c4a (i386: Snib the sprock)

I think I still like your other proposal:

  [branch] created b930c4a: "i386: Snib the sprock"

better. But in the interests of just agreeing on something, I am willing
to accept this. FWIW, the git-reset command doesn't use any delimiter
for the message:

   <branch> is now at <hash> <subject>

So perhaps they should be the same. I don't think it overly matters.

>  detached commit
>  DETACHED HEAD is now at b930c4a (i386: Snib the sprock)

You mentioned the shouty caps before. I think "detached HEAD" is
probably caps enough, but not enough to argue for it (I just want to
mention as an informal vote if Shawn wants to mark it up while
applying).

>  initial commit
>  History has begun anew. Root-commit created.
>  <branch> is now at bc930c4a (i386: Snib the sprock)

Heh.

> "Created" is a problem when one wants to put branch-name before the
> subject line, because the subject has to follow the hash (it doesn't
> describe the pre-state of the branch/detached head), but the newly
> added commit. "Created, on branch, hash (subject)" just looks
> stilted and stupid, so I had to change it. Hopefully this can be
> accepted. If not, count me out.

That was the reason for the helper function that was deleted. It
actually created a format string like "Created %h on <branch>: %s" and
properly escaped the percents in <branch>. So you would have to keep it
if you wanted to interleave the data (but I think what you have is
better -- the branch name or the detached status is the thing that
should be first).

> I'm not sure if the last "else" case setting branch = head; can
> ever happen, but I figured it can't hurt to make sure. Feel free
> to modify commentary around it or the entire section when applying.

It should definitely be there, if only for the sanity of future
expansion (and because I can technically put whatever ref I want into
HEAD :) ).

> -		printf("%s\n", buf.buf);
> -		strbuf_release(&buf);
> +		printf("%s\n", strbuf_detach(&buf, NULL));

This change is bogus. "release" frees a strbuf. "detach" says "Give me
the buffer, and I will take care of freeing it later myself". So you
introduced a leak.

-Peff
