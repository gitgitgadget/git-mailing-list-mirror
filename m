From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] Allow the default low-level merge driver to be configured.
Date: Wed, 18 Apr 2007 02:21:02 -0700
Message-ID: <1176888062910-git-send-email-junkio@cox.net>
References: <11768880622402-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 18 11:21:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He6Lw-0007CC-L3
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 11:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422708AbXDRJVI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 05:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422712AbXDRJVI
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 05:21:08 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:36163 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422710AbXDRJVD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 05:21:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070418092103.VAYS1268.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>
          for <git@vger.kernel.org>; Wed, 18 Apr 2007 05:21:03 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id oZM21W0041kojtg0000200; Wed, 18 Apr 2007 05:21:02 -0400
X-Mailer: git-send-email 1.5.1.1.901.g25ba
In-Reply-To: <11768880622402-git-send-email-junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44877>

When no 'merge' attribute is given to a path, merge-recursive
uses the built-in xdl-merge as the low-level merge driver.

A new configuration item 'merge.default' can name a low-level
merge driver of user's choice to be used instead.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 merge-recursive.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 8ec18ad..5983000 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -839,12 +839,18 @@ static struct user_merge_fn {
 	char *cmdline;
 	char b_[1];
 } *ll_user_merge_fns, **ll_user_merge_fns_tail;
+static const char *default_ll_merge;
 
 static int read_merge_config(const char *var, const char *value)
 {
 	struct user_merge_fn *fn;
 	int blen, nlen;
 
+	if (!strcmp(var, "merge.default")) {
+		default_ll_merge = strdup(value);
+		return 0;
+	}
+
 	if (strcmp(var, "merge.driver"))
 		return 0;
 	if (!value)
@@ -900,8 +906,12 @@ static ll_merge_fn find_ll_merge_fn(void *merge_attr, const char **cmdline)
 		return ll_xdl_merge;
 	else if (ATTR_FALSE(merge_attr))
 		return ll_binary_merge;
-	else if (ATTR_UNSET(merge_attr))
-		return ll_xdl_merge;
+	else if (ATTR_UNSET(merge_attr)) {
+		if (!default_ll_merge)
+			return ll_xdl_merge;
+		else
+			name = default_ll_merge;
+	}
 	else
 		name = merge_attr;
 
-- 
1.5.1.1.901.g25ba
