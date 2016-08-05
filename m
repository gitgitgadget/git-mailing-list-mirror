Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 823721FD99
	for <e@80x24.org>; Sat,  6 Aug 2016 20:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbcHFUFM (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 16:05:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59531 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752047AbcHFUE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 16:04:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 63DEE33FDA;
	Fri,  5 Aug 2016 19:09:18 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ycSO52thM3WqYd9gyV194eU3arg=; b=YoEU3W
	FWLpjzuvSMI4SI+eveD4QwqgYKXEVy/0/FjXbTHgrD5IPW8X8+LHBytOVzsKUlAD
	wyu8jsHO9JcfQpHzYWtu4aRAcBnsRXcxZVFLs3U21RPcj6PXdeGkz7xeFIvSjNMB
	S3kaoP7Ahxw/kZL8JrZ2365S3fEckeHZ/D1yc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ci5+j2+XctAwyp9D3ZgTq647naZfLy6i
	0lT0T0itZQbGcdGXbJQpiBPeaMoqmOo3ZxAQvUfQgE1jYgiI7FM7uFp5pQfP4kaH
	3fqaLu21yqYb75nfPUDUoe740yDMgg1VwIWza6tXdHHnuvrrDOrU7DOIRP4DPAm0
	3woSr1IdxO8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C62A33FD9;
	Fri,  5 Aug 2016 19:09:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CE26533FD7;
	Fri,  5 Aug 2016 19:09:17 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	"git\@vger.kernel.org" <git@vger.kernel.org>, mst@redhat.com,
	Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/6] t7408: merge short tests, factor out testing method
References: <20160804195159.7788-1-sbeller@google.com>
	<20160804195159.7788-3-sbeller@google.com>
	<xmqqeg63vtar.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZChXebtSJeTPGoZgnoKySDrWnD11NX7fyze+rOU=Jwvg@mail.gmail.com>
Date:	Fri, 05 Aug 2016 16:09:15 -0700
In-Reply-To: <CAGZ79kZChXebtSJeTPGoZgnoKySDrWnD11NX7fyze+rOU=Jwvg@mail.gmail.com>
	(Stefan Beller's message of "Fri, 5 Aug 2016 15:45:13 -0700")
Message-ID: <xmqqwpjuu82s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A297D528-5B61-11E6-AF5E-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>> -test_expect_success 'that reference gets used with add' '
>>> -     (
>>> -             cd super/sub &&
>>> -             echo "0 objects, 0 kilobytes" > expected &&
>>> -             git count-objects > current &&
>>> -             diff expected current
>
> This is where the "diff" and "current" above came from.

I KNOW that, but I thought this effort is a continuation of the
modernise-and-make-it-maintainable effort started at 1/6.

> To stop that from happening again I want to have a clean slate,
> i.e. all clones are deleted shortly after using, so it is obvious what
> to use for testing.

OK.  So A, B and super (and super/sub) are the ones that survive
throughout the test, and individual test (including the "let's try
cloning the super into super-clone" at the end of existing tests)
would follow create-use-remove pattern?  Perhaps that can be left
as a comment before the last existing test, e.g. "A, B and super are
permanent, and from here on, if you create a clone of them for
testing, remove your clone once you are done", to inform the test
writers of this convention.

Thanks.
