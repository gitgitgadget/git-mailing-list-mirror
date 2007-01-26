From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] If abbrev is set to zero in git-describe, don't add the unique suffix
Date: Fri, 26 Jan 2007 14:28:55 +0000
Message-ID: <200701261428.55838.andyparkins@gmail.com>
References: <200701261036.26012.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 15:29:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAS4e-00050d-KT
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 15:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbXAZO3A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 09:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbXAZO27
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 09:28:59 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:25001 "EHLO
	369run02s.360vision.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030363AbXAZO27 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 09:28:59 -0500
Received: from dvr.360vision.com ([192.189.1.65]) by 369run02s.360vision.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 26 Jan 2007 14:31:57 +0000
Received: from localhost ([127.0.0.1])
	by dvr.360vision.com with esmtp (Exim 3.36 #1 (Debian))
	id 1HAS4X-0008Ji-00
	for <git@vger.kernel.org>; Fri, 26 Jan 2007 14:28:57 +0000
In-Reply-To: <200701261036.26012.andyparkins@gmail.com>
X-TUID: 4b9255115d7906f1
X-UID: 212
X-Length: 2280
Content-Disposition: inline
X-OriginalArrivalTime: 26 Jan 2007 14:31:57.0828 (UTC) FILETIME=[BBDEC440:01C74156]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37860>

When on a non-tag commit, git-describe normally outputs descriptions of
the form
  v1.0.0-g1234567890
Some scripts (for example the update hook script) might just want to
know the name of the nearest tag, so they then have to do
 x=$(git-describe HEAD | sed 's/-g*//')
This is costly, but more importantly is fragile as it is relying on the
output format of git-describe, which we would then have to maintain
forever.

This patch adds support for setting the --abbrev option to zero.  In
that case git-describe does as it always has, but outputs only the
nearest found tag instead of a completely unique name.  This means that
scripts would not have to parse the output format and won't need
changing if the git-describe suffix is ever changed.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 builtin-describe.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index 4921eee..f3ac2d5 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -188,8 +188,11 @@ static void describe(const char *arg, int last_one)
 				sha1_to_hex(gave_up_on->object.sha1));
 		}
 	}
-	printf("%s-g%s\n", all_matches[0].name->path,
-		   find_unique_abbrev(cmit->object.sha1, abbrev));
+	if (abbrev == 0)
+		printf("%s\n", all_matches[0].name->path );
+	else
+		printf("%s-g%s\n", all_matches[0].name->path,
+			   find_unique_abbrev(cmit->object.sha1, abbrev));
 
 	if (!last_one)
 		clear_commit_marks(cmit, -1);
@@ -212,7 +215,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			tags = 1;
 		else if (!strncmp(arg, "--abbrev=", 9)) {
 			abbrev = strtoul(arg + 9, NULL, 10);
-			if (abbrev < MINIMUM_ABBREV || 40 < abbrev)
+			if (abbrev != 0 && (abbrev < MINIMUM_ABBREV || 40 < abbrev))
 				abbrev = DEFAULT_ABBREV;
 		}
 		else if (!strncmp(arg, "--candidates=", 13)) {
-- 
1.5.0.rc2.gc3537-dirty
