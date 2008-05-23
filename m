From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] Fix git-show-branch --current when not on a branch
Date: Sat, 24 May 2008 01:00:38 +0200 (CEST)
Message-ID: <alpine.DEB.1.10.0805240049400.3980@euler.pkqs.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 24 01:01:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzgGl-0003Xn-M2
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 01:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753876AbYEWXAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 19:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753452AbYEWXAi
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 19:00:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:36381 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753733AbYEWXAi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 19:00:38 -0400
Received: (qmail invoked by alias); 23 May 2008 23:00:36 -0000
Received: from pkqs.net (EHLO euler.pkqs.net) [213.239.210.122]
  by mail.gmx.net (mp022) with SMTP; 24 May 2008 01:00:36 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+dDoF1g/ydtoEU9WaqX5sCg5lnvoruqO0xzIefry
	hMmifWfLHMf7wl
X-X-Sender: sbeyer@euler.pkqs.net
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82769>

builtin-show-branch.c relied on resolve_ref() to return
"refs/heads/foo" if on branch foo.  But if not on a branch,
it returns "HEAD".  Hence, `head + pfxlen' (i.e. head+11)
is a memory address beyond the "HEAD" string, so that
further operation leads to access of uninitialized memory.

This commit fixes the bug by just not adding the
"refs/heads/"-length offset.  So append_one_rev() operates
on "refs/heads/foo" instead of "foo", which still works.
But now it also operates correctly on "HEAD".

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
  builtin-show-branch.c |    3 +--
  1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 019abd3..412eba0 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -782,8 +782,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
  				has_head++;
  		}
  		if (!has_head) {
-			int pfxlen = strlen("refs/heads/");
-			append_one_rev(head + pfxlen);
+			append_one_rev(head);
  		}
  	}

-- 
1.5.5.1
