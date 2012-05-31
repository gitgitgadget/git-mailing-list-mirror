From: Jeff King <peff@peff.net>
Subject: Re: bug? Python traceback on git push
Date: Wed, 30 May 2012 21:08:20 -0400
Message-ID: <20120531010820.GB5488@sigill.intra.peff.net>
References: <CA+u+8CLcUtTCkWN2bZvR8JNmgnCoX+TwRK3_e64zWaV__jOo7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Pedro Werneck <pjwerneck@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 31 03:08:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZtsL-0004Z0-0a
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 03:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757622Ab2EaBIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 21:08:24 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:36686
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757620Ab2EaBIW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 21:08:22 -0400
Received: (qmail 12303 invoked by uid 107); 31 May 2012 01:08:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 May 2012 21:08:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 May 2012 21:08:20 -0400
Content-Disposition: inline
In-Reply-To: <CA+u+8CLcUtTCkWN2bZvR8JNmgnCoX+TwRK3_e64zWaV__jOo7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198854>

On Wed, May 30, 2012 at 07:11:38PM -0300, Pedro Werneck wrote:

> git 1.7.9.5
> 
> I was pushing to a repository
> 
> push actually seems to have worked, but popped this weird python traceback

Not a bug in git. There is no python code at all in the push code path
(the only python in git these days is in the experimental svn
remote-helper). However, the remote side may have a hook that is written
in python...

> remote: Traceback (most recent call last):
> remote:   File "/opt/python/domains/bitbucket.org/current/bitbucket/scripts/git/hooks/pre-receive",
> line 9, in <module>
> remote:     from bitbucket.apps.repo2.hooks import prehooks
> [...]
> remote: ImportError: No module named mercurial.lock
> To git@bitbucket.org:titansgroup/tcf-api.git
>  ! [remote rejected] master -> master (pre-receive hook declined)
> error: failed to push some refs to 'git@bitbucket.org:titansgroup/tcf-api.git'

...and that is exactly what happened. Bitbucket's custom python hook
failed, and git did not allow the push to go through.

> (tcf-env)werneck@werneck:~/devel/tcf-api/src/tcf$ git pull
> Warning: Permanently added 'bitbucket.org,207.223.240.181' (RSA) to
> the list of known hosts.
> Already up-to-date.

I don't know that this shows anything conclusive; depending on your
configuration, you may or may not be pulling from the same ref you were
trying to push to a moment ago.

> (tcf-env)werneck@werneck:~/devel/tcf-api/src/tcf$ git push
> Warning: Permanently added 'bitbucket.org,207.223.240.181' (RSA) to
> the list of known hosts.
> Counting objects: 15, done.
> Delta compression using up to 4 threads.
> Compressing objects: 100% (8/8), done.
> Writing objects: 100% (8/8), 860 bytes, done.
> Total 8 (delta 7), reused 0 (delta 0)
> remote: bb/acl: pjwerneck is allowed. accepted payload.
> To git@bitbucket.org:titansgroup/tcf-api.git
>    16b3b54..a50f671  master -> master

And here you repeat the push, and you see that we had to send the data
again (because the push did not go through last time). No clue why their
hook failed the first time but not the second.

So as far as I can tell, git is operating as advertised. You might want
to file a report with bitbucket about their hook failing.

-Peff
