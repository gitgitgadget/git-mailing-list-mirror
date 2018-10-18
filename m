Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D7871F453
	for <e@80x24.org>; Thu, 18 Oct 2018 19:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbeJSDOP (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 23:14:15 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:50392 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbeJSDOP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 23:14:15 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 42bdvS700Kz5tmN;
        Thu, 18 Oct 2018 21:11:48 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id B5B351AAF;
        Thu, 18 Oct 2018 21:11:48 +0200 (CEST)
Subject: Re: [PATCH] diff: don't attempt to strip prefix from absolute Windows
 paths
To:     Stefan Beller <sbeller@google.com>
Cc:     andreenkosa@gmail.com, Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>
References: <CAD1gVxMg0ZiKqFABrnwt0v_=wr2X_3ErkR92RmCAtFQnuM+L5w@mail.gmail.com>
 <xmqqr2gu8dsx.fsf@gitster-ct.c.googlers.com>
 <ae6fc699-6e09-2979-40dc-9cc49f4f8365@kdbg.org>
 <CAGZ79kYChLNDB_f1KR2k7G9FvHkX7x_yXdhxMRpLFWpRR0SoPg@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <a9a51e28-208d-d8dd-a868-bc2f8cc79598@kdbg.org>
Date:   Thu, 18 Oct 2018 21:11:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYChLNDB_f1KR2k7G9FvHkX7x_yXdhxMRpLFWpRR0SoPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.10.18 um 20:49 schrieb Stefan Beller:
> On Thu, Oct 18, 2018 at 11:38 AM Johannes Sixt <j6t@kdbg.org> wrote:
> 
>> There is one peculiarity, though: [...]
> 
> The explanation makes sense, and the code looks good.
> Do we want to have a test for this niche case?
> 

Good point. That would be the following. But give me a day or two to
cross-check on Windows and whether it really catches the breakage.

diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 453e6c35eb..6e0dd6f9e5 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -127,4 +127,14 @@ test_expect_success 'diff --no-index from repo subdir respects config (implicit)
 	test_cmp expect actual.head
 '
 
+test_expect_success 'diff --no-index from repo subdir with absolute paths' '
+	cat <<-EOF >expect &&
+	1	1	$(pwd)/non/git/{a => b}
+	EOF
+	test_expect_code 1 \
+		git -C repo/sub diff --numstat \
+		"$(pwd)/non/git/a" "$(pwd)/non/git/b" >actual &&
+	test_cmp expect actual
+'
+
 test_done
