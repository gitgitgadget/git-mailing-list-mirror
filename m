Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C9E81F453
	for <e@80x24.org>; Fri, 19 Oct 2018 16:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbeJTBFH (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 21:05:07 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:42739 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727549AbeJTBFH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 21:05:07 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 42cBtm5VHNz5tlF;
        Fri, 19 Oct 2018 18:58:08 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 2903E1AB2;
        Fri, 19 Oct 2018 18:58:08 +0200 (CEST)
Subject: [PATCH v2] diff: don't attempt to strip prefix from absolute Windows
 paths
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, andreenkosa@gmail.com,
        git <git@vger.kernel.org>
References: <CAD1gVxMg0ZiKqFABrnwt0v_=wr2X_3ErkR92RmCAtFQnuM+L5w@mail.gmail.com>
 <xmqqr2gu8dsx.fsf@gitster-ct.c.googlers.com>
 <ae6fc699-6e09-2979-40dc-9cc49f4f8365@kdbg.org>
 <CAGZ79kYChLNDB_f1KR2k7G9FvHkX7x_yXdhxMRpLFWpRR0SoPg@mail.gmail.com>
 <a9a51e28-208d-d8dd-a868-bc2f8cc79598@kdbg.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <2ca9d427-38fb-ff6e-4e2f-1947d86e6273@kdbg.org>
Date:   Fri, 19 Oct 2018 18:58:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <a9a51e28-208d-d8dd-a868-bc2f8cc79598@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git diff can be invoked with absolute paths. Typically, this triggers
the --no-index case. Then the absolute paths remain in the file names
that are printed in the output.

There is one peculiarity, though: When the command is invoked from a
a sub-directory in a repository, then it is attempted to strip the
sub-directory from the beginning of relative paths. Yet, to detect a
relative path the code just checks for an initial forward slash.
This mistakes a Windows style path like "D:/base" as a relative path
and the output looks like this, for example:

  D:\dir\test\one>git -P diff --numstat D:\dir\base D:\dir\diff
  1       1       ir/{base => diff}/1.txt

where the correct output should be

  D:\dir\test\one>git -P diff --numstat D:\dir\base D:\dir\diff
  1       1       D:/dir/{base => diff}/1.txt

If the sub-directory where 'git diff' is invoked is sufficiently deep
that the prefix becomes longer than the path to be printed, then the
subsequent code accesses the path out of bounds.

Use is_absolute_path() to detect Windows style absolute paths.

One might wonder whether the check for a directory separator that
is visible in the patch context should be changed from == '/' to
is_dir_sep() or not. It turns out not to be necessary. That code
only ever investigates paths that have undergone pathspec
normalization, after which there are only forward slashes even on
Windows.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
v2:
- added a test that demonstrates the problem on Windows
- changed the example in the commit message to clarify that this is
  about truncated paths, not about failure to detect common prefix

 diff.c                   |  4 ++--
 t/t4053-diff-no-index.sh | 10 ++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index f0c7557b40..d18eb198f2 100644
--- a/diff.c
+++ b/diff.c
@@ -4267,12 +4267,12 @@ static void diff_fill_oid_info(struct diff_filespec *one)
 static void strip_prefix(int prefix_length, const char **namep, const char **otherp)
 {
 	/* Strip the prefix but do not molest /dev/null and absolute paths */
-	if (*namep && **namep != '/') {
+	if (*namep && !is_absolute_path(*namep)) {
 		*namep += prefix_length;
 		if (**namep == '/')
 			++*namep;
 	}
-	if (*otherp && **otherp != '/') {
+	if (*otherp && !is_absolute_path(*otherp)) {
 		*otherp += prefix_length;
 		if (**otherp == '/')
 			++*otherp;
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 453e6c35eb..6e0dd6f9e5 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -127,4 +127,14 @@ test_expect_success 'diff --no-index from repo subdir respects config (implicit)
 	test_cmp expect actual.head
 '
 
+test_expect_success 'diff --no-index from repo subdir with absolute paths' '
+	cat <<-EOF >expect &&
+	1	1	$(pwd)/non/git/{a => b}
+	EOF
+	test_expect_code 1 \
+		git -C repo/sub diff --numstat \
+		"$(pwd)/non/git/a" "$(pwd)/non/git/b" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.19.1.406.g1aa3f475f3
