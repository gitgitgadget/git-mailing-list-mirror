From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] allow setting GIT_WORK_TREE to "no work tree"
Date: Thu, 7 Feb 2008 00:13:18 -0500
Message-ID: <20080207051317.GA32296@sigill.intra.peff.net>
References: <20080206102608.GA1007@coredump.intra.peff.net> <47A98F07.4000402@viscovery.net> <20080206110131.GA4167@coredump.intra.peff.net> <7v4pclvmae.fsf@gitster.siamese.dyndns.org> <7vwsphu7gr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Lars Hjemli <hjemli@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 06:13:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMz5A-0006Hf-2H
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 06:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbYBGFNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 00:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbYBGFNV
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 00:13:21 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3359 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325AbYBGFNU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 00:13:20 -0500
Received: (qmail 9169 invoked by uid 111); 7 Feb 2008 05:13:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 07 Feb 2008 00:13:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Feb 2008 00:13:18 -0500
Content-Disposition: inline
In-Reply-To: <7vwsphu7gr.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72893>

On Wed, Feb 06, 2008 at 12:59:32PM -0800, Junio C Hamano wrote:

> I do not like the magic GIT_WORK_TREE=: which is simply
> illogical.  GIT_EDITOR=: made perfect sense (":" is actually a
> command that succeeds without doing anything), but ":" does not
> have anything to do with "there is no such path".

No, it doesn't, but they are both no-ops. Sort of. I agree the reasoning
is stretched, but I think we are just going to have to choose _some_
arbitrary value.

Unless you want to switch it to a "git set GIT_DIR automatically,
so don't pretend the user set it" flag variable.

> I was tempted to suggest GIT_WORK_TREE=/dev/null because that is
> what "diff" uses to mark "this does not even exist", but that
> feels dirty.

It feels dirty to me, too. I would rather choose something that doesn't
even look like a path. I think GIT_WORK_TREE=" " is too ugly, too.

Also, having just looked at the '.git-file' code, it does the same thing
(setting GIT_DIR even though the user didn't explicitly ask for it), so
it will need a similar fix. Which makes me lean towards just setting a
"we set this behind the user's back" flag, since that code won't even
have anything to do with the worktree.

In fact, the more I think about it, that makes sense. WORK_TREE munging
just happens to be the only special behavior right now that depends on
whether the user manually set GIT_DIR. But what we really want to
communicate to later code is not "I have corrected this particular
munge" but "don't run any special behavior as a result of this variable
being set."

-Peff
