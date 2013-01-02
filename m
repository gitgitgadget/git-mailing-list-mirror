From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] merge: Honor prepare-commit-msg return code
Date: Wed,  2 Jan 2013 19:42:50 +0100
Message-ID: <1357152170-5511-1-git-send-email-apelisse@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 02 19:43:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqTHW-0005Dt-W9
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 19:43:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013Ab3ABSm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 13:42:56 -0500
Received: from mail-wi0-f180.google.com ([209.85.212.180]:50503 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939Ab3ABSmz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 13:42:55 -0500
Received: by mail-wi0-f180.google.com with SMTP id hj13so8089555wib.1
        for <git@vger.kernel.org>; Wed, 02 Jan 2013 10:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=y1v+9mJ5ZPmukecprnEIOx7lIgRPxdSjTlihYy5gXNo=;
        b=iPLrn44zat52SHojaFoFafRUfQZJNDdPa4jmfuetUXl5GQypBVwcadlDs5lon02+WA
         bCAtUKcLxIJdDSJJBFHoeL+etr5uB6C9K+FiTwxH8a3aiA/YKlZTnKKo2X0PH2j/icA0
         Z6wG5r+oqze6gmabDLbkK4TuOx+edT+8X3RT77OGJlaiGBBXwnB0Sb2nzHdBbttUXRB2
         AyZsGUIBS9nNDLo23TI0eh+jvmOA75dMxcNs2ZCi69avsz0wye24m05D8Cf9cQd6XkDY
         WUXwdbzwmRs4DEeK6/DpG/TX9wVKz5qIZeNFhFcTaGXXkoUSk8d0m9uR7qwYJ2xcOA82
         YzPQ==
X-Received: by 10.194.235.100 with SMTP id ul4mr74481535wjc.7.1357152174299;
        Wed, 02 Jan 2013 10:42:54 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id bd6sm54915662wib.10.2013.01.02.10.42.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Jan 2013 10:42:53 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.27.g3b73c7d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212532>

prepare-commit-msg hook is run when committing to prepare the log
message. If the exit-status is non-zero, the commit should be aborted.

While the script is run before committing a successful merge, the
exit-status is ignored and a non-zero exit doesn't abort the commit.

Abort the commit if prepare-commit-msg returns with a non-zero status
when committing a successful merge.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 builtin/merge.c                    |  5 +++--
 t/t7505-prepare-commit-msg-hook.sh | 13 +++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index a96e8ea..3a31c4b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -800,8 +800,9 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	if (0 < option_edit)
 		strbuf_add_lines(&msg, "# ", comment, strlen(comment));
 	write_merge_msg(&msg);
-	run_hook(get_index_file(), "prepare-commit-msg",
-		 git_path("MERGE_MSG"), "merge", NULL, NULL);
+	if (run_hook(get_index_file(), "prepare-commit-msg",
+		     git_path("MERGE_MSG"), "merge", NULL, NULL))
+		abort_commit(remoteheads, NULL);
 	if (0 < option_edit) {
 		if (launch_editor(git_path("MERGE_MSG"), NULL, NULL))
 			abort_commit(remoteheads, NULL);
diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index 5b4b694..bc497bc 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -167,5 +167,18 @@ test_expect_success 'with failing hook (--no-verify)' '
 
 '
 
+test_expect_success 'with failing hook (merge)' '
+
+	git checkout -B other HEAD@{1} &&
+	echo "more" >> file &&
+	git add file &&
+	chmod -x $HOOK &&
+	git commit -m other &&
+	chmod +x $HOOK &&
+	git checkout - &&
+	head=`git rev-parse HEAD` &&
+	test_must_fail git merge other
+
+'
 
 test_done
-- 
1.8.1.rc3.27.g3b73c7d.dirty
