From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 7 Feb 2008 00:05:49 -0500
Message-ID: <20080207050548.GA32242@sigill.intra.peff.net>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org> <7vodavd9qw.fsf@gitster.siamese.dyndns.org> <7vbq6tset4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 06:06:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMyy5-0004yH-QD
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 06:06:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbYBGFFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 00:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbYBGFFw
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 00:05:52 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2030 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbYBGFFv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 00:05:51 -0500
Received: (qmail 9113 invoked by uid 111); 7 Feb 2008 05:05:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 07 Feb 2008 00:05:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Feb 2008 00:05:49 -0500
Content-Disposition: inline
In-Reply-To: <7vbq6tset4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72892>

On Wed, Feb 06, 2008 at 06:03:51PM -0800, Junio C Hamano wrote:

> * lh/gitdir (Mon Feb 4 21:59:21 2008 +0100) 4 commits
>  - git-submodule: prepare for the .git-file
>  - Add tests for .git file
>  - Document the .git-file
>  - Add platform-independent .git "symlink"
> 
> Seems to have funny interaction with Jeff King's test script
> updates.

I think this is a bug in Lars' code. The problem is that even though we
set GIT_DIR to the contents of the '.git' file, we may already have run
setup_git_env, which creates and remembers paths like '.git/objects'.

It worked with the old tests because we set GIT_CONFIG, which meant that
looking at the config didn't require actually finding the .git
directory. But now that we don't set GIT_CONFIG, setup_git_env gets
called much earlier (to find the right config file). And I think this is
a vindication of my change, since it reflects real world usage much more
-- I can't even get the hash-object test to pass if I do it by hand,
even though the test script passed.

The solution is probably to intercept the lookup of the .git directory
in setup_git_env, and read the .git file there (this should probably get
pulled out as a git_dir() function or similar).

-Peff
