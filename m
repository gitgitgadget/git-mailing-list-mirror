Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C996C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 17:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8A520732
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 17:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PxAukstS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgC3RjY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 13:39:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56266 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgC3RjY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 13:39:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F13243996;
        Mon, 30 Mar 2020 13:39:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6lEFdFFqOaLwbBD36Uk4vfKNLgw=; b=PxAuks
        tSPIqSKhSUKu9Z3991UqLRvS84Xhff2rqvb3khteRNrOlJaaAN61KdUFCMPfPwST
        9xD9PrEd5pWNFjdorJkmLT/teaLAV3Uya494to46I5p9SxY/QvGCVMdqWgXjLOHO
        o7F+3ZyIrAMretgelCi6X/i2dX8YGQPIKF5cQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MlzZz5zWoZEJeYqCharSTFKhdSSe0mH8
        fk/rdW5+8kpZmIAp9bV8lT6+sLOMDIbB2C0Mip8VWigLjPv5Y2V3fgpsop4NiuwX
        q/AN1gh8szQth8Plk+bELp3sqoqFSrpS3EZhojoh/QQ6woPx4um0Y3TBgyCWCfnw
        Og99HQaYQ04=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 158A143995;
        Mon, 30 Mar 2020 13:39:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7CBAD43994;
        Mon, 30 Mar 2020 13:39:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 8/9] update-ref: read commands in a line-wise fashion
References: <cover.1585129842.git.ps@pks.im>
        <1db63f97ec78fad794cec51c5d96b093f7cd2440.1585129843.git.ps@pks.im>
        <xmqqo8she9yp.fsf@gitster.c.googlers.com>
        <20200330081144.GB186019@ncase.pks.im>
Date:   Mon, 30 Mar 2020 10:39:21 -0700
In-Reply-To: <20200330081144.GB186019@ncase.pks.im> (Patrick Steinhardt's
        message of "Mon, 30 Mar 2020 10:11:44 +0200")
Message-ID: <xmqqk13191yu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6444097E-72AD-11EA-8E11-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Mar 27, 2020 at 02:58:38PM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> >  static const struct parse_cmd {
>> >  	const char *prefix;
>> > -	const char *(*fn)(struct ref_transaction *, const char *, const char *);
>> > +	void (*fn)(struct ref_transaction *, const char *, const char *);
>> > +	unsigned extra_lines;
>> 
>> Define and explain the meaning of extra_lines in a comment.  Without
>> it, the most natural way to infer what the variable means by readers
>> would be that "update" command sometimes receives up to two more
>> lines but it also is perfectly normal if there is no extra line.
>> 
>> But I am not sure if that is what is going on.
>> 
>> "update" _always_ needs exactly two more input "lines" when the
>> input is NUL delimited, perhaps, and it is an _error_ if there are
>> not these two lines, no?
>
> That's extactly right. I pondered on a good name, but I wasn't yet able
> to come up with any one that brings across its meaning. I originally had
> `extra_args` but changed it after some internal discussion with Chris.

Wouldn't it make more sense to store the number of args expected
here, not "extra"?  The one that does not take any then can say "I
am subcommand X and I do not want a SP after my name".

The "sometimes after the command there is line.termination, and
sometimes there is NUL, and yet some other times there is SP", which
is a sloppy way to check malformed input (i.e. you do not want SP
for a command that does not take parameters), that you have after
the loop can then go, if you did the parsing that way.

