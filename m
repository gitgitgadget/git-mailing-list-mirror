From: Adam Roben <aroben@apple.com>
Subject: [PATCH 3/9] git-cat-file: Make option parsing a little more flexible
Date: Mon, 22 Oct 2007 22:46:31 -0700
Message-ID: <1193118397-4696-4-git-send-email-aroben@apple.com>
References: <1193118397-4696-1-git-send-email-aroben@apple.com>
 <1193118397-4696-2-git-send-email-aroben@apple.com>
 <1193118397-4696-3-git-send-email-aroben@apple.com>
Cc: Junio C Hamano <gitster@pobox.com>, Adam Roben <aroben@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 07:47:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkCbu-0007N2-LW
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 07:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbXJWFrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 01:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbXJWFrQ
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 01:47:16 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:57262 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbXJWFrM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 01:47:12 -0400
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out4.apple.com (Postfix) with ESMTP id 5F04516874AC;
	Mon, 22 Oct 2007 22:47:11 -0700 (PDT)
Received: from relay14.apple.com (unknown [127.0.0.1])
	by relay14.apple.com (Symantec Mail Security) with ESMTP id 3E58B28092;
	Mon, 22 Oct 2007 22:47:11 -0700 (PDT)
X-AuditID: 11807134-a6e5cbb000000c52-5e-471d8adf0054
Received: from localhost.localdomain (aroben3.apple.com [17.203.12.72])
	by relay14.apple.com (Apple SCV relay) with ESMTP id 200CD28086;
	Mon, 22 Oct 2007 22:47:11 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.1333.ga2f32
In-Reply-To: <1193118397-4696-3-git-send-email-aroben@apple.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62096>

This will make it easier to add newer options later.

Signed-off-by: Adam Roben <aroben@apple.com>
---
 builtin-cat-file.c |   42 ++++++++++++++++++++++++++++++------------
 1 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 34a63d1..3a0be4a 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -143,23 +143,41 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 	return 0;
 }
 
+static const char cat_file_usage[] = "git-cat-file [-t|-s|-e|-p|<type>] <sha1>";
+
 int cmd_cat_file(int argc, const char **argv, const char *prefix)
 {
-	int opt;
-	const char *exp_type, *obj_name;
+	int i, opt = 0;
+	const char *exp_type = 0, *obj_name = 0;
 
 	git_config(git_default_config);
-	if (argc != 3)
-		usage("git-cat-file [-t|-s|-e|-p|<type>] <sha1>");
-	exp_type = argv[1];
-	obj_name = argv[2];
-
-	opt = 0;
-	if ( exp_type[0] == '-' ) {
-		opt = exp_type[1];
-		if ( !opt || exp_type[2] )
-			opt = -1; /* Not a single character option */
+
+	for (i = 1; i < argc; ++i) {
+		const char *arg = argv[i];
+
+		if (!strcmp(arg, "-t") || !strcmp(arg, "-s") || !strcmp(arg, "-e") || !strcmp(arg, "-p")) {
+			exp_type = arg;
+			opt = exp_type[1];
+			continue;
+		}
+
+		if (arg[0] == '-')
+			usage(cat_file_usage);
+
+		if (!exp_type) {
+			exp_type = arg;
+			continue;
+		}
+
+		if (obj_name)
+			usage(cat_file_usage);
+
+		obj_name = arg;
+		break;
 	}
 
+	if (!exp_type || !obj_name)
+		usage(cat_file_usage);
+
 	return cat_one_file(opt, exp_type, obj_name);
 }
-- 
1.5.3.4.1333.ga2f32
