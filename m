Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 923A71FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 17:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755213AbcKVRKN (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 12:10:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53677 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752159AbcKVRKM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 12:10:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3329F4F182;
        Tue, 22 Nov 2016 12:10:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+t4otdVKMVn7gdkoFQm/FSnKsxs=; b=jpu3SR
        PRGr0NecklBQ4+eYwmTAV/PHm81ErTmCHh6kXLm3s+NITtqQPcRQaj/PJ+y3pG0k
        kNXa47JJQn/DRmg7zlxcMsU5VAPcSuqtEMV+rrLq2F9ncx1/tT/3549FlkHaUvd2
        zWyYh/0rMeoMdJkOZKYi37xIe4YZ9LjrNpuX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gDh36M3Dw79/RNYQtB0NK2kr79gsKJ/j
        VOZC05XCufMC9TWHcic01IXgUQdrw67ZkxI+QrQLxxewO3GzUczYOcDdFPi/NyIm
        9FeTgtMObDjpVOBXyQ/qWtZk/r/RwgkiB/y2T9wteakvMEP/sPJMVUR7c+AwFyux
        vTn/MBy5GmM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28A584F181;
        Tue, 22 Nov 2016 12:10:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5CF364F180;
        Tue, 22 Nov 2016 12:10:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Taufiq Hoven <taufiq.hoven@gmail.com>
Subject: Re: [PATCH 2/3] stripspace: respect repository config
References: <cover.1479737858.git.johannes.schindelin@gmx.de>
        <5567548295222401fab10d3f2901c1787afbfd07.1479737858.git.johannes.schindelin@gmx.de>
        <CACsJy8D5oBR+vo2B+Ro2Q4SX0CG3jME4Gfs1_6AohccmpNvD0A@mail.gmail.com>
        <alpine.DEB.2.20.1611221712480.3746@virtualbox>
Date:   Tue, 22 Nov 2016 09:10:08 -0800
In-Reply-To: <alpine.DEB.2.20.1611221712480.3746@virtualbox> (Johannes
        Schindelin's message of "Tue, 22 Nov 2016 17:13:59 +0100 (CET)")
Message-ID: <xmqqshqjqw3z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 864ECD16-B0D6-11E6-9E40-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> This conditional config file reading is a trap for similar bugs to
>> happen again. Is there any reason we should not just mark the command
>> RUN_SETUP_GENTLY in git.c and call git_config() here unconditionally?
>
> As I plan to slip these patches into Git for Windows v2.11.0, i.e. making
> this a last-minute hot fix, I want to err on the side of caution.

So do I.  As a hot-fix, I'd prefer the patch I queued yesterday.

I think we want to audit the ones without RUN_SETUP* in the command
table in order to hunt for regression aka "a fix revealed a bug that
was covered by .git/config accidentally getting read when run from
the top-level of the working tree", though. We may find unreported
breakages that we may have to fix.
