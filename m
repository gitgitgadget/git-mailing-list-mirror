Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC83F1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 08:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeJKPo0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 11:44:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:53825 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbeJKPo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 11:44:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 01:18:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,367,1534834800"; 
   d="scan'208";a="270388964"
Received: from cpinion-mobl.amr.corp.intel.com (HELO ldmartin-desk.jf.intel.com) ([10.252.207.126])
  by fmsmga005.fm.intel.com with ESMTP; 11 Oct 2018 01:18:11 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     lucas.de.marchi@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, lucas.demarchi@intel.com,
        sunshine@sunshineco.com, t.gummerer@gmail.com
Subject: [PATCH v2] range-diff: allow to diff files regardless submodule
Date:   Thu, 11 Oct 2018 01:17:50 -0700
Message-Id: <20181011081750.24240-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.19.1.1.g8c3cf03f71
In-Reply-To: <CAKi4VAL+qSObOABeNHVXGytE9aB3sUJtecE5jYF6_ZfDA+J0ZQ@mail.gmail.com>
References: <CAKi4VAL+qSObOABeNHVXGytE9aB3sUJtecE5jYF6_ZfDA+J0ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do like it's done in grep so mode doesn't end up as
0160000, which means range-diff doesn't work if one has
"submodule.diff = log" in the configuration. Without this
while using range-diff I only get a

    Submodule a 0000000...0000000 (new submodule)

instead of the diff between the revisions.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 range-diff.c          |  2 +-
 t/t3206-range-diff.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/range-diff.c b/range-diff.c
index 60edb2f518..bd8083f2d1 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -354,7 +354,7 @@ static struct diff_filespec *get_filespec(const char *name, const char *p)
 {
 	struct diff_filespec *spec = alloc_filespec(name);
 
-	fill_filespec(spec, &null_oid, 0, 0644);
+	fill_filespec(spec, &null_oid, 0, 0100644);
 	spec->data = (char *)p;
 	spec->size = strlen(p);
 	spec->should_munmap = 0;
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 045aca1c18..6aae364171 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -122,6 +122,35 @@ test_expect_success 'changed commit' '
 	test_cmp expected actual
 '
 
+test_expect_success 'changed commit with sm config' '
+	git range-diff --no-color --submodule=log topic...changed >actual &&
+	cat >expected <<-EOF &&
+	1:  4de457d = 1:  a4b3333 s/5/A/
+	2:  fccce22 = 2:  f51d370 s/4/A/
+	3:  147e64e ! 3:  0559556 s/11/B/
+	    @@ -10,7 +10,7 @@
+	      9
+	      10
+	     -11
+	    -+B
+	    ++BB
+	      12
+	      13
+	      14
+	4:  a63e992 ! 4:  d966c5c s/12/B/
+	    @@ -8,7 +8,7 @@
+	     @@
+	      9
+	      10
+	    - B
+	    + BB
+	     -12
+	     +B
+	      13
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'no commits on one side' '
 	git commit --amend -m "new message" &&
 	git range-diff master HEAD@{1} HEAD
-- 
2.19.1.1.g8c3cf03f71

