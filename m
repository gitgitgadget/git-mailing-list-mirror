From: Scott R Parish <srp@srparish.net>
Subject: [PATCH] don't set-group-id on directories on apple
Date: Mon, 22 Oct 2007 00:55:18 -0700
Message-ID: <20071022075459.GA1157@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 09:55:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijs8M-0002y5-DN
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 09:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbXJVHzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 03:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbXJVHzW
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 03:55:22 -0400
Received: from smtp-gw5.mailanyone.net ([208.70.128.56]:52373 "EHLO
	smtp-gw5.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbXJVHzV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 03:55:21 -0400
Received: from mailanyone.net
	by smtp-gw5.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP srp)
	id 1Ijs87-0004Oy-LT
	for git@vger.kernel.org; Mon, 22 Oct 2007 02:55:20 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 502
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Mon, 22 Oct 2007 00:55:19 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61968>

"git init --shared=all" was failing because chmod was returning
EPERM. According to the man page, the set-group-id behavior is
already default: man 2 mkdir:

  The directory's group ID is set to that of the parent directory
  in which it is created.

Signed-off-by: Scott R Parish <srp@srparish.net>
---
 path.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/path.c b/path.c
index 4260952..4089753 100644
--- a/path.c
+++ b/path.c
@@ -282,8 +282,10 @@ int adjust_shared_perm(const char *path)
 			 : (shared_repository == PERM_EVERYBODY
 			    ? (S_IXGRP|S_IXOTH)
 			    : 0));
+#if !defined(__APPLE__)
 	if (S_ISDIR(mode))
 		mode |= S_ISGID;
+#endif
 	if ((mode & st.st_mode) != mode && chmod(path, mode) < 0)
 		return -2;
 	return 0;
-- 
1.5.3.4.209.g5d1ce-dirty
