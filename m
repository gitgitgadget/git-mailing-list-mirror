Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFBD41F597
	for <e@80x24.org>; Tue, 31 Jul 2018 17:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbeGaSxa (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 14:53:30 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:50398 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729622AbeGaSxa (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 31 Jul 2018 14:53:30 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6VH3cbu026225;
        Tue, 31 Jul 2018 10:12:10 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2kgpbn7e6u-1;
        Tue, 31 Jul 2018 10:12:09 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id AEB6E226E7FC;
        Tue, 31 Jul 2018 10:12:08 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id A39032CDE5F;
        Tue, 31 Jul 2018 10:12:08 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 2/2] read-cache: fix directory/file conflict handling in read_index_unmerged()
Date:   Tue, 31 Jul 2018 10:12:05 -0700
Message-Id: <20180731171205.4794-3-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.2.gf4c50c7885
In-Reply-To: <20180731171205.4794-1-newren@gmail.com>
References: <20180713163331.22446-1-newren@gmail.com>
 <20180731171205.4794-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-31_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807310158
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

read_index_unmerged() has two intended purposes:
  * return 1 if there are any unmerged entries, 0 otherwise
  * drops any higher-stage entries down to stage #0

There are several callers of read_index_unmerged() that check the return
value to see if it is non-zero, all of which then die() if that condition
is met.  For these callers, dropping higher-stage entries down to stage #0
is a waste of resources, and returning immediately on first unmerged entry
would be better.  But it's probably only a very minor difference and isn't
the focus of this series.

The remaining callers ignore the return value and call this function for
the side effect of dropping higher-stage entries down to stage #0.  As
mentioned in commit e11d7b596970 ("'reset --merge': fix unmerged case",
2009-12-31),

    The _only_ reason we want to keep a previously unmerged entry in the
    index at stage #0 is so that we don't forget the fact that we have
    corresponding file in the work tree in order to be able to remove it
    when the tree we are resetting to does not have the path.

In fact, prior to commit d1a43f2aa4bf ("reset --hard/read-tree --reset -u:
remove unmerged new paths", 2008-10-15), read_index_unmerged() did just
remove unmerged entries from the cache immediately but that had the
unwanted effect of leaving around new untracked files in the tree from
aborted merges.

So, that's the intended purpose of this function.  The problem is that
when directory/files conflicts are present, trying to add the file to the
index at stage 0 fails (because there is still a directory in the way),
and the function returns early with a -1 return code to signify the error.
As noted above, none of the callers who want the drop-to-stage-0 behavior
check the return status, though, so this means all remaining unmerged
entries remain in the index and the callers proceed assuming otherwise.
Users then see errors of the form:

    error: 'DIR-OR-FILE' appears as both a file and as a directory
    error: DIR-OR-FILE: cannot drop to stage #0

and potentially also messages about other unmerged entries which came
lexicographically later than whatever pathname was both a file and a
directory.  Google finds a few hits searching for those messages,
suggesting there were probably a couple people who hit this besides me.
Luckily, calling `git reset --hard` multiple times would workaround
this bug.

Since the whole purpose here is to just put the entry *temporarily* into
the index so that any associated file in the working copy can be removed,
we can just skip the DFCHECK and allow both the file and directory to
appear in the index.  The temporary simultaneous appearance of the
directory and file entries in the index will be removed by the callers
by calling unpack_trees(), which excludes these unmerged entries marked
with CE_CONFLICTED flag from the resulting index, before they attempt to
write the index anywhere.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c                         | 13 ++++++++-----
 t/t1015-read-index-unmerged.sh       |  8 ++++----
 t/t6020-merge-df.sh                  |  3 ---
 t/t6042-merge-rename-corner-cases.sh |  2 --
 4 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 372588260e..666d295a5a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2632,10 +2632,13 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 
 /*
  * Read the index file that is potentially unmerged into given
- * index_state, dropping any unmerged entries.  Returns true if
- * the index is unmerged.  Callers who want to refuse to work
- * from an unmerged state can call this and check its return value,
- * instead of calling read_cache().
+ * index_state, dropping any unmerged entries to stage #0 (potentially
+ * resulting in a path appearing as both a file and a directory in the
+ * index; the caller is responsible to clear out the extra entries
+ * before writing the index to a tree).  Returns true if the index is
+ * unmerged.  Callers who want to refuse to work from an unmerged
+ * state can call this and check its return value, instead of calling
+ * read_cache().
  */
 int read_index_unmerged(struct index_state *istate)
 {
@@ -2658,7 +2661,7 @@ int read_index_unmerged(struct index_state *istate)
 		new_ce->ce_flags = create_ce_flags(0) | CE_CONFLICTED;
 		new_ce->ce_namelen = len;
 		new_ce->ce_mode = ce->ce_mode;
-		if (add_index_entry(istate, new_ce, 0))
+		if (add_index_entry(istate, new_ce, ADD_CACHE_SKIP_DFCHECK))
 			return error("%s: cannot drop to stage #0",
 				     new_ce->name);
 	}
diff --git a/t/t1015-read-index-unmerged.sh b/t/t1015-read-index-unmerged.sh
index 32ef6bdcfa..55d22da32c 100755
--- a/t/t1015-read-index-unmerged.sh
+++ b/t/t1015-read-index-unmerged.sh
@@ -30,7 +30,7 @@ test_expect_success 'setup modify/delete + directory/file conflict' '
 	)
 '
 
-test_expect_failure 'read-tree --reset cleans unmerged entries' '
+test_expect_success 'read-tree --reset cleans unmerged entries' '
 	test_when_finished "git -C df_plus_modify_delete clean -f" &&
 	test_when_finished "git -C df_plus_modify_delete reset --hard" &&
 	(
@@ -45,7 +45,7 @@ test_expect_failure 'read-tree --reset cleans unmerged entries' '
 	)
 '
 
-test_expect_failure 'One reset --hard cleans unmerged entries' '
+test_expect_success 'One reset --hard cleans unmerged entries' '
 	test_when_finished "git -C df_plus_modify_delete clean -f" &&
 	test_when_finished "git -C df_plus_modify_delete reset --hard" &&
 	(
@@ -87,7 +87,7 @@ test_expect_success 'setup directory/file conflict + simple edit/edit' '
 	)
 '
 
-test_expect_failure 'git merge --abort succeeds despite D/F conflict' '
+test_expect_success 'git merge --abort succeeds despite D/F conflict' '
 	test_when_finished "git -C df_plus_edit_edit clean -f" &&
 	test_when_finished "git -C df_plus_edit_edit reset --hard" &&
 	(
@@ -103,7 +103,7 @@ test_expect_failure 'git merge --abort succeeds despite D/F conflict' '
 	)
 '
 
-test_expect_failure 'git am --skip succeeds despite D/F conflict' '
+test_expect_success 'git am --skip succeeds despite D/F conflict' '
 	test_when_finished "git -C df_plus_edit_edit clean -f" &&
 	test_when_finished "git -C df_plus_edit_edit reset --hard" &&
 	(
diff --git a/t/t6020-merge-df.sh b/t/t6020-merge-df.sh
index 2af1beec5f..46b506b3b7 100755
--- a/t/t6020-merge-df.sh
+++ b/t/t6020-merge-df.sh
@@ -89,9 +89,6 @@ test_expect_success 'modify/delete + directory/file conflict' '
 '
 
 test_expect_success 'modify/delete + directory/file conflict; other way' '
-	# Yes, we really need the double reset since "letters" appears as
-	# both a file and a directory.
-	git reset --hard &&
 	git reset --hard &&
 	git clean -f &&
 	git checkout modify^0 &&
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index 411550d2b6..de77bfaf4f 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -235,7 +235,6 @@ test_expect_success 'setup content merge + rename/directory conflict' '
 '
 
 test_expect_success 'rename/directory conflict + clean content merge' '
-	git reset --hard &&
 	git reset --hard &&
 	git clean -fdqx &&
 
@@ -259,7 +258,6 @@ test_expect_success 'rename/directory conflict + clean content merge' '
 '
 
 test_expect_success 'rename/directory conflict + content merge conflict' '
-	git reset --hard &&
 	git reset --hard &&
 	git clean -fdqx &&
 
-- 
2.18.0.2.gf4c50c7885

