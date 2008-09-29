From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] make prune report removed objects on -v
Date: Mon, 29 Sep 2008 18:49:52 +0200
Message-ID: <1222706992-15531-1-git-send-email-git@drmicha.warpmail.net>
Cc: Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 29 18:51:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkLxu-0000qE-H0
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 18:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbYI2QuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 12:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbYI2QuG
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 12:50:06 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44509 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751603AbYI2QuF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Sep 2008 12:50:05 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id E706017213D
	for <git@vger.kernel.org>; Mon, 29 Sep 2008 12:50:03 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 29 Sep 2008 12:50:03 -0400
X-Sasl-enc: NrAiY6Qj2kJDoHa3bDjGOI+MmaVxudiElkEKotOQ11pg 1222707003
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 15EE9260E8;
	Mon, 29 Sep 2008 12:50:02 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2.287.g3791f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97034>

This adds an option "-v" which makes "git prune" more verbose:
It outputs all removed objects while removing them.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-prune.txt |    5 ++++-
 builtin-prune.c             |   10 +++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 54f1dab..da6055d 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -8,7 +8,7 @@ git-prune - Prune all unreachable objects from the object database
 
 SYNOPSIS
 --------
-'git-prune' [-n] [--expire <expire>] [--] [<head>...]
+'git-prune' [-n] [-v] [--expire <expire>] [--] [<head>...]
 
 DESCRIPTION
 -----------
@@ -34,6 +34,9 @@ OPTIONS
 	Do not remove anything; just report what it would
 	remove.
 
+-v::
+	Report all removed objects.
+
 \--::
 	Do not interpret any more arguments as options.
 
diff --git a/builtin-prune.c b/builtin-prune.c
index 1663f8b..7b4ec80 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -7,10 +7,11 @@
 #include "parse-options.h"
 
 static const char * const prune_usage[] = {
-	"git prune [-n] [--expire <time>] [--] [<head>...]",
+	"git prune [-n] [-v] [--expire <time>] [--] [<head>...]",
 	NULL
 };
 static int show_only;
+static int verbose;
 static unsigned long expire;
 
 static int prune_tmp_object(const char *path, const char *filename)
@@ -39,11 +40,12 @@ static int prune_object(char *path, const char *filename, const unsigned char *s
 		if (st.st_mtime > expire)
 			return 0;
 	}
-	if (show_only) {
+	if (show_only || verbose) {
 		enum object_type type = sha1_object_info(sha1, NULL);
 		printf("%s %s\n", sha1_to_hex(sha1),
 		       (type > 0) ? typename(type) : "unknown");
-	} else
+	}
+	if (!show_only)
 		unlink(fullpath);
 	return 0;
 }
@@ -135,6 +137,8 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	const struct option options[] = {
 		OPT_BOOLEAN('n', NULL, &show_only,
 			    "do not remove, show only"),
+		OPT_BOOLEAN('v', NULL, &verbose,
+			"report pruned objects"),
 		OPT_DATE(0, "expire", &expire,
 			 "expire objects older than <time>"),
 		OPT_END()
-- 
1.6.0.2.287.g3791f
