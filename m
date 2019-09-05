Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19DC91F461
	for <e@80x24.org>; Thu,  5 Sep 2019 15:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387652AbfIEPrv (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 11:47:51 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34231 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733016AbfIEPrs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 11:47:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id d3so1516353plr.1
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 08:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2AwK6eI+H6EMx9Ytt8FhOZnNquZtsQKeJ6BLOPurjVg=;
        b=UzQl7C6Vh1KbNSuZfFPjJx4iDYzZyhcG8KrVb/CyloTnt6Qjzqva9VbCOIlh4qpy8N
         KacQOWvlfcTP1jWsp5AcK5osnCvQsviGEjSkDA2CQTF2divkQfXTnAtRJT+m30P/f0OU
         pqdDuMj5ynm2g9DAE0ds+evNG+UpWNRFuPrgDKODU2cKnPn2PZ0mi0VmdAWFynVqKjRn
         S+4r71Rdmn1ofbe0wDCv/RWq8OP3IGVxEwnngymga1PRFUl2JjyZmSMRi8lZxFBec8g8
         LOA1U3SJcPyRkEthD3iE7iciF/qQkF8kO+hOA4mjerqASykBU5GxwTvfrt54piwVYHga
         65YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2AwK6eI+H6EMx9Ytt8FhOZnNquZtsQKeJ6BLOPurjVg=;
        b=MNk11nVgAqVPEkQrq9NejqlWU027wLt4anzKYbY0e+qn6+m2TurmMARrTiXmeb+TSO
         lM2IvScWErnXm9fzxflASmn0lv6mAVyQ78NTN4x5gVvYbOXmV4iSbWVZ92fCQLAWqpYV
         HP+i+PlUni1VR95jslmzbeTXCBKkCSztKLS/MdDfG58aOMwzvv+QZIDOpIl6EPhyYYSy
         J79XOSzUIYrpMXn/n7O07bmtpnxddnzJ8We2A+H42vhvHtYalYUZntYAdZMi3Pi9yMXZ
         2xMN77L5JoJv2kttC/Oq9vmAUUa/bIqX9mxjGLFMTYTdIp8Z8IRVRk923d+Z1MveYBGw
         vUjw==
X-Gm-Message-State: APjAAAWNME5a0oBUHKWotksfX0xw+WRWK+50d1l4n/TuZ0iNrrsVpOMk
        JuA1Ghc5YqQTf00KQ5zg95mOGhL2
X-Google-Smtp-Source: APXvYqy2Lcb1IzwEmmz6KOIJkVYFUQs1PNcljUyH/KJNSZ1ct+3ddaC9WHm2nn06oA8CnpU7xvLFJg==
X-Received: by 2002:a17:902:20cc:: with SMTP id v12mr3895049plg.188.1567698467189;
        Thu, 05 Sep 2019 08:47:47 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id x16sm2339867pjn.12.2019.09.05.08.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Sep 2019 08:47:46 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v2 06/12] dir: If our pathspec might match files under a dir, recurse into it
Date:   Thu,  5 Sep 2019 08:47:29 -0700
Message-Id: <20190905154735.29784-7-newren@gmail.com>
X-Mailer: git-send-email 2.22.1.11.g45a39ee867
In-Reply-To: <20190905154735.29784-1-newren@gmail.com>
References: <20190825185918.3909-1-szeder.dev@gmail.com>
 <20190905154735.29784-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index b4d656192e..47c0a99cb5 100644
--- a/dir.c
+++ b/dir.c
@@ -360,7 +360,7 @@ static int match_pathspec_item(const struct index_state *istate,
 		if ((namelen < matchlen) &&
 		    (match[namelen-offset] == '/') &&
 		    !ps_strncmp(item, match, name, namelen))
-			return MATCHED_RECURSIVELY;
+			return MATCHED_RECURSIVELY_LEADING_PATHSPEC;
 
 		/* name" doesn't match up to the first wild character */
 		if (item->nowildcard_len < item->len &&
@@ -377,7 +377,7 @@ static int match_pathspec_item(const struct index_state *istate,
 		 * The submodules themselves will be able to perform more
 		 * accurate matching to determine if the pathspec matches.
 		 */
-		return MATCHED_RECURSIVELY;
+		return MATCHED_RECURSIVELY_LEADING_PATHSPEC;
 	}
 
 	return 0;
@@ -1939,8 +1939,10 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 		/* recurse into subdir if instructed by treat_path */
 		if ((state == path_recurse) ||
 			((state == path_untracked) &&
-			 (dir->flags & DIR_SHOW_IGNORED_TOO) &&
-			 (get_dtype(cdir.de, istate, path.buf, path.len) == DT_DIR))) {
+			 (get_dtype(cdir.de, istate, path.buf, path.len) == DT_DIR) &&
+			 ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
+			  do_match_pathspec(istate, pathspec, path.buf, path.len,
+					    baselen, NULL, DO_MATCH_LEADING_PATHSPEC) == MATCHED_RECURSIVELY_LEADING_PATHSPEC))) {
 			struct untracked_cache_dir *ud;
 			ud = lookup_untracked(dir->untracked, untracked,
 					      path.buf + baselen,
diff --git a/dir.h b/dir.h
index 680079bbe3..46c238ab49 100644
--- a/dir.h
+++ b/dir.h
@@ -211,8 +211,9 @@ int count_slashes(const char *s);
  * when populating the seen[] array.
  */
 #define MATCHED_RECURSIVELY 1
-#define MATCHED_FNMATCH 2
-#define MATCHED_EXACTLY 3
+#define MATCHED_RECURSIVELY_LEADING_PATHSPEC 2
+#define MATCHED_FNMATCH 3
+#define MATCHED_EXACTLY 4
 int simple_length(const char *match);
 int no_wildcard(const char *string);
 char *common_prefix(const struct pathspec *pathspec);
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 12617158db..d83aeb7dc2 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -691,7 +691,7 @@ test_expect_failure 'git clean -d skips nested repo containing ignored files' '
 	test_path_is_file nested-repo-with-ignored-file/file
 '
 
-test_expect_failure 'git clean handles being told what to clean' '
+test_expect_success 'git clean handles being told what to clean' '
 	mkdir -p d1 d2 &&
 	touch d1/ut d2/ut &&
 	git clean -f */ut &&
@@ -707,7 +707,7 @@ test_expect_success 'git clean handles being told what to clean, with -d' '
 	test_path_is_missing d2/ut
 '
 
-test_expect_failure 'git clean works if a glob is passed without -d' '
+test_expect_success 'git clean works if a glob is passed without -d' '
 	mkdir -p d1 d2 &&
 	touch d1/ut d2/ut &&
 	git clean -f "*ut" &&
-- 
2.22.1.11.g45a39ee867

