Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E13981F403
	for <e@80x24.org>; Tue, 19 Jun 2018 02:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937081AbeFSCoY (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 22:44:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:38006 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755482AbeFSCoY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 22:44:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 19:44:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,241,1526367600"; 
   d="scan'208";a="48107496"
Received: from yexl-desktop.sh.intel.com (HELO localhost) ([10.239.159.124])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jun 2018 19:44:23 -0700
Date:   Tue, 19 Jun 2018 10:40:54 +0800
From:   Ye Xiaolong <xiaolong.ye@intel.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH] format-patch: clear UNINTERESTING flag before
 prepare_bases
Message-ID: <20180619024054.GD17789@yexl-desktop>
Mail-Followup-To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eduardo Habkost <ehabkost@redhat.com>
References: <xmqqh8mj70w6.fsf@gitster-ct.c.googlers.com>
 <20180604150543.7304-1-xiaolong.ye@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604150543.7304-1-xiaolong.ye@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Junio

Could you help review this patch?

Thanks,
Xiaolong

On 06/04, Xiaolong Ye wrote:
>When users specify the commit range with 'Z..C' pattern for format-patch, all
>the parents of Z (including Z) would be marked as UNINTERESTING which would
>prevent revision walk in prepare_bases from getting the prerequisite commits,
>thus `git format-patch --base <base_commit_sha> Z..C` won't be able to generate
>the list of prerequisite patch ids. Clear UNINTERESTING flag with
>clear_object_flags solves this issue.
>
>Reported-by: Eduardo Habkost <ehabkost@redhat.com>
>Signed-off-by: Xiaolong Ye <xiaolong.ye@intel.com>
>---
> builtin/log.c           | 1 +
> t/t4014-format-patch.sh | 6 ++++--
> 2 files changed, 5 insertions(+), 2 deletions(-)
>
>diff --git a/builtin/log.c b/builtin/log.c
>index 4686f68594..01993de6fe 100644
>--- a/builtin/log.c
>+++ b/builtin/log.c
>@@ -1746,6 +1746,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
> 	if (base_commit || base_auto) {
> 		struct commit *base = get_base_commit(base_commit, list, nr);
> 		reset_revision_walk();
>+		clear_object_flags(UNINTERESTING);
> 		prepare_bases(&bases, base, list, nr);
> 	}
> 
>diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
>index 028d5507a6..53880da7bb 100755
>--- a/t/t4014-format-patch.sh
>+++ b/t/t4014-format-patch.sh
>@@ -1554,13 +1554,15 @@ test_expect_success 'format-patch -o overrides format.outputDirectory' '
> 
> test_expect_success 'format-patch --base' '
> 	git checkout side &&
>-	git format-patch --stdout --base=HEAD~3 -1 | tail -n 7 >actual &&
>+	git format-patch --stdout --base=HEAD~3 -1 | tail -n 7 >actual1 &&
>+	git format-patch --stdout --base=HEAD~3 HEAD~.. | tail -n 7 >actual2 &&
> 	echo >expected &&
> 	echo "base-commit: $(git rev-parse HEAD~3)" >>expected &&
> 	echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git patch-id --stable | awk "{print \$1}")" >>expected &&
> 	echo "prerequisite-patch-id: $(git show --patch HEAD~1 | git patch-id --stable | awk "{print \$1}")" >>expected &&
> 	signature >> expected &&
>-	test_cmp expected actual
>+	test_cmp expected actual1 &&
>+	test_cmp expected actual2
> '
> 
> test_expect_success 'format-patch --base errors out when base commit is in revision list' '
>-- 
>2.16.GIT
>
