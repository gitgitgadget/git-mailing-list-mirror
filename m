From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2 v2] merge-recursive: point the user to commit when file would be overwritten.
Date: Sun, 22 Nov 2009 23:26:17 +0100
Message-ID: <1258928778-32419-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1258732767-12741-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 22 23:30:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCKwe-0005Ga-VU
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 23:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755781AbZKVW36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 17:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755480AbZKVW36
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 17:29:58 -0500
Received: from imag.imag.fr ([129.88.30.1]:55178 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755420AbZKVW35 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 17:29:57 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id nAMMQPYg022460
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 22 Nov 2009 23:26:25 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NCKsy-0004PP-U2; Sun, 22 Nov 2009 23:26:24 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NCKsy-0008RT-RM; Sun, 22 Nov 2009 23:26:24 +0100
X-Mailer: git-send-email 1.6.5.3.435.g5f2e3.dirty
In-Reply-To: <1258732767-12741-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 22 Nov 2009 23:26:25 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133461>

The commit-before-pull is well accepted in the DVCS community, but is
confusing some new users. This should get them back in the right way when
the problem occurs.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/config.txt |    4 ++++
 advice.c                 |    2 ++
 advice.h                 |    1 +
 merge-recursive.c        |    8 +++++++-
 4 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 13871a6..f481f8d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -126,6 +126,10 @@ advice.*::
 		Directions on how to stage/unstage/add shown in the
 		output of linkgit:git-status[1] and the template shown
 		when writing commit messages. Default: true.
+	commitBeforeMerge::
+		Advice shown when linkgit:git-merge[1] refuses to
+		merge to avoid overwritting local changes.
+		Default: true.
 --
 
 core.fileMode::
diff --git a/advice.c b/advice.c
index ae4b1e8..cb666ac 100644
--- a/advice.c
+++ b/advice.c
@@ -2,6 +2,7 @@
 
 int advice_push_nonfastforward = 1;
 int advice_status_hints = 1;
+int advice_commit_before_merge = 1;
 
 static struct {
 	const char *name;
@@ -9,6 +10,7 @@ static struct {
 } advice_config[] = {
 	{ "pushnonfastforward", &advice_push_nonfastforward },
 	{ "statushints", &advice_status_hints },
+	{ "commitbeforemerge", &advice_commit_before_merge },
 };
 
 int git_default_advice_config(const char *var, const char *value)
diff --git a/advice.h b/advice.h
index e9df8e0..3de5000 100644
--- a/advice.h
+++ b/advice.h
@@ -3,6 +3,7 @@
 
 extern int advice_push_nonfastforward;
 extern int advice_status_hints;
+extern int advice_commit_before_merge;
 
 int git_default_advice_config(const char *var, const char *value);
 
diff --git a/merge-recursive.c b/merge-recursive.c
index f55b7eb..1870448 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3,6 +3,7 @@
  * Fredrik Kuivinen.
  * The thieves were Alex Riesen and Johannes Schindelin, in June/July 2006
  */
+#include "advice.h"
 #include "cache.h"
 #include "cache-tree.h"
 #include "commit.h"
@@ -170,7 +171,7 @@ static int git_merge_trees(int index_only,
 	int rc;
 	struct tree_desc t[3];
 	struct unpack_trees_options opts;
-	static const struct unpack_trees_error_msgs msgs = {
+	struct unpack_trees_error_msgs msgs = {
 		/* would_overwrite */
 		"Your local changes to '%s' would be overwritten by merge.  Aborting.",
 		/* not_uptodate_file */
@@ -182,6 +183,11 @@ static int git_merge_trees(int index_only,
 		/* bind_overlap -- will not happen here */
 		NULL,
 	};
+	if (advice_commit_before_merge) {
+		msgs.would_overwrite = msgs.not_uptodate_file =
+			"Your local changes to '%s' would be overwritten by merge.  Aborting.\n"
+			"Please, commit your changes or stash them before you can merge.";
+	}
 
 	memset(&opts, 0, sizeof(opts));
 	if (index_only)
-- 
1.6.5.3.435.g5f2e3.dirty
