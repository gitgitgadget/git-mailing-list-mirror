From: Jeff King <peff@peff.net>
Subject: Re: Question regarding git fetch
Date: Thu, 27 Aug 2009 17:39:24 -0400
Message-ID: <20090827213924.GE4399@coredump.intra.peff.net>
References: <1251387045053-3527289.post@n2.nabble.com>
 <32541b130908270836m50553ccatddf4c870eec54ddb@mail.gmail.com>
 <7viqg9q7gx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Tom Lambda <tom.lambda@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 23:39:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgmhC-0003jQ-IB
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 23:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232AbZH0VjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 17:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753217AbZH0VjY
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 17:39:24 -0400
Received: from peff.net ([208.65.91.99]:40011 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753206AbZH0VjY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 17:39:24 -0400
Received: (qmail 723 invoked by uid 107); 27 Aug 2009 21:39:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 27 Aug 2009 17:39:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Aug 2009 17:39:24 -0400
Content-Disposition: inline
In-Reply-To: <7viqg9q7gx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127217>

On Thu, Aug 27, 2009 at 02:20:46PM -0700, Junio C Hamano wrote:

> I think it is reasonable, in 1.7.0, to change "git fetch" with command
> line refspacs that lack colon (i.e. saying "fetch this ref" without saying
> "and store it here") so that it updates remote tracking refs if and only
> if an appropriate remote.$remote.fetch is configured to do so.  E.g. when
> I fetch from Eric for git-svn updates with
> 
> 	$ git pull git-svn master
> 
> because I do have
> 
> 	[remote "git-svn"]
>                 url = git://yhbt.net/git-svn
>                 fetch = +refs/heads/*:refs/remotes/git-svn/*

Does the colon really matter? That is, should

  $ git fetch git-svn master

store a tracking ref, but

  $ git fetch git-svn master:foo

not? In both cases, git has learned during the course of an operation
what the new value of the tracking ref could be, so why not store it?

The obstacle I see is that somebody may be using configured refspecs as
something other than a tracking ref. That is, they care about _when_
those refs on the RHS of the refspec are updated, and are not treating
them just as a cache of what the remote side has.

> On the other hand, if my refspecs for "git svn" _were_ like this:
> 
> 	[remote "git-svn"]
> 		url = git://yhbt.net/git-svn
>                 fetch = +refs/heads/master:refs/remotes/git-svn/master
> 
> then I would _not_ want this:
> 
> 	$ git fetch git-svn dev
> 
> to create a new tracking branch refs/remotes/git-svn/dev.

Of course not. It's not in your configured refspec, so you have
requested no such tracking ref. I think we would have to limit ourselves
to how the tracking refs are defined in the refspecs. Otherwise how
would we know to put the tracking ref in refs/remotes/git-svn and not
some other place?

So I think it is a simple matter of applying the configured refspecs
with information we happen to have gotten during the course of a
somewhat-related operation.

-Peff
