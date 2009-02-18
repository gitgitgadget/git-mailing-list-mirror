From: Michael Spang <mspang@uwaterloo.ca>
Subject: [PATCH] Skip timestamp differences for diff --no-index
Date: Wed, 18 Feb 2009 01:48:06 -0500
Message-ID: <1234939686-14932-1-git-send-email-mspang@uwaterloo.ca>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 07:59:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZgOz-00040F-DK
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 07:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbZBRG55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 01:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752336AbZBRG55
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 01:57:57 -0500
Received: from caffeine.csclub.uwaterloo.ca ([129.97.134.17]:46104 "EHLO
	caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752042AbZBRG54 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Feb 2009 01:57:56 -0500
X-Greylist: delayed 590 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Feb 2009 01:57:56 EST
Received: from caffeine.csclub.uwaterloo.ca (localhost [127.0.0.1])
	by caffeine.csclub.uwaterloo.ca (Postfix) with ESMTP id 376ED73CF1;
	Wed, 18 Feb 2009 01:48:06 -0500 (EST)
Received: by caffeine.csclub.uwaterloo.ca (Postfix, from userid 21292)
	id 284DD73CF8; Wed, 18 Feb 2009 01:48:06 -0500 (EST)
X-Mailer: git-send-email 1.5.6.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110510>

We display empty diffs for files whose timestamps have changed.
Usually, refreshing the index makes those empty diffs go away.
However, when not using the index they are not very useful and
there is no option to suppress them.

This forces on the skip_stat_unmatch option for diff --no-index,
suppressing any empty diffs. This option is also used for diffs
against the index when "diff.autorefreshindex" is set, but that
option does not apply to diff --no-index.

Signed-off-by: Michael Spang <mspang@uwaterloo.ca>
---
 diff-no-index.c                       |    1 +
 t/t4013-diff-various.sh               |    5 +++++
 t/t4013/diff.diff_--no-index_dir_dir3 |    2 ++
 3 files changed, 8 insertions(+), 0 deletions(-)
 create mode 100644 t/t4013/diff.diff_--no-index_dir_dir3

diff --git a/diff-no-index.c b/diff-no-index.c
index 0dbd9da..0a14268 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -247,6 +247,7 @@ void diff_no_index(struct rev_info *revs,
 	else
 		revs->diffopt.paths = argv + argc - 2;
 	revs->diffopt.nr_paths = 2;
+	revs->diffopt.skip_stat_unmatch = 1;
 
 	DIFF_OPT_SET(&revs->diffopt, EXIT_WITH_STATUS);
 	DIFF_OPT_SET(&revs->diffopt, NO_INDEX);
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index aba5320..9c70902 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -74,6 +74,10 @@ test_expect_success setup '
 	for i in 1 2; do echo $i; done >>dir/sub &&
 	git update-index file0 dir/sub &&
 
+	mkdir dir3 &&
+	cp dir/sub dir3/sub &&
+	test-chmtime +1 dir3/sub &&
+
 	git config log.showroot false &&
 	git commit --amend &&
 	git show-branch
@@ -262,6 +266,7 @@ diff --patch-with-raw -r initial..side
 diff --name-status dir2 dir
 diff --no-index --name-status dir2 dir
 diff --no-index --name-status -- dir2 dir
+diff --no-index dir dir3
 diff master master^ side
 EOF
 
diff --git a/t/t4013/diff.diff_--no-index_dir_dir3 b/t/t4013/diff.diff_--no-index_dir_dir3
new file mode 100644
index 0000000..2142c2b
--- /dev/null
+++ b/t/t4013/diff.diff_--no-index_dir_dir3
@@ -0,0 +1,2 @@
+$ git diff --no-index dir dir3
+$
-- 
1.6.0.6
