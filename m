Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C783BC433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 07:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C2561C14
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 07:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhKOHDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 02:03:35 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54747 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhKOHDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 02:03:25 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A69E8156A2B;
        Mon, 15 Nov 2021 02:00:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=JgCw+TH6R9KKqrMKgbWWusl3TWsffOKeUbaMTTw6d1o=; b=DWaJ
        l31xwepnlM07qp/ikSdSoIKw5Gw5jRylPTmL8+ovgauL2PAW4+6mpY/VAueUWsqJ
        4XmUkHLd4pVBSpR3nCmOa9v2RB8kIfmbriNnAxnoC6MXkU+VQSgdNX/4lotPsFDt
        ywGRSjtpdUy2ArIHdZDqRye+sEV+MkmFnCGFsOg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9F8BB156A2A;
        Mon, 15 Nov 2021 02:00:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0EEFC156A29;
        Mon, 15 Nov 2021 02:00:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH 0/1] Add a test balloon for C99
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
Date:   Sun, 14 Nov 2021 23:00:25 -0800
Message-ID: <xmqqy25pj43a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B656E976-45E1-11EC-88C8-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Even for users who would like to target an older version of Windows,
> such as the no longer supported Windows 7, GCC and Clang are available.
> The LLVM suite, including Clang, is available pre-compiled for download
> free of charge.  Using a different compiler is specifically proposed by
> Microsoft staff[1] as a solution for users who wish to build modern
> programs for MSVC versions which do not support modern C.
>
> As such, we can assume that Git can be safely compiled with C99 or C11
> support on all operating systems which receive security support, and
> even some which do not.  Our CI confirms that this series passes all
> tests.  Let's introduce a test balloon which checks for this support and
> fails with an error message if it is absent.

I do not have much against adopting nicer C99 language features in
principle, but I hope that we are not becoming too Linux centric
with "other than Linux, as long as Windows is OK in some form,
everything is peachy" mentality.

If there is a rogue implementation that claims to do C99 with
STDC_VERSION without properly supporting some language constructs we
care about, that would be bad.  That is why I tend to prefer the
approach we have taken so far, validating selected features we care
about one by one with pointed weather balloon tests, over "the
compiler says it supports that version, so we trust them".

Perhaps we can do this, and a more pointed "break compilers without
variable decl in for() loop" change, at the same time.  After the
latter turns out to be noise free, we can update CodingGuidelines.

Even when we clear C99 as the whole, I'd be hesitant to allow
certain things from the language (not because compilers do not grok
them, but purely from style and readability point of view).  For
example, -Wdecl-after-statement is a good discipline to follow even
if your compiler allows them.

Thanks.


 Documentation/CodingGuidelines | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuidelines
index 45465bc0c9..5c32b29949 100644
--- c/Documentation/CodingGuidelines
+++ w/Documentation/CodingGuidelines
@@ -205,15 +205,16 @@ For C programs:
    . since mid 2017 with 512f41cf, we have been using designated
      initializers for array (e.g. "int array[10] = { [5] = 2 }").
 
+   . since early 2022 with YYYYYYY, we have been using variable
+     declaration in the for loop (e.g. "for (int i = 0; i < 10;
+     i++)").
+
    These used to be forbidden, but we have not heard any breakage
    report, and they are assumed to be safe.
 
  - Variables have to be declared at the beginning of the block, before
    the first statement (i.e. -Wdeclaration-after-statement).
 
- - Declaring a variable in the for loop "for (int i = 0; i < 10; i++)"
-   is still not allowed in this codebase.
-
  - NULL pointers shall be written as NULL, not as 0.
 
  - When declaring pointers, the star sides with the variable
