From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] Support common unit suffixes in packedGitWindowSize.
Date: Sat, 30 Dec 2006 21:02:42 -0500
Message-ID: <20061231020242.GB5366@spearce.org>
References: <bc77965370c83bccc9b04c68911ab7e9d7d83d58.1167530501.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 03:02:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0q2D-0000LF-0L
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 03:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653AbWLaCCq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 21:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbWLaCCq
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 21:02:46 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38678 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932653AbWLaCCp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 21:02:45 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H0q1w-0007ez-Ep; Sat, 30 Dec 2006 21:02:32 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6CF4D20FB65; Sat, 30 Dec 2006 21:02:42 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <bc77965370c83bccc9b04c68911ab7e9d7d83d58.1167530501.git.spearce@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35649>

Make use of the new git_config_datasize function to parse the value
for core.packedGitWindowSize and core.packedGitLimit, as these
need to be a bytecount internally but the user will probably want
to specify them with standard units, such as "32 MiB".

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Applies on top of sp/mmap.

 Documentation/config.txt |   10 ++++++++--
 config.c                 |    6 +++---
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d71653d..17d5b53 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -123,21 +123,27 @@ core.packedGitWindowSize::
 	single mapping operation.  Larger window sizes may allow
 	your system to process a smaller number of large pack files
 	more quickly.  Smaller window sizes will negatively affect
-	performance due to increased calls to the opreating system's
+	performance due to increased calls to the operating system's
 	memory manager, but may improve performance when accessing
 	a large number of large pack files.  Default is 32 MiB,
 	which should be reasonable for all users/operating systems.
 	You probably do not need to adjust this value.
 
+	Common unit suffixes of 'k', 'kb', 'kib', 'm', 'mb', 'mib',
+	'g', 'gb', 'gib' are supported.
+
 core.packedGitLimit::
 	Maximum number of bytes to map simultaneously into memory
 	from pack files.  If Git needs to access more than this many
 	bytes at once to complete an operation it will unmap existing
 	regions to reclaim virtual address space within the process.
 	Default is 256 MiB, which should be reasonable for all
-	users/operating systems, except on largest Git projects.
+	users/operating systems, except on the largest projects.
 	You probably do not need to adjust this value.
 
+	Common unit suffixes of 'k', 'kb', 'kib', 'm', 'mb', 'mib',
+	'g', 'gb', 'gib' are supported.
+
 alias.*::
 	Command aliases for the gitlink:git[1] command wrapper - e.g.
 	after defining "alias.last = cat-file commit HEAD", the invocation
diff --git a/config.c b/config.c
index 07ad2f1..a9f4497 100644
--- a/config.c
+++ b/config.c
@@ -324,8 +324,8 @@ int git_default_config(const char *var, const char *value)
 	}
 
 	if (!strcmp(var, "core.packedgitwindowsize")) {
-		int pgsz = getpagesize();
-		packed_git_window_size = git_config_int(var, value);
+		unsigned long pgsz = getpagesize();
+		packed_git_window_size = git_config_datasize(var, value);
 		packed_git_window_size /= pgsz;
 		if (packed_git_window_size < 2)
 			packed_git_window_size = 2;
@@ -334,7 +334,7 @@ int git_default_config(const char *var, const char *value)
 	}
 
 	if (!strcmp(var, "core.packedgitlimit")) {
-		packed_git_limit = git_config_int(var, value);
+		packed_git_limit = git_config_datasize(var, value);
 		return 0;
 	}
 
-- 
1.5.0.rc0.g6bb1
