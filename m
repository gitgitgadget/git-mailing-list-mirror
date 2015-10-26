From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] detecting delete/modechange conflicts
Date: Mon, 26 Oct 2015 17:35:02 -0400
Message-ID: <20151026213502.GA17244@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 26 22:35:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqpQB-0005Zr-3V
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 22:35:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbbJZVfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 17:35:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:48140 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753161AbbJZVfF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 17:35:05 -0400
Received: (qmail 9343 invoked by uid 102); 26 Oct 2015 21:35:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Oct 2015 16:35:04 -0500
Received: (qmail 18019 invoked by uid 107); 26 Oct 2015 21:35:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Oct 2015 17:35:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Oct 2015 17:35:02 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280226>

I was surprised to find that:

  # base commit
  echo base >file &&
  git add file &&
  git commit -m base &&

  # one side changes mode
  chmod +x file &&
  git commit -am executable &&

  # the other deletes the file
  git checkout -b other HEAD^ &&
  git rm file &&
  git commit -am removed &&

  git merge master

silently completes the merge, dropping the mode change. We detect
delete/modify conflicts, but not delete/modechange conflicts.  The
trivial index merge does catch it, but both the resolve and recursive
strategies resolve it silently in favor of the deletion.

After looking through the history and the list archive, I don't _think_
this was intentional, and we simply missed the case in both places. But
maybe somebody else knows something I don't. It seems like we should be
punting to the user under the general principle of stupid and safe
merges.

  [1/3]: t6031: move triple-rename test to t3030
  [2/3]: t6031: generalize for recursive and resolve strategies
  [3/3]: merge: detect delete/modechange conflict

-Peff
