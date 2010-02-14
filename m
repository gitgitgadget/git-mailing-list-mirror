From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 1/6] Documentation: document post-rewrite hook
Date: Sun, 14 Feb 2010 17:17:06 +0100
Message-ID: <508ef869b6ac0b7240d6608e24a791777686c610.1266164150.git.trast@student.ethz.ch>
References: <cover.1266164150.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 14 17:17:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngh9u-0003AW-PZ
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 17:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583Ab0BNQRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 11:17:16 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:37742 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751326Ab0BNQRO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 11:17:14 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 14 Feb
 2010 17:17:14 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 14 Feb
 2010 17:17:12 +0100
X-Mailer: git-send-email 1.7.0.216.g74d8e
In-Reply-To: <cover.1266164150.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139916>

This defines the behaviour of the post-rewrite hook support, which
will be implemented in the following patches.

We deliberately do not document how often the hook will be invoked per
rewriting command, but the interface is designed to keep that at
"once".  This would currently not matter too much, since both rebase
and filter-branch are shellscripts and spawn many processes anyway.
However, when a fast sequencer in C is implemented, it will be
beneficial to only have to run the hook once.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/githooks.txt |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 87e2c03..41895e9 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -317,6 +317,42 @@ This hook is invoked by 'git gc --auto'. It takes no parameter, and
 exiting with non-zero status from this script causes the 'git gc --auto'
 to abort.
 
+post-rewrite
+~~~~~~~~~~~~
+
+This hook is invoked by commands that rewrite commits (`git commit
+--amend`, 'git-rebase', 'git-filter-branch').  Its first argument
+denotes the command it was invoked by: currently one of `amend`,
+`rebase`, or `filter-branch`.  Further command-dependent arguments may
+be passed in the future.
+
+The hook receives a list of the rewritten commits on stdin, in the
+format
+
+  <old-sha1> SP <new-sha1> [ SP <extra-info> ] LF
+
+The 'extra-info' is again command-dependent.  If it is empty, the
+preceding SP is also omitted.  Currently, no commands pass any
+'extra-info'.
+
+The following command-specific comments apply:
+
+rebase::
+	For the 'squash' and 'fixup' operation, all commits that were
+	squashed are listed as being rewritten to the squashed commit.
+	This means that there will be several lines sharing the same
+	'new-sha1'.
+
+filter-branch::
+	Commits that were processed by 'git-filter-branch', but not
+	changed, are not included in the list.  If the list is empty
+	after this filtering, the hook is not invoked at all.
+
+There is no default 'post-rewrite' hook, but see the
+`post-receive-copy-notes` script in `contrib/hooks` for an example
+that copies your git-notes to the rewritten commits.
+
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
1.7.0.216.g74d8e
