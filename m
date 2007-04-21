From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 4/4] use the mode information of the tree, if <SHA1>:file name syntax is used
Date: Sat, 21 Apr 2007 14:26:20 +0200
Message-ID: <11771583802608-git-send-email-mkoegler@auto.tuwien.ac.at>
References: 20070421122348.GA29174@auto.tuwien.ac.at <1177158380197-git-send-email-mkoegler@auto.tuwien.ac.at> <11771583802243-git-send-email-mkoegler@auto.tuwien.ac.at> <11771583803353-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 21 14:26:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfEfi-0000Vy-7t
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 14:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030799AbXDUM00 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 08:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030805AbXDUM0Z
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 08:26:25 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:37249 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030799AbXDUM0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 08:26:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 2EB8E73E0A25;
	Sat, 21 Apr 2007 14:26:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vVMYHtJ5Mkvt; Sat, 21 Apr 2007 14:26:22 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 90EDD73EA3C3; Sat, 21 Apr 2007 14:26:20 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
In-Reply-To: <11771583803353-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45170>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 builtin-diff.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index a427358..f1886ec 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -20,6 +20,7 @@
 struct blobinfo {
 	unsigned char sha1[20];
 	const char *name;
+	unsigned mode;
 };
 
 static const char builtin_diff_usage[] =
@@ -88,8 +89,14 @@ static int builtin_diff_blobs(struct rev_info *revs,
 	if (argc > 1)
 		usage(builtin_diff_usage);
 
+	if (blob[0].mode == S_IFINVALID)
+		blob[0].mode = mode;
+
+	if (blob[1].mode == S_IFINVALID)
+		blob[1].mode = mode;
+
 	stuff_change(&revs->diffopt,
-		     mode, mode,
+		     blob[0].mode, blob[1].mode,
 		     blob[0].sha1, blob[1].sha1,
 		     blob[0].name, blob[1].name);
 	diffcore_std(&revs->diffopt);
@@ -271,6 +278,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 				die("more than two blobs given: '%s'", name);
 			hashcpy(blob[blobs].sha1, obj->sha1);
 			blob[blobs].name = name;
+			blob[blobs].mode = list->mode;
 			blobs++;
 			continue;
 
-- 
1.4.4.4
