From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] merge: turn on rewrite detection
Date: Fri, 25 Mar 2011 12:08:10 -0400
Message-ID: <20110325160810.GC26635@sigill.intra.peff.net>
References: <20110325160013.GA25851@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 17:08:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q39Yh-0005bU-VN
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 17:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754412Ab1CYQIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 12:08:13 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41068
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853Ab1CYQIM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 12:08:12 -0400
Received: (qmail 14910 invoked by uid 107); 25 Mar 2011 16:08:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Mar 2011 12:08:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Mar 2011 12:08:10 -0400
Content-Disposition: inline
In-Reply-To: <20110325160013.GA25851@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169995>

We currently don't do break-detection at all in
merge-recursive. But there are some cases where it would
provide a more useful merge result.

For example, consider this case (which is the basis for the
new tests in t6039):

  1. You rename a header file foo.h to bar.h. You install a
     new foo.h that includes bar.h (for compatibility).

  2. Another branch makes changes to foo.h.

When you merge, you want the changes the other branch made
to foo.h to migrate to the rename destination, bar.h, just
as you would if you hadn't installed that compatibility
header.

Similarly, you want the compatibility header left untouched.
The other side's changes all ended up in bar.h, so there is
no reason to conflict with the new content in foo.h.

This patch turns on break detection for merge-recursive. In
addition to new tests in t6039, it makes a similar test in
t3030 pass.

Signed-off-by: Jeff King <peff@peff.net>
---
I hope the tests are readable. I thought it was important to test the
merges in both directions (because an early iteration screwed that up),
which led to factoring out a lot of the setup and checking code.

 merge-recursive.c          |    1 +
 t/t3030-merge-recursive.sh |    2 +-
 t/t6039-merge-break.sh     |  174 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+), 1 deletions(-)
 create mode 100755 t/t6039-merge-break.sh

diff --git a/merge-recursive.c b/merge-recursive.c
index 16263b0..cd42c47 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -426,6 +426,7 @@ static struct string_list *get_renames(struct merge_options *o,
 			    1000;
 	opts.rename_score = o->rename_score;
 	opts.show_rename_progress = o->show_rename_progress;
+	opts.break_opt = 0;
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	if (diff_setup_done(&opts) < 0)
 		die("diff setup failed");
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index e686f04..43ff220 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -631,7 +631,7 @@ test_expect_success 'merge-recursive copy vs. rename' '
 
 if test_have_prereq SYMLINKS
 then
-	test_expect_failure 'merge-recursive rename vs. rename/symlink' '
+	test_expect_success 'merge-recursive rename vs. rename/symlink' '
 
 		git checkout -f rename &&
 		git merge rename-ln &&
diff --git a/t/t6039-merge-break.sh b/t/t6039-merge-break.sh
new file mode 100755
index 0000000..d3dabf5
--- /dev/null
+++ b/t/t6039-merge-break.sh
@@ -0,0 +1,174 @@
+#!/bin/sh
+
+test_description='merging with renames from broken pairs
+
+This is based on a real-world practice of moving a header file to a
+new location, but installing a "replacement" file that points to
+the old one. We need break detection in the merge to find the
+rename.
+'
+. ./test-lib.sh
+
+# A fake header file; it needs a fair bit of content
+# for break detection and inexact rename detection to work.
+mksample() {
+	echo '#ifndef SAMPLE_H'
+	echo '#define SAMPLE_H'
+	for i in 0 1 2 3 4; do
+		for j in 0 1 2 3 4 5 6 7 8 9; do
+			echo "extern fun$i$j();"
+		done
+	done
+	echo '#endif /* SAMPLE_H */'
+}
+
+mvsample() {
+	sed 's/SAMPLE_H/NEW_H/' "$1" >"$2" &&
+	rm "$1"
+}
+
+# A replacement sample header file that references a new one.
+mkreplacement() {
+	echo '#ifndef SAMPLE_H'
+	echo '#define SAMPLE_H'
+	echo "#include \"$1\""
+	echo '#endif /* SAMPLE_H */'
+}
+
+# Tweak the header file in a minor way.
+tweak() {
+	sed 's,42.*,& /* secret of something-or-other */,' "$1" >"$1.tmp" &&
+	mv "$1.tmp" "$1"
+}
+
+reset() {
+	git reset --hard &&
+	git checkout master &&
+	git reset --hard base &&
+	git clean -f &&
+	{ git branch -D topic || true; }
+}
+
+test_expect_success 'setup baseline' '
+	mksample >sample.h &&
+	git add sample.h &&
+	git commit -m "add sample.h" &&
+	git tag base
+'
+
+setup_rename_plus_tweak() {
+	reset &&
+	mvsample sample.h new.h &&
+	mkreplacement new.h >sample.h &&
+	git add sample.h new.h &&
+	git commit -m 'rename sample.h to new.h, with replacement' &&
+	git checkout -b topic base &&
+	tweak sample.h &&
+	git commit -a -m 'tweak sample.h'
+}
+
+check_tweak_result() {
+	mksample >expect.orig &&
+	mvsample expect.orig expect &&
+	tweak expect &&
+	test_cmp expect new.h &&
+	mkreplacement new.h >expect &&
+	test_cmp expect sample.h
+}
+
+test_expect_success 'merge rename to tweak finds rename' '
+	setup_rename_plus_tweak &&
+	git merge master &&
+	check_tweak_result
+'
+
+test_expect_success 'merge tweak to rename finds rename' '
+	setup_rename_plus_tweak &&
+	git checkout master &&
+	git merge topic &&
+	check_tweak_result
+'
+
+setup_double_rename_one_replacement() {
+	setup_rename_plus_tweak &&
+	mvsample sample.h new.h &&
+	git add new.h &&
+	git commit -a -m 'rename sample.h to new.h (no replacement)'
+}
+
+test_expect_success 'merge rename to rename/tweak (one replacement)' '
+	setup_double_rename_one_replacement &&
+	git merge master &&
+	check_tweak_result
+'
+
+test_expect_success 'merge rename/tweak to rename (one replacement)' '
+	setup_double_rename_one_replacement &&
+	git checkout master &&
+	git merge topic &&
+	check_tweak_result
+'
+
+setup_double_rename_two_replacements_same() {
+	setup_rename_plus_tweak &&
+	mvsample sample.h new.h &&
+	mkreplacement new.h >sample.h &&
+	git add sample.h new.h &&
+	git commit -m 'rename sample.h to new.h with replacement (same)'
+}
+
+test_expect_success 'merge rename to rename/tweak (two replacements, same)' '
+	setup_double_rename_two_replacements_same &&
+	git merge master &&
+	check_tweak_result
+'
+
+test_expect_success 'merge rename/tweak to rename (two replacements, same)' '
+	setup_double_rename_two_replacements_same &&
+	git checkout master &&
+	git merge topic &&
+	check_tweak_result
+'
+
+setup_double_rename_two_replacements_diff() {
+	setup_rename_plus_tweak &&
+	mvsample sample.h new.h &&
+	mkreplacement diff.h >sample.h &&
+	git add sample.h new.h &&
+	git commit -m 'rename sample.h to new.h with replacement (diff)'
+}
+
+test_expect_success 'merge rename to rename/tweak (two replacements, diff)' '
+	setup_double_rename_two_replacements_diff &&
+	test_must_fail git merge master &&
+	cat >expect <<-\EOF &&
+	#ifndef SAMPLE_H
+	#define SAMPLE_H
+	<<<<<<< HEAD
+	#include "diff.h"
+	=======
+	#include "new.h"
+	>>>>>>> master
+	#endif /* SAMPLE_H */
+	EOF
+	test_cmp expect sample.h
+'
+
+test_expect_success 'merge rename to rename/tweak (two replacements, diff)' '
+	setup_double_rename_two_replacements_diff &&
+	git checkout master &&
+	test_must_fail git merge topic &&
+	cat >expect <<-\EOF &&
+	#ifndef SAMPLE_H
+	#define SAMPLE_H
+	<<<<<<< HEAD
+	#include "new.h"
+	=======
+	#include "diff.h"
+	>>>>>>> topic
+	#endif /* SAMPLE_H */
+	EOF
+	test_cmp expect sample.h
+'
+
+test_done
-- 
1.7.4.41.g423da.dirty
