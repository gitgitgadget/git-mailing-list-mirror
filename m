From: Jeff King <peff@peff.net>
Subject: Re: git-diff should not fire up $PAGER if there is no diff
Date: Mon, 15 Dec 2008 19:56:58 -0500
Message-ID: <20081216005658.GB3679@coredump.intra.peff.net>
References: <874p15x94i.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Tue Dec 16 01:58:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCOGT-0007dT-2G
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 01:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbYLPA5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 19:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbYLPA5B
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 19:57:01 -0500
Received: from peff.net ([208.65.91.99]:3099 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751624AbYLPA5B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 19:57:01 -0500
Received: (qmail 9330 invoked by uid 111); 16 Dec 2008 00:56:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 15 Dec 2008 19:56:59 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Dec 2008 19:56:58 -0500
Content-Disposition: inline
In-Reply-To: <874p15x94i.fsf@jidanni.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103224>

On Tue, Dec 16, 2008 at 08:21:33AM +0800, jidanni@jidanni.org wrote:

> git-diff should not fire up $PAGER if there is no diff output.
> Just exit. The man page doesn't even mention $PAGER too.

I agree that would be nice, but it is a little difficult to implement.
The current behavior forks early and then pipes the output to the pager.
So we would have to:

  1. change that behavior to instead delay starting the pager until the
     first output. Which means intercepting every
     write/fwrite/printf/fputs/etc call.

  2. detect EOF before starting the pager. We in fact already delay
     running the pager in the forked process until we have some activity
     on the pipe, but I don't know if there is a portable way of
     detecting that that activity is EOF without performing an actual
     read() call (which is undesirable, since it eats the first byte of
     output that should go to the pager).

  3. a hacky solution to (2) above would be to make _2_ pipes, one of
     which signals to the pager sub-process either "exit now" or "proceed
     with running the pager".

The usual workaround is to ask the pager to exit immediately if the
output is small. I.e., putting "F" in your LESS variable (which git does
automatically if you don't already have LESS set).

-Peff
