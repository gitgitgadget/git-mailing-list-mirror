From: skimo@liacs.nl
Subject: [PATCH 22/22] ensure_submodule: fetch missing revisions
Date: Thu, 24 May 2007 00:23:11 +0200
Message-ID: <11799589932420-git-send-email-skimo@liacs.nl>
References: <11799589913153-git-send-email-skimo@liacs.nl>
Cc: Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 00:23:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqzFB-0003Mx-5Z
	for gcvg-git@gmane.org; Thu, 24 May 2007 00:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756699AbXEWWXh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 18:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755709AbXEWWXg
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 18:23:36 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:33737 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756014AbXEWWXe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 18:23:34 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4NMNMuw011621;
	Thu, 24 May 2007 00:23:27 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id B43257DDB4; Thu, 24 May 2007 00:23:13 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11799589913153-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48191>

From: Sven Verdoolaege <skimo@kotnet.org>

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 t/t3042-subprojects-fetch.sh |   46 ++++++++++++++++++++++++++++++++++++++++++
 unpack-trees.c               |   26 +++++++++++++++++++++++
 2 files changed, 72 insertions(+), 0 deletions(-)
 create mode 100755 t/t3042-subprojects-fetch.sh

diff --git a/t/t3042-subprojects-fetch.sh b/t/t3042-subprojects-fetch.sh
new file mode 100755
index 0000000..1acc1bd
--- /dev/null
+++ b/t/t3042-subprojects-fetch.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+test_description='submodule fetch'
+. ./test-lib.sh
+
+test_create_repo orig
+
+test_expect_success 'submodule creation' \
+    '(mkdir orig/A && cd orig/A &&
+      git init &&
+      echo 1 > a &&
+      git add a &&
+      git commit -m "create submodule" || exit $? )'
+
+test_expect_success 'supermodule creation' \
+    '(cd orig &&
+     git add A &&
+     git commit -m "supermodule creation" &&
+     git branch one &&
+     git config 'submodule.A.url' $(pwd)/A || exit $?)'
+
+test_expect_success 'clone supermodule' \
+    'git clone --submodules orig clone &&
+     echo 1 > expected &&
+     git diff expected clone/A/a'
+
+test_expect_success 'submodule change' \
+    '(cd orig/A &&
+      echo 2 > a &&
+      git add a &&
+      git commit -m "change submodule" || exit $? )'
+
+test_expect_success 'supermodule change' \
+    '(cd orig &&
+     git add A &&
+     git commit -m "supermodule change" || exit $? )'
+
+test_expect_success 'pull changes' \
+    '(cd clone &&
+      git pull || exit $? )'
+
+test_expect_success 'check pulled changes' \
+    'echo 2 > expected &&
+     git diff expected clone/A/a'
+
+test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index ddefb51..1a76a29 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -7,6 +7,7 @@
 #include "progress.h"
 #include "refs.h"
 #include "submodules.h"
+#include "run-command.h"
 
 #define DBRT_DEBUG 1
 
@@ -810,6 +811,9 @@ static int ensure_submodule(struct cache_entry *ce,
 {
 	struct stat st;
 	char *path;
+	const char *argv_check[10];
+	const char *argv_fetch[] = {"fetch", NULL};
+	int argc;
 
 	if (!ce)
 		return 0;
@@ -826,10 +830,32 @@ static int ensure_submodule(struct cache_entry *ce,
 		if (lstat(path, &st)) {
 			if (clone_submodule(ce->name))
 				return -1;
+			/* may have been overwritten */
+			path = git_path("submodules/%s/.git", ce->name);
 		}
 	}
 
 	/* Now check that the commit is available and fetch if needed */
+	argc = 0;
+	argv_check[argc++] = "cat-file";
+	argv_check[argc++] = "-t";
+	argv_check[argc++] = sha1_to_hex(ce->sha1);
+	argv_check[argc] = NULL;
+
+	if (run_command_v_opt_cd(argv_check,
+	    RUN_GIT_CMD|RUN_COMMAND_CLEAR_GIT_ENV|RUN_COMMAND_NO_STDOUT|
+	    RUN_COMMAND_NO_STDERR, path)) {
+		if (run_command_v_opt_cd(argv_fetch,
+		    RUN_GIT_CMD|RUN_COMMAND_CLEAR_GIT_ENV, path))
+			return error("Unable to fetch submodule '%s'", ce->name);
+
+		if (run_command_v_opt_cd(argv_check,
+		    RUN_GIT_CMD|RUN_COMMAND_CLEAR_GIT_ENV|RUN_COMMAND_NO_STDOUT|
+		    RUN_COMMAND_NO_STDERR, path))
+			return error(
+			    "Unable to fetch revision %s for submodule '%s'",
+			    sha1_to_hex(ce->sha1), ce->name);
+	}
 
 	return 0;
 }
-- 
1.5.2.784.g5532e
