From: Jeff King <peff@peff.net>
Subject: Re: what are the chances of a 'pre-upload' hook?
Date: Fri, 25 Nov 2011 09:40:07 -0500
Message-ID: <20111125144007.GA4047@sigill.intra.peff.net>
References: <CAMK1S_jaEWV=F6iHKZw_6u5ncDW0bPosNx-03W9bOLOfEEEY1Q@mail.gmail.com>
 <CAMK1S_gh_CsWc-DnbOuUwn+H1i3skm99xzDbWe-wxsKKS0Qw-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 25 15:40:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTwwr-0002x2-Nd
	for gcvg-git-2@lo.gmane.org; Fri, 25 Nov 2011 15:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755800Ab1KYOkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Nov 2011 09:40:10 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43644
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755724Ab1KYOkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2011 09:40:09 -0500
Received: (qmail 5022 invoked by uid 107); 25 Nov 2011 14:46:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Nov 2011 09:46:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Nov 2011 09:40:07 -0500
Content-Disposition: inline
In-Reply-To: <CAMK1S_gh_CsWc-DnbOuUwn+H1i3skm99xzDbWe-wxsKKS0Qw-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185931>

On Fri, Nov 25, 2011 at 09:43:14AM +0530, Sitaram Chamarty wrote:

> The quick summary, in the words of Jeff (second post in that link) is:
> "Because [upload]-pack runs as the user who is [fetching], not as the
> repository owner. So by convincing you to [fetch from] my repository
> in a multi-user environment, I convince you to run some arbitrary code
> of mine."
> 
> My contention (today) is:
> 
>   - you're already taking that risk for push
>   - so this would add a new risk only for people who fetch but don't push
>   - which, I submit, is a very small (if not almost empty) set of people
> 
> I may be wrong but I imagine shared environments are those where
> almost everyone will push at least once in a while.  It's a closed
> group of people, probably all developers, etc etc etc...

One thing to note is that this is _only_ an issue on systems where the
user running upload-pack (or receive-pack, for push) is not the same as
the user who owns the hooks directory. So basically two situations:

  1. Alice and Bob are developers on a multi-user system with ssh
     access. Alice will run "git fetch ~bob/project.git" or "git fetch
     alice@server:~bob/project.git". She executes Bob's hooks as
     herself on the server.

  2. Somebody runs a git:// server, locked down under a "git" user (or a
     smart-http server, under a "www" account).  If users of the service
     can write their own hooks, they will run as the "git" user.

But there are many situations that don't fall under this umbrella. In
(1), maybe Alice and Bob decide that they trust each other enough, and
the hook is more important than the security issue. In (2), users of the
service might not be able to write their own hooks (this is the case for
GitHub, and I assume also for Gerrit).

There should be a way for people who aren't in one of those dangerous
situations to be able to use a hook. The important thing is to set the
defaults in such a way that the people who _are_ in that situation
aren't left in a vulnerable situation.

The easiest way would be something like a "trust remote hooks"
environment variable, off by default. Admins in situation (2) could set
it for their git-daemon (or webserver, or whatever, or
gitolite-over-ssh), once they decided it was safe.

It could also help with (1), but I think you would need to take special
steps to propagate the variable in the "git fetch server:project.git"
case.

-Peff
