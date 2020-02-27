Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AD9C35677
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 16:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466D3246A1
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 16:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fXyAr19a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbgB0QmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:42:02 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57554 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbgB0QmC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 11:42:02 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 723805F9CA;
        Thu, 27 Feb 2020 11:41:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/YKG4T4aVZELIO9N5RIwcUw198w=; b=fXyAr1
        9aC1FirkJJdtQT9lPiamTPtGEpSuVMBPBfWy9nOAY0a1Ae/AHgBWfrR5TDX6C4yN
        twJ5Z9wDRgWf/W0M5k7GIjJWUemjiyakVl2N9DSX24VJ32nTJCe8CADbYq5gxD/9
        iu7VlCdAPeb9SuAhaOy9WThs0HQGESiYYW3C4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RYFmIjeXUhJb+p/+3DSq8HR+sP0/l+xi
        Pq+tFasOjrVoW8X3f86O+aC8vc7/svGv/oy9hvBNIZrsSNnpUYah1atVClkHX8BC
        DIoV8yHt9K0w8luQMqZYzrhYf2meeQOJa5XbsFef7ShOe+LnYw8D0lHhOfx81fkO
        e8bFS03JBzw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B30C5F9C9;
        Thu, 27 Feb 2020 11:41:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CE3685F9C8;
        Thu, 27 Feb 2020 11:41:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Miriam R." <mirucam@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 02/10] bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C
References: <20200226101429.81327-1-mirucam@gmail.com>
        <20200226101429.81327-3-mirucam@gmail.com>
        <xmqqzhd5i1na.fsf@gitster-ct.c.googlers.com>
        <CAN7CjDDwgR=y8gyYmDzmuTW3AKvb1N=EdCtH-8Tr7T=b6cG5gQ@mail.gmail.com>
Date:   Thu, 27 Feb 2020 08:41:55 -0800
In-Reply-To: <CAN7CjDDwgR=y8gyYmDzmuTW3AKvb1N=EdCtH-8Tr7T=b6cG5gQ@mail.gmail.com>
        (Miriam R.'s message of "Thu, 27 Feb 2020 16:34:46 +0100")
Message-ID: <xmqqwo88f0do.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 114470EC-5980-11EA-9DC6-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Miriam R." <mirucam@gmail.com> writes:

>> It would be surprising if this code were correct.  It may be that it
>> happens to (appear to) work because parents of the commit hasn't
>> been painted and calling the helper only clears the mark from the
>> commit (so we won't see repeated "painting down to the root commit")
>> in which case this might be an extremely expensive looking variant
>> of
>>
>>         commit->object.flags &= ~ALL_REV_FLAGS;
>>
>> that only confuses the readers.
>>
>> Even then, I think by clearing bits like SEEN from commit, it breaks
>> the revision traversal machinery---for example, doesn't this mean
>> that the commit we just processed can be re-visited by
>> get_revision() without deduping in a history with forks and merges?
>>
>> Has this been shown to any of your mentors before sending it to the
>> list?
>
> Adding clear_commit_marks() was a suggestion of a previous review of this patch:
> https://public-inbox.org/git/nycvar.QRO.7.76.6.2001301619340.46@tvgsbejvaqbjf.bet/
>
> And of course, my mentor always reviews my patch series before sending.

OK, I just didn't know how you and your mentors work.  Some leave
their door open for mentees and help them when asked but otherwise
act as an ordinary reviewer who somehow prioritises reviewing the
work by their mentees.  So your mentors may be a better source of
information why this piece of code, which I still do not know how it
could be correct, is supposed to work.  Good.

After reading the above URL, I think you may have misread the
suggestion you were given.  Resetting using clear_commit_marks() may
be necessary, but you do so when you finished walking so that you
can do unrelated revision walk later.  For that, you clear the flag
bits after the while() loop that asks get_revision() to yield
commits are done, using the initial set of commits that you used to
start iteration.

That is how bisect.c::check_ancestors() work, that is

 - it initializes a rev_info 'revs' from an array of commit rev[]

 - it lets bisect_common() use the 'revs', which is allowed to
   smudge the flag bits of commit objects.

 - it uses clear_commit_marks_many() to clear the flags of the
   commits whose flag bits may have been smudged and their
   ancestors, recursively.  In order to use as the starting points,
   the original array of commit rev[] that started the revision
   traversal is used.
