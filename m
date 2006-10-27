X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Improve git-prune -n output
Date: Fri, 27 Oct 2006 09:37:11 +0100
Message-ID: <200610270937.11368.andyparkins@gmail.com>
References: <7vlkn3kn65.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 27 Oct 2006 08:37:47 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vlkn3kn65.fsf@assigned-by-dhcp.cox.net>
X-TUID: 207e2bf1117bc4ba
X-Length: 1497
Content-Disposition: inline
X-OriginalArrivalTime: 27 Oct 2006 08:40:15.0539 (UTC) FILETIME=[8655C030:01C6F9A3]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30309>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdNDO-0005EC-4L for gcvg-git@gmane.org; Fri, 27 Oct
 2006 10:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946250AbWJ0IhR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 04:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965251AbWJ0IhQ
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 04:37:16 -0400
Received: from mail.360visiontechnology.com ([194.70.53.226]:49067 "EHLO
 369run02s.360vision.com") by vger.kernel.org with ESMTP id S964830AbWJ0IhP
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 04:37:15 -0400
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Fri, 27 Oct 2006 09:40:15 +0100
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1GdNDF-0006iv-00 for <git@vger.kernel.org>; Fri, 27 Oct
 2006 09:37:13 +0100
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
Fixes issues from...

Junio C Hamano
 Do not leave blank inside () pairs.
 Do not enclose a single statement in {}.
 No longer uses strcpy()

Petr Baudis
 "unknown type" is now simply "unknown"

Andy Parkins
 No longer outputs "would prune"

 builtin-prune.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/builtin-prune.c b/builtin-prune.c
index 7290e6d..b8b2d05 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -16,8 +16,14 @@ static struct rev_info revs;
 
 static int prune_object(char *path, const char *filename, const unsigned char 
*sha1)
 {
+	char buf[20];
+	const char *type;
+
 	if (show_only) {
-		printf("would prune %s/%s\n", path, filename);
+		type = buf;
+		if (sha1_object_info(sha1, type, NULL))
+			type = "unknown";
+		printf("%s %s\n", sha1_to_hex(sha1), type );
 		return 0;
 	}
 	unlink(mkpath("%s/%s", path, filename));
-- 
1.4.3.3.g5bca6
