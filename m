From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Ignore executable bit when adding files if filemode=0.
Date: Wed, 27 Sep 2006 01:21:19 -0400
Message-ID: <20060927052119.GA9614@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Sep 27 07:21:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSRrN-00055z-DE
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 07:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965132AbWI0FV0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 01:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965172AbWI0FV0
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 01:21:26 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:27549 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S965132AbWI0FVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 01:21:25 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GSRrG-0004I9-NO
	for git@vger.kernel.org; Wed, 27 Sep 2006 01:21:23 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9726920FB28; Wed, 27 Sep 2006 01:21:19 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27874>

If the user has configured core.filemode=0 then we shouldn't set
the execute bit in the index when adding a new file as the user
has indicated that the local filesystem can't be trusted.

This means that when adding files that should be marked executable
in a repository with core.filemode=0 the user must perform a
'git update-index --chmod=+x' on the file before committing the
addition.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-update-index.c |    4 +++-
 read-cache.c           |    4 +++-
 t/t3700-add.sh         |   22 ++++++++++++++++++++++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index 0620e77..a3c0a45 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -112,11 +112,13 @@ static int add_file_to_cache(const char 
 	ce->ce_mode = create_ce_mode(st.st_mode);
 	if (!trust_executable_bit) {
 		/* If there is an existing entry, pick the mode bits
-		 * from it.
+		 * from it, otherwise force to 644.
 		 */
 		int pos = cache_name_pos(path, namelen);
 		if (0 <= pos)
 			ce->ce_mode = active_cache[pos]->ce_mode;
+		else
+			ce->ce_mode = create_ce_mode(S_IFREG | 0644);
 	}
 
 	if (index_path(ce->sha1, path, &st, !info_only))
diff --git a/read-cache.c b/read-cache.c
index 20c9d49..97c3867 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -347,11 +347,13 @@ int add_file_to_index(const char *path, 
 	ce->ce_mode = create_ce_mode(st.st_mode);
 	if (!trust_executable_bit) {
 		/* If there is an existing entry, pick the mode bits
-		 * from it.
+		 * from it, otherwise force to 644.
 		 */
 		int pos = cache_name_pos(path, namelen);
 		if (pos >= 0)
 			ce->ce_mode = active_cache[pos]->ce_mode;
+		else
+			ce->ce_mode = create_ce_mode(S_IFREG | 0644);
 	}
 
 	if (index_path(ce->sha1, path, &st, 1))
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 6cd05c3..d36f22d 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -19,4 +19,26 @@ test_expect_success \
     'Test that "git-add -- -q" works' \
     'touch -- -q && git-add -- -q'
 
+test_expect_success \
+	'git-add: Test that executable bit is not used if core.filemode=0' \
+	'git repo-config core.filemode 0 &&
+	 echo foo >xfoo1 &&
+	 chmod 755 xfoo1 &&
+	 git-add xfoo1 &&
+	 case "`git-ls-files --stage xfoo1`" in
+	 100644" "*xfoo1) echo ok;;
+	 *) echo fail; git-ls-files --stage xfoo1; exit 1;;
+	 esac'
+
+test_expect_success \
+	'git-update-index --add: Test that executable bit is not used...' \
+	'git repo-config core.filemode 0 &&
+	 echo foo >xfoo2 &&
+	 chmod 755 xfoo2 &&
+	 git-add xfoo2 &&
+	 case "`git-ls-files --stage xfoo2`" in
+	 100644" "*xfoo2) echo ok;;
+	 *) echo fail; git-ls-files --stage xfoo2; exit 1;;
+	 esac'
+
 test_done
-- 
1.4.2.1.g7a39b
