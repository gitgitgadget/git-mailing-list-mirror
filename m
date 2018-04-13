Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70F2A1F404
	for <e@80x24.org>; Fri, 13 Apr 2018 19:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751091AbeDMTur (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 15:50:47 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52563 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751036AbeDMTuq (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Apr 2018 15:50:46 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 2041121B23;
        Fri, 13 Apr 2018 15:50:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 13 Apr 2018 15:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=5H0XMRewtJ8aJfun8EZSj/+gm3uqdetgnaD0TpqA7Zc=; b=d0Yy2O55
        uIoPLlSwCodjCMgEXZoCl99M0UwBegrcFZiSGIkQbga+g3JewunC4HIFMoeg8djB
        2uvtr8uHla2STAfBha1zj2hFcUF482bzUKfzXbizzYTXMilKtJ9j1swSOeAS041A
        u3pmzWPwfTKoxV2LnZYt07cRcVU6LbTTmNINQnDgW9sGdabwISRquHhaErtGVE/p
        qfs7WeUsNcTSHjs8cJlPdrV+X7MfNm0dZOvTPwiKpKnqkiALrmi3y5VntbOu/maJ
        EN+qm12f/EENKDase9fJV9tca6x5Mjb1OJ/PriSB8NMT1WA/Kf09u3UM5M4Am5jU
        8gAixGmnxYA53g==
X-ME-Sender: <xms:FgrRWoRaSXwZ9pZCA9VfI2_RUJ8W0i0rNYAEBlnAQogNDRyNuLkSfw>
Received: from bod.fritz.box (p54826bc2.dip0.t-ipconnect.de [84.130.107.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id 74A461025D;
        Fri, 13 Apr 2018 15:50:45 -0400 (EDT)
Received: by bod.fritz.box (Postfix, from userid 1000)
        id 1AD817C020F; Fri, 13 Apr 2018 21:50:44 +0200 (CEST)
From:   Michael Vogt <mvo@ubuntu.com>
To:     avarab@gmail.com, sbeller@google.com, git@vger.kernel.org
Cc:     Michael Vogt <mvo@ubuntu.com>
Subject: [PATCH] support: git show --follow-symlinks HEAD:symlink
Date:   Fri, 13 Apr 2018 21:48:29 +0200
Message-Id: <20180413194829.23990-1-mvo@ubuntu.com>
X-Mailer: git-send-email 2.17.0.1.g9777c093a.dirty
In-Reply-To: <87h8oegavn.fsf@evledraar.gmail.com>
References: <87h8oegavn.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support for the `--follow-symlinks` options to git-show. This
allows to write:

    git show --follow-symlink HEAD:path-a-symlink

to get the content of the symlinked file.

Signed-off-by: Michael Vogt <mvo@ubuntu.com>
---
 Documentation/git-show.txt |  6 +++++
 builtin/log.c              |  7 ++++--
 revision.c                 |  2 ++
 revision.h                 |  1 +
 t/t1800-git-show.sh        | 46 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 60 insertions(+), 2 deletions(-)
 create mode 100755 t/t1800-git-show.sh

diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index e73ef5401..d9f7fd90c 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -39,6 +39,12 @@ OPTIONS
 	For a more complete list of ways to spell object names, see
 	"SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
 
+--follow-symlinks::
+	Follow symlinks inside the repository when requesting objects
+	in extended revision syntax of the form tree-ish:path-in-tree.
+	Instead of output about the link itself, provide output about
+	the linked-to object.
+
 include::pretty-options.txt[]
 
 
diff --git a/builtin/log.c b/builtin/log.c
index 94ee177d5..e92af4fc7 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -142,7 +142,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			 struct rev_info *rev, struct setup_revision_opt *opt)
 {
 	struct userformat_want w;
-	int quiet = 0, source = 0, mailmap = 0;
+	int quiet = 0, source = 0, mailmap = 0, follow_symlinks = 0;
 	static struct line_opt_callback_data line_cb = {NULL, NULL, STRING_LIST_INIT_DUP};
 	static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
 	static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
@@ -162,6 +162,8 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		OPT_CALLBACK('L', NULL, &line_cb, "n,m:file",
 			     N_("Process line range n,m in file, counting from 1"),
 			     log_line_range_callback),
+		OPT_BOOL(0, "follow-symlinks", &follow_symlinks,
+			 N_("follow in-tree symlinks (used when showing file content)")),
 		OPT_END()
 	};
 
@@ -173,9 +175,10 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			     builtin_log_options, builtin_log_usage,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
 			     PARSE_OPT_KEEP_DASHDASH);
-
 	if (quiet)
 		rev->diffopt.output_format |= DIFF_FORMAT_NO_OUTPUT;
+	if (follow_symlinks)
+		rev->follow_symlinks = 1;
 	argc = setup_revisions(argc, argv, rev, opt);
 
 	/* Any arguments at this point are not recognized */
diff --git a/revision.c b/revision.c
index b42c836d7..4ab22313f 100644
--- a/revision.c
+++ b/revision.c
@@ -1678,6 +1678,8 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 
 	if (revarg_opt & REVARG_COMMITTISH)
 		get_sha1_flags |= GET_OID_COMMITTISH;
+	if (revs && revs->follow_symlinks)
+		get_sha1_flags |= GET_OID_FOLLOW_SYMLINKS;
 
 	if (get_oid_with_context(arg, get_sha1_flags, &oid, &oc))
 		return revs->ignore_missing ? 0 : -1;
diff --git a/revision.h b/revision.h
index b8c47b98e..060f1038a 100644
--- a/revision.h
+++ b/revision.h
@@ -122,6 +122,7 @@ struct rev_info {
 			first_parent_only:1,
 			line_level_traverse:1,
 			tree_blobs_in_commit_order:1,
+			follow_symlinks:1,
 
 			/* for internal use only */
 			exclude_promisor_objects:1;
diff --git a/t/t1800-git-show.sh b/t/t1800-git-show.sh
new file mode 100755
index 000000000..85541b4db
--- /dev/null
+++ b/t/t1800-git-show.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+test_description='Test git show works'
+
+. ./test-lib.sh
+
+test_expect_success 'verify git show HEAD:foo works' '
+    printf "foo content\n" >foo &&
+    git add foo &&
+    git commit -m "added foo" &&
+    git show HEAD:foo >actual &&
+    printf "foo content\n" >expected &&
+    test_cmp expected actual
+'
+
+test_expect_success 'verify git show HEAD:symlink shows symlink points to foo' '
+    printf "foo content\n" >foo &&
+    ln -s foo symlink &&
+    git add foo symlink &&
+    git commit -m "added foo and a symlink to foo" &&
+    git show HEAD:foo >actual &&
+    printf "foo content\n" >expected &&
+    test_cmp expected actual &&
+    git show HEAD:symlink >actual &&
+    printf "foo" >expected &&
+    test_cmp expected actual
+'
+
+test_expect_success 'verify git show --follow-symlinks HEAD:symlink shows foo' '
+    git show --follow-symlinks HEAD:symlink >actual &&
+    printf "foo content\n" >expected &&
+    test_cmp expected actual
+'
+
+test_expect_success 'verify git show --follow-symlinks HEAD:symlink works with subdirs' '
+    mkdir dir &&
+    ln -s dir symlink-to-dir &&
+    printf "bar content\n" >dir/bar &&
+    git add dir symlink-to-dir &&
+    git commit -m "add dir and symlink-to-dir" &&
+    git show --follow-symlinks HEAD:symlink-to-dir/bar >actual &&
+    printf "bar content\n" >expected &&
+    test_cmp expected actual
+'
+
+test_done
-- 
2.17.0

