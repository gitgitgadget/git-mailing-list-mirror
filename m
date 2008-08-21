From: Jeff King <peff@peff.net>
Subject: [tig PATCH] continue updates when pipe read has errno "Success"
Date: Wed, 20 Aug 2008 21:40:44 -0400
Message-ID: <20080821014043.GA14452@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 03:42:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVzBU-0002f8-5u
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 03:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbYHUBkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 21:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752019AbYHUBkr
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 21:40:47 -0400
Received: from peff.net ([208.65.91.99]:3887 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751673AbYHUBkr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 21:40:47 -0400
Received: (qmail 32131 invoked by uid 111); 21 Aug 2008 01:40:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 20 Aug 2008 21:40:45 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Aug 2008 21:40:44 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93086>

When we are reading from a pipe and receive a signal, our
read call fails and ferror() returns true. The current
behavior is to call end_update and report failure. However,
we can detect this situation by checking that errno is set
to success and continue the reading process.

You can provoke this behavior by running a "tig blame" that
takes a few seconds and then resizing the terminal that tig
is running in (you should get an incomplete blame output and
the error "Failed to read: Success").

Signed-off-by: Jeff King <peff@peff.net>
---
I am not convinced this is the right solution. Specifically:

  - there are a few other calls to ferror. Maybe they should be
    converted, too, which implies that perhaps there is a better idiom
    for checking this.

  - I have no idea how portable this is. Do all stdio implementations
    fail to restart on signal? Do they all set ferror and have errno ==
    0 (I would have expected EINTR, or at the very least a 0-read
    without ferror set)?

But it works for me (Linux, glibc 2.7).

 tig.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tig.c b/tig.c
index 6b111e4..8362ecf 100644
--- a/tig.c
+++ b/tig.c
@@ -2392,7 +2392,7 @@ update_view(struct view *view)
 	update_view_title(view);
 
 check_pipe:
-	if (ferror(view->pipe)) {
+	if (ferror(view->pipe) && errno != 0) {
 		report("Failed to read: %s", strerror(errno));
 		end_update(view, TRUE);
 
-- 
1.6.0.98.g0d3cc
