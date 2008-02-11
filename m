From: Jeff King <peff@peff.net>
Subject: Re: limiting rename detection during merge is a really bad idea
Date: Mon, 11 Feb 2008 06:08:16 -0500
Message-ID: <20080211110816.GA6344@coredump.intra.peff.net>
References: <CF28A4AE-62F0-4E41-9794-2CF85C2C7855@zib.de> <20080211074817.GA18898@sigill.intra.peff.net> <8c5c35580802110241i72169620s693a31f9a098f596@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 12:09:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOWX4-0002hy-Nd
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 12:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbYBKLIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 06:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbYBKLIU
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 06:08:20 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2740 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761AbYBKLIT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 06:08:19 -0500
Received: (qmail 8210 invoked by uid 111); 11 Feb 2008 11:08:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 11 Feb 2008 06:08:17 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2008 06:08:16 -0500
Content-Disposition: inline
In-Reply-To: <8c5c35580802110241i72169620s693a31f9a098f596@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73516>

On Mon, Feb 11, 2008 at 11:41:05AM +0100, Lars Hjemli wrote:

> > It may also be that multiple rename limits are appropriate. I don't mind
> > waiting 30 seconds for rename detection during a particularly tricky
> > merge. I probably do when running 'git-log -p'.
> 
> Yeah, I guess we could add support for merge.renamelimit in addition
> to diff.renamelimit (i.e. use diff.renamelimit if merge.renamelimit is
> unspecified). And/or add the -l option of git-diff-* to
> git-merge.sh/merge-recursive.c.

Perhaps we should first figure out what reasonable default values are. I
think the reported problem was not "Oh, I didn't expect my tweaked
diff.renamelimit to affect merge" but rather "I didn't tweak
diff.renamelimit at all".

The mega-commit I was playing with that caused Linus to suggest
diff.renamelimit in the first place is 374 by 641 (src by dest) and
completes in ~15 minutes. The case recently reported in "git-revert is a
memory hog" is 3541 by 8043, and doesn't complete ever.  We limit to 100
by 100 by default.

Steffen, can you tell us how large your rename set is (unfortunately,
there is no way to get this information easily; you can stop
merge-recursive in the debugger at diffcore-rename.c:457 and look at
num_src and num_create). And how long it takes to run with
diff.renamelimit turned off?

That might give us a clue where a reasonable value is.

-Peff
