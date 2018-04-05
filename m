Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6579B1F404
	for <e@80x24.org>; Thu,  5 Apr 2018 17:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751466AbeDERe4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 13:34:56 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:39124 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751425AbeDERex (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Apr 2018 13:34:53 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w35HYngL006435;
        Thu, 5 Apr 2018 10:34:51 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2h286rvn7u-1;
        Thu, 05 Apr 2018 10:34:49 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 0BE192212A84;
        Thu,  5 Apr 2018 10:34:49 -0700 (PDT)
Received: from newren2-linux.yojoe.local (unknown [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 003C82CDEEA;
        Thu,  5 Apr 2018 10:34:48 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sxlijin@gmail.com, peff@peff.net, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 6/7] dir: If our pathspec might match files under a dir, recurse into it
Date:   Thu,  5 Apr 2018 10:34:45 -0700
Message-Id: <20180405173446.32372-7-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.7.g0b50f94d69
In-Reply-To: <20180405173446.32372-1-newren@gmail.com>
References: <20180405173446.32372-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=386 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804050181
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For git clean, if a directory is entirely untracked and the user did not
specify -d (corresponding to DIR_SHOW_IGNORED_TOO), then we usually do
not want to remove that directory and thus do not recurse into it.
However, if the user manually specified specific (or even globbed) paths
somewhere under that directory to remove, then we need to recurse into
the directory to make sure we remove the relevant paths under that
directory as the user requested.

Note that this does not mean that the recursed-into directory will be
added to dir->entries for later removal; as of a few commits earlier in
this series, there is another more strict match check that is run after
returning from a recursed-into directory before deciding to add it to the
list of entries.  Therefore, this will only result in files underneath
the given directory which match one of the pathspecs being added to the
entries list.

Two particular considerations for this patch:

  * If we want to only recurse into a directory when it is specifically
    matched rather than matched-via-glob (e.g. '*.c'), then we could do
    so via making the final non-zero return in match_pathspec_item be
    MATCHED_RECURSIVELY instead of MATCHED_RECURSIVELY_LEADING_PATHSPEC.
    (See final patch of this RFC series for details; note that the
    relative order of MATCHED_RECURSIVELY_LEADING_PATHSPEC and
    MATCHED_RECURSIVELY are important for such a change.))

  * There is a growing amount of logic in read_directory_recursive() for
    deciding whether to recurse into a subdirectory.  However, there is
    a comment immediately preceding this logic that says to recurse if
    instructed by treat_path().   It may be better for the logic in
    read_directory_recursive() to be moved to treat_path() (or another
    function it calls, such as treat_directory()), but I did not feel
    strongly about this and just left the logic where it was while
    adding to it.  Do others have strong opinions on this?

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c            | 10 ++++++----
 dir.h            |  5 +++--
 t/t7300-clean.sh |  4 ++--
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/dir.c b/dir.c
index b0bca179fd..f55e24f149 100644
--- a/dir.c
+++ b/dir.c
@@ -386,7 +386,7 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
 		if ((namelen < matchlen) &&
 		    (match[namelen-1] == '/') &&
 		    !ps_strncmp(item, match, name, namelen))
-			return MATCHED_RECURSIVELY;
+			return MATCHED_RECURSIVELY_LEADING_PATHSPEC;
 
 		/* name" doesn't match up to the first wild character */
 		if (item->nowildcard_len < item->len &&
@@ -403,7 +403,7 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
 		 * The submodules themselves will be able to perform more
 		 * accurate matching to determine if the pathspec matches.
 		 */
-		return MATCHED_RECURSIVELY;
+		return MATCHED_RECURSIVELY_LEADING_PATHSPEC;
 	}
 
 	return 0;
@@ -1961,8 +1961,10 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 		/* recurse into subdir if instructed by treat_path */
 		if ((state == path_recurse) ||
 			((state == path_untracked) &&
-			 (dir->flags & DIR_SHOW_IGNORED_TOO) &&
-			 (get_dtype(cdir.de, istate, path.buf, path.len) == DT_DIR))) {
+			 (get_dtype(cdir.de, istate, path.buf, path.len) == DT_DIR) &&
+			 ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
+			  do_match_pathspec(pathspec, path.buf, path.len,
+					    baselen, NULL, DO_MATCH_LEADING_PATHSPEC) == MATCHED_RECURSIVELY_LEADING_PATHSPEC))) {
 			struct untracked_cache_dir *ud;
 			ud = lookup_untracked(dir->untracked, untracked,
 					      path.buf + baselen,
diff --git a/dir.h b/dir.h
index b0758b82a2..0573f99ae0 100644
--- a/dir.h
+++ b/dir.h
@@ -210,8 +210,9 @@ extern int count_slashes(const char *s);
  * when populating the seen[] array.
  */
 #define MATCHED_RECURSIVELY 1
-#define MATCHED_FNMATCH 2
-#define MATCHED_EXACTLY 3
+#define MATCHED_RECURSIVELY_LEADING_PATHSPEC 2
+#define MATCHED_FNMATCH 3
+#define MATCHED_EXACTLY 4
 extern int simple_length(const char *match);
 extern int no_wildcard(const char *string);
 extern char *common_prefix(const struct pathspec *pathspec);
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 31f2d0d8ba..889b3401e4 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -669,7 +669,7 @@ test_expect_success 'git clean -d skips untracked dirs containing ignored files'
 	test_path_is_missing foo/b/bb
 '
 
-test_expect_failure 'git clean handles being told what to clean' '
+test_expect_success 'git clean handles being told what to clean' '
 	mkdir -p d1 d2 &&
 	touch d1/ut d2/ut &&
 	git clean -f */ut &&
@@ -685,7 +685,7 @@ test_expect_success 'git clean handles being told what to clean, with -d' '
 	test_path_is_missing d2/ut
 '
 
-test_expect_failure 'git clean handles being told a glob to clean' '
+test_expect_success 'git clean handles being told a glob to clean' '
 	mkdir -p d1 d2 &&
 	touch d1/ut d2/ut &&
 	git clean -f "*ut" &&
-- 
2.17.0.7.g0b50f94d69

