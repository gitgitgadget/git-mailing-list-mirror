From: Jeff King <peff@peff.net>
Subject: [PATCH] diffcore-pickaxe: fix infinite loop on zero-length needle
Date: Thu, 25 Jan 2007 23:48:58 -0500
Message-ID: <20070126044858.GA8653@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 05:49:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAJ1q-0003eB-N3
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 05:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030727AbXAZEtD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 23:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030738AbXAZEtD
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 23:49:03 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3887 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030727AbXAZEtA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 23:49:00 -0500
Received: (qmail 9745 invoked from network); 25 Jan 2007 23:49:22 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 25 Jan 2007 23:49:22 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Jan 2007 23:48:58 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37796>

The "contains" algorithm runs into an infinite loop if the needle string
has zero length. The loop could be modified to handle this, but it makes
more sense to simply have an empty needle return no matches. Thus, a
command like
  git log -S
produces no output.

We place the check at the top of the function so that we get the same
results with or without --pickaxe-regex. Note that until now,
  git log -S --pickaxe-regex
would match everything, not nothing.

Arguably, an empty pickaxe string should simply produce an error
message; however, this is still a useful assertion to add to the
algorithm at this layer of the code.

Noticed by Bill Lear.

Signed-off-by: Jeff King <peff@peff.net>
---
On Thu, Jan 25, 2007 at 06:06:51PM -0600, Bill Lear wrote:

> git log -S --check foo
>
> and the thing went off into outer space.  Now at over 2 1/2 minutes of
> CPU time on my 2 Ghz Opteron box...

 diffcore-pickaxe.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index de44ada..286919e 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -14,6 +14,8 @@ static unsigned int contains(struct diff_filespec *one,
 	const char *data;
 	if (diff_populate_filespec(one, 0))
 		return 0;
+	if (!len)
+		return 0;
 
 	sz = one->size;
 	data = one->data;
-- 
1.5.0.rc2.gccd57
