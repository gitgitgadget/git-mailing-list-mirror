Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34B8D1FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 20:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757841AbcLTU4W (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 15:56:22 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52315 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757496AbcLTU4V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 15:56:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C067D59CF6;
        Tue, 20 Dec 2016 15:56:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KlxGDdKqzTkiJ4X/i0v3J2/j7AA=; b=ENn1YW
        N33oE0RP+DIYgkjOPe7tThy3pKvu8Q81+t+iUpGgaoa8n0+FgnKb/Mdk2zsnJqZf
        q1wuVJd6+eKTpBYCZEnUZ+vL2GzndGjoX+fGn41u6iiXCIUvpxvcJdg9eYbtDuuM
        BpNlsY7V1P3nrN/6vXqGsvVf6p9jhu/PexGaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mTCN+phMeP59wmHujB66qPuYr3EUf1s/
        ykQpAkxhhbVk60fszYSK5y+LJvZvo07Es+76Y5UfRBQSTtsytFkrkIkLdHXthq4E
        vf69/W/IhEKRQeLAWq7bYxspeUsZaOEQkhRfxSi63vm6zvR3+lrWoaZfN0Sh4QXb
        +uaTDhSJTLo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B7FBD59CF5;
        Tue, 20 Dec 2016 15:56:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 28F2A59CF4;
        Tue, 20 Dec 2016 15:56:19 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, johan@herland.net
Subject: Re: [PATCH] fast-import: properly fanout notes when tree is imported
References: <20161219021212.15978-1-mh@glandium.org>
        <xmqqk2aujsyb.fsf@gitster.mtv.corp.google.com>
        <20161220204841.awvabgwsxudxfzca@glandium.org>
Date:   Tue, 20 Dec 2016 12:56:18 -0800
In-Reply-To: <20161220204841.awvabgwsxudxfzca@glandium.org> (Mike Hommey's
        message of "Wed, 21 Dec 2016 05:48:41 +0900")
Message-ID: <xmqqbmw6jp59.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C17D1010-C6F6-11E6-865D-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey <mh@glandium.org> writes:

> On Tue, Dec 20, 2016 at 11:34:04AM -0800, Junio C Hamano wrote:
>> Mike Hommey <mh@glandium.org> writes:
>> 
>> > In typical uses of fast-import, trees are inherited from a parent
>> > commit. In that case, the tree_entry for the branch looks like:
>> > ...
>> > +# Create another notes tree from the one above
>> > +cat >>input <<INPUT_END
>> > +...
>> > +M 040000 $(git log --no-walk --format=%T refs/notes/many_notes) 
>> 
>> There is a trailing SP that cannot be seen by anybody.
>> 
>> Don't do this.  It makes it very easy to miss what is going on and
>> wastes reviewers' time.
>> 
>> Protect it by doing something like:
>> 
>> 	sed -e 's/Z$//' >>input <<INPUT_END
>> 	...
>> 	M 040000 $(git log --no-walk --format=%T refs/notes/many_notes) Z
>
> How about
> EMPTY=
> ...
> M 040000 $(git log --no-walk --format=%T refs/notes/many_notes) $EMPTY
>
> ?

Notice I said "something like" ;-)

I think you are bringing that up to avoid sed, but if you want to go
that route, the long string $EMPTY is distracting, and makes readers
wonder why something that is loud but expands to nothing has to be
there.  It hides the true intention, which is that the SP that comes
before it is the most important thing on that line.

I would think a lot more understandable variant would be to do this
instead:

	SP=" "
	...
	M a lot of garbage $(and command)$SP

