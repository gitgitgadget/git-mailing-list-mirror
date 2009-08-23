From: Thell Fowler <git@tbfowler.name>
Subject: [PATCH-v2/RFC 3/6] xutils: fix ignore-all-space on incomplete line
Date: Sat, 22 Aug 2009 22:49:14 -0500
Message-ID: <1250999357-10827-3-git-send-email-git@tbfowler.name>
References: <1250999285-10683-1-git-send-email-git@tbfowler.name>
Cc: Johannes.Schindelin@gmx.de, Thell Fowler <git@tbfowler.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 23 05:50:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mf45y-0006Jw-Iz
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 05:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933474AbZHWDtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 23:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933470AbZHWDtr
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 23:49:47 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:43332 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S933456AbZHWDto (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 23:49:44 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=localhost.localdomain)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1Mf45S-0004jt-Ir; Sat, 22 Aug 2009 22:49:46 -0500
X-Mailer: git-send-email 1.6.4.176.g556a4
In-Reply-To: <1250999285-10683-1-git-send-email-git@tbfowler.name>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps5.pyrapat.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tbfowler.name
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126835>

  - Allow xdl_recmatch to recognize and continue processing when
    at the end of an incomplete line.

  Resolves issue with --ignore-all-space when either side 1 or 2
  has 0 trailing spaces and either (or both) are incomplete by
  allowing the processing loop to continue when one side has
  reached the end and includes a check for being at eof on an
  incomplete line.

Signed-off-by: Thell Fowler <git@tbfowler.name>
---
 xdiff/xutils.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index c6512a5..e22b4bb 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -191,12 +191,14 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 	int i1, i2;
 
 	if (flags & XDF_IGNORE_WHITESPACE) {
-		for (i1 = i2 = 0; i1 < s1 && i2 < s2; ) {
+		for (i1 = i2 = 0; i1 < s1 || i2 < s2; ) {
 			if (isspace(l1[i1]))
-				while (isspace(l1[i1]) && i1 < s1)
+				while ((isspace(l1[i1]) && i1 < s1)
+						|| (i1 + 1 == s1 && l1[s1] != '\n'))
 					i1++;
 			if (isspace(l2[i2]))
-				while (isspace(l2[i2]) && i2 < s2)
+				while ((isspace(l2[i2]) && i2 < s2)
+						|| (i2 + 1 == s2 && l2[s2] != '\n'))
 					i2++;
 			if (i1 < s1 && i2 < s2 && l1[i1++] != l2[i2++])
 				return 0;
-- 
1.6.4.176.g556a4
