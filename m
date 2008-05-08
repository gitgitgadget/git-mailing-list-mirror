From: Jeff King <peff@peff.net>
Subject: [BUG] deadlock in tellme-more extension
Date: Thu, 8 May 2008 00:16:13 -0400
Message-ID: <20080508041613.GA11768@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 08 06:17:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtxZ2-00041r-AV
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 06:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbYEHEQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 00:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbYEHEQN
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 00:16:13 -0400
Received: from peff.net ([208.65.91.99]:2783 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303AbYEHEQM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 00:16:12 -0400
Received: (qmail 19776 invoked by uid 111); 8 May 2008 04:16:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 08 May 2008 00:16:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 May 2008 00:16:13 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81505>

I am getting a reproducible hang in "git push" and I think it is related
to the tellme-more extension in next.

Unfortunately, I am having trouble making it happen with a small test,
but it does work with this:

  git clone git://git.kernel.org/pub/scm/git/git.git parent &&
  mkdir child && (cd child && git init) &&
  cd parent &&
  git push ../child refs/tags/* &&
  git push ../child master

The sender does a "tellme-more" and then waits for a line back. The
receiver gets the tellme-more, but never says anything else, presumably
because he doesn't have that commit (because master is ahead of any
tags).

I think that the problem might be that in main, the tellme_more variable
serves two purposes: it holds the list of things to tell more about, but
it also serves as a flag to start the history exchange (which needs to
end with a packet_flush to alert the other side). So it seems that the
receiver never puts anything on that list (because we don't know
anything about the mentioned commit; see parse_tellme_more), but then we
never remember that tellme-more was mentioned, so we don't proceed with
sending a NULL list.

So the simple fix is to keep a separate "we should do the history
exchange" variable. But I might be missing something more subtle
happening. And obviously my test script sucks, but I'm not quite sure
how to re-create the problematic situation.

-Peff
