From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] cherry-pick: Add an option to prepend a string to the
 commit message
Date: Sat, 12 Jun 2010 02:28:12 -0400
Message-ID: <20100612062812.GA12685@coredump.intra.peff.net>
References: <1276319237-12010-1-git-send-email-bobbypowers@gmail.com>
 <20100612055831.GA2426@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bobby Powers <bobbypowers@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 12 08:28:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONKCd-0004VD-A3
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 08:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656Ab0FLG2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 02:28:17 -0400
Received: from peff.net ([208.65.91.99]:38569 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544Ab0FLG2P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 02:28:15 -0400
Received: (qmail 18534 invoked by uid 107); 12 Jun 2010 06:28:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 12 Jun 2010 02:28:27 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Jun 2010 02:28:12 -0400
Content-Disposition: inline
In-Reply-To: <20100612055831.GA2426@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148991>

On Sat, Jun 12, 2010 at 12:58:32AM -0500, Jonathan Nieder wrote:

> I would be interested to hear from those who might know whether
> something generic like the applypatch-msg hook could work (which is
> not to say a convenient command-line option would not be handy to have
> in addition to that.)

What bothers me is how specific this munging is. What if I want to
append to the message? Or put something after the subject line, but
before the commit body? Or add a pseudo-header (like signed-off-by) to
the set of pseudo-headers at the end, properly adding a newline if it is
the first such pseudo-header.

FWIW, we can already do this kind of stuff with:

  GIT_EDITOR="sed -i 1i$prefix" git cherry-pick -e $ref

or

  git cherry-pick -n $ref &&
  sed -i 1i$prefix .git/MERGE_MSG
  GIT_EDITOR=true git commit

I'll admit the first one is not very intuitive. But it is easy to script
around the second form. For one of my examples, I would probably do:

  git cherry-pick -n $ref &&
  git log -1 --format='%s%n%ncontent between subject and body%n%b' |
  git commit -F -

The specifics aren't important, but I think you can see that the "don't
commit automatically, make a message as you like, and then use the
regular message-specifiers for commit to commit it" technique is pretty
straightforward and very flexible.

It's obviously more typing for occasional interactive use, but in that
case, why not just use "git cherry-pick -e" and use your editor?

-Peff
