Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 573B320279
	for <e@80x24.org>; Thu,  2 Mar 2017 22:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbdCBWet (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 17:34:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65443 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750915AbdCBWes (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 17:34:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2949D85D1C;
        Thu,  2 Mar 2017 16:39:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g0e/0wYrcjUyZ3C1p7xWof9j57M=; b=ATDa/V
        Cq7sMf0IsqVdc5v9WDvqKA3EehLlXrYBA1VWLOczzqs64ulZjwH6nc2wgplRiwzn
        cGIAujycB53B+CQe/k3FbVac+a0pxDzN6rL9o4wPX+nn7O46Ms+8J+VpMpUdfyyu
        uJuuieHTc7u/MH2O/9E0KHF3RDPoqVc7axTWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qJlQM+7FX1L4yL9q4LO/jn69y7KlJexm
        26zQ8PWWk67pglLrrVYOvjC9UtdGR830+CblVWanAMJyjkH0u32oQ0Gcdfm3LWgv
        10/M7msGnsIrrrgLHvVmaXrMFSugXwv36iYjX87Xwah/Fr4AWUv7xj6G+iNfw5xM
        JvTR7/kOnFI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FFC785D1B;
        Thu,  2 Mar 2017 16:39:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 40A6485D19;
        Thu,  2 Mar 2017 16:39:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Devin J. Pohly" <djpohly@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 3/4] filter-branch: fix --prune-empty on parentless commits
References: <20170223082736.31283-1-djpohly@gmail.com>
        <20170223082736.31283-3-djpohly@gmail.com>
        <xmqqbmts7gjm.fsf@gitster.mtv.corp.google.com>
        <20170223213333.GA3490@prospect.localdomain>
        <xmqqshmvbhe5.fsf@gitster.mtv.corp.google.com>
        <20170302211804.GB3490@prospect.localdomain>
Date:   Thu, 02 Mar 2017 13:39:19 -0800
In-Reply-To: <20170302211804.GB3490@prospect.localdomain> (Devin J. Pohly's
        message of "Thu, 2 Mar 2017 15:18:04 -0600")
Message-ID: <xmqqbmtjbbp4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1B891E0-FF90-11E6-B2D9-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Devin J. Pohly" <djpohly@gmail.com> writes:

> On Thu, Mar 02, 2017 at 11:36:18AM -0800, Junio C Hamano wrote:
>> "Devin J. Pohly" <djpohly@gmail.com> writes:
>> 
>> > I think your point is interesting too, though.  If a commit is also
>> > TREESAME to its parent(s?) in the _pre-filtered_ branch, it seems
>> > reasonable that someone might want to leave it in the filtered branch as
>> > an empty commit while pruning empt*ied* commits.  I would imagine that
>> > as another option (--prune-newly-empty?).
>> 
>> I was hoping to hear from others who may care about filter-branch to
>> comment on this topic to help me decide, but I haven't heard
>> anything, so here is my tentative thinking.
>> 
>> I am leaning to:
>> 
>>  * Take your series as-is, which would mean --prune-empty will
>>    change the behaviour to unconditionally lose the empty root.
>> 
>>  * Then, people who care deeply about it can add a new option that
>>    prunes commits that become empty while keeping the originally
>>    empty ones.
>> 
>> Thoughts?
>
> Sounds good to me.  I would be willing to work on a new option if needed
> (to "atone" for changing existing behavior), so you can loop me in if
> there are any complaints.

Thanks.  I'll wait for others who know filter-branch better than me
to say something for a few days before doing anything, though.
