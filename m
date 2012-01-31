From: Jeff King <peff@peff.net>
Subject: Re: Alternates corruption issue
Date: Tue, 31 Jan 2012 17:42:40 -0500
Message-ID: <20120131224240.GA3844@sigill.intra.peff.net>
References: <1328018729.13744.26.camel@ted>
 <20120131193922.GA31551@sigill.intra.peff.net>
 <7v1uqf8vqu.fsf@alter.siamese.dyndns.org>
 <20120131204417.GA30969@sigill.intra.peff.net>
 <20120131214047.GA13547@burratino>
 <20120131214740.GA2465@sigill.intra.peff.net>
 <20120131215501.GF13252@burratino>
 <20120131220510.GA3253@sigill.intra.peff.net>
 <20120131222258.GG13252@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	"Hart, Darren" <darren.hart@intel.com>,
	"Ashfield, Bruce" <Bruce.Ashfield@windriver.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 31 23:42:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsMPb-0002R1-0v
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 23:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755475Ab2AaWmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 17:42:45 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51232
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753671Ab2AaWmm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 17:42:42 -0500
Received: (qmail 2928 invoked by uid 107); 31 Jan 2012 22:49:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 31 Jan 2012 17:49:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Jan 2012 17:42:40 -0500
Content-Disposition: inline
In-Reply-To: <20120131222258.GG13252@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189478>

On Tue, Jan 31, 2012 at 04:22:58PM -0600, Jonathan Nieder wrote:

> Forgetting the algorithms:
> 
>  (A) means "find what repository we are in the worktree for, or,
>  barring that, what bare repository we are in".
> 
>  (B) means "find which repository the user pointed to.  To be extra
>  nice, we allow a '.git' extension to be left out, so the URL used
>  doesn't have to include the redundant information that this is a
>  git repository, and we even allow pointing to the toplevel of a
>  worktree instead of a repository, too."

I can see that as a plausible interpretation. But I think your "means"
is kind of vague.  In other words, we are assigning a meaning that is
not actually documented anywhere, and which we are hoping matches user
expectations. So the correct behavior kind of depends on your mental
model. IOW, I find your mental model plausible, but it is not the one
that I had.

But like I said, I'm OK either way. I'll prepare this fix with the least
behavior change possible. Then doing your change on top should be a
trivial rearrangement of the lookup arrays (the "hard" part for your
proposed change is adding in the is_git_directory() calls[1], but I'll
do that as part of mine).

> I admit part of the reason I care is that just putting "" first would
> probably taken care of the more important part of
> <http://bugs.debian.org/399041>.

Would that fix it? If I understand it, the repo in question is bare with
a ".git" directory inside it. Your proposed change would make "git
ls-remote foo" work, but wouldn't "cd foo && git log" still be broken?
At the very least, it would show a completely different repo than
ls-remote.

-Peff

[1] Without the is_git_directory() check, the ordering you propose
    breaks things very badly. Because if I point to a non-bare directory
    "foo", we say "OK, foo exists" and never look at "foo/.git". So
    instead, we have to say "OK, foo exists, but hey, it looks nothing
    like a .git directory" and keep trying.
