Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919BDECAAA1
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 16:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiIPQOz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 12:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiIPQOw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 12:14:52 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC26332DB5
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 09:14:50 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD083135503;
        Fri, 16 Sep 2022 12:14:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Gh4r0Csb+e12WzA1M2NSZUTBHWoPRVdJJ8Y6Cj
        QC4ZA=; b=neHdraDo/NvPNO8r9g/wOtMxjdJFlyhxegGvCIL2TA+dirN9TDabfC
        X3e3GVzm47V8M57a+OhZiKtvQppuauEMeQTYmZEQYAZa7vsaG3vCpUBzFwgbsCUB
        yExpRAXTsdl1qYf8IieYvk3nm91o/MWHic7Yk4NCpGH2NVVxdi6M0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3D6F135502;
        Fri, 16 Sep 2022 12:14:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 26DAF135501;
        Fri, 16 Sep 2022 12:14:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] diff-merges: cleanup func_by_opt()
References: <20220914193102.5275-1-sorganov@gmail.com>
        <20220914193102.5275-2-sorganov@gmail.com>
        <xmqqfsgsmq4j.fsf@gitster.g> <87wna3jwx8.fsf@osv.gnss.ru>
Date:   Fri, 16 Sep 2022 09:14:48 -0700
In-Reply-To: <87wna3jwx8.fsf@osv.gnss.ru> (Sergey Organov's message of "Fri,
        16 Sep 2022 16:01:07 +0300")
Message-ID: <xmqqy1uji9dz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B01631CC-35DA-11ED-A056-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>>> Get rid of unneeded "else" statements in func_by_opt().
>>
>> While it is true that loss of "else" will not change what the code
>> means, this change feels subjective and I'd say it falls into "once
>> committed, it is not worth the patch noise to go in and change"
>> category, not a "clean-up we should do".
>
> I agree the "else" vs "no else" is subjective, but the problem in fact
> is that the first "if", unlike the rest of them, already had no "else",
> making the code inconsistent.

This is a static helper function about a single "optarg" string that
wanted to say "switch(optarg) { case "off": ... }" but couldn't in
C, and I happen to view if strcmp else if strcmp ... sequence on the
same string a poor-man's substitute for such a construct.  So my
take of it is to call the second "if" not being "else if" a problem,
not the rest of it.  If we add a new condition on a different input,
making it "if (x) ...; switch(optarg) { ... }" that talks about
something other than optarg, then writing it all with "if" without
"else if" would make it harder to see the pattern, but I do not care
too deeply either way, because this is unlikely to gain any logic
more involved than "switch(optarg) { ... }".

> So the fix should either be adding one
> "else" to the first "if", or remove all of the "else". I chose the
> latter, to end up with less noisy code.

Yup, see above for the reason why I would choose else-if cascade if
I had to but I do not care too deeply either way in this particular
case ;-)
