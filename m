Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C92C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 09:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB68E6008E
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 09:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhFGJxb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 05:53:31 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56930 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhFGJxa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 05:53:30 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 91B8A13869C;
        Mon,  7 Jun 2021 05:51:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aOMM8rxWJFw8NwEIUkDrA3FfciCHTHYwDzUMyf
        f+iRc=; b=VsulLaKsYJDSep7Dcx9eCgYZ/yaIK6G6UY7rUJlpKxGBgb2iSu/l9o
        RYB9rfqobd0vO3g2fLUCwuIt7x6lsOsRN5h2surpH2MVngl+JQnjINpmczGjN40U
        PMZqfyfD8vCw4UzHOqJav/ZphFYCxPxzDg1kFX0HcICBvWyZsvW54=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8AF4213869B;
        Mon,  7 Jun 2021 05:51:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D7377138699;
        Mon,  7 Jun 2021 05:51:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] rerere: enable by default
References: <xmqqfsxvxjj2.fsf@gitster.g>
        <YL1uudVxwcDUg2+T@camp.crustytoothpaste.net>
Date:   Mon, 07 Jun 2021 18:51:35 +0900
In-Reply-To: <YL1uudVxwcDUg2+T@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Mon, 7 Jun 2021 00:56:25 +0000")
Message-ID: <xmqqtumauhnc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F31FA2D4-C775-11EB-AA10-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2021-06-06 at 12:30:25, Junio C Hamano wrote:
>> By default, the rerere machinery has been disabled since a bug in
>> the machinery could screw up the end user's data at the most
>> stressful time during the end user's workday (i.e. during conflict
>> resolution).
>> 
>> It however has been in wide use without causing much trouble (other
>> than, obviously, replaying a broken conflict resolution that was
>> recorded earlier when the user made a mismerge), and it is about
>> time to enable it by default.
>
> Yes, I think this makes sense.  I've been using it for quite a while
> without problems and I'm usually quite good at breaking things, and if
> we can make the user experience better, which I think rerere does,
> that's definitely a good thing.

I agree in principle, but new tests added by topics in flight need
to get prepared for the change.  There are, for example, misguided
checks that insist that the standard error stream out of "git merge"
must be absolutely empty, which will break when rerere machinery
starts reporting that it prepared the preimage so that it can record
the resolution.  Not just rerere, but such a test is brittle and
will break when other inner parts of the system starts reporting
more (e.g. progress) to the standard error stream.

I'd prefer to see these tests cleaned up in the right way (as
opposed to setting rerere.enabled to false upfront, which hides
these suboptimal tests) before this change to enable rerere by
default lands, so it may need a sizeable preparatory work.

Thanks.




