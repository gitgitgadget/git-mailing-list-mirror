Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53F5D1F859
	for <e@80x24.org>; Tue,  9 Aug 2016 17:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbcHIRrQ (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 13:47:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58456 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751919AbcHIRrO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 13:47:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2AF3734788;
	Tue,  9 Aug 2016 13:47:13 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=73uQUPECQ8kJLF2tATx6Y0cBIY8=; b=Mq2BAn
	eoaIZoun9wyz4IVDZtRhq/tfdKMxVlo8bI/3hOKYaVXtM7Xi+4033Mgt6ImX5j+D
	NpXpglwwAezvPcLU3Wurl9FOnBEGFhHsgNDZ3xzhajk0CcXLx4w1p+PFCmX3cc0b
	hoHTCLoxRQyhZp9ETeitmDkT99Ptd3QeXNuBk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MXKBmeANGxeSUhqknjOUQmTAUKpY32zE
	LpKxKpdkGDc8EcKOrETIOKjyXDU+4nviOXBNfTsE2ju23HCEafScvWNDupKVAxKX
	fZCVFPyDqaWT9+RZ6T/SIsAxsSGll5BsVz9GpHvbs3dQNBY51pdhnwNO12SGEPif
	zVzSPP32IhM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C3EA34787;
	Tue,  9 Aug 2016 13:47:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 75B5334786;
	Tue,  9 Aug 2016 13:47:12 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, mst@redhat.com
Subject: Re: [PATCHv2 0/6] git clone: Marry --recursive and --reference
References: <20160809040811.21408-1-sbeller@google.com>
	<xmqqk2fqc583.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZKTV5PCAR41O1t1c_y6N18u6gsoWozOfr=EPHic-7wYw@mail.gmail.com>
Date:	Tue, 09 Aug 2016 10:47:10 -0700
In-Reply-To: <CAGZ79kZKTV5PCAR41O1t1c_y6N18u6gsoWozOfr=EPHic-7wYw@mail.gmail.com>
	(Stefan Beller's message of "Tue, 9 Aug 2016 10:26:12 -0700")
Message-ID: <xmqq8tw5bzs1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D64EF14-5E59-11E6-8661-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> "you did ask me to use alternates once and for all when setting up the
> superproject: now for this added submodule I don't find the alternate;
> That is strange?"

Absolutely.  I do not think you should expect a user to remember if
s/he used alternates when getting a copy of the superproject long
time ago.  Giving "info: using from ..." is good; giving "warning:
not using from ..." is probably irritating, I would think.

Stepping back a bit, when the user says --reference-if-able, does it
warrant any warning either way?  I.e. "we made it borrow from there,
so be careful not to trash that one" may be just as warning-worthy
(if not even more) as "you said we can borrow from there if there is
anything to borrow, but it turns out there isn't any, so the result
is complete stand-alone."  It feels as if we can go without any
warning at least from "git clone --reference-if-able", unless "-v"
option is given.

I have a very strong opinion what should happen when the end-user
facing command is "git submodule", but if I have to choose, I would
prefer to see "git submodule update" tell what it did with "info:"
either case, i.e. "info: borrowing from ... because the superproject
borrows from there", and "info: not borrowing from ... even though
the superproject borrows from there".


