From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Handle double slashes in make_relative_path()
Date: Fri, 22 Jan 2010 01:07:31 +0100
Message-ID: <379d55c6a4110736aadb8ace3b050de879a9deab.1264118830.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 22 01:08:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY74Q-0007E0-Ub
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 01:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755555Ab0AVAHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 19:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755405Ab0AVAHe
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 19:07:34 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:38000 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754705Ab0AVAHe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 19:07:34 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.213.0; Fri, 22 Jan
 2010 01:07:31 +0100
Received: from localhost.localdomain (84.74.100.59) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Fri, 22 Jan
 2010 01:07:31 +0100
X-Mailer: git-send-email 1.6.6.1.532.g594fe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137700>

If you say

  git --git-dir=/some//path --work-tree=/some/ add <somefile>

then setup_work_tree() will call into make_relative_path() with
abs="/some//path" and base="/some".  (Note how the latter has already
lost its trailing slash.  One unfortunate user managed to trigger this
because his $HOME ended in a slash.)

This means that when checking whether 'abs' is a path under 'base', we
need to skip *two* slashes where the previous code only accounted for
one.  Fix it to handle an arbitrary number of slashes at that
position.

Noticed-by: eldenz on freenode
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 path.c              |    6 +++---
 t/t1501-worktree.sh |    6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/path.c b/path.c
index 2ec950b..a195bab 100644
--- a/path.c
+++ b/path.c
@@ -400,10 +400,10 @@ int set_shared_perm(const char *path, int mode)
 	baselen = strlen(base);
 	if (prefixcmp(abs, base))
 		return abs;
-	if (abs[baselen] == '/')
-		baselen++;
-	else if (base[baselen - 1] != '/')
+	if (abs[baselen] != '/' && base[baselen - 1] != '/')
 		return abs;
+	while (abs[baselen] == '/')
+		baselen++;
 	strcpy(buf, abs + baselen);
 	return buf;
 }
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 74e6443..9df3012 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -189,4 +189,10 @@ test_expect_success 'absolute pathspec should fail gracefully' '
 	)
 '
 
+test_expect_success 'make_relative_path handles double slashes in GIT_DIR' '
+	: > dummy_file
+	echo git --git-dir="$(pwd)//repo.git" --work-tree="$(pwd)" add dummy_file &&
+	git --git-dir="$(pwd)//repo.git" --work-tree="$(pwd)" add dummy_file
+'
+
 test_done
-- 
1.6.6.1.532.g594fe
