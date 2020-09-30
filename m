Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A049C4363D
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 21:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAD7720888
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 21:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="b9i1x9rD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731274AbgI3V5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 17:57:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52443 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730470AbgI3V5d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 17:57:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F070101B2D;
        Wed, 30 Sep 2020 17:57:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=icfIK8/jBWrxEB37O/JFPWnHUIo=; b=b9i1x9
        rDln/CTL1UsxTAnsIyyfXu84cG+sXF7ipLOBw5W6fnG80C2WQ5Uyo9KhWiVnQ95y
        8TPdn+folU12Eey9oiwy+DSYZDLJ+tY+bEnCda6Nm2ptEke1JdqpZjvHSgVmHrq/
        6vNWdahhgUiiKZibZDIYIYwwPO55afwtAiMJM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ASw7HlqRn7qN0zLvekUBo8fiyuiBYhZS
        6+OH8Tjn5mMywnx970AEaQpO5UXBcgcgALYgyE3gZOUWaEmu10H4XurNFPsahjf9
        0i+BQv+iBRboKlFxrP0nZ/ZDb6iKVIZDiT1zwlxnqs3dF4IyqHMxeAFVD1OxuNRW
        zas5VVV/N2k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 77120101B2C;
        Wed, 30 Sep 2020 17:57:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C2385101B2B;
        Wed, 30 Sep 2020 17:57:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [v4] refspec: add support for negative refspecs
References: <20200930212529.100458-1-jacob.e.keller@intel.com>
        <CAPig+cQUeQV0=LDQ_tY43k6z7km4X6Fm9JJVPUBoG=wY3gxDfw@mail.gmail.com>
Date:   Wed, 30 Sep 2020 14:57:27 -0700
In-Reply-To: <CAPig+cQUeQV0=LDQ_tY43k6z7km4X6Fm9JJVPUBoG=wY3gxDfw@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 30 Sep 2020 17:34:02 -0400")
Message-ID: <xmqqr1qjexmg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EED0A2D2-0367-11EB-B8B1-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Sep 30, 2020 at 5:26 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
>> Changes since v3
>> * removed the ?: usage (for real this time)
>>
>> +               /* Note the reversal of src and dst */
>> +               if (refspec->pattern) {
>> +                       const char *key = refspec->dst ?: refspec->src;
>
> Blorp.

Woof.

Have squashed this in.

 remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 9f8b25674e..dad3b79332 100644
--- a/remote.c
+++ b/remote.c
@@ -750,7 +750,7 @@ static int query_matches_negative_refspec(struct refspec *rs, struct refspec_ite
 
 		/* Note the reversal of src and dst */
 		if (refspec->pattern) {
-			const char *key = refspec->dst ?: refspec->src;
+			const char *key = refspec->dst ? refspec->dst : refspec->src;
 			const char *value = refspec->src;
 
 			if (match_name_with_pattern(key, needle, value, &expn_name))
