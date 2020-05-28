Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1F4C433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CFFE20829
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405724AbgE1SLZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 14:11:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:20269 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405711AbgE1SLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 14:11:16 -0400
IronPort-SDR: An7CqBshlhogycRXetDIj+6MjOVYb/0839ZH0iQpdFdbYHYqphevwDZD4Yl9yEl//RkRI1lLaW
 Sd6FVjZM198A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 11:10:52 -0700
IronPort-SDR: OUEuYcwbB54cbcpDabsxqIJh/OaJ4Cwd33b+U3k1H5L1A10AczlDLEZdTLbNcPCD4Xi30s0Xnp
 mMRRG8RUanFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="267301359"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by orsmga003.jf.intel.com with ESMTP; 28 May 2020 11:10:51 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v3 13/16] completion: improve handling of --detach in checkout
Date:   Thu, 28 May 2020 11:10:45 -0700
Message-Id: <20200528181048.3509470-14-jacob.e.keller@intel.com>
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

Just like git switch, we should not complete DWIM remote branch names
if --detach has been specified. To avoid this, refactor _git_checkout in
a similar way to _git_switch.

Note that we don't simply clear dwim_opt when we find -d or --detach, as
we will be adding other modes and checks, making this flow easier to
follow.

Update the previously failing tests to show that the breakage has been
resolved.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 contrib/completion/git-completion.bash | 7 ++++++-
 t/t9902-completion.sh                  | 6 ++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 53afd72d0e4e..38b5a5a0d874 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1489,7 +1489,12 @@ _git_checkout ()
 		;;
 	*)
 		local dwim_opt="$(__git_checkout_default_dwim_mode)"
-		__git_complete_refs $dwim_opt
+
+		if [ -n "$(__git_find_on_cmdline "-d --detach")" ]; then
+			__git_complete_refs --mode="refs"
+		else
+			__git_complete_refs $dwim_opt --mode="refs"
+		fi
 		;;
 	esac
 }
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index f4f3a3ca3d55..7e56a62a9bb3 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1372,8 +1372,7 @@ test_expect_success 'git switch - with --detach, complete all references' '
 	EOF
 '
 
-#TODO: checkout --detach incorrectly includes DWIM remote branch names
-test_expect_failure 'git checkout - with --detach, complete only references' '
+test_expect_success 'git checkout - with --detach, complete only references' '
 	test_completion "git checkout --detach " <<-\EOF
 	HEAD Z
 	master Z
@@ -1395,8 +1394,7 @@ test_expect_success 'git switch - with -d, complete all references' '
 	EOF
 '
 
-#TODO: checkout -d incorrectly includes DWIM remote branch names
-test_expect_failure 'git checkout - with -d, complete only references' '
+test_expect_success 'git checkout - with -d, complete only references' '
 	test_completion "git checkout -d " <<-\EOF
 	HEAD Z
 	master Z
-- 
2.25.2

