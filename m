From: Jeff King <peff@peff.net>
Subject: Re: Git ksshaskpass to play nice with https and kwallet
Date: Wed, 5 Oct 2011 14:01:25 -0400
Message-ID: <20111005180125.GC22962@sigill.intra.peff.net>
References: <4E8ADDCF.6090406@drmicha.warpmail.net>
 <20111004105008.GA11789@sigill.intra.peff.net>
 <4E8AEDBD.4070404@drmicha.warpmail.net>
 <20111004113713.GA19171@sigill.intra.peff.net>
 <4E8AF812.5090906@drmicha.warpmail.net>
 <20111004124344.GA30162@sigill.intra.peff.net>
 <4E8B5553.2080706@drmicha.warpmail.net>
 <20111005175536.GB22962@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Oct 05 20:01:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBVmf-0000XC-2b
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 20:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935124Ab1JESB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 14:01:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53958
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934524Ab1JESB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 14:01:27 -0400
Received: (qmail 983 invoked by uid 107); 5 Oct 2011 18:01:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Oct 2011 14:01:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Oct 2011 14:01:25 -0400
Content-Disposition: inline
In-Reply-To: <20111005175536.GB22962@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182872>

On Wed, Oct 05, 2011 at 01:55:36PM -0400, Jeff King wrote:

> On Tue, Oct 04, 2011 at 08:49:55PM +0200, Michael J Gruber wrote:
> 
> > We seem to mean something different:
> > 
> > git config --get remote.bitbucket.pushurl
> > https://grubix@bitbucket.org/grubix/git.git
> > SSH_ASKPASS= git push -n bitbucket
> > Username for 'bitbucket.org':
> > 
> > I mean that git should not need to ask for the username here.
> 
> No, we are in agreement about the intended behavior. I think you are
> seeing a bug. What version of git produced it?
> 
> With my http-auth series, I get:
> 
>   $ git push https://github.com/peff/git.git
>   Username for 'github.com':
> 
>   $ git push https://peff@github.com/peff/git.git
>   Password for 'github.com':
> 
> Using v1.7.7 produces similar results.

Hrm. I do get this, with the same version of git:

  $ git config remote.foo.url https://github.com/peff/git.git
  $ git push foo
  Username for 'github.com':

  $ git config remote.foo.url https://peff@github.com/peff/git.git
  $ git push foo
  Password for 'github.com':

So far so good. Now how about this:

  $ git config remote.foo.url https://github.com/peff/git.git
  $ git config remote.foo.pushurl https://peff@github.com/peff/git.git
  $ git push foo
  Username for 'github.com':

So I think the problem is with pushurl, not with the auth code. Oddly,
though, running GIT_TRACE reveals:

  $ GIT_TRACE=1 git push foo
  trace: built-in: git 'push' 'foo'
  trace: run_command: 'git-remote-https' 'foo' 'https://peff@github.com/peff/git.git'

which is the right URL. So it's almost as if we are throwing away the
passed URL in favor of the configuration, and then looking up the
configuration wrong. I'm about to go get on a plane, so I don't have
more time to look at it now, but I suspect it's something simple and
stupid.

-Peff
