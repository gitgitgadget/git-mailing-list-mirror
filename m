Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1E261F404
	for <e@80x24.org>; Thu, 19 Apr 2018 17:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752966AbeDSR6o (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 13:58:44 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:41706 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752558AbeDSR6h (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Apr 2018 13:58:37 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3JHnDfF028656;
        Thu, 19 Apr 2018 10:58:30 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2hdryeas75-2;
        Thu, 19 Apr 2018 10:58:29 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 6C75822175DC;
        Thu, 19 Apr 2018 10:58:29 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 6661B2CDE6F;
        Thu, 19 Apr 2018 10:58:29 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        torvalds@linux-foundation.org, Elijah Newren <newren@gmail.com>
Subject: [PATCH v10 29/36] merge-recursive: improve add_cacheinfo error handling
Date:   Thu, 19 Apr 2018 10:58:16 -0700
Message-Id: <20180419175823.7946-30-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.290.ge988e9ce2a
In-Reply-To: <20180419175823.7946-1-newren@gmail.com>
References: <20180419175823.7946-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804190156
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Four closely related changes all with the purpose of fixing error handling
in this function:
  - fix reported function name in add_cacheinfo error messages
  - differentiate between the two error messages
  - abort early when we hit the error (stop ignoring return code)
  - mark a test which was hitting this error as failing until we get the
    right fix

In more detail...

In commit 0424138d5715 ("Fix bogus error message from merge-recursive
error path", 2007-04-01), it was noted that the name of the function which
the error message claimed it was reported from did not match the actual
function name.  This was changed to something closer to the real function
name, but it still didn't match the actual function name.  Fix the
reported name to match.

Second, the two errors in this function had identical messages, preventing
us from knowing which error had been triggered.  Add a couple words to the
second error message to differentiate the two.

Next, make sure callers do not ignore the return code so that it will stop
processing further entries (processing further entries could result in
more output which could cause the error to scroll off the screen, or at
least be missed by the user) and make it clear the error is the cause of
the early abort.  These errors should never be triggered in production; if
either one is, it represents a bug in the calling path somewhere and is
likely to have resulted in mis-merged content.  The combination of
ignoring of the return code and continuing to print other standard
messages after hitting the error resulted in the following bug report from
Junio: "...the command pretends that everything went well and merged
cleanly in that path...[Behaving] in a buggy and unexplainable way is bad
enough, doing so silently is unexcusable."  Fix this.

Finally, there was one test in the testsuite that did hit this error path,
but was passing anyway.  This would have been easy to miss since it had a
test_must_fail and thus could have failed for the wrong reason, but in a
separate testing step I added an intentional NULL-dereference to the
codepath where these error messages are printed in order to flush out such
cases.  I could modify that test to explicitly check for this error and
fail the test if it is hit, but since this test operates in a bit of a
gray area and needed other changes, I went for a different fix.  The gray
area this test operates in is the following: If the merge of a certain
file results in the same version of the file that existed in HEAD, but
there are dirty modifications to the file, is that an error with a
"Refusing to overwrite existing file" expected, or a case where the merge
should succeed since we shouldn't have to touch the dirty file anyway?
Recent discussion on the list leaned towards saying it should be a
success.  Therefore, change the expected behavior of this test to match.
As a side effect, this makes the failed-due-to-hitting-add_cacheinfo-error
very clear, and we can mark the test as test_expect_failure.  A subsequent
commit will implement the necessary changes to get this test to pass
again.

Signed-off-by: Elijah Newren <newren@gmail.com>
---

I thought the changes were small enough to just combine, but after
typing up the commit message and seeing how long it is, I'm wondering if
I should split this into two commits.  Thoughts?

 merge-recursive.c             | 13 ++++++++-----
 t/t3501-revert-cherry-pick.sh |  7 +++----
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 27278d51bb..b0f74cb243 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -316,7 +316,7 @@ static int add_cacheinfo(struct merge_options *o,
 
 	ce = make_cache_entry(mode, oid ? oid->hash : null_sha1, path, stage, 0);
 	if (!ce)
-		return err(o, _("addinfo_cache failed for path '%s'"), path);
+		return err(o, _("add_cacheinfo failed for path '%s'; merge aborting."), path);
 
 	ret = add_cache_entry(ce, options);
 	if (refresh) {
@@ -324,7 +324,7 @@ static int add_cacheinfo(struct merge_options *o,
 
 		nce = refresh_cache_entry(ce, CE_MATCH_REFRESH | CE_MATCH_IGNORE_MISSING);
 		if (!nce)
-			return err(o, _("addinfo_cache failed for path '%s'"), path);
+			return err(o, _("add_cacheinfo failed to refresh for path '%s'; merge aborting."), path);
 		if (nce != ce)
 			ret = add_cache_entry(nce, options);
 	}
@@ -942,7 +942,9 @@ static int update_file_flags(struct merge_options *o,
 	}
  update_index:
 	if (!ret && update_cache)
-		add_cacheinfo(o, mode, oid, path, 0, update_wd, ADD_CACHE_OK_TO_ADD);
+		if (add_cacheinfo(o, mode, oid, path, 0, update_wd,
+				  ADD_CACHE_OK_TO_ADD))
+			return -1;
 	return ret;
 }
 
@@ -2783,8 +2785,9 @@ static int merge_content(struct merge_options *o,
 		 */
 		path_renamed_outside_HEAD = !path2 || !strcmp(path, path2);
 		if (!path_renamed_outside_HEAD) {
-			add_cacheinfo(o, mfi.mode, &mfi.oid, path,
-				      0, (!o->call_depth), 0);
+			if (add_cacheinfo(o, mfi.mode, &mfi.oid, path,
+					  0, (!o->call_depth), 0))
+				return -1;
 			return mfi.clean;
 		}
 	} else
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index c9a1f783f5..3871807d09 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -141,7 +141,7 @@ test_expect_success 'cherry-pick "-" works with arguments' '
 	test_cmp expect actual
 '
 
-test_expect_success 'cherry-pick works with dirty renamed file' '
+test_expect_failure 'cherry-pick works with dirty renamed file' '
 	test_commit to-rename &&
 	git checkout -b unrelated &&
 	test_commit unrelated &&
@@ -150,9 +150,8 @@ test_expect_success 'cherry-pick works with dirty renamed file' '
 	test_tick &&
 	git commit -m renamed &&
 	echo modified >renamed &&
-	test_must_fail git cherry-pick refs/heads/unrelated >out &&
-	test_i18ngrep "Refusing to lose dirty file at renamed" out &&
-	test $(git rev-parse :0:renamed) = $(git rev-parse HEAD^:to-rename.t) &&
+	git cherry-pick refs/heads/unrelated >out &&
+	test $(git rev-parse :0:renamed) = $(git rev-parse HEAD~2:to-rename.t) &&
 	grep -q "^modified$" renamed
 '
 
-- 
2.17.0.290.ge988e9ce2a

