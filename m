From: David Kastrup <dak@gnu.org>
Subject: [PATCH] Bump core.deltaBaseCacheLimit to 96m
Date: Sun,  4 May 2014 19:13:57 +0200
Message-ID: <1399223637-29964-1-git-send-email-dak@gnu.org>
Cc: David Kastrup <dak@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 19:14:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wh004-00024E-SP
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 19:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976AbaEDROO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 13:14:14 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:41650 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509AbaEDROO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2014 13:14:14 -0400
Received: from localhost ([127.0.0.1]:40693 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WgzzQ-0003xm-ES; Sun, 04 May 2014 13:14:12 -0400
Received: by lola (Postfix, from userid 1000)
	id 09520E08BB; Sun,  4 May 2014 19:14:03 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248099>

The default of 16m causes serious thrashing for large delta chains
combined with large files.

Here are some benchmarks (pu variant of git blame):

time git blame -C src/xdisp.c >/dev/null

for a repository of Emacs repacked with git gc --aggressive (v1.9,
resulting in a window size of 250) located on an SSD drive.  The file in
question has about 30000 lines, 1Mb of size, and a history with about
2500 commits.

16m (previous default):
real	3m33.936s
user	2m15.396s
sys	1m17.352s

32m:
real	3m1.319s
user	2m8.660s
sys	0m51.904s

64m:
real	2m20.636s
user	1m55.780s
sys	0m23.964s

96m:
real	2m5.668s
user	1m50.784s
sys	0m14.288s

128m:
real	2m4.337s
user	1m50.764s
sys	0m12.832s

192m:
real	2m3.567s
user	1m49.508s
sys	0m13.312s

Signed-off-by: David Kastrup <dak@gnu.org>
---
 Documentation/config.txt | 2 +-
 environment.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1932e9b..21a3c86 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -489,7 +489,7 @@ core.deltaBaseCacheLimit::
 	to avoid unpacking and decompressing frequently used base
 	objects multiple times.
 +
-Default is 16 MiB on all platforms.  This should be reasonable
+Default is 96 MiB on all platforms.  This should be reasonable
 for all users/operating systems, except on the largest projects.
 You probably do not need to adjust this value.
 +
diff --git a/environment.c b/environment.c
index 5c4815d..37354c8 100644
--- a/environment.c
+++ b/environment.c
@@ -37,7 +37,7 @@ int core_compression_seen;
 int fsync_object_files;
 size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
-size_t delta_base_cache_limit = 16 * 1024 * 1024;
+size_t delta_base_cache_limit = 96 * 1024 * 1024;
 unsigned long big_file_threshold = 512 * 1024 * 1024;
 const char *pager_program;
 int pager_use_color = 1;
-- 
1.9.1
