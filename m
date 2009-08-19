From: Thell Fowler <git@tbfowler.name>
Subject: [PATCH 4/6] Make diff -b handle trailing-spaces on incomplete
 lines.
Date: Wed, 19 Aug 2009 18:07:55 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.0908191726090.2012@GWPortableVCS>
References: <1249428804.2774.52.camel@GWPortableVCS> <cover.1250719760.git.git@tbfowler.name>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 20 01:08:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MduGY-0006Yv-TL
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 01:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbZHSXIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 19:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753375AbZHSXIT
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 19:08:19 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:45301 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753338AbZHSXIS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 19:08:18 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=GWPortableVCS.local)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1MduGS-0003WB-BP; Wed, 19 Aug 2009 18:08:20 -0500
X-X-Sender: almostautomated@GWPortableVCS
In-Reply-To: <cover.1250719760.git.git@tbfowler.name>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126594>

  - When processing trailing spaces with --ignore-space-change a diff
    would be found whenever an incomplete line terminated before the
    whitespace handling started regardless of actual trailing-spaces.
    xdl_recmatch should process the full length of the record instead
    of assuming both sides have a terminator, and should treat the
    terminator as a whitespace like it does with '\n'.

Signed-off-by: Thell Fowler <git@tbfowler.name>
---
 xdiff/xutils.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 1f28f4fb4e0a8fdc6c9aa1904cf0362dd1e7b977..e126de450c99fb1e557c2cfc0ffe54e8e3e80394 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -203,9 +203,9 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 		}
 		return (i1 >= s1 && i2 >= s2);
 	} else if (flags & XDF_IGNORE_WHITESPACE_CHANGE) {
-		for (i1 = i2 = 0; i1 < s1 && i2 < s2; ) {
-			if (isspace(l1[i1])) {
-				if (!isspace(l2[i2]))
+		for (i1 = i2 = 0; i1 <= s1 && i2 <= s2; ) {
+			if (isspace(l1[i1]) || (i1 == s1 && i2 < s2)) {
+				if (!isspace(l2[i2]) && i2 != s2)
 					return 0;
 				while (isspace(l1[i1]) && i1 < s1)
 					i1++;
-- 
1.6.4.172.g5c0d0.dirty
