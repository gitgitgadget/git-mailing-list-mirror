From: Arjen Laarhoven <arjen@yaph.org>
Subject: [PATCH 2/2] git-log: Follow file copies with 'git log --follow -C -C'
Date: Thu, 22 Jan 2009 17:37:25 +0100
Message-ID: <1232642245-94405-2-git-send-email-arjen@yaph.org>
References: <1232642245-94405-1-git-send-email-arjen@yaph.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 22 17:47:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ2i0-00061K-8B
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 17:47:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756919AbZAVQog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 11:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756863AbZAVQof
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 11:44:35 -0500
Received: from smtp-vbr17.xs4all.nl ([194.109.24.37]:4071 "EHLO
	smtp-vbr17.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756787AbZAVQod (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 11:44:33 -0500
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Jan 2009 11:44:33 EST
Received: from localhost.localdomain ([194.109.31.155])
	by smtp-vbr17.xs4all.nl (8.13.8/8.13.8) with ESMTP id n0MGbPXq090230
	for <git@vger.kernel.org>; Thu, 22 Jan 2009 17:37:25 +0100 (CET)
	(envelope-from arjen@yaph.org)
X-Mailer: git-send-email 1.6.1.354.gd9e51
In-Reply-To: <1232642245-94405-1-git-send-email-arjen@yaph.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106767>

When the '--follow' option is used with '--find-copies-harder' ('-C -C')
logs on individual files will work across file copies as well as
renames.

Intermediate copies will not be shown as a result of the workings of the
'--find-copies-harder' option.

Signed-off-by: Arjen Laarhoven <arjen@yaph.org>
---
 Documentation/git-log.txt |    6 +++++-
 t/t4202-log.sh            |   12 ++++++++++++
 tree-diff.c               |    2 ++
 3 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 34cf4e5..2d42101 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -52,7 +52,11 @@ include::diff-options.txt[]
 	commits, and doesn't limit diff for those commits.
 
 --follow::
-	Continue listing the history of a file beyond renames.
+	Continue listing the history of a file beyond renames.  When
+	combined with `--find-copies-harder` (`-C -C`) git will also
+	list the file history beyond copies.  Intermediate copies
+	will be skipped, e.g. a copy of file A to B to C will not
+	show B when showing the log on file C.
 
 --log-size::
 	Before the log message print out its size in bytes. Intended
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 7b976ee..a8dd690 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -109,6 +109,18 @@ test_expect_success 'git log --follow' '
 
 '
 
+test_expect_success 'git log --follow --find-copies-harder' '
+
+	actual=$(git log --follow -C -C --pretty="format:%s" ein) &&
+	expect=$(echo fourth; echo third ; echo second ; echo initial) &&
+	test "$actual" = "$expect" || {
+		echo Oops
+		echo "Actual: $actual"
+		false
+	}
+
+'
+
 test_expect_success 'setup case sensitivity tests' '
 	echo case >one &&
 	test_tick &&
diff --git a/tree-diff.c b/tree-diff.c
index 9f67af6..73652b2 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -333,6 +333,8 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
 
 	diff_setup(&diff_opts);
 	DIFF_OPT_SET(&diff_opts, RECURSIVE);
+	if (DIFF_OPT_TST(opt, FIND_COPIES_HARDER))
+		DIFF_OPT_SET(&diff_opts, FIND_COPIES_HARDER);
 	diff_opts.detect_rename = DIFF_DETECT_RENAME;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_opts.single_follow = opt->paths[0];
-- 
1.6.1.354.gd9e51
