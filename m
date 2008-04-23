From: Adam Roben <aroben@apple.com>
Subject: [PATCH 02/11] git-cat-file: Small refactor of cmd_cat_file
Date: Wed, 23 Apr 2008 15:17:44 -0400
Message-ID: <1208978273-98146-3-git-send-email-aroben@apple.com>
References: <1208978273-98146-1-git-send-email-aroben@apple.com>
 <1208978273-98146-2-git-send-email-aroben@apple.com>
Cc: Adam Roben <aroben@apple.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 21:20:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JokUv-00058u-W5
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 21:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999AbYDWTSD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 15:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753925AbYDWTSB
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 15:18:01 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:49405 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753603AbYDWTR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 15:17:58 -0400
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out3.apple.com (Postfix) with ESMTP id 5334D293B002;
	Wed, 23 Apr 2008 12:17:58 -0700 (PDT)
Received: from relay13.apple.com (unknown [127.0.0.1])
	by relay13.apple.com (Symantec Mail Security) with ESMTP id 2E73C28098;
	Wed, 23 Apr 2008 12:17:58 -0700 (PDT)
X-AuditID: 1180711d-ab396bb000000ed7-20-480f8b651ce2
Received: from localhost.localdomain (unknown [17.151.126.45])
	by relay13.apple.com (Apple SCV relay) with ESMTP id 796FA28050;
	Wed, 23 Apr 2008 12:17:57 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.152.g9aeb7
In-Reply-To: <1208978273-98146-2-git-send-email-aroben@apple.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80242>

I separated the logic of parsing the arguments from the logic of fetching and
outputting the data. cat_one_file now does the latter.

Signed-off-by: Adam Roben <aroben@apple.com>
---
 builtin-cat-file.c |   38 ++++++++++++++++++++++----------------
 1 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index f132d58..34a63d1 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -76,31 +76,16 @@ static void pprint_tag(const unsigned char *sha1, const char *buf, unsigned long
 		write_or_die(1, cp, endp - cp);
 }
 
-int cmd_cat_file(int argc, const char **argv, const char *prefix)
+static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 {
 	unsigned char sha1[20];
 	enum object_type type;
 	void *buf;
 	unsigned long size;
-	int opt;
-	const char *exp_type, *obj_name;
-
-	git_config(git_default_config);
-	if (argc != 3)
-		usage("git-cat-file [-t|-s|-e|-p|<type>] <sha1>");
-	exp_type = argv[1];
-	obj_name = argv[2];
 
 	if (get_sha1(obj_name, sha1))
 		die("Not a valid object name %s", obj_name);
 
-	opt = 0;
-	if ( exp_type[0] == '-' ) {
-		opt = exp_type[1];
-		if ( !opt || exp_type[2] )
-			opt = -1; /* Not a single character option */
-	}
-
 	buf = NULL;
 	switch (opt) {
 	case 't':
@@ -157,3 +142,24 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	write_or_die(1, buf, size);
 	return 0;
 }
+
+int cmd_cat_file(int argc, const char **argv, const char *prefix)
+{
+	int opt;
+	const char *exp_type, *obj_name;
+
+	git_config(git_default_config);
+	if (argc != 3)
+		usage("git-cat-file [-t|-s|-e|-p|<type>] <sha1>");
+	exp_type = argv[1];
+	obj_name = argv[2];
+
+	opt = 0;
+	if ( exp_type[0] == '-' ) {
+		opt = exp_type[1];
+		if ( !opt || exp_type[2] )
+			opt = -1; /* Not a single character option */
+	}
+
+	return cat_one_file(opt, exp_type, obj_name);
+}
-- 
1.5.5.1.152.g9aeb7
