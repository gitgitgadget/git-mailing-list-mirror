From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] ls-files: die instead of fprintf/exit in -i error
Date: Thu,  8 Oct 2009 21:53:35 -0400
Message-ID: <1255053215-14059-1-git-send-email-bwalton@artsci.utoronto.ca>
References: <4ACE4C72.4050400@gmail.com>
Cc: git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: bebarino@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Oct 09 03:58:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw4kM-0008Pp-12
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 03:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760166AbZJIBzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 21:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760129AbZJIBzF
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 21:55:05 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:57128 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758446AbZJIBzE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 21:55:04 -0400
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:53928 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1Mw4gc-0000td-M1; Thu, 08 Oct 2009 21:54:26 -0400
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Mw4gc-0003gF-JX; Thu, 08 Oct 2009 21:54:26 -0400
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n991sQ6P014147;
	Thu, 8 Oct 2009 21:54:26 -0400
X-Mailer: git-send-email 1.6.4
In-Reply-To: <4ACE4C72.4050400@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129729>

When ls-files was called with -i but no exclude pattern, it was
calling fprintf(stderr, "...", NULL) and then exiting.  On Solaris,
passing NULL into fprintf was causing a segfault.  On glibc systems,
it was simply producing incorrect output (eg: "(null)": ...).  The
NULL pointer was a result of argv[0] not being preserved by the option
parser.  Instead of requesting that the option parser preserve
argv[0], use die() with a constant string.

A trigger for this bug was: `git ls-files -i`

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
This is the alternate solution to this bug as proposed earlier today.
I don't have a preference either way for which solution is better or
more inline with the 'git way,' so please choose the most appropriate.

I've run the test suite with both patches on Linux and Solaris
and everything passes.

 builtin-ls-files.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index f473220..2c95ca6 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -524,11 +524,8 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 		ps_matched = xcalloc(1, num);
 	}
 
-	if ((dir.flags & DIR_SHOW_IGNORED) && !exc_given) {
-		fprintf(stderr, "%s: --ignored needs some exclude pattern\n",
-			argv[0]);
-		exit(1);
-	}
+	if ((dir.flags & DIR_SHOW_IGNORED) && !exc_given)
+		die("ls-files --ignored needs some exclude pattern");
 
 	/* With no flags, we default to showing the cached files */
 	if (!(show_stage | show_deleted | show_others | show_unmerged |
-- 
1.6.4.4
