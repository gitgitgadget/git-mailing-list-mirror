X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 3/4] Default to displaying /all/ non-tag refs, not just locals
Date: Thu, 2 Nov 2006 11:11:22 +0000
Message-ID: <200611021111.22604.andyparkins@gmail.com>
References: <bec6ab7849e3fcacac23cca44a0ba93282af5fca.1162465753.git.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 11:11:44 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <bec6ab7849e3fcacac23cca44a0ba93282af5fca.1162465753.git.andyparkins@gmail.com>
X-TUID: 0bead34287d13326
X-UID: 158
X-Length: 2267
Content-Disposition: inline
X-OriginalArrivalTime: 02 Nov 2006 11:12:29.0077 (UTC) FILETIME=[C8D38C50:01C6FE6F]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30722>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfaTp-00040H-7O for gcvg-git@gmane.org; Thu, 02 Nov
 2006 12:11:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752843AbWKBLL0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 06:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752844AbWKBLL0
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 06:11:26 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:12902 "EHLO
 369run02s.360vision.com") by vger.kernel.org with ESMTP id S1752843AbWKBLLZ
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 06:11:25 -0500
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Thu, 2 Nov 2006 11:12:29 +0000
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1GfaTk-0003vx-00 for <git@vger.kernel.org>; Thu, 02 Nov
 2006 11:11:24 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Adds support for display_mode == 2; which shows all non-tag refs.  I've set
display_mode = 2 by default so it's easily reverted if needed - or if a switch
for the old mode is wanted it can be easily added

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 builtin-branch.c |   32 +++++++++++++++++++++++++-------
 1 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 85b7007..b88413a 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -104,20 +104,38 @@ static void print_ref_list(int display_m
 {
 	int i;
 	char c;
+	char *p;
 
-	if (display_mode)
-		for_each_remote_ref(append_ref, NULL);
-	else
-		for_each_branch_ref(append_ref, NULL);
+	switch (display_mode) {
+		case 0:
+			for_each_branch_ref(append_ref, NULL);
+			break;
+		case 1:
+			for_each_remote_ref(append_ref, NULL);
+			break;
+		case 2:
+			for_each_ref(append_ref, NULL);
+			break;
+	}
 
 	qsort(ref_list, ref_index, sizeof(char *), ref_cmp);
 
 	for (i = 0; i < ref_index; i++) {
+		p = ref_list[i];
+		if (display_mode == 2) {
+			if (!strncmp( p, "refs/", 5 ))
+				p += 5;
+			if (!strncmp( p, "tags/", 5 ))
+				continue;
+			if (!strncmp( p, "heads/", 6 ))
+				p += 6;
+		}
+
 		c = ' ';
-		if (!strcmp(ref_list[i], head))
+		if (!strcmp(p, head))
 			c = '*';
 
-		printf("%c %s\n", c, ref_list[i]);
+		printf("%c %s\n", c, p);
 	}
 }
 
@@ -160,7 +178,7 @@ static void create_branch(const char *na
 
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
-	int delete = 0, force_delete = 0, force_create = 0, display_mode = 0;
+	int delete = 0, force_delete = 0, force_create = 0, display_mode = 2;
 	int reflog = 0;
 	int i;
 
-- 
1.4.3.2

