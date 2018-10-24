Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA8D61F453
	for <e@80x24.org>; Wed, 24 Oct 2018 19:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbeJYEQC (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 00:16:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:45744 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbeJYEQB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 00:16:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 12:46:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,421,1534834800"; 
   d="scan'208";a="102361625"
Received: from ldmartin-desk.jf.intel.com ([10.24.8.127])
  by orsmga001.jf.intel.com with ESMTP; 24 Oct 2018 12:46:35 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        lucas.de.marchi@gmail.com
Subject: [PATCH v3] range-diff: allow to diff files regardless of submodule config
Date:   Wed, 24 Oct 2018 12:46:17 -0700
Message-Id: <20181024194617.425-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.19.1.543.g4e5b40e2e8
In-Reply-To: <xmqqk1m7orbg.fsf@gitster-ct.c.googlers.com>
References: <xmqqk1m7orbg.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we have `submodule.diff = log' in the configuration file
or `--submodule=log' is given as argument, range-diff fails
to compare both diffs and we only get the following output:

    Submodule a 0000000...0000000 (new submodule)

Even if the repository doesn't have any submodule.

That's because the mode in diff_filespec is not correct and when
flushing the diff, down in builtin_diff() we will enter the condition:

	if (o->submodule_format == DIFF_SUBMODULE_LOG &&
	    (!one->mode || S_ISGITLINK(one->mode)) &&
	    (!two->mode || S_ISGITLINK(two->mode))) {
		show_submodule_summary(o, one->path ? one->path : two->path,
				&one->oid, &two->oid,
				two->dirty_submodule);
		return;

It turns out that S_ISGITLINK will return true (mode == 0160000 here).
Similar thing happens if submodule.diff is "diff".

Do like it's done in grep.c when calling fill_filespec() and force it to
be recognized as a file by adding S_IFREG to the mode.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

v2: Add test to make sure we don't regress

v3: Extend commit mesage with better explanation and base it on maint branch
    since it's a bug fix

 range-diff.c          |  2 +-
 t/t3206-range-diff.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/range-diff.c b/range-diff.c
index b6b9abac26..3d6aa2330a 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -334,7 +334,7 @@ static struct diff_filespec *get_filespec(const char *name, const char *p)
 {
 	struct diff_filespec *spec = alloc_filespec(name);
 
-	fill_filespec(spec, &null_oid, 0, 0644);
+	fill_filespec(spec, &null_oid, 0, 0100644);
 	spec->data = (char *)p;
 	spec->size = strlen(p);
 	spec->should_munmap = 0;
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 2237c7f4af..518c9a527d 100755
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
 test_expect_success 'changed message' '
 	git range-diff --no-color topic...changed-message >actual &&
 	sed s/Z/\ /g >expected <<-EOF &&
-- 
2.19.1.543.g4e5b40e2e8

