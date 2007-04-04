From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Honor -p<n> when applying git diffs
Date: Wed, 4 Apr 2007 11:19:14 -0400
Message-ID: <20070404151914.GA4910@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 17:19:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ7Gk-0001bu-Rm
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 17:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992916AbXDDPTS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 11:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992921AbXDDPTS
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 11:19:18 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46367 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992916AbXDDPTR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 11:19:17 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HZ7GQ-00056v-8Z; Wed, 04 Apr 2007 11:19:10 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8AB8020FBAE; Wed,  4 Apr 2007 11:19:14 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43745>

If the user is trying to apply a Git generated diff file and they
have specified a -p<n> option, where <n> is not 1, the user probably
has a good reason for doing this.  Such as they are me, trying to
apply a patch generated in git.git for the git-gui subdirectory to
the git-gui.git repository, where there is no git-gui subdirectory
present.

Users shouldn't supply -p2 unless they mean it.  But if they are
supplying it, they probably have thought about how to make this
patch apply to their working directory, and want to risk whatever
results may come from that.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-apply.c       |    4 ++--
 t/t4120-apply-popt.sh |   25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)
 create mode 100755 t/t4120-apply-popt.sh

diff --git a/builtin-apply.c b/builtin-apply.c
index 27a182b..a5d6126 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -417,7 +417,7 @@ static int gitdiff_hdrend(const char *line, struct patch *patch)
 static char *gitdiff_verify_name(const char *line, int isnull, char *orig_name, const char *oldnew)
 {
 	if (!orig_name && !isnull)
-		return find_name(line, NULL, 1, TERM_TAB);
+		return find_name(line, NULL, p_value, TERM_TAB);
 
 	if (orig_name) {
 		int len;
@@ -427,7 +427,7 @@ static char *gitdiff_verify_name(const char *line, int isnull, char *orig_name,
 		len = strlen(name);
 		if (isnull)
 			die("git-apply: bad git-diff - expected /dev/null, got %s on line %d", name, linenr);
-		another = find_name(line, NULL, 1, TERM_TAB);
+		another = find_name(line, NULL, p_value, TERM_TAB);
 		if (!another || memcmp(another, name, len))
 			die("git-apply: bad git-diff - inconsistent %s filename on line %d", oldnew, linenr);
 		free(another);
diff --git a/t/t4120-apply-popt.sh b/t/t4120-apply-popt.sh
new file mode 100755
index 0000000..2f672f3
--- /dev/null
+++ b/t/t4120-apply-popt.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Shawn O. Pearce
+#
+
+test_description='git-apply -p handling.'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	mkdir sub &&
+	echo A >sub/file1 &&
+	cp sub/file1 file1 &&
+	git add sub/file1 &&
+	echo B >sub/file1 &&
+	git diff >patch.file &&
+	rm sub/file1 &&
+	rmdir sub
+'
+
+test_expect_success 'apply git diff with -p2' '
+	git apply -p2 patch.file
+'
+
+test_done
-- 
1.5.1.rc3.672.gf5329
