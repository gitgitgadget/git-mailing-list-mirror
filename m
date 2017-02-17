Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F05D201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 23:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964847AbdBQXhC (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 18:37:02 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65302 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S964844AbdBQXhA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 18:37:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CAC06A3A9;
        Fri, 17 Feb 2017 18:36:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Fu1HBt7vciNsJeR55qr49QPQE+U=; b=jSebS2
        zQ1lEcUmPZq6Z33blMyWMD3FBeN3Eui9+rElx5jhvqSv+YogSkgepZk3ZSFBMV9s
        cHfJQ9ha2kZIRHqaqFd/wjTBOd348439mgDJ4b/iSlNvcU6R60ko45RfBqyPvZxk
        tty7hhWFu56bnUp4warTDkIax2uWlCz36K4i0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F84A6A3A7;
        Fri, 17 Feb 2017 18:36:01 -0500 (EST)
Received: from localhost (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A50706A3A6;
        Fri, 17 Feb 2017 18:36:00 -0500 (EST)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] delete_refs(): accept a reflog message argument
In-Reply-To: <xmqqshncu4r4.fsf@gitster.mtv.corp.google.com>
References: <20170126211205.5gz3zsrptop7n34n@sigill.intra.peff.net> <20170217035800.13214-1-kyle@kyleam.com> <20170217035800.13214-2-kyle@kyleam.com> <20170217081205.zn7j6d5cffgdvfbn@sigill.intra.peff.net> <xmqqshncu4r4.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 17 Feb 2017 18:35:59 -0500
Message-ID: <874lzsqtk0.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6E2F0E0-F569-11E6-ACB7-A7617B1B28F4-24757444!pb-smtp2.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=Fu1HBt7vciNsJeR55qr49QPQE+U=; b=WjkfJg3RcHoK4Bgg/YYJJkcqJUGK+8s9PL2w0ZUB5jeQw3YSAYxm46WbbU+kW01iGoyI73FbYXDfFMV0RgP/iFCylC/ySVE/U85xyz14Byj2gsz3ruH6q1BUXeq/uuW6a4m+1xRJ9CVXC7qfXstu9lx5BfWelWGeunA2Iim2Zj4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>>> diff --git a/refs.h b/refs.h
>>> index 9fbff90e7..81627a63d 100644
>>> --- a/refs.h
>>> +++ b/refs.h
>>> @@ -277,7 +277,7 @@ int reflog_exists(const char *refname);
>>>   * be NULL_SHA1. flags is passed through to ref_transaction_delete().
>>>   */
>>>  int delete_ref(const char *refname, const unsigned char *old_sha1,
>>> -	       unsigned int flags);
>>> +	       unsigned int flags, const char *msg);
>>
>> Should the "msg" argument go at the beginning, to match update_ref()?
>
> Probably.  rename/create have the message at the end but their
> parameters are very different from update/delete.  The parameters
> update and delete take are not identical, but we can view them as a
> lot more similar than the other two.  So I think it makes sense for
> delete to try matching update, even though trying to make all four
> the same may proabably be pointless.

I put "msg" after "flags" because that's where it occurs in
ref_transaction_delete(), but matching update_ref() makes sense.

-- 
Kyle
