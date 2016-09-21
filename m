Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAFE220985
	for <e@80x24.org>; Wed, 21 Sep 2016 20:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933698AbcIUUrr (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 16:47:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62450 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933443AbcIUUrq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 16:47:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DFCCA3EEF0;
        Wed, 21 Sep 2016 16:47:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZB2pilkzzbFALY6/IznC2SyccnU=; b=hp7VFa
        ePL5wG4nk8QijuRahL5BvbHhPCO2+l0w5CnH1/YdTnxNFb4awbrZvggIguSRzZIa
        FcHfLTbGWUf/x9A1+CmiqLsN6pZmVE73dmm2ZTj7+fAjfKZZR1ztKIw90RAtaCPb
        2qH2+ALY3IcZkDkdvC+SC8BprJSPkfY4W6a84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G9O3cjGSkAtM3l+4SsrGYRSgygcqP10g
        F5sJNCg6OUtc1BiGLQ5nUvseLgXFRxk9faX7kGKIyROMOIfhy7hyCizLqZ6gHCCb
        uiBlCj1w0LJ/BDQN28r7dyxI7O92JcNuhpoMRtQOvO2b2/9RSMtWBx4KxDWM68dP
        BYcYkJLIxCE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CE8DA3EEEE;
        Wed, 21 Sep 2016 16:47:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5669C3EEEC;
        Wed, 21 Sep 2016 16:47:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH tg/add-chmod+x-fix 2/2] t3700-add: protect one --chmod=+x test with POSIXPERM
References: <cee3c784-8f03-c524-2f67-d35cb3755a41@kdbg.org>
        <5effaf36-d017-3ff1-1de1-d9b303c04f23@kdbg.org>
        <20160920193444.GG8254@hank>
        <xmqqtwd986ml.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 21 Sep 2016 13:47:42 -0700
In-Reply-To: <xmqqtwd986ml.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 21 Sep 2016 11:12:02 -0700")
Message-ID: <xmqqa8f16kup.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A574B220-803C-11E6-8DEF-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...  Comparing the index with the working tree using "status"
> is probably not how you would want to do so.  A future breakage may
> cause the indexed blob name to change by mistake, and status would
> happily report difference but you would not notice its output is
> saying "Hey, they are different between the index and the working
> tree", while you are expecting ONLY the change in the executable bit.

In other words, how about doing it this way?

-- >8 --
From: Johannes Sixt <j6t@kdbg.org>
Date: Tue, 20 Sep 2016 08:18:25 +0200
Subject: [PATCH] t3700-add: do not rely on executable bit of the working tree file

A recently introduced test checks the result of 'git status' after
setting the executable bit on a file. This check does not yield the
expected result when the filesystem does not support the executable
bit.

The primary thing we care about is that a file added with --chmod=+x
has executable bit in the index, not that it is registered in the
index somehow differently from what is in the working tree, which
is what the "status" output tries to catch.  Let's check what we
care about, i.e. the path is marked as an executable in the index.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3700-add.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 16ab2da..1a733bb 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -361,13 +361,11 @@ test_expect_success 'git add --chmod=[+-]x changes index with already added file
 	test_mode_in_index 100644 xfoo3
 '
 
-test_expect_success 'file status is changed after git add --chmod=+x' '
-	echo "AM foo4" >expected &&
+test_expect_success 'git add --chmod=[+-]x changes index with newly added file' '
 	echo foo >foo4 &&
 	git add foo4 &&
 	git add --chmod=+x foo4 &&
-	git status -s foo4 >actual &&
-	test_cmp expected actual
+	test_mode_in_index 100755 foo4
 '
 
 test_expect_success 'no file status change if no pathspec is given' '
-- 
2.10.0-515-g9036219

