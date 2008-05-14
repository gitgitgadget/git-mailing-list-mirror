From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/3] diff options: Introduce --ignore-submodules
Date: Wed, 14 May 2008 18:03:31 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805141803240.30431@racer>
References: <alpine.DEB.1.00.0805141802480.30431@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed May 14 19:04:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwKOp-0007pN-Fw
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 19:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494AbYENRDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 13:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753223AbYENRDc
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 13:03:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:60570 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753407AbYENRDb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 13:03:31 -0400
Received: (qmail invoked by alias); 14 May 2008 17:03:29 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp058) with SMTP; 14 May 2008 19:03:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/2k4UrdL/2M9wMi1Vj9QmuU4fN69a+UZRBIteRDk
	+mHMsece4NIbfn
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0805141802480.30431@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82112>


The new option --ignore-submodules can now be used to ignore changes in
submodules.

Why?  Sometimes it is not interesting when a submodule changed.

For example, when reordering some commits in the superproject, a dirty
submodule is usually totally uninteresting.  So we will use this option
in git-rebase to test for a dirty working tree.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/diff-options.txt |    3 +++
 diff.c                         |    9 +++++++++
 diff.h                         |    1 +
 3 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 13234fa..859d679 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -228,6 +228,9 @@ endif::git-format-patch[]
 --no-ext-diff::
 	Disallow external diff drivers.
 
+--ignore-submodules::
+	Ignore changes to submodules in the diff generation.
+
 --src-prefix=<prefix>::
 	Show the given source prefix instead of "a/".
 
diff --git a/diff.c b/diff.c
index 439d474..d57bc29 100644
--- a/diff.c
+++ b/diff.c
@@ -2496,6 +2496,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_SET(options, ALLOW_EXTERNAL);
 	else if (!strcmp(arg, "--no-ext-diff"))
 		DIFF_OPT_CLR(options, ALLOW_EXTERNAL);
+	else if (!strcmp(arg, "--ignore-submodules"))
+		DIFF_OPT_SET(options, IGNORE_SUBMODULES);
 
 	/* misc options */
 	else if (!strcmp(arg, "-z"))
@@ -3355,6 +3357,9 @@ void diff_addremove(struct diff_options *options,
 	char concatpath[PATH_MAX];
 	struct diff_filespec *one, *two;
 
+	if (DIFF_OPT_TST(options, IGNORE_SUBMODULES) && S_ISGITLINK(mode))
+		return;
+
 	/* This may look odd, but it is a preparation for
 	 * feeding "there are unchanged files which should
 	 * not produce diffs, but when you are doing copy
@@ -3399,6 +3404,10 @@ void diff_change(struct diff_options *options,
 	char concatpath[PATH_MAX];
 	struct diff_filespec *one, *two;
 
+	if (DIFF_OPT_TST(options, IGNORE_SUBMODULES) && S_ISGITLINK(old_mode)
+			&& S_ISGITLINK(new_mode))
+		return;
+
 	if (DIFF_OPT_TST(options, REVERSE_DIFF)) {
 		unsigned tmp;
 		const unsigned char *tmp_c;
diff --git a/diff.h b/diff.h
index 3a02d38..1dfe1f9 100644
--- a/diff.h
+++ b/diff.h
@@ -63,6 +63,7 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_OPT_REVERSE_DIFF        (1 << 15)
 #define DIFF_OPT_CHECK_FAILED        (1 << 16)
 #define DIFF_OPT_RELATIVE_NAME       (1 << 17)
+#define DIFF_OPT_IGNORE_SUBMODULES   (1 << 18)
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
 #define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag)
-- 
1.5.5.1.375.g1becb
