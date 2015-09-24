From: Jeff King <peff@peff.net>
Subject: [PATCH 01/68] show-branch: avoid segfault with --reflog of unborn
 branch
Date: Thu, 24 Sep 2015 17:02:54 -0400
Message-ID: <20150924210253.GA30744@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:03:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDfg-0005RQ-5K
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907AbbIXVC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:02:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:35893 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753273AbbIXVC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:02:56 -0400
Received: (qmail 11647 invoked by uid 102); 24 Sep 2015 21:02:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:02:56 -0500
Received: (qmail 28798 invoked by uid 107); 24 Sep 2015 21:03:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:03:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:02:54 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278560>

When no branch is given to the "--reflog" option, we resolve
HEAD to get the default branch. However, if HEAD points to
an unborn branch, resolve_ref returns NULL, and we later
segfault trying to access it.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/show-branch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 408ce70..092b59b 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -743,6 +743,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			fake_av[1] = NULL;
 			av = fake_av;
 			ac = 1;
+			if (!*av)
+				die("no branches given, and HEAD is not valid");
 		}
 		if (ac != 1)
 			die("--reflog option needs one branch name");
-- 
2.6.0.rc3.454.g204ad51
