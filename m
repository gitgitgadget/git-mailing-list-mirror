From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2] git status: Fix false positive "new commits" output for
 dirty submodules
Date: Fri, 12 Mar 2010 22:23:52 +0100
Message-ID: <4B9AB0E8.90902@web.de>
References: <4B9909F6.5090104@web.de> <7v3a061v7m.fsf@alter.siamese.dyndns.org> <7vpr3azk9h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 12 22:28:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqCP1-0001Rk-MR
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 22:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934637Ab0CLV2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 16:28:11 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:56985 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932683Ab0CLV2J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 16:28:09 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id A1B55153F301C;
	Fri, 12 Mar 2010 22:23:54 +0100 (CET)
Received: from [80.128.53.45] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NqCKm-0003BK-00; Fri, 12 Mar 2010 22:23:53 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <7vpr3azk9h.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/mQ8CWu7hLCqBruKP7PxpDE4jTbL5a8DBsIGO1
	BZByQpUc8DiuNo7xrJykDI7L0E0viLYn3lk28YNwbIRjco6hQj
	QGKssjaDDiU+3bNAy7zg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142065>

Testing if the output "new commits" should appear in the long format of
"git status" is done by comparing the hashes of the diffpair. This always
resulted in printing "new commits" for submodules that contained untracked
or modified content, even if they did not contain new commits. The reason
was that match_stat_with_submodule() did set the "changed" flag for dirty
submodules, resulting in two->sha1 being set to the null_sha1 at the call
sites, which indicates that new commits are present. This is changed so
that when no new commits are present, the same object names are in the
sha1 field for both sides of the filepair, and the working tree side will
have the "dirty_submodule" flag set when appropriate. For a submodule to
be seen as modified even when it just has a dirty work tree, some
conditions had to be extended to also check for the "dirty_submodule"
flag.

Unfortunately the test case that should have found this bug had been
changed incorrectly too. It is fixed and extended to test for other
combinations too.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


Am 11.03.2010 21:16, schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>
>>> Another way to fix this bug would have been to enter the correct sha1
>>> into two->sha1 for submodules with new commits.
>>
>> I didn't follow all the codepaths involved, but it might be worth a try.
>> The beginning of the patch may look something like this, and then you
>> would probably have to fix potential fallouts in diff.c from this change.
> 
> Here is a fix of one of the fallouts.

Thanks for the pointers, here is version 2. This patch applies on top of
the "Refactor dirty submodule detection in diff-lib.c" patch I sent
recently. A few more eyeballs to make sure I touched all the relevant
codepaths would be highly appreciated.


 diff-lib.c                  |    6 +--
 diff.c                      |    7 +++-
 t/t7506-status-submodule.sh |   84 +++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 88 insertions(+), 9 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 64be827..6d4922a 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -72,8 +72,6 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 	    && !DIFF_OPT_TST(diffopt, IGNORE_SUBMODULES)
 	    && (!changed || DIFF_OPT_TST(diffopt, DIRTY_SUBMODULES))) {
 		*dirty_submodule = is_submodule_modified(ce->name);
-		if (*dirty_submodule)
-			changed = 1;
 	}
 	return changed;
 }
@@ -202,7 +200,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		}
 		changed = match_stat_with_submodule(&revs->diffopt, ce, &st,
     	    					    ce_option, &dirty_submodule);
-		if (!changed) {
+		if (!changed && !dirty_submodule) {
 			ce_mark_uptodate(ce);
 			if (!DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
 				continue;
@@ -333,7 +331,7 @@ static int show_modified(struct rev_info *revs,
 	}

 	oldmode = old->ce_mode;
-	if (mode == oldmode && !hashcmp(sha1, old->sha1) &&
+	if (mode == oldmode && !hashcmp(sha1, old->sha1) && !dirty_submodule &&
 	    !DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
 		return 0;

diff --git a/diff.c b/diff.c
index 5aefdcb..f5d93e9 100644
--- a/diff.c
+++ b/diff.c
@@ -2032,7 +2032,7 @@ static int diff_populate_gitlink(struct diff_filespec *s, int size_only)
 	char *data = xmalloc(100), *dirty = "";

 	/* Are we looking at the work tree? */
-	if (!s->sha1_valid && s->dirty_submodule)
+	if (s->dirty_submodule)
 		dirty = "-dirty";

 	len = snprintf(data, 100,
@@ -3092,7 +3092,8 @@ int diff_unmodified_pair(struct diff_filepair *p)
 	 * dealing with a change.
 	 */
 	if (one->sha1_valid && two->sha1_valid &&
-	    !hashcmp(one->sha1, two->sha1))
+	    !hashcmp(one->sha1, two->sha1) &&
+	    !one->dirty_submodule && !two->dirty_submodule)
 		return 1; /* no change */
 	if (!one->sha1_valid && !two->sha1_valid)
 		return 1; /* both look at the same file on the filesystem. */
@@ -3227,6 +3228,8 @@ static void diff_resolve_rename_copy(void)
 		}
 		else if (hashcmp(p->one->sha1, p->two->sha1) ||
 			 p->one->mode != p->two->mode ||
+			 p->one->dirty_submodule ||
+			 p->two->dirty_submodule ||
 			 is_null_sha1(p->one->sha1))
 			p->status = DIFF_STATUS_MODIFIED;
 		else {
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index 1c8d32a..dc9150a 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -34,7 +34,7 @@ test_expect_success 'status with modified file in submodule' '
 	(cd sub && git reset --hard) &&
 	echo "changed" >sub/foo &&
 	git status >output &&
-	grep "modified:   sub (new commits, modified content)" output
+	grep "modified:   sub (modified content)" output
 '

 test_expect_success 'status with modified file in submodule (porcelain)' '
@@ -49,7 +49,7 @@ test_expect_success 'status with modified file in submodule (porcelain)' '
 test_expect_success 'status with added file in submodule' '
 	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	git status >output &&
-	grep "modified:   sub (new commits, modified content)" output
+	grep "modified:   sub (modified content)" output
 '

 test_expect_success 'status with added file in submodule (porcelain)' '
@@ -64,7 +64,7 @@ test_expect_success 'status with untracked file in submodule' '
 	(cd sub && git reset --hard) &&
 	echo "content" >sub/new-file &&
 	git status >output &&
-	grep "modified:   sub (new commits, untracked content)" output
+	grep "modified:   sub (untracked content)" output
 '

 test_expect_success 'status with untracked file in submodule (porcelain)' '
@@ -74,6 +74,84 @@ test_expect_success 'status with untracked file in submodule (porcelain)' '
 	EOF
 '

+test_expect_success 'status with added and untracked file in submodule' '
+	(cd sub && git reset --hard && echo >foo && git add foo) &&
+	echo "content" >sub/new-file &&
+	git status >output &&
+	grep "modified:   sub (modified content, untracked content)" output
+'
+
+test_expect_success 'status with added and untracked file in submodule (porcelain)' '
+	(cd sub && git reset --hard && echo >foo && git add foo) &&
+	echo "content" >sub/new-file &&
+	git status --porcelain >output &&
+	diff output - <<-\EOF
+	 M sub
+	EOF
+'
+
+test_expect_success 'status with modified file in modified submodule' '
+	(cd sub && git reset --hard) &&
+	rm sub/new-file &&
+	(cd sub && echo "next change" >foo && git commit -m "next change" foo) &&
+	echo "changed" >sub/foo &&
+	git status >output &&
+	grep "modified:   sub (new commits, modified content)" output
+'
+
+test_expect_success 'status with modified file in modified submodule (porcelain)' '
+	(cd sub && git reset --hard) &&
+	echo "changed" >sub/foo &&
+	git status --porcelain >output &&
+	diff output - <<-\EOF
+	 M sub
+	EOF
+'
+
+test_expect_success 'status with added file in modified submodule' '
+	(cd sub && git reset --hard && echo >foo && git add foo) &&
+	git status >output &&
+	grep "modified:   sub (new commits, modified content)" output
+'
+
+test_expect_success 'status with added file in modified submodule (porcelain)' '
+	(cd sub && git reset --hard && echo >foo && git add foo) &&
+	git status --porcelain >output &&
+	diff output - <<-\EOF
+	 M sub
+	EOF
+'
+
+test_expect_success 'status with untracked file in modified submodule' '
+	(cd sub && git reset --hard) &&
+	echo "content" >sub/new-file &&
+	git status >output &&
+	grep "modified:   sub (new commits, untracked content)" output
+'
+
+test_expect_success 'status with untracked file in modified submodule (porcelain)' '
+	git status --porcelain >output &&
+	diff output - <<-\EOF
+	 M sub
+	EOF
+'
+
+test_expect_success 'status with added and untracked file in modified submodule' '
+	(cd sub && git reset --hard && echo >foo && git add foo) &&
+	echo "content" >sub/new-file &&
+	git status >output &&
+	grep "modified:   sub (new commits, modified content, untracked content)" output
+'
+
+test_expect_success 'status with added and untracked file in modified submodule (porcelain)' '
+	(cd sub && git reset --hard && echo >foo && git add foo) &&
+	echo "content" >sub/new-file &&
+	git status --porcelain >output &&
+	diff output - <<-\EOF
+	 M sub
+	EOF
+'
+
 test_expect_success 'rm submodule contents' '
 	rm -rf sub/* sub/.git
 '
-- 
1.7.0.2.386.ge30d.dirty
