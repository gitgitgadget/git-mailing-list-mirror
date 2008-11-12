From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 0/4] deny push to current branch of non-bare repo
Date: Wed, 12 Nov 2008 03:44:13 -0500
Message-ID: <20081112084412.GA3860@coredump.intra.peff.net>
References: <20081107220730.GA15942@coredump.intra.peff.net> <7v3ai3f7oa.fsf@gitster.siamese.dyndns.org> <20081108142756.GC17100@coredump.intra.peff.net> <7vwsfeaqpa.fsf@gitster.siamese.dyndns.org> <20081109014926.GA31276@coredump.intra.peff.net> <f73f7ab80811111644y14f0e0ccweed44440356a6508@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>
To: Kyle Moffett <kyle@moffetthome.net>
X-From: git-owner@vger.kernel.org Wed Nov 12 09:45:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0BLv-00068w-In
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 09:45:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbYKLIoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 03:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbYKLIoP
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 03:44:15 -0500
Received: from peff.net ([208.65.91.99]:3185 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751402AbYKLIoP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 03:44:15 -0500
Received: (qmail 17851 invoked by uid 111); 12 Nov 2008 08:44:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Nov 2008 03:44:14 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Nov 2008 03:44:13 -0500
Content-Disposition: inline
In-Reply-To: <f73f7ab80811111644y14f0e0ccweed44440356a6508@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100731>

On Tue, Nov 11, 2008 at 07:44:06PM -0500, Kyle Moffett wrote:

> Hmm, I wonder if it would be possible to also add a "detach" variant;
> which would create a detached-HEAD at the current commit when
> automatically receiving a push to the working branch.  I have a
> post-receive script that does so right now on a couple repositories.
> It's still a little confusing to someone actively working in the
> repository being pushed to, but it's much easier to explain than the
> current default behavior.

A neat idea, but I'm not sure what workflow that is meant to support.

Before you had:

  1. git push non-bare-remote theirHEAD
  2a. echo Oops, I've just screwed myself.
    3a. ssh remote 'git reset --soft HEAD@{1}'
  2b. echo Oops, I just screwed somebody else.
    3b. echo sorry | mail somebody.else

With "refuse" you have:

  1. git push non-bare-remote theirHEAD
  2. echo Oops, rejected.
  3. git push non-bare-remote theirHEAD:elsewhere
  4a. ssh remote 'git merge elsewhere'
  4b. echo 'please merge elsewhere' | mail somebody.else

which is an improvement. With "detach" you have:

  1. git push non-bare-remote theirHEAD
  2. echo Oh, now we've detached on the remote.
  3a. ssh remote 'git checkout theirHEAD'
  3b. echo 'please merge theirHEAD. BTW, you have been detached without
            realizing it, so make sure you didn't lose any commits.' |
            mail somebody.else

So I think in the case that you are working by yourself, you haven't
really saved much effort (you didn't have to repeat your push, but you
still have to go to the remote and checkout instead of merge). But if
you are pushing into somebody _else_'s repo, you have just mightily
confused them as they start to make commits on top of the detached HEAD.

Still, there may be some instances where moving to the detached HEAD is
preferable. But, like the "try to merge if we can" strategy, I think it
is better implemented by setting denyCurrentBranch to ignore and using a
hook for those instances. And if either hook becomes ubiquitous, maybe
it will be worth implementing within git itself (but I doubt it for
either, as the desired behavior is highly dependent on your personal
workflow).

-Peff
