Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA59EC433DB
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 20:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7021822ADF
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 20:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbhAMUeE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 15:34:04 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54843 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbhAMUeE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 15:34:04 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D852A68A5;
        Wed, 13 Jan 2021 15:33:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oAx0CgZQohAwV81nQkHF9N+oPA4=; b=kwNCH4
        0ISasK1eWN70c0jnc/70vAYH5+3DP4jmbnLtvcLHf0WQSC8q8LU7Fq0jtYu9aLVx
        ckhCwL6+7VW45TOgqiycWvGMt5vnVEOjWhhJDBWCMVUXkhSln0DbmJSQn+fVCwbn
        uSFDsg0hbBgskeecnJANWS3eUvIdSCTASSQc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UUgZfDWtqcxIJ7XZoiJmsHFJ579PlvHJ
        s48+xlXaQ8Y57ozM93KN7l0NPgQjWzwMSQZlblmG+sZ7FKN0vkE7utUtljXCcmF4
        I56Nv206yPlStpOz0agL5QtQUHnK19TskyeZryhN5pu681KNcy1hjvpsffIW8O36
        39rzXw5XEhU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2565CA68A4;
        Wed, 13 Jan 2021 15:33:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AC165A68A3;
        Wed, 13 Jan 2021 15:33:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: git am fails because of weird text in commit log
References: <20210113085846-mutt-send-email-mst@kernel.org>
Date:   Wed, 13 Jan 2021 12:33:21 -0800
In-Reply-To: <20210113085846-mutt-send-email-mst@kernel.org> (Michael
        S. Tsirkin's message of "Wed, 13 Jan 2021 09:01:16 -0500")
Message-ID: <xmqqzh1cwp9q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 93E39B44-55DE-11EB-B729-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Michael S. Tsirkin" <mst@redhat.com> writes:

> So someone sends me a patch with --- in the commit log, like this below.
> Result: git am gets confused and can't apply the patch.

Quite understandable.

> Shouldn't git format-patch at least complain about commit log
> like this, if not mangle it in some way?

It probably is too early to warn, mangle or quote in "git commit".
I agree with you that "git format-patch" would be the best step in a
typical workflow to warn, mangle or quote.

The solution would probably begin with identifying the lines in the
commit log that mailinfo.c::patchbreak() considers the beginning of
the patch part.  After finding such a line:

 - Warning is easy.  

 - Mangling the line by prefixing something like " " in front of it
   would also be easy.

 - Quoting thru to the end of "patch that shouldn't have been there"
   in possibly a reversible way is probably too hard.

Mangling or quoting should be hidden behind an option, I would
think.

Patches welcome.

Thanks.
