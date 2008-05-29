From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] unpack_trees(): allow callers to differentiate worktree
 errors from merge errors
Date: Wed, 28 May 2008 17:17:24 -0700
Message-ID: <1212020246-26480-5-git-send-email-gitster@pobox.com>
References: <1212020246-26480-1-git-send-email-gitster@pobox.com>
 <1212020246-26480-2-git-send-email-gitster@pobox.com>
 <1212020246-26480-3-git-send-email-gitster@pobox.com>
 <1212020246-26480-4-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 02:19:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1VrC-0004LH-0X
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 02:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752984AbYE2ASF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 20:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752784AbYE2ASE
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 20:18:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52652 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbYE2ASD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 20:18:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E1BDC2B61
	for <git@vger.kernel.org>; Wed, 28 May 2008 20:18:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 363DD2B60 for <git@vger.kernel.org>; Wed, 28 May 2008 20:18:01 -0400
 (EDT)
X-Mailer: git-send-email 1.5.6.rc0.43.g823ea
In-Reply-To: <1212020246-26480-4-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: B324EC02-2D14-11DD-B6AF-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83160>

Instead of uniformly returning -1 on any error, this teaches
unpack_trees() to return -2 when the merge itself is Ok but worktree
refuses to get updated.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 unpack-trees.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 0de5a31..cba0aca 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -358,8 +358,13 @@ static int unpack_failed(struct unpack_trees_options *o, const char *message)
 	return -1;
 }
 
+/*
+ * N-way merge "len" trees.  Returns 0 on success, -1 on failure to manipulate the
+ * resulting index, -2 on failure to reflect the changes to the work tree.
+ */
 int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
 {
+	int ret;
 	static struct cache_entry *dfc;
 
 	if (len > MAX_UNPACK_TREES)
@@ -404,11 +409,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		return unpack_failed(o, "Merge requires file-level merging");
 
 	o->src_index = NULL;
-	if (check_updates(o))
-		return -1;
+	ret = check_updates(o) ? (-2) : 0;
 	if (o->dst_index)
 		*o->dst_index = o->result;
-	return 0;
+	return ret;
 }
 
 /* Here come the merge functions */
-- 
1.5.6.rc0.43.g823ea
