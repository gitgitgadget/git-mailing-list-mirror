Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA7FC433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 20:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF75661A10
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 20:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238119AbhCXUdn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 16:33:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62658 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237892AbhCXUde (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 16:33:34 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B2575BF5E6;
        Wed, 24 Mar 2021 16:33:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a1VSv4h7O96J9rHRhPgDyA2NR/8=; b=RRDKMd
        A7fVh6+omS6MkAhNMFmAaSYZ2AYTRZH/PFq1LoCxFHgAVYhAVvrqpGjQ58bgy3yv
        y62UNgR6yL9LnE4HU/IJJUUNnurO0fZkeg1sZSHrwEqyOfPKlNjvCPMc0vcuorFL
        d/FWGCSqNMxfQNoT+zsz12CFRH+0DN1FWlvCw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gHmZ6mqm5Um4IHLn0oNP2ZzLRmvSnkU4
        PWTk84NovahDgaNYeojMiQF7J7Akflm/UTdVfAUi5r/LnDVy4WWjv0PhpKPV3hAR
        QtRflPoDSqoQVXCOcoa5fBpHQ7MkebftGDexl5EksBbnG0zqiS5XP12nqrI5abim
        vZN3aBnuKe8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA2E1BF5E5;
        Wed, 24 Mar 2021 16:33:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2E3EFBF5E3;
        Wed, 24 Mar 2021 16:33:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     lilinchao@oschina.cn
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] remote-curl.c: handle v1 when check_smart_http
References: <20210324053648.25584-1-lilinchao@oschina.cn>
        <006547b28c6311eb93820024e87935e7@oschina.cn>
        <xmqq7dlwxpn3.fsf@gitster.g>
Date:   Wed, 24 Mar 2021 13:33:32 -0700
In-Reply-To: <xmqq7dlwxpn3.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        24 Mar 2021 13:28:32 -0700")
Message-ID: <xmqq35wkxper.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33A6A7F6-8CE0-11EB-A5B1-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +	} else if (!strcmp(reader.line, "version 1")) {
>> +		die(_("v1 is just the original protocol with a version string, use v0 or v2 instead."));
>
> The user may no longer get "invalid response; got 'version 1'", but
> the above does not still explain why v1 is bad and v0 or v2 is
> welcome, either.  IOW, I do not think the patch improves the message
> to achieve what it attempted to do, i.e.
>
>     ... but the other side just treat it as "invalid response", this
>     can't explain why is not ok.

Alternatively

	v1 is not supported; use v0 or v2

would explain why the connection is refused.  It explains why it is
not ok much clearly than "just the original with a version string".

> I wonder if it is a sensible and better alternative to treat v1
> response as if we got v0 (if v1 is truly the same as v0 except for
> the initial version advertisement).
>
> Input from those who are familiar with the protocol versions is very
> much appreciated.

This still stands; we reject because we don't support, but is it
easy to support it instead, if there is no difference?
