Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F374C1F6BD
	for <e@80x24.org>; Fri,  3 Feb 2017 23:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752936AbdBCXWd convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 3 Feb 2017 18:22:33 -0500
Received: from mga14.intel.com ([192.55.52.115]:28630 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752822AbdBCXWc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 18:22:32 -0500
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2017 15:22:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,331,1477983600"; 
   d="scan'208";a="221135158"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga004.fm.intel.com with ESMTP; 03 Feb 2017 15:22:31 -0800
Received: from orsmsx158.amr.corp.intel.com (10.22.240.20) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.248.2; Fri, 3 Feb 2017 15:22:31 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.108]) by
 ORSMSX158.amr.corp.intel.com ([169.254.10.135]) with mapi id 14.03.0248.002;
 Fri, 3 Feb 2017 15:22:31 -0800
From:   "Gumbel, Matthew K" <matthew.k.gumbel@intel.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH] commit: Optimize number of lstat() calls
Thread-Topic: [PATCH] commit: Optimize number of lstat() calls
Thread-Index: AdJ89sXXqfIdkCvQTFCVofr1nzB7xQBexnlA
Date:   Fri, 3 Feb 2017 23:22:30 +0000
Message-ID: <DA0A42D68346B1469147552440A645039A9C9988@ORSMSX115.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjY0OWVhZDMtMjkyMy00MmQzLTljNWYtOWFmZGM4ZDA0MmY2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX0lDIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE1LjkuNi42IiwiVHJ1c3RlZExhYmVsSGFzaCI6InY5b3pEMkVYZFRyRHlcL09KejdcLzk0ZisxS2x6N0FQaXRhY2xQN3BEUnJGcz0ifQ==
x-ctpclassification: CTP_IC
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When making a --only commit, original behavior was to do a full cache
update for the purposes of giving the pre-commit hook an up-to-date set 
of stat data. That would result in long runtime for git-commit in a big 
repo on NFS (>60s for a 54k-file repo).

With this change, when doing a --only commit and no pre-commit hook is
present, the cache update is skipped since it is known a priori which
files are to be committed.

This was discussed on the mailing list here:
https://public-inbox.org/git/DA0A42D68346B1469147552440A645039A9C56D4@ORSMSX115.amr.corp.intel.com/

Signed-off-by: Matthew K. Gumbel <matthew.k.gumbel@intel.com>
---
builtin/commit.c | 8 ++++++--
1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 2de5f6c..1df3d71 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -470,7 +470,9 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix

    hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
    add_remove_files(&partial);
-   refresh_cache(REFRESH_QUIET);
+    if (find_hook("pre-commit")) {
+        refresh_cache(REFRESH_QUIET);
+    }
    update_main_cache_tree(WRITE_TREE_SILENT);
    if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
        die(_("unable to write new_index file"));
@@ -482,7 +484,9 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix

    create_base_index(current_head);
    add_remove_files(&partial);
-   refresh_cache(REFRESH_QUIET);
+    if (find_hook("pre-commit")) {
+        refresh_cache(REFRESH_QUIET);
+    }

    if (write_locked_index(&the_index, &false_lock, CLOSE_LOCK))
        die(_("unable to write temporary index file"));
-- 
2.8.4


