Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D131C55191
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 02:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C8C20857
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 02:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgDYCU4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 22:20:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:47708 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgDYCUx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 22:20:53 -0400
IronPort-SDR: U69Mv9GXItUuPd/HV6VupBxGPkQ4BKyfIX/TSto9SKcsq3Hv5iLNKjJt9QxV7e7XkNTXBz5rSi
 cqB1LTkOqCSg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 19:20:52 -0700
IronPort-SDR: SKm+yE7Qxc5Bc1SMUtTb6bZrP7vOETsdH0Sdlw6q96ZVwCyY0X5cLV9aR1aIJjUaQyOl12mhdR
 Ufz+rdPkKzjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,314,1583222400"; 
   d="scan'208";a="281056778"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by fmsmga004.fm.intel.com with ESMTP; 24 Apr 2020 19:20:52 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 03/11] completion: add test highlighting subpar git switch --track completion
Date:   Fri, 24 Apr 2020 19:20:36 -0700
Message-Id: <20200425022045.1089291-4-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200425022045.1089291-1-jacob.e.keller@intel.com>
References: <20200425022045.1089291-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

If git switch is called with --track, it will attempts to DWIM into
creating a local tracking branch that tracks the provided remote branch.
It seems reasonable that, to support this behavior, we should only
complete remote branches in the form "<remote>/<branch>".

Indeed, current completion is not just sub-par, but could almost be
described as entirely useless.

  $git switch --track <TAB>

will only report *local* branch names. Indeed a new test case highlights
this quite well:

  --- expected    2020-04-25 00:25:34.424965326 +0000
  +++ out_sorted  2020-04-25 00:25:34.441965370 +0000
  @@ -1,2 +1,2 @@
  -other/branch-in-other
  -other/master-in-other
  +master
  +matching-branch
  not ok 100 - git switch - with --track, complete only remote branches # TODO known breakage

Understanding exactly what causes this is not that simple.

First we enable DWIM output by default. Then, if "--track",
"--no-track", or "--no-guess" is enabled on the command line, we disable
DWIM. This makes sense, because --track should not include the default
"DWIM" remote branch names.

Following this, there is a check for "--detach". If "--detach" is *not*
present, then we set only_local_ref=y. this is done because we would
like to avoid printing remote references. This immediately seems wrong
because --track should allow completing remote references.

Finally, if only_local_ref is 'y', and the track_opt for DWIM logic is
disabled, we complete only local branches. This occurs because --track
disabled track_opt, and not providing --detach sets only_local_ref to
'y'.

Fixing this correctly is not trivial, so it is left to a follow up
change.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 t/t9902-completion.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index af4661cbcc73..002223160058 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1271,6 +1271,16 @@ test_expect_success 'git switch - with --detach, complete all references' '
 	EOF
 '
 
+# TODO: Since --track on its own will perform a DWIM to extract the local
+# branch name, we should complete only the remote branches with their remote
+# name.
+test_expect_failure 'git switch - with --track, complete only remote branches' '
+	test_completion "git switch --track " <<-\EOF
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
 test_expect_success 'git switch - with --no-track, complete only local branch names' '
 	test_completion "git switch --no-track " <<-\EOF
 	master Z
-- 
2.25.2

