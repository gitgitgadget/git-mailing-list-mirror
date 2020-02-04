Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFC3C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 19:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC172082E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 19:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZcdbvQmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgBDTAp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 14:00:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62356 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgBDTAp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 14:00:45 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C0263BBA0;
        Tue,  4 Feb 2020 14:00:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zS5p4mrPj0C0jT93M/jzInnqxDI=; b=ZcdbvQ
        mODNhLnrTuFqRGht2nthR++q3rkuvS5RIg8kGBBwptVUkw4xKBMW1zgWK0H5O82U
        37uh2E+QHiKso7zmX79z0Wa/2wBRElsYCoiWOhW/L1xzcZBgbKuYOHujcX2BpGOb
        ck9a7u7FDBgBZfDRWycGJHvdVUvPv5/cU0Cro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eemyTrn9HU2YE0P+uZ18gqWKGymSf1re
        h1h4LOuxaHX7WyYisvqMUrfKXTkZdGhwOATu6jCR0IrW4URL0hd9yRAggMFtZ3w4
        Oj8lXmfqB+4wVGR8LppCPnjqFT4VFuFc471sdHFj6ODEWCFnZeo3nFjRA71bTShW
        ArRCkKgaDuA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 52D6A3BB9F;
        Tue,  4 Feb 2020 14:00:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A4CFC3BB9E;
        Tue,  4 Feb 2020 14:00:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 13/15] bugreport: add packed object summary
References: <20200124033436.81097-1-emilyshaffer@google.com>
        <20200124033436.81097-14-emilyshaffer@google.com>
Date:   Tue, 04 Feb 2020 11:00:41 -0800
In-Reply-To: <20200124033436.81097-14-emilyshaffer@google.com>
        (emilyshaffer@google.com's message of "Thu, 23 Jan 2020 19:34:34
        -0800")
Message-ID: <xmqq8sli89eu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4597F6A-4780-11EA-861E-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

emilyshaffer@google.com writes:

> From: Emily Shaffer <emilyshaffer@google.com>
>
> Alongside the loose object counts, it can be useful to show the number
> of packs and packed objects. This way we can check whether the repo has
> an appropriate ratio of packed to loose objects to help determine
> whether it's behaving correctly.

This lets the enumeration machinery to enumerate at the individual
object level, relies on the enumeration machinery to show your
callback all objects from the same pack before an object from a
different pack, to count both objects and packs.

But given that packfiles record how many objects there are in the
pack, and that the packfile.c layer must know what are the pack
files we have available, I wonder if we have an API already to allow
us to enumerate each packfile, and while counting the number of
times our callback was called, add the objects contained in each of
them.  If there isn't, it does not sound like a bad API function to
add (i.e. given a repository r, iterate over r->objects->packed_git
and let the API caller see each of them; the API caller can grab
num_objects and add them up).

