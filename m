From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Increase packedGit{Limit,WindowSize} on 64 bit systems.
Date: Thu, 4 Jan 2007 22:28:08 -0500
Message-ID: <20070105032808.GA14247@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 04:28:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2fkf-0004FM-Hc
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 04:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbXAED2N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 22:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbXAED2N
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 22:28:13 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53259 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030304AbXAED2M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 22:28:12 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H2fkM-00026j-4m; Thu, 04 Jan 2007 22:27:58 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 78C9B20FB65; Thu,  4 Jan 2007 22:28:08 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35976>

If we have a 64 bit address space we can easily afford to commit
a larger amount of virtual address space to pack file access.
So on these platforms we should increase the default settings of
core.packedGit{Limit,WindowSize} to something that will better
handle very large projects.

Thanks to Andy Whitcroft for pointing out that we can safely
increase these defaults on such systems.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/config.txt |   16 ++++++++++------
 git-compat-util.h        |   10 ++++++++--
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e4ee52f..b4aae0d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -125,9 +125,12 @@ core.packedGitWindowSize::
 	more quickly.  Smaller window sizes will negatively affect
 	performance due to increased calls to the operating system's
 	memory manager, but may improve performance when accessing
-	a large number of large pack files.  Default is 32 MiB,
-	which should be reasonable for all users/operating systems.
-	You probably do not need to adjust this value.
+	a large number of large pack files.
++
+Default is 1 MiB if NO_MMAP was set at compile time, otherwise 32
+MiB on 32 bit platforms and 1 GiB on 64 bit platforms.  This should
+be reasonable for all users/operating systems.  You probably do
+not need to adjust this value.
 +
 Common unit suffixes of 'k', 'm', or 'g' are supported.
 
@@ -136,9 +139,10 @@ core.packedGitLimit::
 	from pack files.  If Git needs to access more than this many
 	bytes at once to complete an operation it will unmap existing
 	regions to reclaim virtual address space within the process.
-	Default is 256 MiB, which should be reasonable for all
-	users/operating systems, except on the largest projects.
-	You probably do not need to adjust this value.
++
+Default is 256 MiB on 32 bit platforms and 8 GiB on 64 bit platforms.
+This should be reasonable for all users/operating systems, except on
+the largest projects.  You probably do not need to adjust this value.
 +
 Common unit suffixes of 'k', 'm', or 'g' are supported.
 
diff --git a/git-compat-util.h b/git-compat-util.h
index f243b86..55456da 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -97,11 +97,17 @@ extern int git_munmap(void *start, size_t length);
 #else /* NO_MMAP */
 
 #include <sys/mman.h>
-#define DEFAULT_PACKED_GIT_WINDOW_SIZE (32 * 1024 * 1024)
+#define DEFAULT_PACKED_GIT_WINDOW_SIZE \
+	(sizeof(void*) >= 8 \
+		?  1 * 1024 * 1024 * 1024 \
+		: 32 * 1024 * 1024)
 
 #endif /* NO_MMAP */
 
-#define DEFAULT_PACKED_GIT_LIMIT (256 * 1024 * 1024)
+#define DEFAULT_PACKED_GIT_LIMIT \
+	(sizeof(void*) >= 8 \
+		?   8 * 1024 * 1024 * 1024 \
+		: 256 * 1024 * 1024)
 
 #ifdef NO_SETENV
 #define setenv gitsetenv
-- 
1.5.0.rc0.gce9e
