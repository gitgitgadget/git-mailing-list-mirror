Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B521BC433E0
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 17:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 780DA64E21
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 17:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhBVRVT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 12:21:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58438 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhBVRVT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 12:21:19 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B9BE711E016;
        Mon, 22 Feb 2021 12:20:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Aqm+4w5fXGRUUv7Hsc9NM/+v4HE=; b=EVr2AS
        JOYEGStV4cDE4YSM30yAUCNdSnFN8kHf6fxnxsNh+rBkN9yF7d/5YrOZRtFgW1ZV
        33XZUZsRMtzbTOoO3WnBj0UBA5dOhhvIJOaRP/fZ+zWyKl52CiORVYtWwt7TxXx7
        qdUB1qNk4dtIyBFZDeS2ltdmjQZoRz04wfsKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KeyZMwSg5vl+R2J55Izy7Qj6vGbb8nRO
        IQ4E2Y+Guy+QYJ5RRWmGoYaxU8r2qKC0uoKQ68FIAfaeSth7JQ41aC8oSL5o1IFi
        x2k/3NDrWlQh6czW7Lvj1bDj++x+FQA3eKuAjBezIB2uvJ4cMeaOZfL//0Lpj4nZ
        um9/4tXf3d4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B388F11E015;
        Mon, 22 Feb 2021 12:20:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 067B411E012;
        Mon, 22 Feb 2021 12:20:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     git@vger.kernel.org
Subject: Re: noeol when redirect git log output to a file
References: <20210222231406.CE72.409509F4@e16-tech.com>
Date:   Mon, 22 Feb 2021 09:20:32 -0800
In-Reply-To: <20210222231406.CE72.409509F4@e16-tech.com> (Wang Yugui's message
        of "Mon, 22 Feb 2021 23:14:07 +0800")
Message-ID: <xmqqk0r081en.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 458A1D6A-7532-11EB-BECE-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wang Yugui <wangyugui@e16-tech.com> writes:

> [root@T640 ~]# git log '--pretty=format:%h: %an: %s' -- hw/ >a.txt

This is an expected behaviour.

Notice that the format string given above does not end in LF by
itself (its final placeholder is the subject string without LF at
the end).  LF you'd see in the output all come from the "log"
machinery and not from the format string.  When the machinery adds
LFs, there are "separator" and "terminator" behaviour, the former of
which adds a separating LF between each item, while the latter adds
a terminating LF after each item.

"--pretty=format" is defined to use a separator semantics that is
suited to show multi-line items, each of which ends in LF on its own
(think of --pretty=format:"by %an%n%b").  Using terminator behaviour
you'd get an useless extra LF at the end for such a format, and
separator behaviour lets you avoid it.

"git log --help" and find "tformat", to learn more.  --format=<fmt>,
instead of --pretty=format:<fmt>, may also help.
