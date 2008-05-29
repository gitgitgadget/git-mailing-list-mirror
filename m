From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] checkout: make reset_clean_to_new() not die by itself
Date: Wed, 28 May 2008 17:17:22 -0700
Message-ID: <1212020246-26480-3-git-send-email-gitster@pobox.com>
References: <1212020246-26480-1-git-send-email-gitster@pobox.com>
 <1212020246-26480-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 02:25:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1Vwz-0005eX-LQ
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 02:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbYE2AYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 20:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752479AbYE2AYJ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 20:24:09 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbYE2AYI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 20:24:08 -0400
X-Greylist: delayed 381 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 May 2008 20:24:08 EDT
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A171A215A
	for <git@vger.kernel.org>; Wed, 28 May 2008 20:17:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTP id AEA242157 for <git@vger.kernel.org>; Wed, 28 May 2008 20:17:41 -0400
 (EDT)
X-Mailer: git-send-email 1.5.6.rc0.43.g823ea
In-Reply-To: <1212020246-26480-2-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: AA0BA03E-2D14-11DD-9D36-60A28689AC60-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83162>

Instead, have its error percolate up through the callchain and let it be
the exit status of the main command.  No semantic changes yet.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-checkout.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 00dc8ca..cc97724 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -172,7 +172,7 @@ static int reset_to_new(struct tree *tree, int quiet)
 	return 0;
 }
 
-static void reset_clean_to_new(struct tree *tree, int quiet)
+static int reset_clean_to_new(struct tree *tree, int quiet)
 {
 	struct unpack_trees_options opts;
 	struct tree_desc tree_desc;
@@ -189,7 +189,8 @@ static void reset_clean_to_new(struct tree *tree, int quiet)
 	parse_tree(tree);
 	init_tree_desc(&tree_desc, tree->buffer, tree->size);
 	if (unpack_trees(1, &tree_desc, &opts))
-		exit(128);
+		return 128;
+	return 0;
 }
 
 struct checkout_opts {
@@ -295,7 +296,9 @@ static int merge_working_tree(struct checkout_opts *opts,
 				return ret;
 			merge_trees(new->commit->tree, work, old->commit->tree,
 				    new->name, "local", &result);
-			reset_clean_to_new(new->commit->tree, opts->quiet);
+			ret = reset_clean_to_new(new->commit->tree, opts->quiet);
+			if (ret)
+				return ret;
 		}
 	}
 
-- 
1.5.6.rc0.43.g823ea
