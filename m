Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BC3C433E1
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61251207D3
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405721AbgE1SLW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 14:11:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:20223 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405704AbgE1SLP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 14:11:15 -0400
IronPort-SDR: mImNE5RBi+mJYyAj5ENNWuij4TddKDaFgR0VGnZBN/smH3UhNlISjw1+JfrBSjrXMnJJ3v148h
 0X8uTeP80XgQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 11:10:51 -0700
IronPort-SDR: M76eEBZMUtwAqOjSr9veD+npHpylRTey0iYpt8UWQAjYCxs4I+1eFazu64ZE3vD+HxgMn4hedc
 Eu7VptXWBjYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="267301345"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by orsmga003.jf.intel.com with ESMTP; 28 May 2020 11:10:50 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v3 01/16] completion: add test showing subpar git switch completion
Date:   Thu, 28 May 2020 11:10:33 -0700
Message-Id: <20200528181048.3509470-2-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200528181048.3509470-1-jacob.e.keller@intel.com>
References: <20200528181048.3509470-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

When provided with no options, git switch only allows switching between
branches. The one exception to this is the "Do What I Mean" logic that
allows a unique remote branch name to be interpreted as a request to
create a branch of the same name that is tracking that remote branch.

Unfortunately, the logic for the completion of git switch results in
completing not just branch names, but also pseudorefs like HEAD, tags,
and fully specified <remote>/<branch> references.

For example, we currently complete the following:

 $git switch <TAB>
 HEAD
 branch-in-other
 master
 master-in-other
 matching-branch
 matching-tag
 other/branch-in-other
 other/master-in-other

Indeed, if one were to attempt to use git switch with some of these
provided options, git will reject the request:

 $git switch HEAD
 fatal: a branch is expected, got 'HEAD

 $git switch matching-tag
 fatal: a branch is expected, got tag 'matching-tag'

 $git switch other/branch-in-other
 fatal: a branch is expected, got remote branch 'other/branch-in-other'

Ideally, git switch without options ought to complete only words which
will be accepted. Without options, this means to list local branch names
and the unique remote branch names without their remote name pre-pended.

 $git switch <TAB>
 branch-in-other
 master
 master-in-other
 matching-branch

Add a test case that highlights this subpar completion. Also add
a similar test for git checkout completion that shows that due to the
complex nature of git checkout, it must complete all references.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 t/t9902-completion.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 3c44af694015..8f25fd24b43e 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1240,6 +1240,29 @@ test_expect_success '__git_complete_fetch_refspecs - fully qualified & prefix' '
 	test_cmp expected out
 '
 
+#TODO: git switch completion includes unexpected references
+test_expect_failure 'git switch - with no options, complete local branches and unique remote branch names for DWIM logic' '
+	test_completion "git switch " <<-\EOF
+	branch-in-other Z
+	master Z
+	master-in-other Z
+	matching-branch Z
+	EOF
+'
+
+test_expect_success 'git checkout - completes refs and unique remote branches for DWIM' '
+	test_completion "git checkout " <<-\EOF
+	HEAD Z
+	branch-in-other Z
+	master Z
+	master-in-other Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
 test_expect_success 'teardown after ref completion' '
 	git branch -d matching-branch &&
 	git tag -d matching-tag &&
-- 
2.25.2

