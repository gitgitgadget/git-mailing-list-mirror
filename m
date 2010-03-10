From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v6 03/13] Documentation: document post-rewrite hook
Date: Wed, 10 Mar 2010 15:03:40 +0100
Message-ID: <0aef1241fac194157f246f3864517b6a318340a4.1268229087.git.trast@student.ethz.ch>
References: <cover.1268229087.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 10 15:04:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpMWm-0003ux-GM
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 15:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345Ab0CJOE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 09:04:29 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:7878 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932348Ab0CJOEW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 09:04:22 -0500
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 10 Mar
 2010 15:04:12 +0100
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 10 Mar
 2010 15:03:51 +0100
X-Mailer: git-send-email 1.7.0.2.407.g21ebda
In-Reply-To: <cover.1268229087.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141891>

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


 Documentation/githooks.txt |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 87e2c03..a741769 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -317,6 +317,40 @@ This hook is invoked by 'git gc --auto'. It takes no parameter, and
 exiting with non-zero status from this script causes the 'git gc --auto'
 to abort.
 
+post-rewrite
+~~~~~~~~~~~~
+
+This hook is invoked by commands that rewrite commits (`git commit
+--amend`, 'git-rebase'; currently 'git-filter-branch' does 'not' call
+it!).  Its first argument denotes the command it was invoked by:
+currently one of `amend` or `rebase`.  Further command-dependent
+arguments may be passed in the future.
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
++
+The commits are guaranteed to be listed in the order that they were
+processed by rebase.
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
1.7.0.2.407.g21ebda
