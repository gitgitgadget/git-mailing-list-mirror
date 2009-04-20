From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] read-tree -m A B: prime cache-tree from the switched-to
 tree
Date: Mon, 20 Apr 2009 03:58:19 -0700
Message-ID: <1240225100-29960-4-git-send-email-gitster@pobox.com>
References: <1240225100-29960-1-git-send-email-gitster@pobox.com>
 <1240225100-29960-2-git-send-email-gitster@pobox.com>
 <1240225100-29960-3-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 20 13:00:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvrEN-0001Cx-BU
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 13:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754623AbZDTK6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 06:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754615AbZDTK6e
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 06:58:34 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:32798 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754488AbZDTK6c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 06:58:32 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EE82310AD1
	for <git@vger.kernel.org>; Mon, 20 Apr 2009 06:58:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8DD1D10AD0 for
 <git@vger.kernel.org>; Mon, 20 Apr 2009 06:58:31 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.rc1.18.g66996
In-Reply-To: <1240225100-29960-3-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2FE8951E-2D9A-11DE-BFBF-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116970>

When switching to a new branch with "read-tree -m A B", the resulting
index must match tree B and we can prime the cache tree with it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-read-tree.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 9cd7d07..391d709 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -199,9 +199,14 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	 * "-m ent" or "--reset ent" form), we can obtain a fully
 	 * valid cache-tree because the index must match exactly
 	 * what came from the tree.
+	 *
+	 * The same holds true if we are switching between two trees
+	 * using read-tree -m A B.  The index must match B after that.
 	 */
 	if (nr_trees == 1 && !opts.prefix)
 		prime_cache_tree(&active_cache_tree, trees[0]);
+	else if (nr_trees == 2 && opts.merge)
+		prime_cache_tree(&active_cache_tree, trees[1]);
 
 	if (write_cache(newfd, active_cache, active_nr) ||
 	    commit_locked_index(&lock_file))
-- 
1.6.3.rc1.18.g66996
