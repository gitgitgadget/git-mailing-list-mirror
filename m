Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CE4220A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 15:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbeLMPfS (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 10:35:18 -0500
Received: from mail.javad.com ([54.86.164.124]:46887 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728827AbeLMPfS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 10:35:18 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id ED7CF3E93A;
        Thu, 13 Dec 2018 15:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1544715317;
        bh=5Pmp8m0dVDzvlSPiF9QjYMzsjn2wRTL9OQRcm1J5Y94=; l=2299;
        h=Received:From:To:Subject;
        b=sqEWLHGfZiUK6gvMzvkTFyvns/oCCPk+E16rtChpGxVDXNlWw5XCRrPK0cG6SF5xL
         Upq2jwUVPovX42DxrcRX5vrmVPhHqiZcfIZsbyxI7sryzaspVZeG+FslMtCGwZteDQ
         r9yiy/8KO0T9cchnJB4aqIsaVCIpjTPlZjFpkk48=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1gXT19-00067p-14; Thu, 13 Dec 2018 18:35:15 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] cherry-pick: do not error on non-merge commits when '-m 1' is specified
References: <87efh0pdln.fsf@javad.com>
        <xmqqsh5gt9sm.fsf@gitster-ct.c.googlers.com>
        <871s6n5mtd.fsf@javad.com>
        <xmqqo99qf46q.fsf@gitster-ct.c.googlers.com>
        <87o99qylv5.fsf@javad.com>
Date:   Thu, 13 Dec 2018 18:35:15 +0300
In-Reply-To: <87o99qylv5.fsf@javad.com> (Sergey Organov's message of "Thu, 13
        Dec 2018 09:35:58 +0300")
Message-ID: <878t0twibw.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>>

[...]

>>
>> The change to the code itself looks sane, but applying this patch
>> alone will break existing tests whose expectations must be updated,
>> and this new behaviour must be protected by a new test (or two) so
>> that we won't accidentally stop accepting "-m 1" for a single-parent
>> commit.
>
> I fixed most of the tests, but
>
> "t3510/4: cherry-pick persists opts correctly"
>
> is an offender for me. It looks like it [ab]uses current "-m 1" behavior
> just to stop in the middle of the sequence, and I'm not sure how to fix
> it most suitably.

I came up with the following as a preparatory change. Looks acceptable?

-- 8< --

    t3510: stop using '-m 1' to force failure mid-sequence of cherry-picks
    
    We are going to allow 'git cherry-pick -m 1' for non-merge commits, so
    this method to force failure will stop to work.
    
    Use '-m 4' instead as it's very unlikely we will ever have such an
    octopus in this test setup.

	Modified   t/t3510-cherry-pick-sequence.sh
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index c84eeef..a873cf4 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -61,7 +61,8 @@ test_expect_success 'cherry-pick mid-cherry-pick-sequence' '
 
 test_expect_success 'cherry-pick persists opts correctly' '
 	pristine_detach initial &&
-	test_expect_code 128 git cherry-pick -s -m 1 --strategy=recursive -X patience -X ours initial..anotherpick &&
+	m=4 &&
+	test_expect_code 128 git cherry-pick -s -m $m --strategy=recursive -X patience -X ours initial..anotherpick &&
 	test_path_is_dir .git/sequencer &&
 	test_path_is_file .git/sequencer/head &&
 	test_path_is_file .git/sequencer/todo &&
@@ -69,7 +70,7 @@ test_expect_success 'cherry-pick persists opts correctly' '
 	echo "true" >expect &&
 	git config --file=.git/sequencer/opts --get-all options.signoff >actual &&
 	test_cmp expect actual &&
-	echo "1" >expect &&
+	echo "$m" >expect &&
 	git config --file=.git/sequencer/opts --get-all options.mainline >actual &&
 	test_cmp expect actual &&
 	echo "recursive" >expect &&

-- 8< --

-- 
Sergey
