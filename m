From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Fix read-tree merging more than 3 trees using 3-way merge
Date: Wed, 15 Aug 2007 15:46:03 -0700
Message-ID: <7vbqd8o1qs.fsf@gitster.siamese.dyndns.org>
References: <600399.61066.qm@web52807.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Perrin Meyer <perrinmeyer@yahoo.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 00:46:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILRdI-0005cU-4H
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 00:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937322AbXHOWqT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 18:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937286AbXHOWqR
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 18:46:17 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:46578 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937316AbXHOWqP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 18:46:15 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 73C2A122083;
	Wed, 15 Aug 2007 18:46:34 -0400 (EDT)
In-Reply-To: <600399.61066.qm@web52807.mail.re2.yahoo.com> (Perrin Meyer's
	message of "Wed, 15 Aug 2007 14:19:47 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55963>

For multi-base merges, we allowed read-tree -m to take more than
three trees (the last two are our and their branches, and all the
earlier ones, typically one but potentially more, are used as the
merge base).  Unfortunately, the conversion done by commit 933bf40
broke this.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-read-tree.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 1967d10..5b07e9a 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -96,7 +96,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 {
 	int i, newfd, stage = 0;
 	unsigned char sha1[20];
-	struct tree_desc t[3];
+	struct tree_desc t[20];
 	struct unpack_trees_options opts;
 
 	memset(&opts, 0, sizeof(opts));
@@ -263,6 +263,9 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			opts.head_idx = 1;
 	}
 
+	if (ARRAY_SIZE(t) < nr_trees)
+		die("I cannot read more than %d trees", ARRAY_SIZE(t));
+
 	for (i = 0; i < nr_trees; i++) {
 		struct tree *tree = trees[i];
 		parse_tree(tree);
-- 
1.5.3.rc5
