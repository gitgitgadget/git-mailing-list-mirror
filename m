X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH 1/3] Allow short pack names to git-pack-objects --unpacked=.
Date: Sun, 29 Oct 2006 04:37:11 -0500
Message-ID: <20061029093711.GC3847@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 29 Oct 2006 09:37:29 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30420>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ge76Y-0007vl-E4 for gcvg-git@gmane.org; Sun, 29 Oct
 2006 10:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932132AbWJ2JhS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 04:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWJ2JhS
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 04:37:18 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39562 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S932132AbWJ2JhQ
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 04:37:16 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Ge76h-0002sW-0U; Sun, 29 Oct 2006 04:37:31 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 57CD720E45B; Sun, 29 Oct 2006 04:37:12 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Allow short pack names to git-pack-objects --unpacked=.

This allows us to pass just the file name of a pack rather than
the complete path when we want pack-objects to consider its
contents as though they were loose objects.  This can be helpful
if $GIT_OBJECT_DIRECTORY contains shell metacharacters which make
it cumbersome to pass complete paths safely in a shell script.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index e89d24c..5e6c8b8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1203,6 +1203,24 @@ unsigned long find_pack_entry_one(const
 	return 0;
 }
 
+static int matches_pack_name(struct packed_git *p, const char *ig)
+{
+	const char *last_c, *c;
+
+	if (!strcmp(p->pack_name, ig))
+		return 0;
+
+	for (c = p->pack_name, last_c = c; *c;)
+		if (*c == '/')
+			last_c = ++c;
+		else
+			++c;
+	if (!strcmp(last_c, ig))
+		return 0;
+
+	return 1;
+}
+
 static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e, const char **ignore_packed)
 {
 	struct packed_git *p;
@@ -1214,7 +1232,7 @@ static int find_pack_entry(const unsigne
 		if (ignore_packed) {
 			const char **ig;
 			for (ig = ignore_packed; *ig; ig++)
-				if (!strcmp(p->pack_name, *ig))
+				if (!matches_pack_name(p, *ig))
 					break;
 			if (*ig)
 				continue;
-- 
1.4.3.3.g7d63
