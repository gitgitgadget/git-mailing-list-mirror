From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/4] merge-recursive: use strbuf_expand() instead of interpolate()
Date: Sun, 23 Nov 2008 00:13:00 +0100
Message-ID: <492891FC.6000908@lsrfire.ath.cx>
References: <4928912A.5050307@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jon Loeliger <jdl@freescale.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 23 00:14:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L41gO-0001wh-55
	for gcvg-git-2@gmane.org; Sun, 23 Nov 2008 00:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753508AbYKVXNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Nov 2008 18:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753455AbYKVXNI
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Nov 2008 18:13:08 -0500
Received: from india601.server4you.de ([85.25.151.105]:49191 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753321AbYKVXNH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Nov 2008 18:13:07 -0500
Received: from [10.0.1.101] (p57B7B890.dip.t-dialin.net [87.183.184.144])
	by india601.server4you.de (Postfix) with ESMTPSA id AA17E2F8057;
	Sun, 23 Nov 2008 00:13:04 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <4928912A.5050307@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101561>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 ll-merge.c        |   21 +++++++++------------
 merge-recursive.c |    1 -
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/ll-merge.c b/ll-merge.c
index 4a71614..fa2ca52 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -8,7 +8,6 @@
 #include "attr.h"
 #include "xdiff-interface.h"
 #include "run-command.h"
-#include "interpolate.h"
 #include "ll-merge.h"
 
 struct ll_merge_driver;
@@ -169,11 +168,12 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 			int virtual_ancestor)
 {
 	char temp[3][50];
-	char cmdbuf[2048];
-	struct interp table[] = {
-		{ "%O" },
-		{ "%A" },
-		{ "%B" },
+	struct strbuf cmd = STRBUF_INIT;
+	struct strbuf_expand_dict_entry dict[] = {
+		{ "O", temp[0] },
+		{ "A", temp[1] },
+		{ "B", temp[2] },
+		{ NULL }
 	};
 	struct child_process child;
 	const char *args[20];
@@ -189,17 +189,13 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 	create_temp(src1, temp[1]);
 	create_temp(src2, temp[2]);
 
-	interp_set_entry(table, 0, temp[0]);
-	interp_set_entry(table, 1, temp[1]);
-	interp_set_entry(table, 2, temp[2]);
-
-	interpolate(cmdbuf, sizeof(cmdbuf), fn->cmdline, table, 3);
+	strbuf_expand(&cmd, fn->cmdline, strbuf_expand_dict_cb, &dict);
 
 	memset(&child, 0, sizeof(child));
 	child.argv = args;
 	args[0] = "sh";
 	args[1] = "-c";
-	args[2] = cmdbuf;
+	args[2] = cmd.buf;
 	args[3] = NULL;
 
 	status = run_command(&child);
@@ -224,6 +220,7 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
  bad:
 	for (i = 0; i < 3; i++)
 		unlink(temp[i]);
+	strbuf_release(&cmd);
 	return status;
 }
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 7472d3e..0e988f2 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -16,7 +16,6 @@
 #include "string-list.h"
 #include "xdiff-interface.h"
 #include "ll-merge.h"
-#include "interpolate.h"
 #include "attr.h"
 #include "merge-recursive.h"
 #include "dir.h"
-- 
1.6.0.4.755.g6e139
