X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Improve git-prune -n output
Date: Thu, 26 Oct 2006 11:38:24 +0100
Message-ID: <200610261138.24761.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 10:38:52 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-TUID: fce7975c95b72788
X-Length: 1376
Content-Disposition: inline
X-OriginalArrivalTime: 26 Oct 2006 10:41:28.0279 (UTC) FILETIME=[4AD00E70:01C6F8EB]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30182>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd2dA-0005PP-Nf for gcvg-git@gmane.org; Thu, 26 Oct
 2006 12:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423026AbWJZKia (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 06:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423163AbWJZKia
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 06:38:30 -0400
Received: from mail.360visiontechnology.com ([194.70.53.226]:22109 "EHLO
 369run02s.360vision.com") by vger.kernel.org with ESMTP id S1423026AbWJZKi3
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 06:38:29 -0400
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Thu, 26 Oct 2006 11:41:28 +0100
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1Gd2d0-0008EH-00 for <git@vger.kernel.org>; Thu, 26 Oct
 2006 11:38:26 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

prune_object() in show_only mode would previously just show the path to the
object that would be deleted.  The path the object is stored in shouldn't be
shown to users, they only know about sha1 identifiers so show that instead.

Further, the sha1 alone isn't that useful for examining what is going to be
deleted.  This patch also adds the object type to the output, which makes it
easy to pick out, say, the commits and use git-show to display them.
Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 builtin-prune.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/builtin-prune.c b/builtin-prune.c
index 7290e6d..e3bcf5f 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -16,8 +16,13 @@ static struct rev_info revs;
 
 static int prune_object(char *path, const char *filename, const unsigned char *sha1)
 {
+	char type[20];
+
 	if (show_only) {
-		printf("would prune %s/%s\n", path, filename);
+		if (sha1_object_info(sha1, type, NULL)) {
+			strcpy( type, "unknown type" );
+		}
+		printf("would prune %s %s\n", sha1_to_hex( sha1 ), type );
 		return 0;
 	}
 	unlink(mkpath("%s/%s", path, filename));
-- 
1.4.2.3
