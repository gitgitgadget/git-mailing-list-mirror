From: Adam Roben <aroben@apple.com>
Subject: [PATCH 2/9] git-cat-file: Small refactor of cmd_cat_file
Date: Mon, 22 Oct 2007 22:46:30 -0700
Message-ID: <1193118397-4696-3-git-send-email-aroben@apple.com>
References: <1193118397-4696-1-git-send-email-aroben@apple.com>
 <1193118397-4696-2-git-send-email-aroben@apple.com>
Cc: Junio C Hamano <gitster@pobox.com>, Adam Roben <aroben@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 07:47:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkCbv-0007N2-BL
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 07:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbXJWFrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 01:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbXJWFrR
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 01:47:17 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:57261 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbXJWFrM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 01:47:12 -0400
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out4.apple.com (Postfix) with ESMTP id 3EB0F16874AB;
	Mon, 22 Oct 2007 22:47:11 -0700 (PDT)
Received: from relay14.apple.com (unknown [127.0.0.1])
	by relay14.apple.com (Symantec Mail Security) with ESMTP id 264A028050;
	Mon, 22 Oct 2007 22:47:11 -0700 (PDT)
X-AuditID: 11807134-a665bbb000000c52-5d-471d8adf9453
Received: from localhost.localdomain (aroben3.apple.com [17.203.12.72])
	by relay14.apple.com (Apple SCV relay) with ESMTP id 0C84928055;
	Mon, 22 Oct 2007 22:47:11 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.1333.ga2f32
In-Reply-To: <1193118397-4696-2-git-send-email-aroben@apple.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62097>

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
1.5.3.4.1333.ga2f32
