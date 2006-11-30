X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH] ls-files: Give hints when errors happen.
Date: Thu, 30 Nov 2006 12:28:28 +0100
Message-ID: <20061130115908.942AF5BA19@nox.op5.se>
NNTP-Posting-Date: Thu, 30 Nov 2006 11:59:31 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32727>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpkZO-0004qE-4j for gcvg-git@gmane.org; Thu, 30 Nov
 2006 12:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936238AbWK3L7L (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 06:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936240AbWK3L7L
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 06:59:11 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:36295 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S936238AbWK3L7K (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 06:59:10 -0500
Received: from nox.op5.se (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id EC5516BCC2 for <git@vger.kernel.org>; Thu, 30 Nov
 2006 12:59:08 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500) id 942AF5BA19; Thu, 30 Nov
 2006 12:59:08 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Without this patch "git commit file.c file2.c" produces the not
so stellar output:

	error: pathspec 'file.c' did not match any.
	error: pathspec 'file2.c' did not match any.

With this patch, the output is changed to:

	error: pathspec 'file.c' did not match any file(s) known to git.
	error: pathspec 'file2.c' did not match any file(s) known to git.
	Did you forget to 'git add'?

Signed-off-by: Andreas Ericsson <ae@op5.se>
---
 builtin-ls-files.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index ad8c41e..bc79ce4 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -487,10 +487,14 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 		for (num = 0; pathspec[num]; num++) {
 			if (ps_matched[num])
 				continue;
-			error("pathspec '%s' did not match any.",
+			error("pathspec '%s' did not match any file(s) known to git.",
 			      pathspec[num] + prefix_offset);
 			errors++;
 		}
+
+		if (errors)
+			fprintf(stderr, "Did you forget to 'git add'?\n");
+
 		return errors ? 1 : 0;
 	}
 
-- 
1.4.4.1.GIT
