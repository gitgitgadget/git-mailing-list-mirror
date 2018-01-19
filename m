Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C86891F404
	for <e@80x24.org>; Fri, 19 Jan 2018 22:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756647AbeASWOZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 17:14:25 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50727 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756567AbeASWOX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 17:14:23 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4613AC0047;
        Fri, 19 Jan 2018 17:14:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EPLyD+TAxIvT2uacG7Ii4xOrsrk=; b=CCoQXy
        VPudsn1e6cqivCH7Qaq3OuqEKs2vTriN270yH09sk2+bgpZAOpiGQvIv/nevb7EC
        gtvQye0Xu8udJmSkNii/Ffy/Z0nRjVmY2kyILFgpLAWFzVv/BaiUn4j0NYxV5SSZ
        7r6t24x47ORz/aKnzEZaihS26zT64ldzSj2FI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rO3uNayw/DPzpDPDo2WkDNRu7FeS8j0j
        IPlj/bwJFy47Y8FsxV3sOSIWpsB9IVWEj82w8JpsJR9KzKVRMwnKOCNWzYA9sCLJ
        tlUTGtnHMncomF780cX2t7zxZxhiYHPWqLyDHIGrX3TOO7bfI2ODB7HmH9omQXai
        GzAPsESwQL4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E074C0046;
        Fri, 19 Jan 2018 17:14:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A63E2C0045;
        Fri, 19 Jan 2018 17:14:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Mathias Rav <m@git.strova.dk>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] files_initial_transaction_commit(): only unlock if locked
References: <20180118143841.1a4c674d@novascotia>
        <20180118141914.GA32718@sigill.intra.peff.net>
Date:   Fri, 19 Jan 2018 14:14:07 -0800
In-Reply-To: <20180118141914.GA32718@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 18 Jan 2018 09:19:14 -0500")
Message-ID: <xmqqwp0do5sg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11F25658-FD66-11E7-B0D8-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jan 18, 2018 at 02:38:41PM +0100, Mathias Rav wrote:
>
>> Running git clone --single-branch --mirror -b TAGNAME previously
>> triggered the following error message:
>> 
>> 	fatal: multiple updates for ref 'refs/tags/TAGNAME' not allowed.
>> 
>> This error condition is handled in files_initial_transaction_commit().
>> 
>> 42c7f7ff9 ("commit_packed_refs(): remove call to `packed_refs_unlock()`", 2017-06-23)
>> introduced incorrect unlocking in the error path of this function,
>> which changes the error message to
>> 
>> 	fatal: BUG: packed_refs_unlock() called when not locked
>> 
>> Move the call to packed_refs_unlock() above the "cleanup:" label
>> since the unlocking should only be done in the last error path.
>
> Thanks, this solution looks correct to me. It's pretty low-impact since
> the locking is the second-to-last thing in the function, so we don't
> have to re-add the unlock to a bunch of error code paths. But one
> alternative would be to just do:
>
>   if (packed_refs_is_locked(refs))
> 	packed_refs_unlock(refs->packed_ref_store);
>
> in the cleanup section.

Yeah, that may be a more future-proof alternative, and just as you
said the patch as posted would be sufficient, too.

Thanks.
