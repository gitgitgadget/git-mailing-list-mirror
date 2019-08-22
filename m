Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 992191F461
	for <e@80x24.org>; Thu, 22 Aug 2019 16:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389916AbfHVQZB (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 12:25:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64533 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389875AbfHVQYu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 12:24:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9FA64175BF3;
        Thu, 22 Aug 2019 12:24:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qTMIkwMIVtaRR83mR28OZkcKSLo=; b=G7Apf8
        UDLfGBg0YOegcydzS+AMBzLexOWKnjgx/qi+WRfnuBrWz2L1bdVLCWrBscaJ6BWX
        r57e/2+WW9h7f5QzlE0WCn4fx3DCyXngIeP94+SWuEgGGKXegANquUVnhFMWyygh
        bs9cj81L7LMzax8I8pBZOd9CNN4BOemomc6IY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S7dAEXOq/APt2uaXaEZduOeu1xYQnAA9
        NB4dPMJNuHBP721mXGfoK0dC1BdDx1zCj9tkhyqCtjM+ZTJzeD/JMC6UNLevi1yo
        0SZ75cctLdPhGXJ1fDxEtqMAOAQJPCoJ3PBQyyjQqnVR78+9pH6flxlnYXVv1jt3
        EEwZJmCF2PQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9734C175BF2;
        Thu, 22 Aug 2019 12:24:49 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0B9AF175BF1;
        Thu, 22 Aug 2019 12:24:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Giuseppe =?utf-8?Q?Crin=C3=B2?= <giuscri@gmail.com>,
        git@vger.kernel.org
Subject: Re: [BUG] You can't have single quote in your username
References: <CAGV3M55WAQOAOiZPPgR+6p2EVzakrbz1gYAMh-BqxCVDeLCq9w@mail.gmail.com>
        <20190822150614.o25g37pwfcaos2zn@localhost.localdomain>
Date:   Thu, 22 Aug 2019 09:24:48 -0700
In-Reply-To: <20190822150614.o25g37pwfcaos2zn@localhost.localdomain> (Pratyush
        Yadav's message of "Thu, 22 Aug 2019 20:36:14 +0530")
Message-ID: <xmqqy2zlp3qn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C949E62-C4F9-11E9-BCC3-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> This strbuf_addstr_without_crud() function removes various characters 
> from the start and end of the author info, one of which is the single 
> quotation. I'm not sure why this is done, the more experienced folk 
> where will have the answer.

The logic there exists in order to remove cruft around the name on a
typical e-mail header (remember, most of the very core-ish part of
the Git was written and got solidified back when the Linux kernel
was the primary client of the system, and many commits were created
via "am"), e.g. sender's mail client may send something like this:

    From: 'Foo bar Baz' <my@name.xz>

and we do not want to take surrounding sq pair as part of the name.
