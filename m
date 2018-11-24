Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7EC51F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 02:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbeKXMvl (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 07:51:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52732 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbeKXMvl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Nov 2018 07:51:41 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B1185126F98;
        Fri, 23 Nov 2018 21:05:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=axh8BMQvVa7gdlT6ok1REiP54e4=; b=FN4IQq
        cZYmxcofn+CzPGiBNiOGWSi+lJXhDh1ncdbXY6cuHsljr12O33tYHvyktbotmzqZ
        6jzGcphefKNZ2x55AI6tj10a1aOwlL75AyQwYVvGjEZze6t4hTzmx9KHIxDzS7p+
        O3ApMBDj2bqOvd4hcnn6OTBRQNjTznylfI9WM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZW+/OwgFR7cDmLOJApLM3rdOMqy94blW
        o8c7Gt4C59qCx/2BarAVu8Cf9YA7Ez+Grx+boKhz6e9iMprmkJ6pfOmXUJPiWwFs
        5lwb/m74xsy4x6+64XcrZ+eUJhf8j0LcJc9WCh2NkDRdKcKEIGTJqZ0trvQSaxtD
        byJdbBb6B1s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F51C126F96;
        Fri, 23 Nov 2018 21:05:03 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1DAA4126F93;
        Fri, 23 Nov 2018 21:05:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com
Subject: Re: [PATCH v4 0/2] Fix scissors bug during merge conflict
References: <cover.1542496915.git.liu.denton@gmail.com>
        <cover.1542768902.git.liu.denton@gmail.com>
        <xmqqefbe7otv.fsf@gitster-ct.c.googlers.com>
        <20181122011055.GA1584@archbookpro.localdomain>
Date:   Sat, 24 Nov 2018 11:05:00 +0900
In-Reply-To: <20181122011055.GA1584@archbookpro.localdomain> (Denton Liu's
        message of "Wed, 21 Nov 2018 20:10:55 -0500")
Message-ID: <xmqqin0n44dv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A6DA2A6-EF8D-11E8-9DD7-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> I just realised that there is a slight problem with the proposed change.
> When we do a merge and there are no merge conflicts, at the end of the
> merge, we get dropped into an editor with this text:
>
> 	Merge branch 'master' into new
>
> 	# Please enter a commit message to explain why this merge is necessary,
> 	# especially if it merges an updated upstream into a topic branch.
> 	#
> 	# Lines starting with '#' will be ignored, and an empty message aborts
> 	# the commit.
>
> Note that in git-merge, the cleanup only removes commented lines and
> this cannot be configured to be scissors or whatever else. I think that
> the fact that it's not configurable isn't a problem; most hardcore
> commit message editing happens in git-commit anyway.

OK.

> However, since we taught git-merge the --cleanup option, this might be
> misleading for the end-user since they would expect the MERGE_MSG to be
> cleaned up as specified.
>
> I see two resolutions for this. We can either rename --cleanup more
> precisely so users won't be confused (perhaps something like
> --merge-conflict-scissors but a lot more snappy) or we can actually make
> git-merge respect the cleanup option and post-process the message
> according to the specified cleanup rule.

The former certainly would be simpler to implement, but feels more
like an excuse for not doing the right thing to me, when I put
myself in shoes of users who use 'scissors' clean-up option in
commit.  I dunno.

