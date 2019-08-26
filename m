Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C2601F461
	for <e@80x24.org>; Mon, 26 Aug 2019 18:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731907AbfHZSOV (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 14:14:21 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56645 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729433AbfHZSOV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 14:14:21 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1D83A7402E;
        Mon, 26 Aug 2019 14:14:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W9hzkQdq296zgVKBHL+gnzlOi5k=; b=g/io8i
        fPoKJfErRpXS1nR8BYDJi6V//R+4L71YzUX/3BnTJevJ70UqjKMo+tSqW6HfPgZN
        KjOfS39U8fDPJoOIiXjXpvzeHujXv+i4C3/DQNsVIZu/JfkGqd3iysIxIsZm2vTW
        mtHrQJTDjG/eXITK70923WRWR9zOqXOoU1rC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xcDPquhBT7U3oOH0T0BfKgR3JBIKqCm2
        Z5pXvFHDhDgQG+4Kf/nYF7shjFTS8dBnmdtvndjR09XWP8MAyf8Q4o+JERPrL8iL
        xEZfhpPD6RCI4serZpsZH1ZjmzdG2lvofhZCPuzajpYDp3ZXdhsETraG8dn/5Upu
        NFIPpH+ILAk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 16F8C7402D;
        Mon, 26 Aug 2019 14:14:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 246B874029;
        Mon, 26 Aug 2019 14:14:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org
Subject: Re: revision.c alters commit object state ; also no cleanup
References: <20190826085844.ue77hen2z6rggpe5@glandium.org>
Date:   Mon, 26 Aug 2019 11:14:13 -0700
In-Reply-To: <20190826085844.ue77hen2z6rggpe5@glandium.org> (Mike Hommey's
        message of "Mon, 26 Aug 2019 17:58:44 +0900")
Message-ID: <xmqq7e6zhk0a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5086E7F6-C82D-11E9-8B92-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey <mh@glandium.org> writes:

> First, revision.c doesn't come with a function to clear a struct
> rev_info....
> Then, revision.c kind of does nasty things to commit objects...

Yeah, these two stem from the "run once and let exit() clean things
up" design the oldest part of the system shares.  Regarding the
latter, i.e. parent rewriting, I recall that there is a codepath
that saves the original true parents away in a second field when we
know we would want to show it (and avoid the overhead of copying
when we do not have to), so you should be able to extend it to keep
the original parent list.

