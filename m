Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A10C433F5
	for <git@archiver.kernel.org>; Sat, 25 Dec 2021 00:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhLYAGX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 19:06:23 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51799 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhLYAGW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 19:06:22 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DFFA11740D7;
        Fri, 24 Dec 2021 19:06:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EupUPXD01O5LmzR3EcFZmgYHKRXJ+RPVZsgD6i
        7e8A4=; b=a3KPM1AlRYUdpLDPUz2VxuMgaSvuCK9lR+ZZpIyMcr9z2bonEopL09
        E9dmyol3pM3Q20jv5hKlDzrpauT+pzowVCSrzGLCHNplcxxZQrkmCrC7KTvAULFO
        WlEj6qQKY1pQzIunJZECUw5cRXLB7k5SaFKAyaq/P6JrpeM6EZQt0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D980D1740D6;
        Fri, 24 Dec 2021 19:06:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2B5311740D5;
        Fri, 24 Dec 2021 19:06:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re* [PATCH v5 3/7] grep tests: add missing "grep.patternType"
 config test
References: <cover-v4-0.7-00000000000-20211203T101348Z-avarab@gmail.com>
        <cover-v5-0.7-00000000000-20211222T025214Z-avarab@gmail.com>
        <patch-v5-3.7-f02f246aa23-20211222T025214Z-avarab@gmail.com>
        <xmqq35mj7yd4.fsf@gitster.g>
Date:   Fri, 24 Dec 2021 16:06:13 -0800
In-Reply-To: <xmqq35mj7yd4.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        23 Dec 2021 14:25:11 -0800")
Message-ID: <xmqqfsqh35vu.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79FC8E96-6516-11EC-886D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The grep.patternType configuration variable has the "last one wins"
> semantics just all the usual configuration variable, but the meaning
> of the variable when it is set to "default" depends on the value set
> to grep.extendedRegexp variable.
>
> If you rewrite with the above understanding, what you wrote will
> become a lot more concise.
>
>     Extend the grep tests to assert that grep.patternType is the
>     usual "last one wins" variable, and specifically, setting it to
>     "default" has the same meaning as setting it to "basic" when
>     grep.extendedRegexp is not set (or set to false).

Also, it is probably a good idea to strees that grep.extendedRegexp
is also "last one wins", so as I wrote in a separate message, Git
finds the last one for grep.extendedRegexp and grep.patternType
independently and combines these last values to come up with the
pattern type it uses.

I'll tentatively queue the following patch between your 3/7 and 4/7,
but it probably is a good idea to squash it into 3/7, as it belongs
to the same theme: clarify how these two variables are meant to
interact with each other.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
Subject: [PATCH] t7810: make sure grep.extendedRegexp is also last-one-wins

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7810-grep.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 113902c3bd..2c17704e01 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -451,6 +451,16 @@ do
 		test_cmp expected actual
 	'
 
+	test_expect_success "grep $L with grep.extendedRegexp is last-one-wins" '
+		echo "${HC}ab:a+bc" >expected &&
+		git \
+			-c grep.extendedRegexp=true \
+			-c grep.patternType=default \
+			-c grep.extendedRegexp=false \
+			grep "a+b*c" $H ab >actual &&
+		test_cmp expected actual
+	'
+
 	test_expect_success "grep $L with grep.patternType=extended and grep.patternType=default" '
 		echo "${HC}ab:a+bc" >expected &&
 		git \
-- 
2.34.1-563-g3368a7891b

