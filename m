From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 4/7] Default core.packdGitWindowSize to 1 MiB if NO_MMAP.
Date: Sun, 24 Dec 2006 00:46:13 -0500
Message-ID: <20061224054613.GD8146@spearce.org>
References: <487c7d0ea81f2f82f330e277e0aea38a66ca7cfe.1166939109.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 06:46:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyMBg-0001Sp-O4
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 06:46:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134AbWLXFqS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 00:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754140AbWLXFqR
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 00:46:17 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53743 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134AbWLXFqR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 00:46:17 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GyMBb-0008PE-S7; Sun, 24 Dec 2006 00:46:15 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1EBE920FB65; Sun, 24 Dec 2006 00:46:14 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <487c7d0ea81f2f82f330e277e0aea38a66ca7cfe.1166939109.git.spearce@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35341>

If the compiler has asked us to disable use of mmap() on their
platform then we are forced to use git_mmap and its emulation via
pread.  In this case large (e.g. 32 MiB) windows for pack access
are simply too big as a command will wind up reading a lot more
data than it will ever need, significantly reducing response time.

To prevent a high latency when NO_MMAP has been selected we now
use a default of 1 MiB for core.packedGitWindowSize.  Credit goes
to Linus and Junio for recommending this more reasonable setting.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 environment.c     |    2 +-
 git-compat-util.h |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/environment.c b/environment.c
index 289fc84..e89aab4 100644
--- a/environment.c
+++ b/environment.c
@@ -22,7 +22,7 @@ char git_commit_encoding[MAX_ENCODING_LENGTH] = "utf-8";
 int shared_repository = PERM_UMASK;
 const char *apply_default_whitespace;
 int zlib_compression_level = Z_DEFAULT_COMPRESSION;
-size_t packed_git_window_size = 32 * 1024 * 1024;
+size_t packed_git_window_size = DEFAULT_packed_git_window_size;
 size_t packed_git_limit = 256 * 1024 * 1024;
 int pager_in_use;
 int pager_use_color = 1;
diff --git a/git-compat-util.h b/git-compat-util.h
index 5d9eb26..e056339 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -87,6 +87,7 @@ extern void set_warn_routine(void (*routine)(const char *warn, va_list params));
 #define MAP_FAILED ((void*)-1)
 #endif
 
+#define DEFAULT_packed_git_window_size (1 * 1024 * 1024)
 #define mmap git_mmap
 #define munmap git_munmap
 extern void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
@@ -95,6 +96,7 @@ extern int git_munmap(void *start, size_t length);
 #else /* NO_MMAP */
 
 #include <sys/mman.h>
+#define DEFAULT_packed_git_window_size (32 * 1024 * 1024)
 
 #endif /* NO_MMAP */
 
-- 
1.4.4.3.g2e63
