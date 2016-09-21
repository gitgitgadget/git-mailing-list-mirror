Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEAD91F935
	for <e@80x24.org>; Wed, 21 Sep 2016 21:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756735AbcIUVM5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 17:12:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55274 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754886AbcIUVM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 17:12:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A38640861;
        Wed, 21 Sep 2016 17:12:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mpoxM6+VQZw9uSZLq4nUfadxoiM=; b=onxcD7
        Mf1bW9hEnlGaEyimRKtWZIUCGtaIP3113Sx/ygeUMjf3sesh/gYUNAJTfwtHe+B0
        Y2xDd5eM0JUoAeQZq/jB8dMxosxx1pAleqaI06hbOBWPL6tcFKQ2unIMAwC3FSa+
        P4pV+/g1Xet3ZQc9cxbDDrkPpNMnFoIXplPO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mVJAMZTpcLfEGbh3ja2md11WNu1U4bXQ
        efySqd5URz9W8GtsJ39DaYt3YVKPcWrigFUE20pZ7jdJT9GoveIFijzjb7c8HJi4
        1i9OVvEPlPB1COmDuL5lva0CuMsE+oCVOSjY0yq9fffy+Jc73LkYwKBeQwOy5PeB
        /jZ//msG+Jc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7029140860;
        Wed, 21 Sep 2016 17:12:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E496F4085E;
        Wed, 21 Sep 2016 17:12:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH tg/add-chmod+x-fix 2/2] t3700-add: protect one --chmod=+x test with POSIXPERM
References: <cee3c784-8f03-c524-2f67-d35cb3755a41@kdbg.org>
        <5effaf36-d017-3ff1-1de1-d9b303c04f23@kdbg.org>
        <20160920193444.GG8254@hank>
        <xmqqtwd986ml.fsf@gitster.mtv.corp.google.com>
        <xmqqa8f16kup.fsf@gitster.mtv.corp.google.com>
        <c3aefd9d-b794-21a1-619e-bce6a3c2cf47@kdbg.org>
Date:   Wed, 21 Sep 2016 14:12:52 -0700
In-Reply-To: <c3aefd9d-b794-21a1-619e-bce6a3c2cf47@kdbg.org> (Johannes Sixt's
        message of "Wed, 21 Sep 2016 22:58:55 +0200")
Message-ID: <xmqq60pp6jor.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29D5E180-8040-11E6-AB41-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> But I came to a different conclusion as I said in a message that
> crossed yours. I hope Thomas can pick up the baton again.

Yeah, our mails crossed, apparently, and I do agree with your
reasoning.  How about this, then?

-- >8 -- 
From: Johannes Sixt <j6t@kdbg.org>
Date: Tue, 20 Sep 2016 08:18:25 +0200
Subject: [PATCH] t3700-add: do not check working tree file mode without POSIXPERM

A recently introduced test checks the result of 'git status' after
setting the executable bit on a file. This check does not yield the
expected result when the filesystem does not support the executable
bit.

What we care about is that a file added with "--chmod=+x" has
executable bit in the index and that "--chmod=+x" (or any other
options for that matter) does not muck with working tree files.
The former is tested by other existing tests, so let's check the
latter more explicitly and only under POSIXPERM prerequisite.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3700-add.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 16ab2da..924a266 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -361,13 +361,11 @@ test_expect_success 'git add --chmod=[+-]x changes index with already added file
 	test_mode_in_index 100644 xfoo3
 '
 
-test_expect_success 'file status is changed after git add --chmod=+x' '
-	echo "AM foo4" >expected &&
+test_expect_success POSIXPERM 'git add --chmod=[+-]x does not change the working tree' '
 	echo foo >foo4 &&
 	git add foo4 &&
 	git add --chmod=+x foo4 &&
-	git status -s foo4 >actual &&
-	test_cmp expected actual
+	! test -x foo4
 '
 
 test_expect_success 'no file status change if no pathspec is given' '
-- 
2.10.0-515-g9036219

