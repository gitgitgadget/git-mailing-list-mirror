From: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] Provide a way to flush git-diff-tree's output
Date: Thu, 18 May 2006 16:58:51 +1000
Message-ID: <17516.6955.282732.460675@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 08:59:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgcTZ-0006e8-Hk
	for gcvg-git@gmane.org; Thu, 18 May 2006 08:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWERG7K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 02:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWERG7K
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 02:59:10 -0400
Received: from ozlabs.org ([203.10.76.45]:49119 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751289AbWERG7J (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 May 2006 02:59:09 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 46AAC67A77; Thu, 18 May 2006 16:59:08 +1000 (EST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20268>

Gitk wants to use git-diff-tree as a filter to tell it which ids from
a given list affect a set of files or directories.  We don't want to
fork and exec a new git-diff-tree process for each batch of ids, since
there could be a lot of relatively small batches.  For example, a
batch could contain as many ids as fit in gitk's headline display
window, i.e. 20 or so, and we would be processing a new batch every
time the user scrolls that window.

The --stdin flag to git-diff-tree is suitable for this, but the main
difficulty is that the output of git-diff-tree gets buffered and
doesn't get sent until the buffer is full.

This provides a way to get git-diff-tree to flush its output buffers.
If a blank line is supplied on git-diff-tree's standard input, it will
flush its output buffers and then accept further input.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/diff-tree.c b/diff-tree.c
index 7207867..69bb74b 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -138,7 +138,10 @@ int main(int argc, const char **argv)
 		opt->diffopt.setup |= (DIFF_SETUP_USE_SIZE_CACHE |
 				       DIFF_SETUP_USE_CACHE);
 	while (fgets(line, sizeof(line), stdin))
-		diff_tree_stdin(line);
+		if (line[0] == '\n')
+			fflush(stdout);
+		else
+			diff_tree_stdin(line);
 
 	return 0;
 }
