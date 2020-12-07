Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF682C433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 983812388D
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgLGT5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 14:57:38 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56983 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgLGT5i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 14:57:38 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8BF6AE067;
        Mon,  7 Dec 2020 14:56:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=++e7CeOnC2/yIMR7pgbcVMUNyKQ=; b=Jg29o4
        MrIc5hlcrcUovbZCUXogJGPdVpHEyr5PaTb9oNPjKe6bI9sWx++MSqqGny6gRJzJ
        DarrU6CXYwF6UyPYMUWHTTPZVMxDyPU9heQAdRqhbMlzJ0mMarNMwAUQVk+j3biL
        UJfHp0t2M57WS5/P7qpJVekJbKvJ3MzVFIDQY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H4dL4a+edlDmNvpEfOweSqWuitnj6qu+
        HpaYV1BUMmPe8OEoI2dIXRTTgqmFRMPFu+RiL2ck/SGdiagB9VYr3QvrtjBPBDPF
        MXldXHGmb6RDRhWiAFH9R3IBP7uE5lTKq3kiRc5uNwlQeHBgGZMouc6epyoOf7FA
        HlNVmtxTZ94=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BF9CEAE066;
        Mon,  7 Dec 2020 14:56:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 350E2AE065;
        Mon,  7 Dec 2020 14:56:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Peter Kaestle <peter.kaestle@nokia.com>,
        Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.us>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH v2] submodules: fix of regression on fetching of
 non-init subsub-repo
References: <CAPig+cQ8VC2q4nuzgM9QxmddH4cMezbZdRZDxX1PqfW6XKcC_A@mail.gmail.com>
        <1607348819-61355-1-git-send-email-peter.kaestle@nokia.com>
        <613FAD04-0D5A-4DE0-8FE8-0C5C5619B7BC@gmail.com>
Date:   Mon, 07 Dec 2020 11:56:54 -0800
In-Reply-To: <613FAD04-0D5A-4DE0-8FE8-0C5C5619B7BC@gmail.com> (Philippe
        Blain's message of "Mon, 7 Dec 2020 13:42:08 -0500")
Message-ID: <xmqqh7ox9ypl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B5BC506-38C6-11EB-BD5C-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> I would maybe add more details here, something like the following 
> (we can cite your previous attempt, because it was merged to 'master'):
>
> The first attempt to fix this regression, in 1b7ac4e6d4
> (submodules: fix of regression on fetching of non-init
> subsub-repo, 2020-11-12), by simply reverting a62387b, resulted in
> an infinite loop of submodule fetches in the simpler case of a
> recursive fetch of a superproject with uninitialized submodules,
> and so this commit was reverted in 7091499bc0 (Revert "submodules:
> fix of regression on fetching of non-init subsub-repo",
> 2020-12-02).  To prevent future breakages, also add a regression
> test for this scenario.

Forgot to mention in my other response, but I do find this a very
sensible addition.

Thanks.
