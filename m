Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9019B1F461
	for <e@80x24.org>; Tue,  9 Jul 2019 19:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfGITjl (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 15:39:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50352 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfGITjl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 15:39:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB314161FFE;
        Tue,  9 Jul 2019 15:39:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xh/af9j6LpLVKLeqHiCiwD351Ik=; b=Jta9p4
        Go2626vX3pe1t/4mKw51/JLs6HhRNfmgU031NQLD70c6kjiYmGGOSmpKYphuEdab
        XLIyRxyvPRN9a8v2r4yfUGJrtBo16hYfZDxkqy77MkMOuBdQTAlUd0SSoBrJhAWj
        P/4pO5DE3KApxC/dtRozsUPgvs3/ZHKJN7xdc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tqxof2QfWguqHN+5xCm7BLcSw3aVF7pJ
        s+RTfqfP/r0LOKjHTXdwywllBtPqOz4rTLIFd094l4TbltoSYp+N8OU+xYyxyrKc
        r59dmgKspl7lqhDQccJQDVLd+yh6ZwIMKnzAzLfxxm1Tews9AHJet/+NLW4XThah
        tvIqg3d++qE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C1F39161FFD;
        Tue,  9 Jul 2019 15:39:38 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 31975161FFC;
        Tue,  9 Jul 2019 15:39:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 07/14] apply: make parse_git_header public
References: <20190705170630.27500-1-t.gummerer@gmail.com>
        <20190708163315.29912-1-t.gummerer@gmail.com>
        <20190708163315.29912-8-t.gummerer@gmail.com>
Date:   Tue, 09 Jul 2019 12:39:37 -0700
In-Reply-To: <20190708163315.29912-8-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Mon, 8 Jul 2019 17:33:08 +0100")
Message-ID: <xmqqimsbuhdy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49AEB2D2-A281-11E9-85F3-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Make parse_git_header a "public" function in apply.h, so we can re-use
> it in range-diff in a subsequent commit.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---

Thanks for these refactoring patches on "apply" machinery in the
early part of the series.  I noticed two small things, though.

 - The apply_state instance *does* represent a state and various
   fields get updated as we read and process the patch.  The smaller
   structure you invented, on the other hand, does not carry any
   "state" at all.  Even its "linenr" field does not get incremented
   as we read/process---you create a new copy to take a snapshot of
   the current state from apply_state.  parse_git_header_data may
   have been a name that reflects the nature of the structure
   better.

 - I wonder if it makes the concept clearer if you did not create a
   new instance outside the apply_state, but instead replaced the
   three fields in the apply_state with an instance of this new
   structure.  When you call an API function with shrunk interface,
   you'd pass a pointer to a field inside the apply_state instance,
   instead of copying three fields manually.

But other than that, I think these patches are generally moving bits
in the right direction.

I do not have strong opinions on the later part of the series on
range-diff proper.

Thanks.
