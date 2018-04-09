Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE2E31F42D
	for <e@80x24.org>; Mon,  9 Apr 2018 09:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751862AbeDIJAx (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 05:00:53 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46459 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751549AbeDIJAw (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Apr 2018 05:00:52 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 11CAE20FE9
        for <git@vger.kernel.org>; Mon,  9 Apr 2018 05:00:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 09 Apr 2018 05:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=wr153oubh67+7hNsaDa1QAuhSNqlK3yrDo/cHOAxkVc=; b=UXYHID47
        v8/HQAybaYgVdvwrCUErv1bPWpyKqbJqZalLnc5ImOdl7o02wWafbYn23jIDA3LR
        trcAuRyo/oOiatLZhfiWrStyFZ9VQ3jsnMuA4WLGHx8a4+qV2AO0He9iDZ3eMv8l
        e8T8gtjZZOaZkPzWgrU18XjD0EDnLwtoNyM0M44o9QEA9izUBPUSB7/mBsi0t2Mt
        Fnx5KoMSJcQoGagh3OHryqHwf7HObyirjUdraKhuVla64GuGN4I/ZO/3e2KgydKD
        gzgdQZVskUo5MyqEQUtr9y17Dz2sGX3UTTFa+dvmqD8lwzJUFvnKWgPKEd9ciDEl
        dn9RsEbecWxXSw==
X-ME-Sender: <xms:wSvLWgxZ2lhBpDR6ntauW6lZTt_bqhyWq8bmBL4Zb5kNprD3WzrEXw>
Received: from bod.fritz.box (p54aa7ed8.dip0.t-ipconnect.de [84.170.126.216])
        by mail.messagingengine.com (Postfix) with ESMTPA id 895B2E43C8
        for <git@vger.kernel.org>; Mon,  9 Apr 2018 05:00:49 -0400 (EDT)
Received: by bod.fritz.box (Postfix, from userid 1000)
        id C42BB7C09AA; Mon,  9 Apr 2018 11:00:47 +0200 (CEST)
Date:   Mon, 9 Apr 2018 11:00:47 +0200
From:   Michael Vogt <mvo@ubuntu.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH] Add "git show --follow-symlinks HEAD:symlink"
Message-ID: <20180409090047.lfru2ul5fbnggfg7@bod>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hthxz4tzgele65yj"
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hthxz4tzgele65yj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I noticed that `git show HEAD:path-to-symlink` does not work and
returns an error like:
"fatal: Path 'debian/changelog' exists on disk, but not in 'HEAD'."

Looking at `git show` it seems there is no way right now to make
git-show show blobs if they are symlinks [1].

It would be nice to have this ability. Attached is a draft patch to
allow to write: `git show --follow-symlinks HEAD:path-to-symlink`.
Tests are missing in the patch, I'm happy to add those if there is a
chance for the feature to get in.

Cheers,
 Michael

[1] Using `git cat-file --follow-symlinks --batch < input` works but
    feels a bit less elegant compared to supporting it directly in
    git-show.

--hthxz4tzgele65yj
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-support-git-show-follow-symlinks-HEAD-symlink.patch"

From 616b7f21c057656960cb6b8a266095bbef734122 Mon Sep 17 00:00:00 2001
From: Michael Vogt <mvo@ubuntu.com>
Date: Mon, 9 Apr 2018 10:38:13 +0200
Subject: [PATCH] support: git show --follow-symlinks HEAD:symlink

Add support for the `--follow-symlinks` options to git-show. This
allows to write:

    git show --follow-symlink HEAD:path-a-symlink

to get the content of the symlinked file.
---
 builtin/log.c | 7 +++++--
 revision.c    | 2 ++
 revision.h    | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

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
-- 
2.14.1


--hthxz4tzgele65yj--
