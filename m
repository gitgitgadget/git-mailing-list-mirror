Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B24C001DC
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 18:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjGZSO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 14:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGZSOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 14:14:25 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0665526A6
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 11:14:24 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8C7791894C;
        Wed, 26 Jul 2023 14:14:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EDGbf2P8QSXYUW6ogC1V3hcLgz9BgzbGfKztkX
        lHLSI=; b=QveGCD80hAMpyybbXFdl+PqxLWJMXC0exJw7Gh6YIY8G7WkAkpugjA
        h6NfRZJ6Ts/QOp0LkRrNAEHeJKCiGAoMDZvGLhqPmMdv2pZZIasYMtWFuF9dj7UC
        gUQz5EQyCP0jQu+d0KhjrEAM7LJcj4FWeGqSR/X3NXgyIY0/N4/ao=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 855DB1894B;
        Wed, 26 Jul 2023 14:14:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 296A718948;
        Wed, 26 Jul 2023 14:14:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yuri <yuri@tsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: 'git stash push -- {dir}' puts files in stash that are outside
 of {dir}
References: <5fce9c4f-0ea7-9393-4a30-ddd66946661d@tsoft.com>
        <xmqqsf9ad1ju.fsf@gitster.g>
        <792f71bb-2b9a-2e2b-80ea-9e3afd9fbfb4@tsoft.com>
Date:   Wed, 26 Jul 2023 11:14:20 -0700
In-Reply-To: <792f71bb-2b9a-2e2b-80ea-9e3afd9fbfb4@tsoft.com>
        (yuri@tsoft.com's message of "Wed, 26 Jul 2023 10:36:16 -0700")
Message-ID: <xmqqo7jyczgj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E3BC092-2BE0-11EE-91F2-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yuri <yuri@tsoft.com> writes:

> On 7/26/23 10:29, Junio C Hamano wrote:
>> Are there configuration variables set to affect the behaviour of the
>> "git stash" command in your environment that I do not have (I have
>> nothing in "git config -l | grep stash" output), which may be
>> affecting why it does not reproduce for me?
>
>
> "git config -l | grep stash" doesn't print anything.

Another thing to try.  The command internally uses some internal
form of "git diff" to find out what to save and reset to the HEAD
version in the working tree, so if you have an exotic configuration
variable that affects the way "diff" behaves, it _could_ trigger a
symptom like that (needless to say, the internal invocation of "git
diff" should have prepared for such an end-user configuration and
explicitly countermanded it, but people add configuration variables
after a command was implemented without thinking the ramification
through and especially when they are rarely used ones that do not
usually appear on Git developers' radar, such a bad interaction can
go unnoticed for a long time).
