From: Jeff King <peff@peff.net>
Subject: [PATCH 5/6] textconv: use shell to run helper
Date: Wed, 30 Dec 2009 06:01:09 -0500
Message-ID: <20091230110109.GE22959@coredump.intra.peff.net>
References: <20091230095634.GA16349@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 12:01:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPwIo-0004eT-QA
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 12:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666AbZL3LBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 06:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752564AbZL3LBO
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 06:01:14 -0500
Received: from peff.net ([208.65.91.99]:45817 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752542AbZL3LBN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 06:01:13 -0500
Received: (qmail 5242 invoked by uid 107); 30 Dec 2009 11:05:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 30 Dec 2009 06:05:54 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Dec 2009 06:01:09 -0500
Content-Disposition: inline
In-Reply-To: <20091230095634.GA16349@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135885>

Currently textconv helpers are run directly. Running through
the shell is useful because the user can provide a program
with command line arguments, like "antiword -f".

It also makes textconv more consistent with other parts of
git, most of which run their helpers using the shell.

The downside is that textconv helpers with shell
metacharacters (like space) in the filename will be broken.

Signed-off-by: Jeff King <peff@peff.net>
---
This is the first actual change in behavior. This patch and 6/6 should
perhaps be held back with a warning period. I am inclined to consider it
a bug that they didn't use the shell, and this is fixing it.

 diff.c                         |    1 +
 t/t4030-diff-textconv.sh       |    2 +-
 t/t4031-diff-rewrite-binary.sh |    2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index d14a575..2794238 100644
--- a/diff.c
+++ b/diff.c
@@ -3818,6 +3818,7 @@ static char *run_textconv(const char *pgm, struct diff_filespec *spec,
 	*arg = NULL;
 
 	memset(&child, 0, sizeof(child));
+	child.use_shell = 1;
 	child.argv = argv;
 	child.out = -1;
 	if (start_command(&child) != 0 ||
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index a3f0897..c16d538 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -48,7 +48,7 @@ test_expect_success 'file is considered binary by plumbing' '
 
 test_expect_success 'setup textconv filters' '
 	echo file diff=foo >.gitattributes &&
-	git config diff.foo.textconv "$PWD"/hexdump &&
+	git config diff.foo.textconv "\"$PWD\""/hexdump &&
 	git config diff.fail.textconv false
 '
 
diff --git a/t/t4031-diff-rewrite-binary.sh b/t/t4031-diff-rewrite-binary.sh
index a894c60..27fb31b 100755
--- a/t/t4031-diff-rewrite-binary.sh
+++ b/t/t4031-diff-rewrite-binary.sh
@@ -54,7 +54,7 @@ chmod +x dump
 
 test_expect_success 'setup textconv' '
 	echo file diff=foo >.gitattributes &&
-	git config diff.foo.textconv "$PWD"/dump
+	git config diff.foo.textconv "\"$PWD\""/dump
 '
 
 test_expect_success 'rewrite diff respects textconv' '
-- 
1.6.6.65.g050d2.dirty
