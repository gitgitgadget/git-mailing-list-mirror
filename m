Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F9BC433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 21:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3E3161206
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 21:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346193AbhDMVXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 17:23:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65296 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhDMVXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 17:23:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 45292123C4F;
        Tue, 13 Apr 2021 17:22:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wEZ9FGcEg4QTRISwehY/ntoEMMc=; b=TmYMMO
        tOJ2E+HrYQq3fTo5cdLI1EoLBSuyF5Dohi2AOBn9RpCVlWauPk8F5phRTtH2PsWj
        pg899QYDFfKjoiRAIwsZtwaeaW0K132VLK73qdh97+07naa6yW6gADjMrYWkhU2n
        QuScq1X1c80ZI3UYrmwCRlMz/s6jG9l92jaKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Bo4gkR3XxlXoDxkXdVo0h3zbSX0FJ/jk
        J+fPRf3cZkzjFdU/mfBZcbj6NBPCh0HcY/VDCDOYrdoRMr8ba55RZkbWeXbkadsB
        8EWh4TfAGTQKwLjdhtr8+pUc6+emxYK0TC4yyh5CTOyOHzJbLySqye+UQmSkMnzQ
        gw7YbVpsZtQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3CD6A123C4C;
        Tue, 13 Apr 2021 17:22:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 89D2A123C3B;
        Tue, 13 Apr 2021 17:22:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Sam Bostock <sam.bostock@shopify.com>, git@vger.kernel.org
Subject: Re: `git fetch` not updating 'origin/HEAD' after branch rename
References: <CAHwnEogvmTZ-VS5GksoGEiyo3EHO+At+xeWa3frXUESD3HicnQ@mail.gmail.com>
        <xmqqlf9lly3d.fsf@gitster.g> <87pmyxc2n3.fsf@igel.home>
Date:   Tue, 13 Apr 2021 14:22:44 -0700
In-Reply-To: <87pmyxc2n3.fsf@igel.home> (Andreas Schwab's message of "Tue, 13
        Apr 2021 23:09:52 +0200")
Message-ID: <xmqqzgy1khgb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 644219E0-9C9E-11EB-82C2-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Apr 13 2021, Junio C Hamano wrote:
>
>> It may also be
>> possible to add "git fetch --reset-remote-tracking-HEAD" option to
>> make "fetch" overwrite existing origin/HEAD but somebody has to
>> propose such a change, argue for its benefit and get it accepted by
>> the community.
>
> Isn't that what git remote set-head origin -a does?

Yes, but the point is to do so when fetch is run (i.e. it talks with
the other side not just to learn which branch their HEAD points at,
but it actually does the fetching of new history on branches).  And
it might open the door to add a configuration to tell "fetch" to do
so unconditionally, if it turns out to be useful enough.
