From: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] Make git-diff-tree indicate when it flushes
Date: Mon, 29 May 2006 22:24:35 +1000
Message-ID: <17530.59395.5611.931858@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 14:25:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkgnp-000389-Qs
	for gcvg-git@gmane.org; Mon, 29 May 2006 14:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWE2MYu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 08:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWE2MYu
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 08:24:50 -0400
Received: from ozlabs.org ([203.10.76.45]:47568 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750776AbWE2MYt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 08:24:49 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 5075167AC5; Mon, 29 May 2006 22:24:48 +1000 (EST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20945>

There are times when gitk needs to know that the commits it has sent
to git-diff-tree --stdin did not match, and it needs to know in a
timely fashion even if none of them match.  At the moment,
git-diff-tree outputs nothing for non-matching commits, so it is
impossible for gitk to distinguish between git-diff-tree being slow
and git-diff-tree saying no.

This makes git-diff-tree output a blank line in response to a blank
line in its input (which already causes git-diff-tree to flush its
output buffers).  Gitk, or other users of git-diff-tree --stdin, can
use the blank line to indicate that git-diff-tree has processed all
the commits on its input up to the input blank line, and any commits
that have not been output do not match.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index cc53b81..dbe5737 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -139,9 +139,10 @@ int cmd_diff_tree(int argc, const char *
 		opt->diffopt.setup |= (DIFF_SETUP_USE_SIZE_CACHE |
 				       DIFF_SETUP_USE_CACHE);
 	while (fgets(line, sizeof(line), stdin))
-		if (line[0] == '\n')
+		if (line[0] == '\n') {
+			putchar('\n');
 			fflush(stdout);
-		else
+		} else
 			diff_tree_stdin(line);
 
 	return 0;
