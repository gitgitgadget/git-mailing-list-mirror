Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7700E20229
	for <e@80x24.org>; Fri, 21 Oct 2016 15:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935671AbcJUP6v (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 11:58:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53130 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935659AbcJUP6t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 11:58:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33EC444088;
        Fri, 21 Oct 2016 11:58:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GeRJHbfPd4kcOoQpjWlTlx2RuOo=; b=L6ZCK7
        qFFxtEfV1iXQQJvBfcx+dK2xfT1JkcMork0Z28QQ7CaUhUky1ZHDnEiF0aYgB/Q6
        /n9yc7PabfuNScP4jq2MVrm5wuUF50/vkqYQFtOOpY4b1XanbTgPeJs26scmmuKk
        aZfY7rqe7qLqVSL2qTdS7anVm3wa9SXVIJCho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LkyDrbX2IHww5GunodpgpD3SIXGflW6z
        9HEy02OmcEdfrwtiVAWlrQiQXygZZZloThaghg2yFbl5K30zvnf6G13Fhqt0QPf/
        HIOVvpXCnUuQv36yG6nlvcD2gqvYYle6Dqx2yGU25TLzcqblaKAYRMbWKzJB9mD4
        o3w2Z5N11yo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 29E6244087;
        Fri, 21 Oct 2016 11:58:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 880CF44086;
        Fri, 21 Oct 2016 11:58:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Luke Shumaker <lukeshu@sbcglobal.net>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] daemon, path.c: fix a bug with ~ in repo paths
References: <20161018150629.23205-1-lukeshu@sbcglobal.net>
        <xmqqvawppote.fsf@gitster.mtv.corp.google.com>
        <87pomxildc.wl-lukeshu@sbcglobal.net>
        <CACsJy8AzWqJ_9JQ_BGnAB3E3GrGSTS40z8umbtO6mQJukWOooQ@mail.gmail.com>
Date:   Fri, 21 Oct 2016 08:58:45 -0700
In-Reply-To: <CACsJy8AzWqJ_9JQ_BGnAB3E3GrGSTS40z8umbtO6mQJukWOooQ@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 19 Oct 2016 21:12:37 +0700")
Message-ID: <xmqqlgxhd77u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40510998-97A7-11E6-B6E5-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> The amount of changes is unbelievable for fixing such a rare case
> though. I wonder if we can just detect this in daemon.c and pass
> "./~foo/bar" instead of "~foo/bar" to enter_repo() in non-strict mode
> to "disable" expand_user_path(). If it works, it's much simpler
> changes (even though a bit hacky)

Conceptually, it ought to be updating the code that says "Does it
begin with a tilde?  Then try to do user-path expansion and fail if
that is not enabled and if it succeeds use the resulting directory"
to "Is user-path enabled and does it begin with a tilde?  Then try
to do user-path expansion and if it succeeds use the resulting
directory".  Compared to that mental model we have with this
codepath, I agree that the change does look quite invasive and
large.

It is OK for a change to be large, as long as the end result is
easier to read and understand than the original.  I am undecided if
that is the case with this patch, though.

Also I am a bit worried about the change in the semantics.  While it
is not the best way to achieve this, the server operators could use
it as a way to add directories whose contents need to be hidden to
give them names that begin with a tilde without enabling user-path
expansion.  This change may be a new and useful feature for Luke,
but to these server operators this change can be a new bug---it is
probably a minor new bug as they can work it around by using other
means to hide these directories, though.
