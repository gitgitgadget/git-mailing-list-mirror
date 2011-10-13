From: Jeff King <peff@peff.net>
Subject: Re: [Bug] git pull doesn't recognize --work-tree parameter
Date: Thu, 13 Oct 2011 14:37:09 -0400
Message-ID: <20111013183709.GB17573@sigill.intra.peff.net>
References: <E95C75ED-99F2-463C-A1AB-0F8152696739@jetbrains.com>
 <20111013155923.GA13134@sigill.intra.peff.net>
 <7vbotk6aae.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 20:37:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REQ9q-0006jL-2K
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 20:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017Ab1JMShR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 14:37:17 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59812
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751699Ab1JMShM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 14:37:12 -0400
Received: (qmail 27669 invoked by uid 107); 13 Oct 2011 18:37:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Oct 2011 14:37:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Oct 2011 14:37:09 -0400
Content-Disposition: inline
In-Reply-To: <7vbotk6aae.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183507>

On Thu, Oct 13, 2011 at 11:01:13AM -0700, Junio C Hamano wrote:

> I am not absolutely sure about "obviously correct", given that you assume
> that cd_to_toplevel does what its name makes you think it does.  I've been
> wondering if we want to do give a bit more sanity to "cd_to_toplevel" and
> "rev-parse --show-toplevel".
> 
>     $ pwd
>     /srv/project/git/git.git
>     $ (cd Documentation/howto && git rev-parse --show-toplevel); echo $?
>     /srv/project/git/git.git
>     0
> 
> So far so good, however:
> 
>     $ (cd .git/refs/heads && git rev-parse --show-toplevel); echo $?
>     0
> 
> I do not think this is quite right.

Ugh. You are right. I for some reason assumed that cd_to_toplevel would,
of all things, cd to the toplevel.  I think the right solution is to
introduce a "cd_to_work_tree_toplevel" (or similarly named) command that
always moves to the root of the work tree.

And then convert the two scripts in my patch to use it (along with the
change to require_work_tree_exists).  That would make my prior analysis
hold, then, as the annoying do-nothing behavior of "cd_to_toplevel" only
kicks in when we are outside the work tree (i.e., it could not have
happened before in those scripts, because the existing require_work_tree
call would cause us to die).

> We would probably want to add "rev-parse --show-work-tree", but we would
> need to audit the users of cd_to_toplevel before starting to use it.  I
> wouldn't be surprised if there is a script that creates a temporary work
> tree in .git/some/where and runs the scripted Porcelains without setting
> GIT_WORK_TREE, relying on the historical behaviour of cd_to_toplevel that
> does not really go to the top level.

Right. I suspect the proposed behavior for cd_to_toplevel is what they
all would want eventually, but some scripts may need minor tweaks. I
think we should follow the same path as require_work_tree_exists, and
introduce the new function, use it where we know it's safe, and then
eventually get rid of the old one.

The real trick is coming up with a good name, because cd_to_toplevel is
already taken. :)

-Peff
