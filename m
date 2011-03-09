From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] log: fix --max-count when used together with -S or -G
Date: Wed,  9 Mar 2011 21:52:15 +0100
Message-ID: <1299703935-639-1-git-send-email-Matthieu.Moy@imag.fr>
References: <7vvczte7tw.fsf@alter.siamese.dyndns.org>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 09 21:56:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxQQs-0005hs-Rb
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 21:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879Ab1CIU4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 15:56:11 -0500
Received: from imag.imag.fr ([129.88.30.1]:48777 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791Ab1CIU4I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 15:56:08 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id p29KqOk5020294
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 9 Mar 2011 21:52:24 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PxQMq-00057u-9B; Wed, 09 Mar 2011 21:52:24 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1PxQMq-0000BI-3a; Wed, 09 Mar 2011 21:52:24 +0100
X-Mailer: git-send-email 1.7.4.1.211.gda9d9.dirty
In-Reply-To: <7vvczte7tw.fsf@alter.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 09 Mar 2011 21:52:24 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168759>

--max-count is implemented by counting revisions in get_revision(), but
the -S and -G take effect later (after running diff), hence,
--max-count=10 -Sfoo meant "examine the 10 first revisions, and out of
them, show only those changing the occurences of foo", not "show 10
revisions changing the occurences of foo".

In case the commit isn't actually shown, cancel the decrement of
max_count.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---

Although I don't find the patch really elegant, it seems correct
(well, there was an obvious bug: I didn't check that max_count was !=
-1, but that's repaired), and nobody came up with a better idea.

Since the RFC, I also added tests.

 builtin/log.c                             |    8 +++++++-
 t/t4013-diff-various.sh                   |    3 +++
 t/t4013/diff.log_-SF_master_--max-count=0 |    2 ++
 t/t4013/diff.log_-SF_master_--max-count=1 |    7 +++++++
 t/t4013/diff.log_-SF_master_--max-count=2 |    7 +++++++
 5 files changed, 26 insertions(+), 1 deletions(-)
 create mode 100644 t/t4013/diff.log_-SF_master_--max-count=0
 create mode 100644 t/t4013/diff.log_-SF_master_--max-count=1
 create mode 100644 t/t4013/diff.log_-SF_master_--max-count=2

diff --git a/builtin/log.c b/builtin/log.c
index f5ed690..167d710 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -263,7 +263,13 @@ static int cmd_log_walk(struct rev_info *rev)
 	 * retain that state information if replacing rev->diffopt in this loop
 	 */
 	while ((commit = get_revision(rev)) != NULL) {
-		log_tree_commit(rev, commit);
+		if (!log_tree_commit(rev, commit) &&
+		    rev->max_count >= 0)
+			/*
+			 * We decremented max_count in get_revision,
+			 * but we didn't actually show the commit.
+			 */
+			rev->max_count++;
 		if (!rev->reflog_info) {
 			/* we allow cycles in reflog ancestry */
 			free(commit->buffer);
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index b8f81d0..5daa0f2 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -210,6 +210,9 @@ log -m -p master
 log -SF master
 log -S F master
 log -SF -p master
+log -SF master --max-count=0
+log -SF master --max-count=1
+log -SF master --max-count=2
 log -GF master
 log -GF -p master
 log -GF -p --pickaxe-all master
diff --git a/t/t4013/diff.log_-SF_master_--max-count=0 b/t/t4013/diff.log_-SF_master_--max-count=0
new file mode 100644
index 0000000..c1fc6c8
--- /dev/null
+++ b/t/t4013/diff.log_-SF_master_--max-count=0
@@ -0,0 +1,2 @@
+$ git log -SF master --max-count=0
+$
diff --git a/t/t4013/diff.log_-SF_master_--max-count=1 b/t/t4013/diff.log_-SF_master_--max-count=1
new file mode 100644
index 0000000..c981a03
--- /dev/null
+++ b/t/t4013/diff.log_-SF_master_--max-count=1
@@ -0,0 +1,7 @@
+$ git log -SF master --max-count=1
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:02:00 2006 +0000
+
+    Third
+$
diff --git a/t/t4013/diff.log_-SF_master_--max-count=2 b/t/t4013/diff.log_-SF_master_--max-count=2
new file mode 100644
index 0000000..a6c55fd
--- /dev/null
+++ b/t/t4013/diff.log_-SF_master_--max-count=2
@@ -0,0 +1,7 @@
+$ git log -SF master --max-count=2
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:02:00 2006 +0000
+
+    Third
+$
-- 
1.7.4.1.211.gda9d9.dirty
