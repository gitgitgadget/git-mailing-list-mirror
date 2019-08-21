Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 183331F461
	for <e@80x24.org>; Wed, 21 Aug 2019 15:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfHUPWU (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 11:22:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57631 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfHUPWT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 11:22:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B121159100;
        Wed, 21 Aug 2019 11:22:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dqhVDQPGPfeMghKRlBNHVvspPdk=; b=bXUQBY
        tAw72LyaMU5zES4X2VSnUyqptkxqvhoLbGUCuLDzTQNzUM5MJTv03p02SDHMr1Fm
        XcCbI1x/qPTHckACQ2mZCejptl9wpotmaXMmDRFtBdvau2owpdRDV8S1myaChxYC
        gcO9v9Ssxbkiy6LFWEzW/BV9W/aQHAjpRpVF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CBZR/sYg35/peqBQffa2CGP6q8dAkYLC
        aFdHjU532NOviXve5ucld58EKV+5uCDTDZxR1WPM4nm5giSEGbN/CXXRXXKhOsLK
        XINv9V9MLd63XPZPMjKsgJMY3/seADYEO4rKClCIuRlGe3u57qLqb0wIxrLRt3R3
        fdBAl+yVIEk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D12B1590FE;
        Wed, 21 Aug 2019 11:22:17 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 42E781590FC;
        Wed, 21 Aug 2019 11:22:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, garimasigit@gmail.com, jeffhost@microsoft.com,
        stolee@gmail.com, Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH 1/1] quote: handle null and empty strings in sq_quote_buf_pretty()
References: <pull.314.git.gitgitgadget@gmail.com>
        <9d2685bdb2e193986bec8cad88795963977d41fe.1566329700.git.gitgitgadget@gmail.com>
        <xmqqtvabtwai.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 21 Aug 2019 08:22:15 -0700
In-Reply-To: <xmqqtvabtwai.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 20 Aug 2019 13:29:57 -0700")
Message-ID: <xmqq7e76tufs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75574904-C427-11E9-92C3-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>  create mode 100644 t/helper/test-quote.c
>>  create mode 100755 t/t0091-quote.sh
>
> I do not appreciate these two new files only to test this corner
> case.  ...

To avoid misunderstanding, I am not against having unit tests when
they are appropriate. What I am against is to have only unit tests,
especially when the effect of a bug (and its fix) can be tested with
externally observable behaviour. The latter gives us a better sense
of the real-world impact (e.g. if run_command would spawn the given
command via shell using the 'sh -c "... stringified command and its
arguments ..."' idiom, it may be done with the function we fixed
here, which would mean that the user cannot pass '' as an argument
to that codepath), while a unit test gives readers "ok, the function
behaves that way now" alone, without answering "then what?  What
difference does this fix make to my use of Git as a whole?".

In any case, thanks for an attempt to fix.
