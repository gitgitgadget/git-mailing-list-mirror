From: Jeff King <peff@peff.net>
Subject: Re: Friendly refspecs
Date: Tue, 22 Apr 2008 16:12:22 -0400
Message-ID: <20080422201222.GC29313@sigill.intra.peff.net>
References: <20080409203453.GA10370@sigill.intra.peff.net> <20080409222500.GB19248@mithlond> <20080409225112.GB12103@sigill.intra.peff.net> <20080413093102.GC12107@mithlond.arda.local> <20080416034823.GA11727@sigill.intra.peff.net> <alpine.LNX.1.00.0804161126280.19665@iabervon.org> <7vod89pnxx.fsf@gitster.siamese.dyndns.org> <20080422105658.GA11238@sigill.intra.peff.net> <7v63u9zva9.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0804221259180.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Apr 22 22:13:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoOrY-0008C3-40
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 22:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173AbYDVUMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 16:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753015AbYDVUMZ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 16:12:25 -0400
Received: from peff.net ([208.65.91.99]:1795 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752351AbYDVUMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 16:12:25 -0400
Received: (qmail 15891 invoked by uid 111); 22 Apr 2008 20:12:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 22 Apr 2008 16:12:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Apr 2008 16:12:22 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0804221259180.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80163>

On Tue, Apr 22, 2008 at 01:19:35PM -0400, Daniel Barkalow wrote:

> That's no good for people who make lightweight tags, since those will be 
> commits, and "git push <remote> tag:tag" would push refs/tags/tag to 
> refs/heads/tag.

Yes.

> But I think the proposal was for "git push $there $name:$name", where name 
> gets expanded locally to refs/heads/$name, which I think should probably 
> work. I think it should require $name to be unambiguous locally, though, 
> because it wouldn't be too unusual for people to end up with the same name 
> for a branch and a lightweight tag, and then try pushing that name, 
> expecting one or the other to get pushed.

Ambiguity is already handled when we resolve the left-hand side of the
refspec:

  $ git branch foo
  $ git tag foo
  $ git push origin foo
  error: src refspec foo matches more than one.
  fatal: The remote end hung up unexpectedly
  error: failed to push some refs to '/home/peff/foo/parent/.git'

I guess you could say something like:

  $ git branch dest
  $ git tag dest
  $ git push origin master:dest

and the "dest" here will become a branch. But that is because it has
nothing to do with your local refs called "dest": the right-hand side is
purely a remote matter. If the remote has an ambiguous "dest", then we
already handle that case:

  $ cd ../parent && git branch dest && git tag dest
  $ cd ../child && git push origin master:dest
  error: dst refspec dest matches more than one.
  fatal: The remote end hung up unexpectedly
  error: failed to push some refs to '/home/peff/foo/parent/.git'

-Peff
