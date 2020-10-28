Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4B6C56201
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 21:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE1CF24844
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 21:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D1i9VY2B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgJ1VeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:34:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54097 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgJ1VeF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 17:34:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2A9A8F958A;
        Wed, 28 Oct 2020 15:18:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z49kEEXeaOkI9Y+SOA/mpXqmgOE=; b=D1i9VY
        2BmV7pHplm/CEjshEFQ593ErASluz0jMqYTd+J90PPMW9ycmhlNC14pPjWF85NtY
        5Lc6hU/7g1H/4Pfj+AVWAmXHGyoWQW2qLQGPjVRx53fM5SLCskG94qVJRkXYv2ng
        WbVdsloyVQ/kxaxI+5T0MXGoUmwfw5p0XvQxw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O0rEMXuzTp82c9oRDMjg8vEBaf52fOZl
        5iqzVyfCkdB8U71XPFu3hp6EuOueNElp/jPkybIlwM8NxsXJFNCOBU4JaCdS2h+5
        MeU2dlEaMYKld7i0sV1scmU5FeAzB+HmHTQN6tUdBdmiejU52nKHgvcVuhCxpe0j
        /wpZH/D7cMY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 23F5AF9589;
        Wed, 28 Oct 2020 15:18:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 67570F9584;
        Wed, 28 Oct 2020 15:18:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2 7/8] verify_path(): disallow symlinks in
 .gitattributes and .gitignore
References: <20201005121609.GA2907272@coredump.intra.peff.net>
        <20201005121645.GG2907394@coredump.intra.peff.net>
        <20201027033518.GH2645313@google.com>
        <20201027075853.GH3005508@coredump.intra.peff.net>
        <20201027234309.GA1298045@google.com>
Date:   Wed, 28 Oct 2020 12:18:12 -0700
In-Reply-To: <20201027234309.GA1298045@google.com> (Jonathan Nieder's message
        of "Tue, 27 Oct 2020 16:43:09 -0700")
Message-ID: <xmqqeeli9n2j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53881CC8-1952-11EB-B016-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Yes.  And to reiterate the point a little: the reason nobody sets
> transfer.fsckObjects is that we haven't made it easy to distinguish
> between "hard error, should never be overridden" checks (like
> BAD_PARENT_SHA1), "new tools shouldn't write these but they exist in
> important repos like perl.git and anything consuming Git repositories
> needs to cope with them" (like MISSING_SPACE_BEFORE_DATE from some
> commits' concatenated authors), and so on.

Hmph, don't we "distinguish" them by setting appropriate default
levels, though?  Perhaps some classes of errors are set too strict?

>> So I won't be too devastated to remove the symlink checks, or possibly
>> downgrade them to purely warnings (or "info"; the naming in fsck.c is
>> confusing, because the transfer operations take even warnings as fatal.
>> I suspect we could do with some cleanup there).
>
> Downgrading the .gitignore check to warning sounds okay.  .gitmodules
> would still want to be an error, of course.

.gitattributes (and any other .git<thing> we may have in the
future), too.

Thanks.

