Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA6861F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 22:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751107AbdARWnN (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 17:43:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62343 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750874AbdARWnL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 17:43:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC852602D7;
        Wed, 18 Jan 2017 17:42:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=96vlIAKlV4+j1PaCWL8N4Wd9BQY=; b=dm6rbP
        UssfdLUQ7QHFAwl01M3/fpueZzSIHDPqTU++Hl6eEO9IE/RfsO03T67zJyBM2Sxp
        /cFkDn7RveYqKlcJ4ZXe6G6T5budcu3ETv54jHFvfaHQyMjlj0q33e9iD8H/zp7L
        +4ufqhu9Qdf66PMyUNeWOmcMrv/tyi36zcHYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mWQTPxJRZDboRJr1fmxt4KbP+UXpudvL
        /ZuoypkUvfDxC4h/7fip2Iro/wQ37T1rBV9wg8rqFkO7CjOu6uYuginooVcZXmSw
        JGs3RKSZriTEIfdqKjeA/m8SwmwAslHZ/Zi6xk/YVbDF5ERO+QUuJbvq7ho66PJK
        ati4ghdI5uE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A2D75602D6;
        Wed, 18 Jan 2017 17:42:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 16AFE602D4;
        Wed, 18 Jan 2017 17:42:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/5] name-rev: extend --refs to accept multiple patterns
References: <20170118000930.5431-1-jacob.e.keller@intel.com>
        <20170118000930.5431-3-jacob.e.keller@intel.com>
        <xmqqy3y8878k.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xpMAVq8K41cDZy5FTiRTHoWWd3yOSmLoj4ucAvCPoNa0g@mail.gmail.com>
Date:   Wed, 18 Jan 2017 14:42:29 -0800
In-Reply-To: <CA+P7+xpMAVq8K41cDZy5FTiRTHoWWd3yOSmLoj4ucAvCPoNa0g@mail.gmail.com>
        (Jacob Keller's message of "Wed, 18 Jan 2017 13:12:37 -0800")
Message-ID: <xmqqpojk2dnu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 656EF212-DDCF-11E6-9B55-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Wed, Jan 18, 2017 at 12:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> I agree that we cannot short-cut on the first match to make sure
>> that the outcome is stable, but I wondered what should be shown when
>> we do have multiple matches.  Say I gave
>>
>>     --refs="v*" --refs="refs/tags/v1.*"
>>
>> and refs/tags/v1.0 matched.  The above code would say we can
>> abbreviate.
>>
>> What is the reason behind this design decision?  Is it because it is
>> clear that the user shows her willingness to accept more compact
>> form by having --refs="v*" that would allow shortening?  If that is
>> the case, I think I agree with the reasoning.  But we probably want
>> to write it down somewhere, because another reasoning, which may
>> also be valid, would call for an opposite behaviour (i.e. the more
>> specific --refs="refs/tags/v1.*" also matched, so let's show that
>> fact by not shortening).
>
> I'm not sure which reasoning makes most sense. Any other opinions?

FWIW, I do think that the design decision to declare that it can be
abbreviated if the ref matches at least one short pattern makes
sense, and I am guessing (because you didn't answer when asked what
_your_ reasoning behind the code was) that you are in agreement.  I
just want it to be spelled out probably as in-code comment, so that
people who later come to this part of the code know why it was
designed that way.  And they can disagree and change it if the end
result is better---I just want to make sure that they can understand
what they are disagreeing when it happens, as opposed to them
scratching their head saying "we do not know why it was chosen to be
done this way, let's make a random change to make it behave
differently".
