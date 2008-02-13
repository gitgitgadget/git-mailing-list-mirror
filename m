From: Jeff King <peff@peff.net>
Subject: Re: git-archive for files changed in revision range
Date: Wed, 13 Feb 2008 08:43:13 -0500
Message-ID: <20080213134313.GA3617@coredump.intra.peff.net>
References: <20080213130304.GA19957@grahamcox.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Graham Cox <graham@grahamcox.co.uk>
X-From: git-owner@vger.kernel.org Wed Feb 13 14:44:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPHtv-0003dB-Gx
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 14:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533AbYBMNnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 08:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753359AbYBMNnR
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 08:43:17 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4821 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753420AbYBMNnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 08:43:16 -0500
Received: (qmail 15853 invoked by uid 111); 13 Feb 2008 13:43:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 13 Feb 2008 08:43:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Feb 2008 08:43:13 -0500
Content-Disposition: inline
In-Reply-To: <20080213130304.GA19957@grahamcox.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73791>

On Wed, Feb 13, 2008 at 01:03:04PM +0000, Graham Cox wrote:

> The command line I used was something like (This is mostly from memory):
> git-archive --format=zip . `git-whatchanged <start>..HEAD --pretty=oneline 
>   | grep '^:' | sed 's/^.*\t//'` > release.zip

That will list files multiple times if they were modified in more than
one commit. And really, there's no need to walk the history. You really
are just comparing against two points (your baseline and your current
state). Walking the history will also erroneously include files which
changed, but then reverted back to their original state (though I expect
that is the uncommon case).

How about:

  # mark our start point for this and future releases
  git tag baseline `git rev-list HEAD | tail -n 1`

  # find files which differ between then and now; but we only need
  # to care about added and modified files, since deleted ones
  # don't need to be shipped
  git diff --diff-filter=AM --raw baseline HEAD | awk '{print $6}' >files

  # and archive
  git archive --format=zip HEAD `cat files`

You can even use diff's "-z" option if you have filenames that are hard
to quote, but I will leave that as an exercise to the reader.

-Peff
