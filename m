From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] blame: read custom grafts given by -S before calling
 setup_revisions()
Date: Wed, 18 Mar 2009 00:50:56 -0700
Message-ID: <7viqm7l15r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 08:52:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjqZk-0002h2-Gi
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 08:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbZCRHvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 03:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbZCRHvD
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 03:51:03 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44218 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbZCRHvB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 03:51:01 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 78F3F7590;
	Wed, 18 Mar 2009 03:50:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EE004758F; Wed,
 18 Mar 2009 03:50:57 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 85465532-1391-11DE-85F9-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113597>

setup_revisions() while getting the command line arguments parses the
given commits from the command line, which means their direct parents will
not be rewritten by the custom graft file.

Call read_ancestry() early to work around this issue.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-blame.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 4ea3431..0c241a9 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2346,6 +2346,10 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 parse_done:
 	argc = parse_options_end(&ctx);
 
+	if (revs_file && read_ancestry(revs_file))
+		die("reading graft file %s failed: %s",
+		    revs_file, strerror(errno));
+
 	if (DIFF_OPT_TST(&revs.diffopt, FIND_COPIES_HARDER))
 		opt |= (PICKAXE_BLAME_COPY | PICKAXE_BLAME_MOVE |
 			PICKAXE_BLAME_COPY_HARDER);
@@ -2484,10 +2488,6 @@ parse_done:
 	sb.ent = ent;
 	sb.path = path;
 
-	if (revs_file && read_ancestry(revs_file))
-		die("reading graft file %s failed: %s",
-		    revs_file, strerror(errno));
-
 	read_mailmap(&mailmap, ".mailmap", NULL);
 
 	if (!incremental)
-- 
1.6.2.1.278.g7b6274e
