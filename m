From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] merge-recursive: fix parsing of "diff-algorithm" option
Date: Thu, 26 Sep 2013 21:02:48 +0100
Message-ID: <689bf88b6f1d33e123cc786042cc6dba23464351.1380225743.git.john@keeping.me.uk>
Cc: Luke Noel-Storr <luke.noel-storr@integrate.co.uk>,
	Michal Privoznik <mprivozn@redhat.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 26 22:03:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPHmL-0002nw-Nx
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 22:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133Ab3IZUDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 16:03:10 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:36322 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854Ab3IZUDH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 16:03:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 015C022B60;
	Thu, 26 Sep 2013 21:03:06 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x-rfXH7xFlw7; Thu, 26 Sep 2013 21:03:01 +0100 (BST)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 9C61822BA7;
	Thu, 26 Sep 2013 21:02:55 +0100 (BST)
X-Mailer: git-send-email 1.8.4.566.g73d370b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235429>

The "diff-algorithm" option to the recursive merge strategy takes the
name of the algorithm as an option, but it uses strcmp on the option
string to check if it starts with "diff-algorithm=", meaning that this
options cannot actually be used.

Fix this by switching to prefixcmp.  At the same time, clarify the
following line by using strlen instead of a hard-coded length, which
also makes it consistent with nearby code.

Reported-by: Luke Noel-Storr <luke.noel-storr@integrate.co.uk>
Signed-off-by: John Keeping <john@keeping.me.uk>
---
 merge-recursive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 40eb840..dbb7104 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2069,8 +2069,8 @@ int parse_merge_opt(struct merge_options *o, const char *s)
 		o->xdl_opts = DIFF_WITH_ALG(o, PATIENCE_DIFF);
 	else if (!strcmp(s, "histogram"))
 		o->xdl_opts = DIFF_WITH_ALG(o, HISTOGRAM_DIFF);
-	else if (!strcmp(s, "diff-algorithm=")) {
-		long value = parse_algorithm_value(s+15);
+	else if (!prefixcmp(s, "diff-algorithm=")) {
+		long value = parse_algorithm_value(s + strlen("diff-algorithm="));
 		if (value < 0)
 			return -1;
 		/* clear out previous settings */
-- 
1.8.4.566.g73d370b
