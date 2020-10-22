Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCADDC388F7
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 16:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FE282463D
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 16:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hMCeg/LD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901743AbgJVQ1T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 12:27:19 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65332 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2901741AbgJVQ1S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 12:27:18 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5DEE6ECEBC;
        Thu, 22 Oct 2020 12:27:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/qPJkzt7+IHJmTGKobyNGU8z2AA=; b=hMCeg/
        LDchzVWY7ASG8Gs6YVGFNakwEUB1nfsUKixLC/Sj4z2wVy6OKrUmv8Q7jFLa3uJU
        bv1s2moodq8NmWNivwZtr3ES5I7kliYjjzBC8LPSmhFR4Rxce4kOTMTNj0pH40ts
        HJH5/AmujcfpfTd5a66eBbF6STKQjnmGt6U6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xjEAoa/NOhcm/LaNry9CqfIv30MsXoZY
        jWedzFuE5r3yYUbIeYerp29Yfezyk8UakAPXUYHkgc7T04if4hjUZQRRjPfrtaj1
        tL7xRXD++YDcqboirdkmMn5jG9josAMTAQpix0fACa22a9+lJ4zrTTp6chplIdvY
        GKwC5JdS3y8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 55623ECEBB;
        Thu, 22 Oct 2020 12:27:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 96A85ECEB6;
        Thu, 22 Oct 2020 12:27:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shengfa Lin <shengfa@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, nathaniel@google.com,
        rsbecker@nexbridge.com, sandals@crustytoothpaste.net,
        santiago@nyu.edu
Subject: Re: [WIP v2 1/2] Adding a record-time-zone command option for commit
References: <xmqqk0vtki66.fsf@gitster.c.googlers.com>
        <20201021050146.3001222-1-shengfa@google.com>
        <xmqqzh4f76jr.fsf@gitster.c.googlers.com>
Date:   Thu, 22 Oct 2020 09:27:10 -0700
In-Reply-To: <xmqqzh4f76jr.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 21 Oct 2020 11:55:20 -0700")
Message-ID: <xmqqd01ans4h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7089FF5E-1483-11EB-BAB6-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Yes, we could check it in datestamp(), but ... 
>
>> Initially, I thought this would be sufficient to show "-0000" in commit log
>> message. However, I found that the show_date function is used for "decoding";
>> converting timestamp and tz to more readable format. Then I realize the
>> function won't distinguish between +0 and -0 as it only takes in a tz as
>> argument. As a result,...
>
> ... I would have imagined that you do not have to deal with all
> those complications if you don't hook this to such a low level of
> the call graph.  That is why I wondered:
> ...

Let me answer some of my puzzlement myself; that is, I would have
understood the change well if it were explained to me this way, and
if that explanation matched what the patches did ;-)

The topic has two major parts.

The code that prepares the timestamp to be recorded for the current
user, who wants to record an anonymous timezone "-0000", is one (and
the easier) part.  And this part could be done all inside
ident_default_date() without touching anything in date.c; when we
need to call datestamp(), we are getting the current time for the
current user, so we can mask the timezone.

The other part is that we need to read the timestamp from existing
records, and if we choose to distinguish between timestamp in UTC
and timestamp with anonymous timezone, we'd need to devise a way to
encode the anonymous timezone differently.  It is where the extra
bit that says "this bit does not usually mean anything but only when
the offset (which is a signed integer whose valid range is set to
between -2400 to +2400 by date.c::match_tz()) is zero, and this bit
is set, the zone is anonymous" comes in.

	Side note.  I suspect the damage to the callchain can be
	limited much narrower if we didn't add this bit throughout
	the API.  What if we instead pick a number outside the valid
	range of offsets, say -10000, as a sentinel value and passed
	that throughout the code when we want an anonymous zone?

	The functions in the callchain that care about the timezone
	must understand how anonymous zone is encoded anyway, so to
	them it's a matter of using an int plus one bit or using an
	int that can have a special value.  But other functions in
	the callchain whose sole purpose (with respect to the
	timezone information) is to pass it between their caller and
	their callee as an opaque piece of data, using just a single
	integer is much less error prone---the patch does not have
	to touch them at all.

Thanks.
