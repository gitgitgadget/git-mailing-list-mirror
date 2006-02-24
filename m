From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] git ls files recursively show ignored files
Date: Fri, 24 Feb 2006 17:02:34 -0500
Message-ID: <20060224220234.GB29982@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Feb 24 23:03:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCl1d-0002lJ-4o
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 23:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbWBXWCj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 17:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbWBXWCj
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 17:02:39 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40089 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932597AbWBXWCi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 17:02:38 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FCl1A-0005Z3-Ko
	for git@vger.kernel.org; Fri, 24 Feb 2006 17:02:28 -0500
Received: by asimov.spearce.org (Postfix, from userid 1000)
	id A110520FBA0; Fri, 24 Feb 2006 17:02:34 -0500 (EST)
To: git@vger.kernel.org
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
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16745>

Make git-ls-files --others --ignored recurse into non-excluded
subdirectories.

Typically when asking git-ls-files to display all files which are
ignored by one or more exclude patterns one would want it to recurse
into subdirectories which are not themselves excluded to see if
there are any excluded files contained within those subdirectories.

---
 I found this issue while trying to find temporary garbage that was
 created within a tracked subdirectory:

   touch a/b/foo#1
   git-ls-files --others --ignored --exclude='*#1'

 would never display a/b/foo#1 as the directory 'a' was not itself
 excluded.  It would be rather nice if git-ls-files actually
 showed it.

 ls-files.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

base 98214e96be00c5132047ae80bca20d4690933c33
last 809da5f8a21a10112eece4ee9be55fe64371ce68
diff --git a/ls-files.c b/ls-files.c
index 90b289f03d987c6c90214fc12d00c30b4e28bb27..df25c8c012a96a8277413ca3a81490b81b7dc067 100644
--- a/ls-files.c
+++ b/ls-files.c
@@ -279,8 +279,11 @@ static void read_directory(const char *p
 				continue;
 			len = strlen(de->d_name);
 			memcpy(fullname + baselen, de->d_name, len+1);
-			if (excluded(fullname) != show_ignored)
-				continue;
+			if (excluded(fullname) != show_ignored) {
+				if (!show_ignored || DTYPE(de) != DT_DIR) {
+					continue;
+				}
+			}
 
 			switch (DTYPE(de)) {
 			struct stat st;
-- 
1.2.3.g809d
