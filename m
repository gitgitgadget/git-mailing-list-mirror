Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF80EC433F5
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 21:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiBNVDU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 16:03:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiBNVDT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 16:03:19 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66117F8B9A
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 13:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644872590; x=1676408590;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jBt1BGF0S1j8N9vzeAKvwjiLe3m7Ck38xBur0sAfhUU=;
  b=PvutTnNdkZQ7hVdZyxsrMOSNH+ZrBTUvE23Hee84CHitPMTkmYCtt8QM
   NPitf+TNpSjtw/0JTAZ+EmpPgBgbi8fkp2ql5hLGRYWhFstuSzTi+o+ji
   R7frds3olPMIWGeGb2zSuQFnFa2TKT+H0feOLzSMgMtpmgpvavx+QsLz4
   y7nz0ZnOtnyk4WXAk76DTdNIRdhi8lntq/4cWZfws1I50YtS6IpnOYUhI
   fX3E3WCVEVe2d0TU/+ynbV4na8U4LMlcanliDuYqBy95o5AHI+hAbXY+c
   Nt3Bx6eOSkjWY1MO5c9KPSuZt3jf3abq5Bh7NX5G6vdCBqdGi6tmmVq/W
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="249931959"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="249931959"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 13:02:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="587359139"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.10])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 13:02:59 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH] name-rev: test showing failure with non-monotonic commit dates
Date:   Mon, 14 Feb 2022 13:01:36 -0800
Message-Id: <20220214210136.1532574-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.35.1.129.gb80121027d12
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

If a commit in a sequence of linear history has a non-monotonically
increasing commit timestamp, git name-rev will not properly name the
commit.

However, if you use --annotate-stdin then the commit does actually get
picked up and named properly.

Analyzing the source, it appears to be caused by the cutoff logic which
is some sort of heuristic which relies on monotonically increasing
commit dates.

This seems like the cutoff using commit date is some sort of heuristic
which reduces the cost of describing something.. but --annotate-stdin
and --all don't use it.

In the example setup I could do:

echo "<commit id>" | git name-rev --annotate-stdin

and get the expected result without the cutoff logic, and it seems at
least on small repositories to be as fast as the normal attempt, except
it produces accurate results.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 t/t6120-describe.sh | 62 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 9781b92aeddf..e9f897e42591 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -488,6 +488,68 @@ test_expect_success 'name-rev covers all conditions while looking at parents' '
 	)
 '
 
+# A-B-C-D-E-main
+#
+# Where C has a non-monotonically increasing commit timestamp w.r.t. other
+# commits
+test_expect_success 'non-monotonic commit dates setup' '
+	git init non-monotonic &&
+	(
+		cd non-monotonic &&
+
+		echo A >file &&
+		git add file &&
+		GIT_COMMITTER_DATE="2020-01-01 18:00" git commit -m A &&
+
+		echo B >file &&
+		git add file &&
+		GIT_COMMITTER_DATE="2020-01-02 18:00" git commit -m B &&
+
+		echo C >file &&
+		git add file &&
+		GIT_COMMITTER_DATE="2005-01-01 18:00" git commit -m C &&
+
+		echo D >file &&
+		git add file &&
+		GIT_COMMITTER_DATE="2020-01-04 18:00" git commit -m D &&
+
+		echo E >file &&
+		git add file &&
+		GIT_COMMITTER_DATE="2020-01-05 18:00" git commit -m E
+	)
+'
+
+test_expect_failure 'name-rev commit timestamp prevents naming commits' '
+	(
+		cd non-monotonic &&
+
+		B=$(git rev-parse main~3) &&
+
+		echo "$B main~3" >expect &&
+		git name-rev $B >actual &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'name-rev --all works with non-monotonic' '
+	(
+		cd non-monotonic &&
+
+		cat >expect <<EOF &&
+main
+main~1
+main~2
+main~3
+main~4
+EOF
+
+		git log --pretty=%H | git name-rev --annotate-stdin --name-only >actual &&
+
+		test_cmp expect actual
+	)
+'
+
 #               B
 #               o
 #                \
-- 
2.35.1.129.gb80121027d12

