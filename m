From: Junio C Hamano <gitster@pobox.com>
Subject: "git checkout" branch switching safety broken in 'next'
Date: Mon, 10 Mar 2008 01:12:37 -0700
Message-ID: <7vmyp7j8ui.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 09:13:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYd8O-0007Uv-CI
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 09:13:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbYCJIMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 04:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbYCJIMp
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 04:12:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37437 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbYCJIMo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 04:12:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3449D23C8;
	Mon, 10 Mar 2008 04:12:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 74B1C23C7; Mon, 10 Mar 2008 04:12:39 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76704>

Linus, please be careful when switching branches if you are using your
unpack_trees() patch (in 'next') for production.  There is a breakage that
makes switching branches with "git checkout" lose your work-in-progress.

Traditionally, when you have a change in the work tree, and switch to
another branch that has different contents in the modified path, we
errored out by saying:

    error: Entry 'foo' not uptodate. Cannot merge.

The updated unpack_trees() notices the condition, issues this message
correctly and tries to propagate the error up, but loses the error at a
few places in the call chain.  The end result is that the caller does not
notice the two-way merge failure, and after that all h*ll breaks loose.

I think this should fix it.

-- >8 --
traverse_trees_recursive(): propagate merge errors up

There were few places where merge errors detected deeper in the call chain
were ignored and not propagated up the callchain to the caller.

Most notably, this caused "git checkout" to switch branches to internally
notice that a path modified in a work tree are different between the HEAD
version and the commit being switched to, but ignore that and switch
branches nevertheless, resulting in an incorrect two-way merge and loss of
the change in the work tree.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 unpack-trees.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index da68557..5a0f038 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -144,8 +144,7 @@ int traverse_trees_recursive(int n, unsigned long dirmask, unsigned long df_conf
 			sha1 = names[i].sha1;
 		fill_tree_descriptor(t+i, sha1);
 	}
-	traverse_trees(n, t, &newinfo);
-	return 0;
+	return traverse_trees(n, t, &newinfo);
 }
 
 /*
@@ -306,7 +305,9 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 			if (src[0])
 				conflicts |= 1;
 		}
-		traverse_trees_recursive(n, dirmask, conflicts, names, info);
+		if (traverse_trees_recursive(n, dirmask, conflicts,
+					     names, info) < 0)
+			return -1;
 		return mask;
 	}
 
