From: Jeff King <peff@peff.net>
Subject: [PATCH 01/67] show-branch: avoid segfault with --reflog of unborn
 branch
Date: Tue, 15 Sep 2015 11:23:07 -0400
Message-ID: <20150915152307.GA29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:23:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbs4h-0005bX-F7
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbbIOPXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:23:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:59266 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751438AbbIOPXK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 11:23:10 -0400
Received: (qmail 11015 invoked by uid 102); 15 Sep 2015 15:23:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 10:23:09 -0500
Received: (qmail 6734 invoked by uid 107); 15 Sep 2015 15:23:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:23:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 11:23:07 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277902>

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
2.6.0.rc2.408.ga2926b9
