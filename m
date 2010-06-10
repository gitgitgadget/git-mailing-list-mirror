From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/2] rev-list: introduce --count option
Date: Thu, 10 Jun 2010 13:47:23 +0200
Message-ID: <a1981bddc4deb4125824ecb02a914c2931543430.1276169807.git.trast@student.ethz.ch>
References: <cover.1276169807.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Shawn O. Pearce" <spearce@spearce.org>, <git@vger.kernel.org>,
	John Tapsell <johnflux@gmail.com>,
	Steven Michalske <smichalske@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Thu Jun 10 13:47:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMgEl-0005uh-DC
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 13:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758797Ab0FJLrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 07:47:48 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:30564 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758727Ab0FJLrr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 07:47:47 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 10 Jun
 2010 13:47:47 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 10 Jun
 2010 13:47:25 +0200
X-Mailer: git-send-email 1.7.1.553.ga798e
In-Reply-To: <cover.1276169807.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148859>

Add a --count option that, instead of actually listing the commits,
merely counts them.

This is mostly geared towards script use, and to this end it acts
specially when used with --left-right: it outputs the left and right
counts separately.  Previously, scripts would have to run a shell loop
or small inline script over to achieve the same.  (Without
--left-right, a simple |wc -l does the job.)

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/rev-list-options.txt   |    9 +++++++++
 builtin/rev-list.c                   |   16 ++++++++++++++++
 revision.c                           |    2 ++
 revision.h                           |    5 +++++
 t/t6007-rev-list-cherry-pick-file.sh |   29 +++++++++++++++++++++++++++++
 5 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index b9fb7a8..066ade9 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -98,6 +98,15 @@ you would get an output like this:
 This implies the '--topo-order' option by default, but the
 '--date-order' option may also be specified.
 
+ifdef::git-rev-list[]
+--count::
+	Print a number stating how many commits would have been
+	listed, and suppress all other output.  When used together
+	with '--left-right', instead print the counts for left and
+	right commits, separated by a tab.
+endif::git-rev-list[]
+
+
 ifndef::git-rev-list[]
 Diff Formatting
 ~~~~~~~~~~~~~~~
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 51ceb19..efe9360 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -50,6 +50,15 @@ static void show_commit(struct commit *commit, void *data)
 
 	graph_show_commit(revs->graph);
 
+	if (revs->count) {
+		if (commit->object.flags & SYMMETRIC_LEFT)
+			revs->count_left++;
+		else
+			revs->count_right++;
+		finish_commit(commit, data);
+		return;
+	}
+
 	if (info->show_timestamp)
 		printf("%lu ", commit->date);
 	if (info->header_prefix)
@@ -400,5 +409,12 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			     quiet ? finish_object : show_object,
 			     &info);
 
+	if (revs.count) {
+		if (revs.left_right)
+			printf("%d\t%d\n", revs.count_left, revs.count_right);
+		else
+			printf("%d\n", revs.count_left + revs.count_right);
+	}
+
 	return 0;
 }
diff --git a/revision.c b/revision.c
index b209d49..94fca7f 100644
--- a/revision.c
+++ b/revision.c
@@ -1146,6 +1146,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->boundary = 1;
 	} else if (!strcmp(arg, "--left-right")) {
 		revs->left_right = 1;
+	} else if (!strcmp(arg, "--count")) {
+		revs->count = 1;
 	} else if (!strcmp(arg, "--cherry-pick")) {
 		revs->cherry_pick = 1;
 		revs->limited = 1;
diff --git a/revision.h b/revision.h
index 568f1c9..bafa728 100644
--- a/revision.h
+++ b/revision.h
@@ -57,6 +57,7 @@ struct rev_info {
 			limited:1,
 			unpacked:1,
 			boundary:2,
+			count:1,
 			left_right:1,
 			rewrite_parents:1,
 			print_parents:1,
@@ -131,6 +132,10 @@ struct rev_info {
 
 	/* notes-specific options: which refs to show */
 	struct display_notes_opt notes_opt;
+
+	/* commit counts */
+	int count_left;
+	int count_right;
 };
 
 #define REV_TREE_SAME		0
diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index 4b8611c..b565638 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -32,6 +32,23 @@ test_expect_success setup '
 	git tag B
 '
 
+cat >expect <<EOF
+<tags/B
+>tags/C
+EOF
+
+test_expect_success '--left-right' '
+	git rev-list --left-right B...C > actual &&
+	git name-rev --stdin --name-only --refs="*tags/*" \
+		< actual > actual.named &&
+	test_cmp actual.named expect
+'
+
+test_expect_success '--count' '
+	git rev-list --count B...C > actual &&
+	test "$(cat actual)" = 2
+'
+
 test_expect_success '--cherry-pick foo comes up empty' '
 	test -z "$(git rev-list --left-right --cherry-pick B...C -- foo)"
 '
@@ -54,4 +71,16 @@ test_expect_success '--cherry-pick with independent, but identical branches' '
 		HEAD...master -- foo)"
 '
 
+cat >expect <<EOF
+1	2
+EOF
+
+# Insert an extra commit to break the symmetry
+test_expect_success '--count --left-right' '
+	git checkout branch &&
+	test_commit D &&
+	git rev-list --count --left-right B...D > actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.1.553.ge4d5c.dirty
