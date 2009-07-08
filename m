From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 1/4] write-tree: migrate to parse-options
Date: Tue,  7 Jul 2009 22:15:38 -0700
Message-ID: <1247030141-11695-2-git-send-email-bebarino@gmail.com>
References: <1247030141-11695-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 07:16:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOPVt-00082W-8G
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 07:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755852AbZGHFPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 01:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755345AbZGHFPu
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 01:15:50 -0400
Received: from mail-px0-f181.google.com ([209.85.216.181]:37259 "EHLO
	mail-px0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754815AbZGHFPt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 01:15:49 -0400
Received: by mail-px0-f181.google.com with SMTP id 11so141523pxi.33
        for <git@vger.kernel.org>; Tue, 07 Jul 2009 22:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=mgyHdgQNg6yjDjDDAW8l6N6PIak30YvNCob7iVUOQMo=;
        b=Y+vDcNcY/zoQ2L1Lx8D0v7Ir/x+qitgzjLJbIX+g0qFpfU9NOz3kbTOpEZaxIrGQQv
         mH4M3IyTs3ih/zgpE0TEbkAGkauMFSir7iw8ZDY0i/smSnFhsDQ9DfTY/VcBJjSLHVQz
         amfAEeM4bcAhpGfvZN17HcSZGgtLIIv/5mGcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PAtbslgr7Nuw3ab0snE9mlfq5y5yMLjZmvHcgr9FPWPevt6epRLotk34Tw4xlZe5ft
         Awj1AZs3lFSHzzAI7goE3T8UhfeG8ULmSXd8EzHTjm0w+kjlVs4+e98HDoTHx2Bx7ag9
         i20BNoKaeBGPnrwOTj7p3CAQyP+FHPcxng1T0=
Received: by 10.114.147.1 with SMTP id u1mr10943054wad.108.1247030149104;
        Tue, 07 Jul 2009 22:15:49 -0700 (PDT)
Received: from earth (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id l37sm1263271waf.40.2009.07.07.22.15.46
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Jul 2009 22:15:48 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Tue, 07 Jul 2009 22:15:45 -0700
X-Mailer: git-send-email 1.6.3.3.385.g60647
In-Reply-To: <1247030141-11695-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122888>

A check for extra options has been dropped, it could never be triggered
in the original code as the usage message would be printed instead.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

For historical purposes (and those interested), the die() became dead
code in commit 6bd2035 (write-tree: --prefix=<path> 2006-04-26) when
the line if (argc == 2) was changed to a while loop.

 builtin-write-tree.c |   40 +++++++++++++++++++---------------------
 1 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/builtin-write-tree.c b/builtin-write-tree.c
index 3a24ce8..b223af4 100644
--- a/builtin-write-tree.c
+++ b/builtin-write-tree.c
@@ -7,9 +7,12 @@
 #include "cache.h"
 #include "tree.h"
 #include "cache-tree.h"
+#include "parse-options.h"
 
-static const char write_tree_usage[] =
-"git write-tree [--missing-ok] [--prefix=<prefix>/]";
+static const char * const write_tree_usage[] = {
+	"git write-tree [--missing-ok] [--prefix=<prefix>/]",
+	NULL
+};
 
 int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 {
@@ -17,27 +20,22 @@ int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 	const char *prefix = NULL;
 	unsigned char sha1[20];
 	const char *me = "git-write-tree";
+	struct option write_tree_options[] = {
+		OPT_BIT(0, "missing-ok", &flags, "allow missing objects",
+			WRITE_TREE_MISSING_OK),
+		{ OPTION_STRING, 0, "prefix", &prefix, "<prefix>/",
+		  "write tree object for a subdirectory <prefix>" ,
+		  PARSE_OPT_LITERAL_ARGHELP },
+		{ OPTION_BIT, 0, "ignore-cache-tree", &flags, NULL,
+		  "only useful for debugging",
+		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, NULL,
+		  WRITE_TREE_IGNORE_CACHE_TREE },
+		OPT_END()
+	};
 
 	git_config(git_default_config, NULL);
-	while (1 < argc) {
-		const char *arg = argv[1];
-		if (!strcmp(arg, "--missing-ok"))
-			flags |= WRITE_TREE_MISSING_OK;
-		else if (!prefixcmp(arg, "--prefix="))
-			prefix = arg + 9;
-		else if (!prefixcmp(arg, "--ignore-cache-tree"))
-			/*
-			 * This is only useful for debugging, so I
-			 * do not bother documenting it.
-			 */
-			flags |= WRITE_TREE_IGNORE_CACHE_TREE;
-		else
-			usage(write_tree_usage);
-		argc--; argv++;
-	}
-
-	if (argc > 2)
-		die("too many options");
+	argc = parse_options(argc, argv, unused_prefix, write_tree_options,
+			     write_tree_usage, 0);
 
 	ret = write_cache_as_tree(sha1, flags, prefix);
 	switch (ret) {
-- 
1.6.3.3.385.g60647
