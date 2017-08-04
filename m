Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDCE42047F
	for <e@80x24.org>; Fri,  4 Aug 2017 21:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752205AbdHDVSY (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 17:18:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54708 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752068AbdHDVSX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 17:18:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 89899A46EB;
        Fri,  4 Aug 2017 17:18:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rfl3MLJ92uNos2JTAzjYcPRttEA=; b=CXgtO0
        /J5t8bEVwVCgqr3DauDuxJG6XU4KAlC22Q1ohkwq7xiBdZ0wY01aLIwYgPMOA17E
        lRCXyNIO/+NsGL5REuyJ6lRsrLKFkhRn7+x0FHQzfBkmuNOvoNzuomWfhjuTAjQP
        pMiNVEPmE9/Drs7MrRZlEYgQ5IAVMhChEk8Y8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OKOZz6QwCQlN/AJ+tI6dSpCj6Ao4Y9l7
        9nH9NHAfxZ+b8XRziLtqfCa3JK/6Hl/zVMRKnPgWiCAUrN8fplRjWr8/hRYot0MT
        cTPz3RMyv47wUVqU+DL5cC8CdK0OJOPWcaJpjfzSajeu7+6uLNypF+POKtF11vfg
        2/2c+l1fG7w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8181AA46EA;
        Fri,  4 Aug 2017 17:18:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E0570A46E9;
        Fri,  4 Aug 2017 17:18:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>,
        git@vger.kernel.org
Subject: Re: [RFC] imap-send: escape backslash in password
References: <58b783d6-c024-4491-2f88-edfb9c43c55c@morey-chaisemartin.com>
        <xmqqbmnvtain.fsf@gitster.mtv.corp.google.com>
        <87bmnvktee.fsf@linux-m68k.org>
        <20170804202255.3oia7ivsoa6vu4me@sigill.intra.peff.net>
Date:   Fri, 04 Aug 2017 14:18:13 -0700
In-Reply-To: <20170804202255.3oia7ivsoa6vu4me@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 4 Aug 2017 16:22:55 -0400")
Message-ID: <xmqq3797t4kq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D81B9B8-795A-11E7-AFFD-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It's been a long time since I've done anything with IMAP, but I think
> another alternative would be to send it as a "literal", like:
>
>   {6}
>   foobar
>
> That's relatively easy to format correctly using the current printf
> specifiers that imap_exec() takes. Though as I said elsewhere in the
> thread, perhaps imap_exec() should provide a different interface.

Yes, I was scanning the RFC and came to the same conclusion ;-)

> I also think it might be reasonable to scrap all of this ad-hoc imap
> code in favor of curl, which already gets these cases right. We already
> have a curl-backed implementation. I think we just left the old code out
> of conservatism. But it seems somewhat buggy and unmaintained, and I
> wonder if we aren't better off to simply encourage people to install
> curl.

That is a very attractive direction to go in, especially in the mid
to longer term.  Perhaps we declare that the ad-hoc hardcoded imap
is deprecated in the next cycle and drop the support by the end of
this year?

