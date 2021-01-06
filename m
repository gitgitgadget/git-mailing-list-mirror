Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51159C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 08:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0014B2310B
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 08:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbhAFI4L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 03:56:11 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53990 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbhAFI4J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 03:56:09 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 199FC10D7FB;
        Wed,  6 Jan 2021 03:55:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=6Sg11I9Lr20vJn6j0JWniU2JPH4=; b=f5SFW75x4dAB69DdAdPp
        1ouk7/mugLu7mjQxq5UrAlENtJag56e1c8t+Oo1+2R12BBs3yQ+i8wIwNHTzMo+K
        4gZRejJMJTvgXOFvJi26fMrh86AVI8tVIqPthYc/W4jzzsgoykoBacxIvOwJVBCJ
        OHm2GdBbc5BMRkfZQsk9Utg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=nt94xS2j4+c1bcYuF6j80iB1nx/AtgzCC18DAajxtMssGw
        L+b7ZhlGbP7Zn4FtlkSoX7SrDUHY4YXPtBAeVLTjjq+P4gaFMy7+LlVjmNBwZKRh
        diZgLuDoGmHWjMuss69398mr5lmlK5sxDkI4EzEXLMJ2ujXp9v7q2dpCKTgo4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0401B10D7FA;
        Wed,  6 Jan 2021 03:55:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 28DBC10D7F9;
        Wed,  6 Jan 2021 03:55:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 8/8] cache-tree: avoid path comparison loop when silent
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
        <20ea7050324cdd78b0966f54366b26224dfc7814.1609356414.git.gitgitgadget@gmail.com>
        <CABPp-BFp5=C+6B1WUarXzabo0fU4xotP5UG91-hYahCHDA6Cng@mail.gmail.com>
Date:   Wed, 06 Jan 2021 00:55:22 -0800
Message-ID: <xmqqble2sav9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA0A421C-4FFC-11EB-AA92-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Looking through that code, I come to the same conclusion, though it
> might be nice to have Junio confirm (and to explain the "if (10 <
> ++funny)" section; did that help debugging too?).   The second part of
> the loop was part of his initial commit adding the cache-tree
> extension in commit 749864627c ("Add cache-tree.", 2006-04-23)

This is not about debugging our implementation.  The verification
was done to protect against the on-disk index file left by broken
implementations of other people.  Either JGit or Dulwich (I do not
recall which one) used to have such a broken sort long time ago,
IIRC, and the thing is, a broken implementation can be internally
consistent.

I do not think we've heard problem reports discovered by this check
about other peoples' broken implementation, but a chicken-and-egg is
certainly in action here.  The check would have caught any new and
broken implementation of Git before it got released to the wild to
cause harm and that is probably we haven't heard.

