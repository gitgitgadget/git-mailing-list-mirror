From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] diff: allow unstuck arguments with --diff-algorithm
Date: Fri,  5 Apr 2013 12:15:27 +0100
Message-ID: <8fc6f21da7c876d50f2f35c73252e95d525dffb5.1365160527.git.john@keeping.me.uk>
Cc: Michal Privoznik <mprivozn@redhat.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 18:45:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWFM-0002u6-6O
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765239Ab3DELPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 07:15:42 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:53046 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765123Ab3DELPl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 07:15:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 8156B161E3FD;
	Fri,  5 Apr 2013 12:15:40 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y4whrOJC21-i; Fri,  5 Apr 2013 12:15:40 +0100 (BST)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 0F37B161E291;
	Fri,  5 Apr 2013 12:15:34 +0100 (BST)
X-Mailer: git-send-email 1.8.2.540.gf023cfe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220161>

The argument to --diff-algorithm is mandatory, so there is no reason to
require the argument to be stuck to the option with '='.  Change this
for consistency with other Git commands.

Note that this doesi not change the handling of diff-algorithm in
merge-recursive.c since the primary interface to that is via the -X
option to 'git merge' where the unstuck form does not make sense.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 diff.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index db952a5..e0152f8 100644
--- a/diff.c
+++ b/diff.c
@@ -3596,8 +3596,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
 	else if (!strcmp(arg, "--histogram"))
 		options->xdl_opts = DIFF_WITH_ALG(options, HISTOGRAM_DIFF);
-	else if (!prefixcmp(arg, "--diff-algorithm=")) {
-		long value = parse_algorithm_value(arg+17);
+	else if ((argcount = parse_long_opt("diff-algorithm", av, &optarg))) {
+		long value = parse_algorithm_value(optarg);
 		if (value < 0)
 			return error("option diff-algorithm accepts \"myers\", "
 				     "\"minimal\", \"patience\" and \"histogram\"");
@@ -3605,6 +3605,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_XDL_CLR(options, NEED_MINIMAL);
 		options->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
 		options->xdl_opts |= value;
+		return argcount;
 	}
 
 	/* flags options */
-- 
1.8.2.540.gf023cfe
