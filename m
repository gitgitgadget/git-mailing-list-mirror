From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] diff: accept -- when using --no-index
Date: Tue,  6 Jan 2009 19:53:32 +0100
Message-ID: <1231268012-5592-1-git-send-email-trast@student.ethz.ch>
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 19:55:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKH4s-0006Bs-Re
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 19:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367AbZAFSxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 13:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbZAFSxd
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 13:53:33 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:22110 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659AbZAFSxd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 13:53:33 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 6 Jan 2009 19:53:31 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 6 Jan 2009 19:53:30 +0100
X-Mailer: git-send-email 1.6.1.50.g847c
X-OriginalArrivalTime: 06 Jan 2009 18:53:30.0418 (UTC) FILETIME=[11163920:01C97030]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104706>

Accept -- as an "end of options" marker even when using --no-index.
Previously, the -- triggered a "normal" index/tree diff and
subsequently failed because of the unrecognized (in that mode)
--no-index.

Note that the second loop can treat '--' as a normal option, because
the preceding checks ensure it is the third-to-last argument.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

---
 diff-no-index.c                                    |    8 ++++++--
 t/t4013-diff-various.sh                            |    1 +
 .../diff.diff_--no-index_--name-status_--_dir2_dir |    3 +++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index b60d345..d1e8e4b 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -173,8 +173,10 @@ void diff_no_index(struct rev_info *revs,
 
 	/* Were we asked to do --no-index explicitly? */
 	for (i = 1; i < argc; i++) {
-		if (!strcmp(argv[i], "--"))
-			return;
+		if (!strcmp(argv[i], "--")) {
+			i++;
+			break;
+		}
 		if (!strcmp(argv[i], "--no-index"))
 			no_index = 1;
 		if (argv[i][0] != '-')
@@ -214,6 +216,8 @@ void diff_no_index(struct rev_info *revs,
 			i++;
 		else if (!strcmp(argv[1], "-q"))
 			options |= DIFF_SILENT_ON_REMOVED;
+		else if (!strcmp(argv[i], "--"))
+			i++;
 		else {
 			j = diff_opt_parse(&revs->diffopt, argv + i, argc - i);
 			if (!j)
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index aeb5405..aba5320 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -261,6 +261,7 @@ diff --patch-with-stat -r initial..side
 diff --patch-with-raw -r initial..side
 diff --name-status dir2 dir
 diff --no-index --name-status dir2 dir
+diff --no-index --name-status -- dir2 dir
 diff master master^ side
 EOF
 
diff --git a/t/t4013/diff.diff_--no-index_--name-status_--_dir2_dir b/t/t4013/diff.diff_--no-index_--name-status_--_dir2_dir
new file mode 100644
index 0000000..6756f8d
--- /dev/null
+++ b/t/t4013/diff.diff_--no-index_--name-status_--_dir2_dir
@@ -0,0 +1,3 @@
+$ git diff --no-index --name-status -- dir2 dir
+A	dir/sub
+$
-- 
tg: (e9b8523..) t/diff-no-index-invocation (depends on: origin/master)
