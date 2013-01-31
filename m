From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] branch: let branch filters imply --list
Date: Thu, 31 Jan 2013 01:46:11 -0500
Message-ID: <20130131064611.GB25315@sigill.intra.peff.net>
References: <20130131064357.GA24660@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Peter Wu <lekensteyn@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 07:46:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0nuu-0007V5-MB
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 07:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598Ab3AaGqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 01:46:15 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54449 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917Ab3AaGqO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 01:46:14 -0500
Received: (qmail 3749 invoked by uid 107); 31 Jan 2013 06:47:37 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Jan 2013 01:47:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jan 2013 01:46:11 -0500
Content-Disposition: inline
In-Reply-To: <20130131064357.GA24660@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215099>

Currently, a branch filter like `--contains`, `--merged`, or
`--no-merged` is ignored when we are not in listing mode.
For example:

  git branch --contains=foo bar

will create the branch "bar" from the current HEAD, ignoring
the `--contains` argument entirely. This is not very
helpful. There are two reasonable behaviors for git here:

  1. Flag an error; the arguments do not make sense.

  2. Implicitly go into `--list` mode

This patch chooses the latter, as it is more convenient, and
there should not be any ambiguity with attempting to create
a branch; using `--contains` and not wanting to list is
nonsensical.

That leaves the case where an explicit modification option
like `-d` is given.  We already catch the case where
`--list` is given alongside `-d` and flag an error. With
this patch, we will also catch the use of `--contains` and
other filter options alongside `-d`.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-branch.txt |  6 +++---
 builtin/branch.c             |  3 +++
 t/t3201-branch-contains.sh   | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 01aa87f..07ef5af 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -195,15 +195,15 @@ start-point is either a local or remote-tracking branch.
 
 --contains [<commit>]::
 	Only list branches which contain the specified commit (HEAD
-	if not specified).
+	if not specified). Implies `--list`.
 
 --merged [<commit>]::
 	Only list branches whose tips are reachable from the
-	specified commit (HEAD if not specified).
+	specified commit (HEAD if not specified). Implies `--list`.
 
 --no-merged [<commit>]::
 	Only list branches whose tips are not reachable from the
-	specified commit (HEAD if not specified).
+	specified commit (HEAD if not specified). Implies `--list`.
 
 <branchname>::
 	The name of the branch to create or delete.
diff --git a/builtin/branch.c b/builtin/branch.c
index 873f624..4aa3d4e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -825,6 +825,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (!delete && !rename && !edit_description && !new_upstream && !unset_upstream && argc == 0)
 		list = 1;
 
+	if (with_commit || merge_filter != NO_FILTER)
+		list = 1;
+
 	if (!!delete + !!rename + !!force_create + !!list + !!new_upstream + !!unset_upstream > 1)
 		usage_with_options(builtin_branch_usage, options);
 
diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index f86f4bc..141b061 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -55,6 +55,16 @@ test_expect_success 'branch --contains=side' '
 
 '
 
+test_expect_success 'branch --contains with pattern implies --list' '
+
+	git branch --contains=master master >actual &&
+	{
+		echo "  master"
+	} >expect &&
+	test_cmp expect actual
+
+'
+
 test_expect_success 'side: branch --merged' '
 
 	git branch --merged >actual &&
@@ -66,6 +76,16 @@ test_expect_success 'side: branch --merged' '
 
 '
 
+test_expect_success 'branch --merged with pattern implies --list' '
+
+	git branch --merged=side master >actual &&
+	{
+		echo "  master"
+	} >expect &&
+	test_cmp expect actual
+
+'
+
 test_expect_success 'side: branch --no-merged' '
 
 	git branch --no-merged >actual &&
@@ -95,4 +115,19 @@ test_expect_success 'master: branch --no-merged' '
 
 '
 
+test_expect_success 'branch --no-merged with pattern implies --list' '
+
+	git branch --no-merged=master master >actual &&
+	>expect &&
+	test_cmp expect actual
+
+'
+
+test_expect_success 'implicit --list conflicts with modification options' '
+
+	test_must_fail git branch --contains=master -d &&
+	test_must_fail git branch --contains=master -m foo
+
+'
+
 test_done
-- 
1.8.1.2.5.g1cb3f73
