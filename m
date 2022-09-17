Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A7DECAAA1
	for <git@archiver.kernel.org>; Sat, 17 Sep 2022 00:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiIQAqY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 20:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIQAqX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 20:46:23 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD449E685
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 17:46:22 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF4ED14AB8A;
        Fri, 16 Sep 2022 20:46:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kY2tXAtXVHdIL6e9IrGCl319VHh+J5RUv7mOEf
        kvTrA=; b=sOju3/Epf8GSz3UzydXpvfgVBmkRCrOZVmwcNCW294IjnA3oMr+Aww
        86dUnmFEvx24Oe16Yjsl5OXORlZ02x4ZBHyH9FbBX4+JJaxoazEO//vLdrx1d/oJ
        UhiLWgdFEzLkD5pAR1zzec4aLWGFpRyueBLqSJGbrCTCPEMEH7FKI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C580814AB89;
        Fri, 16 Sep 2022 20:46:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0578B14AB88;
        Fri, 16 Sep 2022 20:46:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     rsbecker@nexbridge.com, 'Git Mailing List' <git@vger.kernel.org>
Subject: Re: [BUG] Non-portable Construct Introduced in diagnose.c (dirent)
 at v2.38.0-rc0
References: <011001d8ca20$bc4d81f0$34e885d0$@nexbridge.com>
        <5d02d3b8-dc79-a2d8-f5e1-129d2228ff23@github.com>
Date:   Fri, 16 Sep 2022 17:46:19 -0700
In-Reply-To: <5d02d3b8-dc79-a2d8-f5e1-129d2228ff23@github.com> (Victoria Dye's
        message of "Fri, 16 Sep 2022 16:11:23 -0700")
Message-ID: <xmqqtu56eskk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25DDAAF6-3622-11ED-B138-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> rsbecker@nexbridge.com wrote:
>> The dirent d_type field is not available on every system. This was
>> introduced at 2.38.0-rc0 in diagnose.c
>> 
>> diagnose.c, line 79: error(1565): struct "dirent" has no field "d_type"
>> 
>>   		    e->d_type == DT_DIR && strlen(e->d_name) == 2 &&
>> 
>> (3 more issues in diagnose exist of this form).
>> 
>> The code should use the  NO_D_TYPE_IN_DIRENT knob to detect whether this is
>> an existing field as defined in cache.h.

Also, even if d_type member exists in the dirent struct, the value
can be DT_UNKNOWN and the code should be prepared to fall back to do
lstat() on the path in such a case.

dir.c::resolve_dtype() can be looked at for inspiration but only for
inspiration and not for copying (because it is about tracked working
tree paths, the function does a lot more than what diagnose.c wants
to).

> Apologies for missing that, I'll try to send a patch fixing it either later
> today or sometime Monday.

Thanks, both of you.

