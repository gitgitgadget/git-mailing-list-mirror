Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5742EC47247
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 19:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10BD420731
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 19:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WWE6PUnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgD3Tt2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:49:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61535 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgD3Tt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 15:49:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CD25FBA497;
        Thu, 30 Apr 2020 15:49:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7GT2UiFecvjAWMeru9eXRVw8U60=; b=WWE6PU
        nrJyqNjZRl5mVgaXqu33LA6VJuEonSAkRXrVy6U8ftlxthbNb50db4AVXoK33xyx
        IEW7wIixqsthlD6ctTU1iyY0IEjoI18wE6ol0riRk/og0gnNPmUtJ7WOPo6YK65G
        cd7J5HELoo01dPPLmh39XO8RMhKIq+3/+CV4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dkf74OjsNZw6KWlY5gaMFPnesiOPhtMf
        +S6WPDBXN3Io/FRcwZwSNpaOAjKXrfAQ3f73iMjlBOzs8AkJ7aJiHVPMMLq9xIob
        OGbx90eH8xlMfsiATVhsQIr0Re0pnRp6KbXFXtP7gU+Dkn+sSb51gXZJqbI7fxz1
        l7X0+WKc0os=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C5A51BA496;
        Thu, 30 Apr 2020 15:49:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 03D91BA493;
        Thu, 30 Apr 2020 15:49:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@yhbt.net>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git@vger.kernel.org
Subject: Re: Guess the base-commit of a series
References: <20200430172147.3fblnrvi73asnkp5@chatter.i7.local>
        <20200430173302.GA18877@dcvr>
Date:   Thu, 30 Apr 2020 12:49:21 -0700
In-Reply-To: <20200430173302.GA18877@dcvr> (Eric Wong's message of "Thu, 30
        Apr 2020 17:33:02 +0000")
Message-ID: <xmqqk11wsqim.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B08865A6-8B1B-11EA-914C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@yhbt.net> writes:

> Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:
>> Hello:
>> 
>> Given a/ b/ filenames and blob index information, is there a relatively 
>> easy way to find the latest branch commit where a patch series would 
>> apply cleanly (i.e. guess the base-commit)?
>
> Not as far as I know...

Me neither.

I am assuming that this is in the context of the kernel project,
where there are numerous but manageable number of well known
repositories, so Konstantin can probably create a (bare) repository
that fetches from all of them into refs/remotes/{linus,next,...}/
remote-tracking branches.  With that, running this command

    $ git rev-list --all | git diff-tree --stdin --raw -r

and write a script that parses its output may not be too hard.

I am not sure what Konstantin wanted to say with "the latest branch
commit", but if the starting point (i.e. branch) is known, then such
a script can read from the output of the above pipeline but instead
of starting from "--all", start the traversal from the branch tip.

There may not be any such tree with all those blobs.  For the second
patch in an N-patch series, there won't be such a tree anywhere
other than the author's repository unless the first patch of the
series has been applied somewhere well known.

