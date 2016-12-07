Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B97F81FBB0
	for <e@80x24.org>; Wed,  7 Dec 2016 10:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753032AbcLGKQP (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 05:16:15 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34591 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752956AbcLGKQO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 05:16:14 -0500
Received: by mail-pg0-f65.google.com with SMTP id e9so23017417pgc.1
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 02:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=gWQUD28ba6GOODxLiJCP3y8htIipTpFo6MfBb3m49cg=;
        b=NT3ewo/bSmlT/qaEZQ/vd7KjdDXTupl1KhX3ifvFge1qrWXKyY6peXe2++p05jub9R
         AuSLis8bRK2aW7KN3NOtLiY3tfbRUfGarpIG+f5Qc9lsC8yg08YG8ZQlMAl81mv6Ev8B
         qYWyIFC4vppmjqLbnMHVC5GJUP9XQJ76azA2abxumj015b/UyX755SZxbejl80Z1pgYk
         WTIT7OWP9HN/6U0dE4qNQJsRHj5sMrYmUcUhVoJIdYVXGKORNRYHrh41aXGE0FHdeqVC
         uJlx2xXfPtgJf0NPSJBeLS3WR6xamOSI3C7tlGihHUZgEO4Z1klQendFemhpBqHFvSBu
         CZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gWQUD28ba6GOODxLiJCP3y8htIipTpFo6MfBb3m49cg=;
        b=HJ0ZYXzp/I3y8AqkK/+a1kBczyxcjt6c6Jgec1xCng/+07EQxID5Z/Bi8C53nnIKXM
         WJWtdQM2lqNPf3I87/tHf8Vf3B5hfApwbWw7B83tFuHKOM6c1wQOQBiUIWYEzBGJwi1p
         R1Ma3yASP6RtUt9NEPw7+fGnzH/8R+iZkMUy7D4m5M/aEENMCo6rUnVZQXQd/oaLNBmC
         wIa8zm7qDDzzslpqHhWfQrFkMb39h2+GSD1+sEhPXBJQnwPm056dvs2ld1ECavWW0143
         hUAXR519q3zHsbkQaj4vw8Xox4D0lgeFmYj4xce0f2pj8RHrx03Cm41qHC69omS0UCHY
         xZnQ==
X-Gm-Message-State: AKaTC01qrlIyaSUHwjAsnZC11KbR8KbSiLInLPY0rNUH7FA+1Qbbawa5lt2s0Ad/7k/pXA==
X-Received: by 10.99.9.66 with SMTP id 63mr120325376pgj.84.1481105772277;
        Wed, 07 Dec 2016 02:16:12 -0800 (PST)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id 71sm41367048pft.25.2016.12.07.02.16.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 02:16:10 -0800 (PST)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git ML <git@vger.kernel.org>, Frank Becker <fb@mooflu.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Keeping <john@keeping.me.uk>
Subject: [PATCH v2] difftool: fix dir-diff index creation when in a subdirectory
Date:   Wed,  7 Dec 2016 02:16:08 -0800
Message-Id: <20161207101608.16058-1-davvid@gmail.com>
X-Mailer: git-send-email 2.11.0.1.g7697df0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

9ec26e7977 (difftool: fix argument handling in subdirs, 2016-07-18)
corrected how path arguments are handled in a subdirectory, but
it introduced a regression in how entries outside of the
subdirectory are handled by dir-diff.

When preparing the right-side of the diff we only include the
changed paths in the temporary area.

The left side of the diff is constructed from a temporary
index that is built from the same set of changed files, but it
was being constructed from within the subdirectory.  This is a
problem because the indexed paths are toplevel-relative, and
thus they were not getting added to the index.

Teach difftool to chdir to the toplevel of the repository before
preparing its temporary indexes.  This ensures that all of the
toplevel-relative paths are valid.

Add test cases to more thoroughly exercise this scenario.

Reported-by: Frank Becker <fb@mooflu.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
Changes since v1:

- Improved commit message thanks to Johannes Schindelin
  ("git whatis" was used to describe the referenced commit)

- Add more tests for edge cases that are properly handled
  but were not being tested.

 git-difftool.perl   |  4 ++++
 t/t7800-difftool.sh | 44 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index a5790d03a0..959822d5f3 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -182,6 +182,10 @@ EOF
 		}
 	}
 
+	# Go to the root of the worktree so that the left index files
+	# are properly setup -- the index is toplevel-relative.
+	chdir($workdir);
+
 	# Setup temp directories
 	my $tmpdir = tempdir('git-difftool.XXXXX', CLEANUP => 0, TMPDIR => 1);
 	my $ldir = "$tmpdir/left";
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 70a2de461a..99d4123461 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -374,6 +374,7 @@ test_expect_success PERL 'setup change in subdirectory' '
 	echo master >sub/sub &&
 	git add sub/sub &&
 	git commit -m "added sub/sub" &&
+	git tag v1 &&
 	echo test >>file &&
 	echo test >>sub/sub &&
 	git add file sub/sub &&
@@ -409,12 +410,49 @@ run_dir_diff_test 'difftool --dir-diff ignores --prompt' '
 	grep file output
 '
 
-run_dir_diff_test 'difftool --dir-diff from subdirectory' '
+run_dir_diff_test 'difftool --dir-diff branch from subdirectory' '
 	(
 		cd sub &&
 		git difftool --dir-diff $symlinks --extcmd ls branch >output &&
-		grep sub output &&
-		grep file output
+		# "sub" must only exist in "right"
+		# "file" and "file2" must be listed in both "left" and "right"
+		test "1" = $(grep sub output | wc -l) &&
+		test "2" = $(grep file"$" output | wc -l) &&
+		test "2" = $(grep file2 output | wc -l)
+	)
+'
+
+run_dir_diff_test 'difftool --dir-diff v1 from subdirectory' '
+	(
+		cd sub &&
+		git difftool --dir-diff $symlinks --extcmd ls v1 >output &&
+		# "sub" and "file" exist in both v1 and HEAD.
+		# "file2" is unchanged.
+		test "2" = $(grep sub output | wc -l) &&
+		test "2" = $(grep file output | wc -l) &&
+		test "0" = $(grep file2 output | wc -l)
+	)
+'
+
+run_dir_diff_test 'difftool --dir-diff branch from subdirectory w/ pathspec' '
+	(
+		cd sub &&
+		git difftool --dir-diff $symlinks --extcmd ls branch -- .>output &&
+		# "sub" only exists in "right"
+		# "file" and "file2" must not be listed
+		test "1" = $(grep sub output | wc -l) &&
+		test "0" = $(grep file output | wc -l)
+	)
+'
+
+run_dir_diff_test 'difftool --dir-diff v1 from subdirectory w/ pathspec' '
+	(
+		cd sub &&
+		git difftool --dir-diff $symlinks --extcmd ls v1 -- .>output &&
+		# "sub" exists in v1 and HEAD
+		# "file" is filtered out by the pathspec
+		test "2" = $(grep sub output | wc -l) &&
+		test "0" = $(grep file output | wc -l)
 	)
 '
 
-- 
2.11.0.1.g7697df0

