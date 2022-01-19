Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBD2C433EF
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 22:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357562AbiASWh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 17:37:29 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54227 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243245AbiASWhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 17:37:25 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B2771717FC;
        Wed, 19 Jan 2022 17:37:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AFvZZIzb09qR8SgKq+CDxWZ8PxyUzRHgxBnmkb
        X+dfA=; b=jGx2ScKd98jH+uxoIgykrL1YVtVVDUs0EOjxbPTc1mmF3UTtDInq8P
        CmAG2jIU3QfefaOIjmKb5g8WovaprJsjF0dqbgchJKkxNo18Wxid4dd+F8Y/J23M
        SH6DJTSakPPtwDJ6wZpYCH1DlL4643HmoxHYMX9Rldy0sd7J8tE28=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 93FBB1717FB;
        Wed, 19 Jan 2022 17:37:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 042201717F8;
        Wed, 19 Jan 2022 17:37:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Michael Herrmann <michael@herrmann.io>, git@vger.kernel.org
Subject: Re: A puzzle: reset --hard and hard links
References: <CABrKpmDseZkPCpRb8KmBJaxDp24sySJay5ffZrxqgSMGKyj5qQ@mail.gmail.com>
        <YeiOoAcM7TMK2pgz@camp.crustytoothpaste.net>
Date:   Wed, 19 Jan 2022 14:37:20 -0800
In-Reply-To: <YeiOoAcM7TMK2pgz@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Wed, 19 Jan 2022 22:20:16 +0000")
Message-ID: <xmqqilufl5cv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DEAB70C-7978-11EC-95C2-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Whether it happens in this particular case probably depends on what data
> is in the index and whether it's considered stale, since if the file is
> out of date, I believe a git reset --hard will replace it rather than
> try to determine whether it's up to date.

True, but I think it answers a different question, which was "to
replace or to overwrite".  I do not recall any codepath in git
proper (I do not know about third-party tools and scripts around the
fringe, though) that overwrites working tree files instead of
writing into new files and replacing them.

If there is a hardlink to outside the working tree of a tracked
path, and "git reset --hard [<committish>]" needs to modify the
contents of that tracked path because it does not match what is
recorded in the committish, I think it is the right thing to severe
the link and leave the path outside the working tree intact. If we
instead overwrote, we will damage "the other file" that shares the
hardlink, which is outside the working tree hence outside our
control.

Also, if two paths inside a working tree are made into hardlinks to
each other, whenever Git needs to update either of them, we would
severe the link, i.e. not ovewrite but replace, and it is the right
thing to do, since Git trakcs these two paths as two separate things
(i.e. the index has one entry for each of these paths).
