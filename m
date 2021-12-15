Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A519C433EF
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 21:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhLOVlG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 16:41:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61503 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhLOVlE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 16:41:04 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 868F9F28A7;
        Wed, 15 Dec 2021 16:41:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PKVdEF9i1N1H1+aA5A8KmpZF2NNe41SnayiQVX
        vQ9d8=; b=mX/po2nl4pqG0CtHHd7sb9H3FNs6B5/yK2cxeSfoiXYfyT6mva5+Rk
        bZcxoI7cgrp2tMe3VZI8ah+a4FaYMUcTjbw22UAISHlRIWBD+swPA/qXZ+5Cgeb0
        znZ3I7r5bw/Vh2zIrNcXSxqI8G87Zj0U1L9sYA3i/Uk7xni9QehR0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 76E4CF28A5;
        Wed, 15 Dec 2021 16:41:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A8CA4F28A4;
        Wed, 15 Dec 2021 16:41:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Subject: Re: [PATCH 4/4] git-p4: resolve RCS keywords in binary
References: <20211213225441.1865782-1-jholdsworth@nvidia.com>
        <20211213225441.1865782-5-jholdsworth@nvidia.com>
        <xmqqzgp484f3.fsf@gitster.g>
        <BN8PR12MB336146CB8B6FD458AE3BE42BC8759@BN8PR12MB3361.namprd12.prod.outlook.com>
Date:   Wed, 15 Dec 2021 13:41:01 -0800
In-Reply-To: <BN8PR12MB336146CB8B6FD458AE3BE42BC8759@BN8PR12MB3361.namprd12.prod.outlook.com>
        (Joel Holdsworth's message of "Tue, 14 Dec 2021 13:12:13 +0000")
Message-ID: <xmqqczlx4kcy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B339C03A-5DEF-11EC-97B8-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Holdsworth <jholdsworth@nvidia.com> writes:

>> Makes sense, and I am with others who commented on the previous
>> discussion thread that the right approach to take is to take the stuff coming
>> from Perforce as byte strings, process them as such and write them out as
>> byte strings, UNLESS we positively know what the source and destination
>> encodings are.
>> 
>> And this change we see here, matching with patterns, is perfectly in line with
>> that direction.  Very nice.
>
> Not bad. Fortunately, it's not possible for $ characters to appear as a component of a multi-byte UTF-8 character, so it's possible to do the matching byte-wise.
>
>> 
>> >          try:
>> > -            with os.fdopen(handle, "w+") as outFile, open(file, "r") as inFile:
>> > +            with os.fdopen(handle, "wb") as outFile, open(file, "rb") as inFile:
>> 
>> We seem to have lost "w+" and now it is "wb".  I do not see a reason to make
>> outFile anything but write-only, so the end result looks good to me, but is it
>> an unrelated "bug"fix that should be explained as such (e.g. "there is no
>> reason to make outFile read-write, so instead of using 'w+' just use 'wb'
>> while we make it unencoded output by adding 'b' to it")?
>
> I am happy to split this change into a separate patch if this is preferred.

I do not think this is big enough for a separate patch; just a
mention in the log message is sufficient.
